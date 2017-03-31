disp('Choose Fly position files source');
wholepossrc = uigetdir;
disp('Choose flydatabase directory'):
savedir = uigetdir;
wholepossubs = dir(wholepossrc);
fly = [];
flies = [];
files = dir(fullfile(wholepossubs(N).name,'*.mat'));

for k = 1:length(wholepossrc)
  fly(k) = Fly();
  geno = 'Wildtype';
  hours = fly(k) = fly(k).assignment(files(k).name, k, date, hours, geno ,wholepos,wholepossrc,savedir);
  fly(k) = basiccal(fly(k));
  fly(k) = correction(fly(k));
  fly(k) = zoneid(fly(k));
  fly(k) = findrunstop(fly(k));
  fly(k) = findangle(fly(k));
  flies = [flies;fly(k)];
end

save(fullfile(savedir,'fliesdatabase5'),'flies');
