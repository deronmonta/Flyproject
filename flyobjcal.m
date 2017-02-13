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
ten_hr_fly = [];
eleven_hr_fly = [];
twlve_hr_fly = [];
hr = [];
attraction = [];
normal_fly = findobj(flydatabase,'genotype','Wildtype');
zero_hr_fly = findobj(flydatabase,'desiccation_hr',0,'genotype','Wildtype');
one_hr_fly = findobj(flydatabase,'desiccation_hr',1,'genotype','Wildtype');
two_hr_fly = findobj(flydatabase,'desiccation_hr',2,'genotype','Wildtype');
three_hr_fly = findobj(flydatabase,'desiccation_hr',3,'genotype','Wildtype');
four_hr_fly = findobj(flydatabase,'desiccation_hr',4,'genotype','Wildtype');
five_hr_fly = findobj(flydatabase,'desiccation_hr',5,'genotype','Wildtype');
six_hr_fly = findobj(flydatabase,'desiccation_hr',6,'genotype','Wildtype');
seven_hr_fly = findobj(flydatabase,'desiccation_hr',7,'genotype','Wildtype');
eight_hr_fly = findobj(flydatabase,'desiccation_hr',8,'genotype','Wildtype');
nine_hr_fly = findobj(flydatabase,'desiccation_hr',9,'genotype','Wildtype');
ten_hr_fly = findobj(flydatabase,'desiccation_hr',10,'genotype','Wildtype');
eleven_hr_fly = findobj(flydatabase,'desiccation_hr',11,'genotype','Wildtype');
twlve_hr_fly = findobj(flydatabase,'desiccation_hr',12,'genotype','Wildtype');
rna_fly = findobj(flydatabase,'genotype','IR40aRNAi');
no_water = findobj(flydatabase,'genotype','Wildtype, No water control');
% one_hr_fly.zone = [one_hr_fly.zone']
% Atrraction1 = find([one_hr_fly.zone] == 'i')/length([one_hr_fly.zone])


attractionavg = [nanmedian([zero_hr_fly.attraction])
nanmedian([one_hr_fly.attraction])
nanmedian([two_hr_fly.attraction])
nanmedian([three_hr_fly.attraction])
nanmedian([four_hr_fly.attraction])
nanmedian([five_hr_fly.attraction])
nanmedian([six_hr_fly.attraction])
nanmedian([seven_hr_fly.attraction])
nanmedian([eight_hr_fly.attraction])
nanmedian([nine_hr_fly.attraction])
nanmedian([ten_hr_fly.attraction])
nanmedian([eleven_hr_fly.attraction])
nanmedian([twlve_hr_fly.attraction])];

dpercentageavg = [nanmedian([zero_hr_fly.dpercentage])
nanmedian([one_hr_fly.dpercentage])
nanmedian([two_hr_fly.dpercentage])
nanmedian([three_hr_fly.dpercentage])
nanmedian([four_hr_fly.dpercentage])
nanmedian([five_hr_fly.dpercentage])
nanmedian([six_hr_fly.dpercentage])
nanmedian([seven_hr_fly.dpercentage])
nanmedian([eight_hr_fly.dpercentage])
nanmedian([nine_hr_fly.dpercentage])
nanmedian([ten_hr_fly.dpercentage])
nanmedian([eleven_hr_fly.dpercentage])
nanmedian([twlve_hr_fly.dpercentage])];

speedavg = [nanmedian([zero_hr_fly.avgspeed])
nanmedian([one_hr_fly.avgspeed])
nanmedian([two_hr_fly.avgspeed])
nanmedian([three_hr_fly.avgspeed])
nanmedian([four_hr_fly.avgspeed])
nanmedian([five_hr_fly.avgspeed])
nanmedian([six_hr_fly.avgspeed])
nanmedian([seven_hr_fly.avgspeed])
nanmedian([eight_hr_fly.avgspeed])
nanmedian([nine_hr_fly.avgspeed])
nanmedian([ten_hr_fly.avgspeed])
nanmedian([eleven_hr_fly.avgspeed])
nanmedian([twlve_hr_fly.avgspeed])];

sharpturns = [nanmedian([zero_hr_fly.sharpturn])
nanmedian([one_hr_fly.sharpturn])
nanmedian([two_hr_fly.sharpturn])
nanmedian([three_hr_fly.sharpturn])
nanmedian([four_hr_fly.sharpturn])
nanmedian([five_hr_fly.sharpturn])
nanmedian([six_hr_fly.sharpturn])
nanmedian([seven_hr_fly.sharpturn])
nanmedian([eight_hr_fly.sharpturn])
nanmedian([nine_hr_fly.sharpturn])
nanmedian([ten_hr_fly.sharpturn])
nanmedian([eleven_hr_fly.sharpturn])
nanmedian([twlve_hr_fly.sharpturn])];

innerspeed = [nanmedian([[zero_hr_fly.innerspeed]])
nanmedian([one_hr_fly.innerspeed])
nanmedian([two_hr_fly.innerspeed])
nanmedian([three_hr_fly.innerspeed])
nanmedian([four_hr_fly.innerspeed])
nanmedian([five_hr_fly.innerspeed])
nanmedian([six_hr_fly.innerspeed])
nanmedian([seven_hr_fly.innerspeed])
nanmedian([eight_hr_fly.innerspeed])
nanmedian([nine_hr_fly.innerspeed])
nanmedian([ten_hr_fly.innerspeed])
nanmedian([eleven_hr_fly.innerspeed])
nanmedian([twlve_hr_fly.innerspeed])];

midspeed = [nanmedian([[zero_hr_fly.midspeed]])
nanmedian([one_hr_fly.midspeed])
nanmedian([two_hr_fly.midspeed])
nanmedian([three_hr_fly.midspeed])
nanmedian([four_hr_fly.midspeed])
nanmedian([five_hr_fly.midspeed])
nanmedian([six_hr_fly.midspeed])
nanmedian([seven_hr_fly.midspeed])
nanmedian([eight_hr_fly.midspeed])
nanmedian([nine_hr_fly.midspeed])
nanmedian([twlve_hr_fly.midspeed])];

totaldecisions = [nanmedian([[zero_hr_fly.totald]])
nanmedian([one_hr_fly.totald])
nanmedian([two_hr_fly.totald])
nanmedian([three_hr_fly.totald])
nanmedian([four_hr_fly.totald])
nanmedian([five_hr_fly.totald])
nanmedian([six_hr_fly.totald])
nanmedian([seven_hr_fly.totald])
nanmedian([eight_hr_fly.totald])
nanmedian([nine_hr_fly.totald])
nanmedian([ten_hr_fly.totald])
nanmedian([eleven_hr_fly.totald])
nanmedian([twlve_hr_fly.totald])];

correctd = [nanmedian([[zero_hr_fly.correctd]])
nanmedian([one_hr_fly.correctd])
nanmedian([two_hr_fly.correctd])
nanmedian([three_hr_fly.correctd])
nanmedian([four_hr_fly.correctd])
nanmedian([five_hr_fly.correctd])
nanmedian([six_hr_fly.correctd])
nanmedian([seven_hr_fly.correctd])
nanmedian([eight_hr_fly.correctd])
nanmedian([nine_hr_fly.correctd])
nanmedian([twlve_hr_fly.correctd])];

runsavg = [nanmedian([zero_hr_fly.runs])
nanmedian([one_hr_fly.runs])
nanmedian([two_hr_fly.runs])
nanmedian([three_hr_fly.runs])
nanmedian([four_hr_fly.runs])
nanmedian([five_hr_fly.runs])
nanmedian([six_hr_fly.runs])
nanmedian([seven_hr_fly.runs])
nanmedian([eight_hr_fly.runs])
nanmedian([nine_hr_fly.runs])
nanmedian([ten_hr_fly.runs])
nanmedian([eleven_hr_fly.runs])
nanmedian([twlve_hr_fly.runs])];

stopsavg = [nanmedian([zero_hr_fly.stops])
nanmedian([one_hr_fly.stops])
nanmedian([two_hr_fly.stops])
nanmedian([three_hr_fly.stops])
nanmedian([four_hr_fly.stops])
nanmedian([five_hr_fly.stops])
nanmedian([six_hr_fly.stops])
nanmedian([seven_hr_fly.stops])
nanmedian([eight_hr_fly.stops])
nanmedian([nine_hr_fly.stops])
nanmedian([ten_hr_fly.stops])
nanmedian([eleven_hr_fly.stops])
nanmedian([twlve_hr_fly.stops])];

firstenter = [nanmean([zero_hr_fly.firstenter])
nanmean([one_hr_fly.firstenter])
nanmean([two_hr_fly.firstenter])
nanmean([three_hr_fly.firstenter])
nanmean([four_hr_fly.firstenter])
nanmean([five_hr_fly.firstenter])
nanmean([six_hr_fly.firstenter])
nanmean([seven_hr_fly.firstenter])
nanmean([eight_hr_fly.firstenter])
nanmean([nine_hr_fly.firstenter])
nanmean([ten_hr_fly.firstenter])
nanmean([eleven_hr_fly.firstenter])
nanmean([twlve_hr_fly.firstenter])
nanmean([no_water.firstenter])];

dperframe = [nanmedian([zero_hr_fly.dperframe])
nanmedian([one_hr_fly.dperframe])
nanmedian([two_hr_fly.dperframe])
nanmedian([three_hr_fly.dperframe])
nanmedian([four_hr_fly.dperframe])
nanmedian([five_hr_fly.dperframe])
nanmedian([six_hr_fly.dperframe])
% nanmedian([seven_hr_fly.dperframe])
nanmedian([eight_hr_fly.dperframe])
nanmedian([nine_hr_fly.dperframe])
nanmedian([ten_hr_fly.dperframe])
nanmedian([eleven_hr_fly.dperframe])
nanmedian([twlve_hr_fly.dperframe])];

runchance = [nanmedian([zero_hr_fly.runchance])
nanmedian([one_hr_fly.runchance])
nanmedian([two_hr_fly.runchance])
nanmedian([three_hr_fly.runchance])
nanmedian([four_hr_fly.runchance])
nanmedian([five_hr_fly.runchance])
nanmedian([six_hr_fly.runchance])
nanmedian([seven_hr_fly.runchance])
nanmedian([eight_hr_fly.runchance])
nanmedian([nine_hr_fly.runchance])
nanmedian([ten_hr_fly.runchance])
nanmedian([eleven_hr_fly.runchance])
nanmedian([twlve_hr_fly.runchance])];

stopchance = [nanmedian([zero_hr_fly.stopchance])
nanmedian([one_hr_fly.stopchance])
nanmedian([two_hr_fly.stopchance])
nanmedian([three_hr_fly.stopchance])
nanmedian([four_hr_fly.stopchance])
nanmedian([five_hr_fly.stopchance])
nanmedian([six_hr_fly.stopchance])
nanmedian([seven_hr_fly.stopchance])
nanmedian([eight_hr_fly.stopchance])
nanmedian([nine_hr_fly.stopchance])
nanmedian([ten_hr_fly.stopchance])
nanmedian([eleven_hr_fly.stopchance])
nanmedian([twlve_hr_fly.stopchance])];

enterspeed = [nanmedian([zero_hr_fly.enterspeedavg])
nanmedian([one_hr_fly.enterspeedavg])
nanmedian([two_hr_fly.enterspeedavg])
nanmedian([three_hr_fly.enterspeedavg])
nanmedian([four_hr_fly.enterspeedavg])
nanmedian([five_hr_fly.enterspeedavg])
nanmedian([six_hr_fly.enterspeedavg])
nanmedian([seven_hr_fly.enterspeedavg])
%nanmedian([eight_hr_fly.enterspeedavg])
nanmedian([nine_hr_fly.enterspeedavg])
nanmedian([ten_hr_fly.enterspeedavg])
nanmedian([eleven_hr_fly.enterspeedavg])
nanmedian([twlve_hr_fly.enterspeedavg])];



% for N = 1 : length(flydatabase)
%   if flydatabase(N).desiccation_hr == 0
%     zero_hr_fly = [zero_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 1
%     one_hr_fly = [one_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 2
%     two_hr_fly = [two_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 3
%     three_hr_fly = [three_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 4
%     four_hr_fly = [four_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 5
%     five_hr_fly = [five_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 6
%     six_hr_fly = [six_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 7
%     seven_hr_fly = [seven_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 8
%     eight_hr_fly = [eight_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 9
%     nine_hr_fly = [nine_hr_fly;flydatabase(N)];
%   end
%   if flydatabase(N).desiccation_hr == 12
%     twlve_hr_fly = [twlve_hr_fly;flydatabase(N)];
%   end %Group in to different desiccation hours Group by different hours
% end

% for K = 1 : length(flydatabase) %Sort by desiccation hours
%   hr = [hr;flydatabase(K).desiccation_hr];
%   speed = [dpercentage;flydatabase(K).dpercentage];
%   attraction = [attraction;flydatabase(K).attraction];
% end


% scatter(hr,dpercentage);
% title('Hours vs decisions percentage');
% figure;
% scatter(hr,attraction);
% title('Hours vs attraction');

figure;
subplot(3,3,1);
boxplot([normal_fly.attraction],[normal_fly.desiccation_hr]);
title('Attraction')

subplot(3,3,2)
boxplot([normal_fly.enterspeedavg],[normal_fly.desiccation_hr]);
title('Enterspeed');

subplot(3,3,3)
boxplot([normal_fly.innerspeed],[normal_fly.desiccation_hr]);
title('Innerspeed');

subplot(3,3,4)
boxplot([normal_fly.dperframe],[normal_fly.desiccation_hr]);
title('Frames per decision');


subplot(3,3,5)
boxplot([normal_fly.dpercentage],[normal_fly.desiccation_hr]);
title('Decision percentage');


figure;
subplot(3,3,1)
histogram(fix(vertcat(zero_hr_fly.dis2center)));
title('0 hr ');
subplot(3,3,2)
histogram(fix(vertcat(one_hr_fly.dis2center)));
title('1 hr ');
subplot(3,3,3)
histogram(fix(vertcat(two_hr_fly.dis2center)));
title('2 hr ');
subplot(3,3,4)
histogram(fix(vertcat(three_hr_fly.dis2center)));
title('3 hr ');
subplot(3,3,5)
histogram(fix(vertcat(four_hr_fly.dis2center)));
title('4 hr ');
subplot(3,3,6)
histogram(fix(vertcat(five_hr_fly.dis2center)));
title('5 hr ');
subplot(3,3,7)
histogram(fix(vertcat(six_hr_fly.dis2center)));
title('6 hr ');
subplot(3,3,8)
histogram(fix(vertcat(seven_hr_fly.dis2center)));
title('7 hr ');
subplot(3,3,9)
histogram(fix(vertcat(eight_hr_fly.dis2center)));
title('8 hr ');

figure;
subplot(3,3,1)
histogram(fix(vertcat(nine_hr_fly.dis2center)));
title('9 hr ');
subplot(3,3,2)
histogram(fix(vertcat(ten_hr_fly.dis2center)));
title('10 hr ');
subplot(3,3,3)
histogram(fix(vertcat(eleven_hr_fly.dis2center)));
title('11 hr ');
subplot(3,3,4)
histogram(fix(vertcat(twlve_hr_fly.dis2center)));
title('12 hr ');

subplot(3,3,5)
histogram(fix(vertcat(no_water.dis2center)));
title('No water');





% subplot(3,3,6)
% [normal_fly.firstenter]
% % normal_fly.firstenter(isnan(normal_fly.firstenter)) = [];
% boxplot([normal_fly.firstenter],[normal_fly.desiccation_hr]);
% title('First enter');
