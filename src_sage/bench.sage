import os
os.chdir("MM")
for lib in os.listdir("."):
    for p in os.listdir(lib):
        print('try loading {0}/{1}/{1}.mtx'.format(lib, p))
        mdict = load_matrix('{0}/{1}/{1}.mtx'.format(lib, p), file_format='mm', sparse=False)
