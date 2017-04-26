%This will Group the flies according to different condition

%file = uigetfile;
clear all;
load('flydatabase');%Load fly database
water_thirsty = [];
water_non_thirsty = [];
no_water_thirsty = [];
water_thirsty = findobj(flydatabase,'desiccation_hr',12,'water','Y');
water_non_thirsty = findobj(flydatabase,'desiccation_hr',0,'water','Y');
no_water_thirsty = findobj(flydatabase,'water','N');
water_thirsty_out = findobj(flydatabase,'desiccation_hr',12,'water','Y','startout',1);



subplot(4,4,1);%Attraction index
grp = [ones(1,length([water_non_thirsty.attraction])), 2*ones(1,length([no_water_thirsty.attraction])),3*ones(1,length([water_thirsty.attraction]))];
%A grouping matrix indicating where each group ends
attraction = horzcat([water_non_thirsty.attraction],[no_water_thirsty.attraction],[water_thirsty.attraction]);
%Concat every fly data
boxplot(attraction, grp);
[attractionp,tbl] = anova1(attraction,grp,'off')%One way anova for this parameter
stringtitle = strcat('P value: ',num2str(attractionp));
xlabel(stringtitle);
title('Attraction');
ylabel('Portion Time spent in target');


subplot(4,4,2)
grp = [ones(1,length([water_non_thirsty.avgspeed])), 2*ones(1,length([no_water_thirsty.avgspeed])),3*ones(1,length([water_thirsty.avgspeed]))];
%A grouping matrix indicating where each group ends
speed = vertcat(water_non_thirsty.avgspeed,no_water_thirsty.avgspeed,water_thirsty.avgspeed);
boxplot(speed,grp);
[speedp,tb2] = anova1(speed,grp,'off')%One way anova for this parameter
title('Locomotion')
ylabel('Pixels per frame')
stringtitle = strcat('P value: ',num2str(speedp));
xlabel(stringtitle);

subplot(4,4,3)% Run duration
grp = [ones(1,length([water_non_thirsty.runs])), 2*ones(1,length([no_water_thirsty.runs])),3*ones(1,length([water_thirsty.runs]))];
runs = vertcat(water_non_thirsty.runs,no_water_thirsty.runs,water_thirsty.runs);
boxplot(runs,grp);
[runsp,tb3] = anova1(runs,grp,'off')%One way anova for this parameter
title('Run duration');
stringtitle = strcat('P value: ',num2str(runsp));
xlabel(stringtitle);

subplot(4,4,4)% Stop duration
grp = [ones(1,length([water_non_thirsty.stops])), 2*ones(1,length([no_water_thirsty.stops])),3*ones(1,length([water_thirsty.stops]))];
stops = vertcat(water_non_thirsty.stops,no_water_thirsty.stops,water_thirsty.stops);
boxplot(stops,grp);
[stopsp,tb4] = anova1(stops,grp,'off')%One way anova for this parameter
title('Stop duration');
stringtitle = strcat('P value: ',num2str(stopsp));
xlabel(stringtitle);

subplot(4,4,5)%Inner speed
grp = [ones(1,length([water_non_thirsty.innerspeed])), 2*ones(1,length([no_water_thirsty.innerspeed])),3*ones(1,length([water_thirsty.innerspeed]))];
innerspeed = horzcat([water_non_thirsty.innerspeed],[no_water_thirsty.innerspeed],[water_thirsty.innerspeed]);
boxplot(innerspeed,grp);
[innerspeedp,tb5] = anova1(innerspeed,grp,'off')%One way anova for this parameter
title('Inner Speed');
stringtitle = strcat('P value: ',num2str(innerspeedp));
xlabel(stringtitle);

