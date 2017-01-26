%This program will take wholspos files as input and save every Document as a fly object
%Below are the variables that needs to be inputed to object
% 1. filename;
% 2. id;
% 3. date;
% 4. genotype;
% 5. wholepos;
% 6. desiccation_hr;
%7. save_dir
%8. src_dir

disp('Choose Fly position files source');
wholepossrc = uigetdir;

wholepossubs = dir(fullfile(wholspossrc))
disp(wholepossubs);

for N = 1:length(wholepossubs) %Loop through every sub folder

disp(wholepossubs(N).name);


    if strcmp(wholepossubs(N).name,'0_hr')

      hours = 0;
      wholepossrc
      % srcdir = 'C:\Users\deron\Documents\MATLAB\Wildtype\Wholepos_file\0_hr';
      % savedir1 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Tracks_file\0hr_'; %Save directory for flyparaauto; src directory for flystatauto
      % savedir2 = 'C:\Users\deron\Documents\MATLAB\Wildtype\Popstat_file';
      files = dir(fullfile(wholepossubs(N),'*.mat'));
      files
      types = which(files.name);
      file_names = files.name;
      % file_names
      % types = which(file_names)
      %
      for k = 1:length(files)%Loop through every .mat file in the folder
        file_names(k) = Fly();
        which(file_names(k))
      end
    end




end
