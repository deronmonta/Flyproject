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
one_hr_fly = [one_hr_fly];
% one_hr_fly.zone = [one_hr_fly.zone']
% Atrraction1 = find([one_hr_fly.zone] == 'i')/length([one_hr_fly.zone])


attractionavg = [nanmean([zero_hr_fly.attraction])
nanmean([one_hr_fly.attraction])
nanmean([two_hr_fly.attraction])
nanmean([three_hr_fly.attraction])
nanmean([four_hr_fly.attraction])
nanmean([five_hr_fly.attraction])
nanmean([six_hr_fly.attraction])
nanmean([seven_hr_fly.attraction])
nanmean([eight_hr_fly.attraction])
 nanmean([nine_hr_fly.attraction])
nanmean([twlve_hr_fly.attraction])];

dpercentageavg = [nanmean([zero_hr_fly.dpercentage])
nanmean([one_hr_fly.dpercentage])
nanmean([two_hr_fly.dpercentage])
nanmean([three_hr_fly.dpercentage])
nanmean([four_hr_fly.dpercentage])
nanmean([five_hr_fly.dpercentage])
nanmean([six_hr_fly.dpercentage])
nanmean([seven_hr_fly.dpercentage])
nanmean([eight_hr_fly.dpercentage])
nanmean([nine_hr_fly.dpercentage])
nanmean([twlve_hr_fly.dpercentage])];

speedavg = [nanmean([zero_hr_fly.avgspeed])
nanmean([one_hr_fly.avgspeed])
nanmean([two_hr_fly.avgspeed])
nanmean([three_hr_fly.avgspeed])
nanmean([four_hr_fly.avgspeed])
nanmean([five_hr_fly.avgspeed])
nanmean([six_hr_fly.avgspeed])
nanmean([seven_hr_fly.avgspeed])
nanmean([eight_hr_fly.avgspeed])
nanmean([nine_hr_fly.avgspeed])
nanmean([twlve_hr_fly.avgspeed])];

sharpturns = [nanmean([zero_hr_fly.sharpturn])
nanmean([one_hr_fly.sharpturn])
nanmean([two_hr_fly.sharpturn])
nanmean([three_hr_fly.sharpturn])
nanmean([four_hr_fly.sharpturn])
nanmean([five_hr_fly.sharpturn])
nanmean([six_hr_fly.sharpturn])
nanmean([seven_hr_fly.sharpturn])
nanmean([eight_hr_fly.sharpturn])
nanmean([nine_hr_fly.sharpturn])
nanmean([twlve_hr_fly.sharpturn])];

innerspeed = [nanmean([[zero_hr_fly.innerspeed]])
nanmean([one_hr_fly.innerspeed])
nanmean([two_hr_fly.innerspeed])
nanmean([three_hr_fly.innerspeed])
nanmean([four_hr_fly.innerspeed])
nanmean([five_hr_fly.innerspeed])
nanmean([six_hr_fly.innerspeed])
nanmean([seven_hr_fly.innerspeed])
nanmean([eight_hr_fly.innerspeed])
nanmean([nine_hr_fly.innerspeed])
nanmean([twlve_hr_fly.innerspeed])];

midspeed = [nanmean([[zero_hr_fly.midspeed]])
nanmean([one_hr_fly.midspeed])
nanmean([two_hr_fly.midspeed])
nanmean([three_hr_fly.midspeed])
nanmean([four_hr_fly.midspeed])
nanmean([five_hr_fly.midspeed])
nanmean([six_hr_fly.midspeed])
nanmean([seven_hr_fly.midspeed])
nanmean([eight_hr_fly.midspeed])
nanmean([nine_hr_fly.midspeed])
nanmean([twlve_hr_fly.midspeed])];

totaldecisions = [nanmean([[zero_hr_fly.totald]])
nanmean([one_hr_fly.totald])
nanmean([two_hr_fly.totald])
nanmean([three_hr_fly.totald])
nanmean([four_hr_fly.totald])
nanmean([five_hr_fly.totald])
nanmean([six_hr_fly.totald])
nanmean([seven_hr_fly.totald])
nanmean([eight_hr_fly.totald])
nanmean([nine_hr_fly.totald])
nanmean([twlve_hr_fly.totald])];

correctd = [nanmean([[zero_hr_fly.correctd]])
nanmean([one_hr_fly.correctd])
nanmean([two_hr_fly.correctd])
nanmean([three_hr_fly.correctd])
nanmean([four_hr_fly.correctd])
nanmean([five_hr_fly.correctd])
nanmean([six_hr_fly.correctd])
nanmean([seven_hr_fly.correctd])
nanmean([eight_hr_fly.correctd])
nanmean([nine_hr_fly.correctd])
nanmean([twlve_hr_fly.correctd])];



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
  speed = [dpercentage;flies(K).dpercentage];
  attraction = [attraction;flies(K).attraction];
end


% scatter(hr,dpercentage);
% title('Hours vs decisions percentage');
% figure;
% scatter(hr,attraction);
% title('Hours vs attraction');

figure;
subplot(2,2,1);
plot(attractionavg);
subplot(2,2,2);
plot(dpercentageavg);
