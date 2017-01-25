file = uigetfile;
fname = file;
load(file);
wholepos = posinput;

hr = 0;
geno = 'Wildtype'


N = Fly();
N = assignment(N, fname, hr, geno, posinput, )
