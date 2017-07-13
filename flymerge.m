myDir = uigetdir;
cd(myDir);
myFiles = dir(fullfile(myDir,'*.mat'));
flydatabase = [];
delete flydatabase.mat;

for i = 1 : length(myFiles)

  load(myFiles(i).name);
  disp(myFiles(i).name);
  fliesbuffer = [];
  fliesbuffer = [flies];
  flydatabase = [flydatabase;fliesbuffer];


end

for n = 1 : length(flydatabase)

  flydatabase(n).id = n;

end

save('flydatabase');
