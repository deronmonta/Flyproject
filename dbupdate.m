clear all;
flydb = uigetfile;
load(flydb);
for k = 1 : length(flydatabase)
  % flydatabase(k);
  % flydatabase(k).tzone_outer_radius = 240;
  % flydatabase(k).tzone_inner_radius = 100;
  flydatabase(k) = basiccal(flydatabase(k));
  flydatabase(k) = correction(flydatabase(k));
  % flydatabase(k) = zoneid(flydatabase(k));
  % flydatabase(k) = findrunstop(flydatabase(k));
   flydatabase(k) = findangle(flydatabase(k));

end
save('flydatabase.mat', 'flydatabase');
