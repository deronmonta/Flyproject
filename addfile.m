clear all
disp('Choose Fly position files source');
wholepossrc = uigetdir;
disp('Choose flydatabase directory');
savedir = 'C:\Users\deron\Documents\MATLAB\Fly_Data_Git\Lin_DataBase';
% fly = Fly();%Single Fly obj
flies = [];%Flies array
files = dir(fullfile(wholepossrc,'*.mat'));
files
hours = input('Enter desiccation hour: ');
geno = input('Enter Geno type: ','s');
water = input('Water source? (Y/N)','s');
files.name
for k = 1:length(files)
  cd(wholepossrc)
  load(files(k).name)
  fly = Fly();%Initalize fly obj
  fly = fly.assignment(files(k).name, k, date, hours,water, geno ,wholepos,wholepossrc,savedir)
  %self, fname, id, datecreated, dest, water, geno, wholepos, srcdir, savedir;
  fly = basiccal(fly);
  fly = correction(fly);
  fly = zoneid(fly);
  fly = findrunstop(fly);
  % fly = findangle(fly);
  flies = [flies;fly];
end

save(fullfile(savedir,'ptnw0524'),'flies');% Change the filename here
