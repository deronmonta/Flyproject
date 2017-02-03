%This program is for fly database manipulation
file = uigetfile;
load(file);%Load fly database
new_fly = [];
zero_hr_fly = [];
one_hr_fly = [];
two_hr_fly = [];
three_hr_fly = [];
four_hr_fly = [];
five_hr_fly = [];
six_hr_fly = [];
seven_hr_fly = [];
eight_hr_fly = [];
nine_hr_fly = [];
twlve_hr_fly = [];
hr = [];
dpercentage = [];
attraction = [];

zero_hr_fly = findobj(flies,'desiccation_hr',0);
one_hr_fly = findobj(flies,'desiccation_hr',1);
two_hr_fly = findobj(flies,'desiccation_hr',2);
three_hr_fly = findobj(flies,'desiccation_hr',3);
four_hr_fly = findobj(flies,'desiccation_hr',4);
five_hr_fly = findobj(flies,'desiccation_hr',5);
six_hr_fly = findobj(flies,'desiccation_hr',6);
seven_hr_fly = findobj(flies,'desiccation_hr',7);
eight_hr_fly = findobj(flies,'desiccation_hr',8);
nine_hr_fly = findobj(flies,'desiccation_hr',9);
twlve_hr_fly = findobj(flies,'desiccation_hr',12);
[one_hr_fly.attraction]'
one_hr_fly.zone
Atrraction1 = find(one_hr_fly.zone == 'i')/length(one_hr_fly.zone)


attractionavg = [mean([zero_hr_fly.attraction])
mean([one_hr_fly.attraction])
mean([two_hr_fly.attraction])
mean([three_hr_fly.attraction])
mean([four_hr_fly.attraction])
mean([five_hr_fly.attraction])
mean([six_hr_fly.attraction])
mean([seven_hr_fly.attraction])
mean([eight_hr_fly.attraction])
 mean([nine_hr_fly.attraction])
mean([twlve_hr_fly.attraction])];

dpercentageavg = [mean([zero_hr_fly.dpercentage])
mean([one_hr_fly.dpercentage])
mean([two_hr_fly.dpercentage])
mean([three_hr_fly.dpercentage])
mean([four_hr_fly.dpercentage])
mean([five_hr_fly.dpercentage])
mean([six_hr_fly.dpercentage])
mean([seven_hr_fly.dpercentage])
mean([eight_hr_fly.dpercentage])
mean([nine_hr_fly.dpercentage])
mean([twlve_hr_fly.dpercentage])];







% for N = 1 : length(flies)
%   if flies(N).desiccation_hr == 0
%     zero_hr_fly = [zero_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 1
%     one_hr_fly = [one_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 2
%     two_hr_fly = [two_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 3
%     three_hr_fly = [three_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 4
%     four_hr_fly = [four_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 5
%     five_hr_fly = [five_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 6
%     six_hr_fly = [six_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 7
%     seven_hr_fly = [seven_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 8
%     eight_hr_fly = [eight_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 9
%     nine_hr_fly = [nine_hr_fly;flies(N)];
%   end
%   if flies(N).desiccation_hr == 12
%     twlve_hr_fly = [twlve_hr_fly;flies(N)];
%   end %Group in to different desiccation hours Group by different hours
% end

for K = 1 : length(flies) %Sort by desiccation hours
  hr = [hr;flies(K).desiccation_hr];
  dpercentage = [dpercentage;flies(K).dpercentage];
  attraction = [attraction;flies(K).attraction];
end


scatter(hr,dpercentage);
title('Hours vs decisions percentage');
figure;
scatter(hr,attraction);
title('Hours vs attraction');

figure;
subplot(2,2,1);
plot(attractionavg);
subplot(2,2,2);
plot(dpercentageavg);
