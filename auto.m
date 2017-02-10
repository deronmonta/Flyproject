%This program will take wholspos files as input and save every Document as a fly object array(Database)
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

wholepossubs = dir(wholepossrc)
flies = [];
savedir = uigetdir;
for N = 1:length(wholepossubs) %Loop through every sub folder    || ~(wholepossubs(N).name == '..')
  fly = [];
  if ~(wholepossubs(N).name == '.')
    geno = 'Wildtype';
    % file_names = files.name;
    disp(wholepossubs(N).name);
    files = dir(fullfile(wholepossubs(N).name,'*.mat'))

    if strcmp(wholepossubs(N).name,'0_hr')
      hours = 0;
    elseif strcmp(wholepossubs(N).name,'1_hr')
      hours = 1;
    elseif strcmp(wholepossubs(N).name,'2_hr')
      hours = 2;
    elseif strcmp(wholepossubs(N).name,'3_hr')
      hours = 3;
    elseif strcmp(wholepossubs(N).name,'4_hr')
      hours = 4;
    elseif strcmp(wholepossubs(N).name,'5_hr')
      hours = 5;
    elseif strcmp(wholepossubs(N).name,'6_hr')
      hours = 6;
    elseif strcmp(wholepossubs(N).name,'7_hr')
      hours = 7;
    elseif strcmp(wholepossubs(N).name,'8_hr')
      hours = 8;
    elseif strcmp(wholepossubs(N).name,'9_hr')
      hours = 9;
    elseif strcmp(wholepossubs(N).name,'10_hr')
      hours = 10
    elseif strcmp(wholepossubs(N).name,'11_hr')
      hours = 11
    elseif strcmp(wholepossubs(N).name,'12_hr')
      hours = 12;
    elseif strcmp(wholepossubs(N).name,'no water control')
      hours = 12;
      geno = 'Wildtype, No water control';
    elseif strcmp(wholepossubs(N).name,'IR40aRNAi')
      hours = 8;
      geno = 'IR40aRNAi';
    end

    for k = 1:length(files) %Loop through files in sub folder
      load(files(k).name);
       %Remove error prone charecters
      files(k).name = strrep(files(k).name,'_','');
      files(k).name = strrep(files(k).name,'.mat','');
      files(k).name = strrep(files(k).name,'.avi','');
      files(k).name = strrep(files(k).name,'-','');
      disp(files(k).name);

      fly = [fly; Fly()];%fly is a buffer for each folder,
      fly(k) = fly(k).assignment(files(k).name, k, date, hours, geno ,wholepos,wholepossrc,savedir);
      fly(k) = basiccal(fly(k));
      fly(k) = correction(fly(k));
      fly(k) = zoneid(fly(k));
      fly(k) = findrunstop(fly(k));
      fly(k) = findangle(fly(k));
      flies = [flies;fly(k)];
   end
 end

save(fullfile(savedir,'fliesdatabase1'),'flies');
end
