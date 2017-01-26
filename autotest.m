
%Below are the variables that needs to be inputed to object
% 1. filename;
% 2. id;
% 3. date;
% 4. genotype;
% 5. wholepos;
% 6. desiccation_hr;
%7. save_dir
%8. src_dir


file = uigetfile;
fname = file;
load(file);

hr = 0;
geno = 'Wildtype'
srcdir = 'C:\Users\Bayesian\Documents\MATLAB\Wildtype\Wholepos_file\0_hr';
savedir = 'C:\Users\Bayesian\Documents\MATLAB\Wildtype\Wholepos_file';
id = 1;
date = '1/25/2107';
N = Fly();
N = assignment(N,fname,id, date, hr, geno, wholepos, srcdir, savedir);
N = basiccal(N);
N = zoneid(N);
