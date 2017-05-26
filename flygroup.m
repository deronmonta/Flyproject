%This will Group the flies according to different condition

%file = uigetfile;
clear all;
load('flydatabase');%Load fly database
water_thirsty = [];
water_non_thirsty = [];
no_water_thirsty = [];
no_water_non_thirsty = [];
no_water_non_thirsty = findobj(flydatabase,'desiccation_hr',0,'water','N');
water_thirsty = findobj(flydatabase,'desiccation_hr',25,'water','Y');
water_non_thirsty = findobj(flydatabase,'desiccation_hr',0,'water','Y');
no_water_thirsty = findobj(flydatabase,'water','N');
water_thirsty_out = findobj(flydatabase,'desiccation_hr',25,'water','Y','startout',1);



subplot(4,4,1);%Attraction index
grp = [ones(1,length([no_water_non_thirsty.attraction])), 2*ones(1,length([water_non_thirsty.attraction])),3*ones(1,length([no_water_thirsty.attraction])),4*ones(1,length([water_thirsty.attraction]))];
%A grouping matrix indicating where each group ends
attraction = horzcat([no_water_non_thirsty.attraction],[water_non_thirsty.attraction],[no_water_thirsty.attraction],[water_thirsty.attraction]);
%Concat every fly data
boxplot(attraction, grp);
[attractionp,tbl] = anova1(attraction,grp,'off')%One way anova for this parameter
stringtitle = strcat('P value: ',num2str(attractionp));
xlabel(stringtitle);
title('Attraction');
ylabel('Portion Time spent in target');


subplot(4,4,2)
grp = [ones(1,length([no_water_non_thirsty.avgspeed])), 2*ones(1,length([water_non_thirsty.avgspeed])),3*ones(1,length([no_water_thirsty.avgspeed])),4*ones(1,length([water_thirsty.avgspeed]))];
%A grouping matrix indicating where each group ends
speed = horzcat([no_water_non_thirsty.avgspeed],[water_non_thirsty.avgspeed],[no_water_thirsty.avgspeed],[water_thirsty.avgspeed]);
boxplot(speed,grp);
[speedp,tb2] = anova1(speed,grp,'off')%One way anova for this parameter
title('Locomotion')
ylabel('Pixels per frame')
stringtitle = strcat('P value: ',num2str(speedp));
xlabel(stringtitle);

subplot(4,4,3)% Run duration
grp = [ones(1,length([no_water_non_thirsty.runs])), 2*ones(1,length([water_non_thirsty.runs])),3*ones(1,length([no_water_thirsty.runs])),4*ones(1,length([water_thirsty.runs]))];
runs = horzcat([no_water_non_thirsty.runs],[water_non_thirsty.runs],[no_water_thirsty.runs],[water_thirsty.runs]);
boxplot(runs,grp);
[runsp,tb3] = anova1(runs,grp,'off')%One way anova for this parameter
title('Run duration');
stringtitle = strcat('P value: ',num2str(runsp));
xlabel(stringtitle);

subplot(4,4,4)% Stop duration
grp = [ones(1,length([no_water_non_thirsty.stops])), 2*ones(1,length([water_non_thirsty.stops])),3*ones(1,length([no_water_thirsty.stops])),4*ones(1,length([water_thirsty.stops]))];
stops = horzcat([no_water_non_thirsty.stops],[water_non_thirsty.stops],[no_water_thirsty.stops],[water_thirsty.stops]);
boxplot(stops,grp);
[stopsp,tb4] = anova1(stops,grp,'off')%One way anova for this parameter
title('Stop duration');
stringtitle = strcat('P value: ',num2str(stopsp));
xlabel(stringtitle);

