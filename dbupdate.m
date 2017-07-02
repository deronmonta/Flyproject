clear all;
flydb = uigetfile;
load(flydb);
for k = 1 : length(flydatabase)
  % flydatabase(k);
  % flydatabase(k).tzone_outer_radius = 240;
  % if flydatabase(k).desiccation_hr > 0
  %   flydatabase(k).desiccation_hr = 25;
  % end
   flydatabase(k).tzone_inner_radius = 60;
  flydatabase(k) = basiccal(flydatabase(k));
  flydatabase(k) = correction(flydatabase(k));
   flydatabase(k) = zoneid(flydatabase(k));
   flydatabase(k) = zonecal(flydatabase(k));
  flydatabase(k) = findrunstop(flydatabase(k));
   flydatabase(k) = findangle(flydatabase(k));
   flydatabase(k) = findperiod(flydatabase(k));

end
save('flydatabase.mat', 'flydatabase');
