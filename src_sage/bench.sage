import os
import time
os.chdir("mps")
for lib in os.listdir("."):
    with open('../bench/{0}.csv'.format(lib), 'w') as f_csv:
        f_csv.write('file,dim,time,bandwidth,profile,bandwidth,profile,reduce\n')
        for prob in os.listdir(lib):
            print(prob)
            if prob.endswith('.mps') and os.path.getsize('{0}/{1}'.format(lib, prob)) < 2000000:
                try:
                    print('try loading {0}/{1}'.format(lib, prob))
                    mdict = load_matrix('{0}/{1}'.format(lib, prob), file_format='mps', sparse=False)
                    # m = load_matrix('MM/LPnetlib/lp_25fv47/lp_25fv47', file_format='mm', sparse=False)
                    print('success at load {0}/{1}'.format(lib, prob))
                    print('build A A^T')
                    M = mdict['A'] * mdict['A'].transpose()
                    b, _ = M.get_bandwidth()
                    p = M.get_profile()
                    print('compute the reverse Cuthill-McKee reorder')
                    t_in = time.time()
                    rcm = M.rcm()
                    t_out = time.time()
                    # Test for duplicated values in rcm() return.
                    """
                    test = collections.Counter(rcm)
                    for i in test:
                        if test[i] > 1:
                            raise ValueError('rcm have duplicated values')
                    """
                    print('reorder A A^T')
                    M = M[rcm, rcm]
                    rcm_b, _ = M.get_bandwidth()
                    rcm_p = M.get_profile()
                    if rcm_b <= b or rcm_p <= p:
                        r = '+'
                    else:
                        r = '-'
                    f_csv.write('{0},{1},{2},{3},{4},{5},{6},{7}\n'.format(prob,
                        M.ncols(), t_out - t_in, b, p, rcm_b, rcm_p, r))
                except OSError:
                    print(80*'-')
                    print('failed to load {0}/{1}'.format(lib, prob))
                    print(e)
                    print(80*'-')
                except ValueError, e:
                    print(80*'-')
                    print('failed processing {0}/{1}: {2}'.format(lib, prob,
                        e))
                    f_csv.write('{0},{1},{2},{2},{2},{2}\n'.format(prob,
                        M.ncols(), '***'))
                    print(80*'-')
                except Exception, e:
                    print(80*'-')
                    print('failed processing {0}/{1}: {2}'.format(lib, prob,
                        e))
                    f_csv.write('{0},{1},{2},{2},{2},{2}\n'.format(prob,
                        M.ncols(), '---'))
                    print(80*'-')
