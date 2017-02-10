flydb = uigetfile;
load(flydb);
for k = 1 : length(flydb)
  % flydatabase(k);
  flydatabase(k).tzone_inner_radius = 50;
  flydatabase(k) = basiccal(flydatabase(k));
  flydatabase(k) = correction(flydatabase(k));
  flydatabase(k) = zoneid(flydatabase(k));
  flydatabase(k) = findrunstop(flydatabase(k));
  flydatabase(k) = findangle(flydatabase(k));

end

save('flydatabase.mat', 'flydatabase');
