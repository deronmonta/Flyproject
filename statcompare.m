%Compare population stat with different condition
%Input is popstat


  mydir = uigetdir;
  myFiles = dir(fullfile(mydir,'*.mat'));
  popstat = [];

figure;
hold on;
attraction = [];
avgspeed = [];
drate =[];
correctd = [];
wrongd = [];
innerspeed = [];
midspeed = [];
outerspeed = [];
avgwd = [];
avgcd = [];
avgd = [];
filelength = [];
totoald = [];
attraction2 = [];

    for N = 1 : length(myFiles)%Load every tracks file in directory

      disp(myFiles(N).name);
      load(myFiles(N).name);
      disp('Average Speed');
      disp(popstat.avgspeed);
      disp('Atrraction index');
      disp(popstat.avgattraction);
      disp('Decisions percentage');
      disp(popstat.drate);
      disp('Correct Decisions');
      disp(popstat.avgcorrectd);
      disp('Wrong Decisions');
      disp(popstat.avgwrongd);

      filelength = [filelength; length(popstat.dis2center)];
      innerspeed = [innerspeed;popstat.avginnerspeed];
      midspeed = [midspeed;popstat.avgmidspeed];
      outerspeed = [outerspeed;popstat.avgouterspeed];
      attraction = [attraction;popstat.avgattraction];
      avgspeed = [avgspeed;popstat.avgspeed];
      drate = [drate;popstat.drate];
      correctd = [correctd;popstat.avgcorrectd];
      wrongd = [wrongd;popstat.avgwrongd];
      totald = correctd + wrongd;
      attraction2 = [attraction2;popstat.attraction2];

      avgd = filelength ./ totald;% Average frames needed to make one decision
      avgwd = filelength ./ wrongd;%Average frames needed to make one wrong decision
      avgcd = filelength ./ correctd;%Average frames needed to make one right decision
    end

    %disp(drate);
    disp(wrongd);
disp(filelength);
disp(totald);
disp(avgd);
subplot(3,3,1);
plot(attraction);
title('Attraction');


subplot(3,3,2);
plot(avgspeed);
title('Average Speed');

subplot(3,3,3);
plot(avgcd);
title('Frames per Correct Decision');

subplot(3,3,4);
plot(avgwd);
title('Frames per Wrong Decision');



subplot(3,3,5);
plot(innerspeed);
title('Innerspeed');

subplot(3,3,6);
plot(midspeed);
title('Mid Speed');

subplot(3,3,7);
plot(outerspeed);
title('Outer Speed');

subplot(3,3,8);
plot(avgd);
title('Frames per decision');

subplot(3,3,9);
plot(attraction2);
title('New attracion index');