subplot(4,4,5)%Inner speed
grp = [ones(1,length([no_water_non_thirsty.innerspeed])), 2*ones(1,length([water_non_thirsty.innerspeed])),3*ones(1,length([no_water_thirsty.innerspeed])),4*ones(1,length([water_thirsty.innerspeed]))];
innerspeed = horzcat([no_water_non_thirsty.innerspeed],[water_non_thirsty.innerspeed],[no_water_thirsty.innerspeed],[water_thirsty.innerspeed]);
boxplot(innerspeed,grp);
[innerspeedp,tb5] = anova1(innerspeed,grp,'off')%One way anova for this parameter
title('Inner Speed');
stringtitle = strcat('P value: ',num2str(innerspeedp));
xlabel(stringtitle);

subplot(4,4,6)%Mid speed
grp = [ones(1,length([no_water_non_thirsty.midspeed])), 2*ones(1,length([water_non_thirsty.midspeed])),3*ones(1,length([no_water_thirsty.midspeed])),4*ones(1,length([water_thirsty.midspeed]))];
midspeed = horzcat([no_water_non_thirsty.midspeed],[water_non_thirsty.midspeed],[no_water_thirsty.midspeed],[water_thirsty.midspeed]);
boxplot(midspeed,grp);
[midspeedp,tb6] = anova1(midspeed,grp,'off')%One way anova for this parameter
title('Mid Speed');
stringtitle = strcat('P value: ',num2str(midspeedp));
xlabel(stringtitle);

subplot(4,4,7)%Outer Speed
grp = [ones(1,length([no_water_non_thirsty.outerspeed])), 2*ones(1,length([water_non_thirsty.outerspeed])),3*ones(1,length([no_water_thirsty.outerspeed])),4*ones(1,length([water_thirsty.outerspeed]))];
outerspeed = horzcat([no_water_non_thirsty.outerspeed],[water_non_thirsty.outerspeed],[no_water_thirsty.outerspeed],[water_thirsty.outerspeed]);
[outerspeedp,tb7] = anova1(outerspeed,grp,'off')%One way anova for this parameter
boxplot(outerspeed,grp);
title('Outer Speed');
stringtitle = strcat('P value: ',num2str(outerspeedp));
xlabel(stringtitle);


subplot(4,4,8)
grp = [ones(1,length([no_water_non_thirsty.firstenter])), 2*ones(1,length([water_non_thirsty.firstenter])),3*ones(1,length([no_water_thirsty.firstenter])),4*ones(1,length([water_thirsty.firstenter]))];
firstenter = horzcat([no_water_non_thirsty.firstenter],[water_non_thirsty.firstenter],[no_water_thirsty.firstenter],[water_thirsty.firstenter]);
[firstenterp,tb8] = anova1(firstenter,grp,'off')%One way anova for this parameter
boxplot(firstenter,grp);
title('First Enter');
stringtitle = strcat('P value: ',num2str(firstenterp));
xlabel(stringtitle);

% subplot(4,4,9)
% grp = [ones(1,length([water_non_thirsty.eachtimeini])), 2*ones(1,length([no_water_thirsty.eachtimeini])),3*ones(1,length([water_thirsty.eachtimeini]))];
% eachtimeini = horzcat([water_non_thirsty.eachtimeini],[no_water_thirsty.eachtimeini],[water_thirsty.eachtimeini]);
% boxplot(eachtimeini,grp)
% title('Each time spent in target zone')

% grp = [ones(1,length(horzcat(water_non_thirsty.avgcurvature))),2*ones(1,length(horzcat(no_water_thirsty.avgcurvature))),3*ones(1,length(horzcat(water_thirsty.avgcurvature)))];
% curvature =  horzcat(water_non_thirsty.avgcurvature,no_water_thirsty.avgcurvature,water_thirsty.avgcurvature);
% boxplot(curvature,grp);
% title('curvature');

