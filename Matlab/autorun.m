%This program will take wholspos files as input and output them as popstat files

disp('Choose Fly position files source');
wholspossrc = uigetdir;

wholepossubs = dir(fullfile(wholspossrc))
disp(wholepossubs);

for N = 1:length(wholepossubs) %Loop through every sub folder

disp(wholepossubs(N).name);



if strcmp(wholepossubs(N).name,'0_hr')
  hours = 0;
  srcdir = 'C:\Users\deron\Documents\MATLAB\Wildtype\Wholepos_file\0_hr';
  savedir1 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Tracks_file\0hr_'; %Save directory for flyparaauto; src directory for flystatauto
  savedir2 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Popstat_file';
  flyparaauto(srcdir, savedir1);
  flystatauto(savedir1, savedir2, hours);


end

if strcmp(wholepossubs(N).name,'1_hr')

  srcdir = 'C:\Users\deron\Documents\MATLAB\Wildtype\Wholepos_file\1_hr';
  savedir1 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Tracks_file\1_hr'; %Save directory for flyparaauto; src directory for flystatauto
  savedir2 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Popstat_file'
  flyparaauto(srcdir, savedir1);
  flystatauto(savedir1, savedir2, hours);

end

if strcmp(wholepossubs(N).name,'2_hr')
  srcdir = 'C:\Users\deron\Documents\MATLAB\Wildtype\Wholepos_file\2_hr';
  savedir1 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Tracks_file\2_hr'; %Save directory for flyparaauto; src directory for flystatauto
  savedir2 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Popstat_file'
  flyparaauto(srcdir, savedir1, hours);

end

if strcmp(wholepossubs(N).name,'3_hr')
  srcdir = 'C:\Users\deron\Documents\MATLAB\Wildtype\Wholepos_file\3_hr';
  savedir1 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Tracks_file\3_hr'; %Save directory for flyparaauto; src directory for flystatauto
  savedir2 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Popstat_file';
  flyparaauto(srcdir, savedir1);
  flystatauto(srcdir, savedir1, hours);

end

if strcmp(wholepossubs(N).name,'4_hr')
  srcdir = 'C:\Users\deron\Documents\MATLAB\Wildtype\Wholepos_file\4_hr';
  savedir1 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Tracks_file\4_hr'; %Save directory for flyparaauto; src directory for flystatauto
  savedir2 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Popstat_file';
  flyparaauto(srcdir, savedir1);
  flystatauto(srcdir, savedir1, hours);

end

if strcmp(wholepossubs(N).name,'5_hr')


end

if strcmp(wholepossubs(N).name,'6_hr')


end



end
