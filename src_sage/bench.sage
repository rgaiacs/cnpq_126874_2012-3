import os
os.chdir("MM")
for lib in os.listdir("."):
    with open('../bench/{0}.csv'.format(lib), 'w') as f_csv:
        f_csv.write('file,dim,bandwidth,profile,rcm_bandwidth,rcm_profile\n')
        for prob in os.listdir(lib):
            try:
                print('try loading {0}/{1}/{1}.mtx'.format(lib, prob))
                mdict = load_matrix('{0}/{1}/{1}.mtx'.format(lib, prob), file_format='mm', sparse=False)
                # m = load_matrix('MM/LPnetlib/lp_25fv47/lp_25fv47.mtx', file_format='mm', sparse=False)
                print('success at load {0}/{1}/{1}.mtx'.format(lib, prob))
                print('build A A^T')
                M = mdict['A'] * mdict['A'].transpose()
                b, _ = M.get_bandwidth()
                p = M.get_profile()
                print('compute the reverse Cuthill-McKee reorder')
                rcm = M.rcm()
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
                f_csv.write('{0},{1},{2},{3},{4},{5}\n'.format(prob,
                    M.ncols(), b, p, rcm_b, rcm_p))
            except OSError:
                print(80*'-')
                print('failed to load {0}/{1}/{1}.mtx'.format(lib, prob))
                print(e)
                print(80*'-')
            except ValueError, e:
                print(80*'-')
                print('failed processing {0}/{1}/{1}.mtx: {2}'.format(lib, prob,
                    e))
                f_csv.write('{0},{1},{2},{2},{2},{2}\n'.format(prob,
                    M.ncols(), '***'))
                print(80*'-')
            except Exception, e:
                print(80*'-')
                print('failed processing {0}/{1}/{1}.mtx: {2}'.format(lib, prob,
                    e))
                f_csv.write('{0},{1},{2},{2},{2},{2}\n'.format(prob,
                    M.ncols(), '---'))
                print(80*'-')