subplot(4,4,9);
grp = [ones(1,length([no_water_non_thirsty.size5avgangle])), 2*ones(1,length([water_non_thirsty.size5avgangle])),3*ones(1,length([no_water_thirsty.size5avgangle])),4*ones(1,length([water_thirsty.size5avgangle]))];
size5avgangle =  horzcat([no_water_non_thirsty.size5avgangle],[water_non_thirsty.size5avgangle],[no_water_thirsty.size5avgangle],[water_thirsty.size5avgangle]);
boxplot(size5avgangle,grp);
[size5avganglep,tb9] = anova1(size5avgangle,grp,'off')%One way anova for this parameter
title('Anlges turned');
stringtitle = strcat('P value: ',num2str(size5avganglep));
xlabel(stringtitle);

subplot(4,4,10)
grp = [ones(1,length([no_water_non_thirsty.size5sharpturn])), 2*ones(1,length([water_non_thirsty.size5sharpturn])),3*ones(1,length([no_water_thirsty.size5sharpturn])),4*ones(1,length([water_thirsty.size5sharpturn]))];
size5sharpturn =  horzcat([no_water_non_thirsty.size5sharpturn],[water_non_thirsty.size5sharpturn],[no_water_thirsty.size5sharpturn],[water_thirsty.size5sharpturn]);
boxplot(size5sharpturn,grp);
[size5sharpturnp,tb10] = anova1(size5sharpturn,grp,'off')%One way anova for this parameter
title('Total Sharp turns');
stringtitle = strcat('P value: ',num2str(size5sharpturnp));
xlabel(stringtitle);

subplot(4,4,11)
grp = [ones(1,length([no_water_non_thirsty.avgsize5anglei])), 2*ones(1,length([water_non_thirsty.avgsize5anglei])),3*ones(1,length([no_water_thirsty.avgsize5anglei])),4*ones(1,length([water_thirsty.avgsize5anglei]))];
avgsize5anglei =  horzcat([no_water_non_thirsty.avgsize5anglei],[water_non_thirsty.avgsize5anglei],[no_water_thirsty.avgsize5anglei],[water_thirsty.avgsize5anglei]);
boxplot(avgsize5anglei,grp);
[avgsize5angleip,tb10] = anova1(avgsize5anglei,grp,'off')%One way anova for this parameter
title('Angle in Inner zone');
stringtitle = strcat('P value: ',num2str(avgsize5angleip));
xlabel(stringtitle);

subplot(4,4,12)
grp = [ones(1,length([no_water_non_thirsty.avgsize5anglem])), 2*ones(1,length([water_non_thirsty.avgsize5anglem])),3*ones(1,length([no_water_thirsty.avgsize5anglem])),4*ones(1,length([water_thirsty.avgsize5anglem]))];
avgsize5anglem =  horzcat([no_water_non_thirsty.avgsize5anglem],[water_non_thirsty.avgsize5anglem],[no_water_thirsty.avgsize5anglem],[water_thirsty.avgsize5anglem]);
boxplot(avgsize5anglem,grp);
[avgsize5anglemp,tb10] = anova1(avgsize5anglem,grp,'off')%One way anova for this parameter
title('Angle in Mid zone');
stringtitle = strcat('P value: ',num2str(avgsize5anglemp));
xlabel(stringtitle);

subplot(4,4,13)
grp = [ones(1,length([no_water_non_thirsty.avgsize5angleo])), 2*ones(1,length([water_non_thirsty.avgsize5angleo])),3*ones(1,length([no_water_thirsty.avgsize5angleo])),4*ones(1,length([water_thirsty.avgsize5angleo]))];
avgsize5angleo =  horzcat([no_water_non_thirsty.avgsize5angleo],[water_non_thirsty.avgsize5angleo],[no_water_thirsty.avgsize5angleo],[water_thirsty.avgsize5angleo]);
boxplot(avgsize5angleo,grp);
[avgsize5angleop,tb10] = anova1(avgsize5angleo,grp,'off')%One way anova for this parameter
title('Angle in Outer zone');
stringtitle = strcat('P value: ',num2str(avgsize5angleop));
xlabel(stringtitle);

