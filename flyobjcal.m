%This program is for fly database manipulation
file = uigetfile;
load(file);%Load fly database
new_fly = [];
zero_hr_fly = [];
hr = [];
dpercentage = [];
for N = 1 : length(flies)
  if flies(N).desiccation_hr == 0
    zero_hr_fly = [zero_hr_fly;flies(N)];
  end
end

for K = 1 : length(flies)
  hr = [hr;flies(K).desiccation_hr];
  dpercentage = [dpercentage;flies(K).dpercentage];
end

scatter(hr,dpercentage)
