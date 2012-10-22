import collections
with open('netlib.csv', 'w') as f_csv:
    f_csv.write('file,dim,bandwidth,profile,rcm_bandwidth,rcm_profile\n')
    # with open('f2bench.txt') as f:
    f = ['beaconfd']
    for l in f:
        try:
            print('try to load ..netlib/{0}.mps'.format(l.rstrip()))
            mdict = load_matrix('../netlib/{0}.mps'.format(l.rstrip()),
                    sparse=False)
            print('success at load ../netlib/{0}.mps'.format(l.rstrip()))
        except Exception, e:
            print(80*'-')
            print('failed to load ../netlib/{0}.mps'.format(l.rstrip()))
            print(e)
            print(80*'-')
        print('build A A^T')
        M = mdict['A'] * mdict['A'].transpose()
        b, _ = M.get_bandwidth()
        p, _ = M.get_profile()
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
        rcm_p, _ = M.get_profile()
        f_csv.write('{0},{1},{2},{3},{4},{5}\n'.format(l.rstrip(),
            M.ncols(), b, p, rcm_b, rcm_p))