subplot(4,4,6)%Mid speed
grp = [ones(1,length([water_non_thirsty.midspeed])), 2*ones(1,length([no_water_thirsty.midspeed])),3*ones(1,length([water_thirsty.midspeed]))];
midspeed = horzcat([water_non_thirsty.midspeed],[no_water_thirsty.midspeed],[water_thirsty.midspeed]);
boxplot(midspeed,grp);
[midspeedp,tb6] = anova1(midspeed,grp,'off')%One way anova for this parameter
title('Mid Speed');
stringtitle = strcat('P value: ',num2str(midspeedp));
xlabel(stringtitle);

subplot(4,4,7)%Outer Speed
grp = [ones(1,length([water_non_thirsty.outerspeed])), 2*ones(1,length([no_water_thirsty.outerspeed])),3*ones(1,length([water_thirsty.outerspeed]))];
outerspeed = horzcat([water_non_thirsty.outerspeed],[no_water_thirsty.outerspeed],[water_thirsty.outerspeed]);
[outerspeedp,tb7] = anova1(outerspeed,grp,'off')%One way anova for this parameter
boxplot(outerspeed,grp);
title('Outer Speed');
stringtitle = strcat('P value: ',num2str(outerspeedp));
xlabel(stringtitle);


subplot(4,4,8)
grp = [ones(1,length([water_non_thirsty.firstenter])), 2*ones(1,length([no_water_thirsty.firstenter])),3*ones(1,length([water_thirsty.firstenter]))];
firstenter = horzcat([water_non_thirsty.firstenter],[no_water_thirsty.firstenter],[water_thirsty.firstenter]);
[firstenterp,tb8] = anova1(firstenter,grp,'off')%One way anova for this parameter
boxplot(firstenter,grp);
title('First Enter');
stringtitle = strcat('P value: ',num2str(firstenterp));
xlabel(stringtitle);

subplot(4,4,9)
% grp = [ones(1,length([water_non_thirsty.eachtimeini])), 2*ones(1,length([no_water_thirsty.eachtimeini])),3*ones(1,length([water_thirsty.eachtimeini]))];
% eachtimeini = horzcat([water_non_thirsty.eachtimeini],[no_water_thirsty.eachtimeini],[water_thirsty.eachtimeini]);
% boxplot(eachtimeini,grp)
% title('Each time spent in target zone')

% grp = [ones(1,length(vertcat(water_non_thirsty.avgcurvature))),2*ones(1,length(vertcat(no_water_thirsty.avgcurvature))),3*ones(1,length(vertcat(water_thirsty.avgcurvature)))];
% curvature =  vertcat(water_non_thirsty.avgcurvature,no_water_thirsty.avgcurvature,water_thirsty.avgcurvature);
% boxplot(curvature,grp);
% title('curvature');

subplot(4,4,9);
grp = [ones(1,length(vertcat(water_non_thirsty.size5avgangle))),2*ones(1,length(vertcat(no_water_thirsty.size5avgangle))),3*ones(1,length(vertcat(water_thirsty.size5avgangle)))];
size5avgangle =  vertcat(water_non_thirsty.size5avgangle,no_water_thirsty.size5avgangle,water_thirsty.size5avgangle);
boxplot(size5avgangle,grp);
[size5avganglep,tb9] = anova1(size5avgangle,grp,'off')%One way anova for this parameter
title('Anlges turned');
stringtitle = strcat('P value: ',num2str(size5avganglep));
xlabel(stringtitle);

subplot(4,4,10)
grp = [ones(1,length(vertcat(water_non_thirsty.size5sharpturn))),2*ones(1,length(vertcat(no_water_thirsty.size5sharpturn))),3*ones(1,length(vertcat(water_thirsty.size5sharpturn)))];
size5sharpturn =  vertcat(water_non_thirsty.size5sharpturn,no_water_thirsty.size5sharpturn,water_thirsty.size5sharpturn);
boxplot(size5sharpturn,grp);
[size5sharpturnp,tb10] = anova1(size5sharpturn,grp,'off')%One way anova for this parameter
title('Total Sharp turns');
stringtitle = strcat('P value: ',num2str(size5sharpturnp));
xlabel(stringtitle);

subplot(4,4,11)