subplot(4,4,14)
grp = [ones(1,length([no_water_non_thirsty.enterspeedavg])), 2*ones(1,length([water_non_thirsty.enterspeedavg])),3*ones(1,length([no_water_thirsty.enterspeedavg])),4*ones(1,length([water_thirsty.enterspeedavg]))];
enterspeedavg =  horzcat([no_water_non_thirsty.enterspeedavg],[water_non_thirsty.enterspeedavg],[no_water_thirsty.enterspeedavg],[water_thirsty.enterspeedavg]);
boxplot(enterspeedavg,grp);
[enterspeedavgp,tb10] = anova1(enterspeedavg,grp,'off')%One way anova for this parameter
title('Enter Speed');
stringtitle = strcat('P value: ',num2str(enterspeedavgp));
xlabel(stringtitle);

subplot(4,4,15)
grp = [ones(1,length([no_water_non_thirsty.exitspeedavg])), 2*ones(1,length([water_non_thirsty.exitspeedavg])),3*ones(1,length([no_water_thirsty.exitspeedavg])),4*ones(1,length([water_thirsty.exitspeedavg]))];
exitspeedavg =  horzcat([no_water_non_thirsty.exitspeedavg],[water_non_thirsty.exitspeedavg],[no_water_thirsty.exitspeedavg],[water_thirsty.exitspeedavg]);
boxplot(exitspeedavg,grp);
[exitspeedavgp,tb10] = anova1(exitspeedavg,grp,'off')%One way anova for this parameter
title('Exit Speed');
stringtitle = strcat('P value: ',num2str(exitspeedavgp));
xlabel(stringtitle);

subplot(4,4,16)
grp = [ones(1,length([no_water_non_thirsty.runsin])), 2*ones(1,length([water_non_thirsty.runsin])),3*ones(1,length([no_water_thirsty.runsin])),4*ones(1,length([water_thirsty.runsin]))];
runsin =  horzcat([no_water_non_thirsty.runsin],[water_non_thirsty.runsin],[no_water_thirsty.runsin],[water_thirsty.runsin]);
boxplot(runsin,grp);
[runsinp,tb10] = anova1(runsin,grp,'off')%One way anova for this parameter
title('Runs in target ');
stringtitle = strcat('P value: ',num2str(runsinp));
xlabel(stringtitle);


figure;

subplot(4,4,1)
grp = [ones(1,length([no_water_non_thirsty.eachtimeinmavg])), 2*ones(1,length([water_non_thirsty.eachtimeinmavg])),3*ones(1,length([no_water_thirsty.eachtimeinmavg])),4*ones(1,length([water_thirsty.eachtimeinmavg]))];
eachtimeinmavg =  horzcat([no_water_non_thirsty.eachtimeinmavg],[water_non_thirsty.eachtimeinmavg],[no_water_thirsty.eachtimeinmavg],[water_thirsty.eachtimeinmavg]);
boxplot(eachtimeinmavg,grp);
[eachtimeinmavgp,tb10] = anova1(eachtimeinmavg,grp,'off')%One way anova for this parameter
title('Time to Return');
stringtitle = strcat('P value: ',num2str(eachtimeinmavgp));
xlabel(stringtitle);

subplot(4,4,2)
grp = [ones(1,length([no_water_non_thirsty.eachtimeiniavg])), 2*ones(1,length([water_non_thirsty.eachtimeiniavg])),3*ones(1,length([no_water_thirsty.eachtimeiniavg])),4*ones(1,length([water_thirsty.eachtimeiniavg]))];
eachtimeiniavg =  horzcat([no_water_non_thirsty.eachtimeiniavg],[water_non_thirsty.eachtimeiniavg],[no_water_thirsty.eachtimeiniavg],[water_thirsty.eachtimeiniavg]);
boxplot(eachtimeiniavg,grp);
[eachtimeiniavgp,tb10] = anova1(eachtimeiniavg,grp,'off')%One way anova for this parameter
title('Average Time Span in Inner Zone');
stringtitle = strcat('P value: ',num2str(eachtimeiniavgp));
xlabel(stringtitle);
