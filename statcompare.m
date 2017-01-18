%Compare population stat with different condition
%Input is popstat


%The main function
function statcompare()

  mydir = uigetdir;
  myFiles = dir(fullfile(mydir,'*.mat'));
  popstat = [];


stats = struct('attraction',[],'avgspeed',[],'drate',[],'correctd',[],'wrongd',[],'innerspeed',[],'midspeed',[],...
            'outerspeed',[],'avgwd',[],'avgcd',[],'avgd',[],'filelength',[],'totald',[],'runs',[],'stops',[]);

            stats = loopthrough(stats,myFiles);
            stats = calculations(stats);
            display(stats);


end

%Loop through all popstat files

 function stats = loopthrough(stats,myFiles)

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
      disp('Runs');
      disp(popstat.avgruns);

      stats.filelength = [stats.filelength; length(popstat.dis2center)];
      stats.innerspeed = [stats.innerspeed;popstat.avginnerspeed];
      stats.midspeed = [stats.midspeed;popstat.avgmidspeed];
      stats.outerspeed = [stats.outerspeed;popstat.avgouterspeed];
      stats.attraction = [stats.attraction;popstat.avgattraction];
      stats.avgspeed = [stats.avgspeed;popstat.avgspeed];
      stats.drate = [stats.drate;popstat.drate];
      stats.correctd = [stats.correctd;popstat.avgcorrectd];
      stats.wrongd = [stats.wrongd;popstat.avgwrongd];
      stats.runs = [stats.runs;popstat.avgruns];
      stats.stops = [stats.stops;popstat.avgstops];
    end
end
%recalculate parameters
function stats = calculations(stats)
  stats.runs

  stats.totald = stats.correctd + stats.wrongd;
  stats.avgd = stats.filelength ./ stats.totald;% Average frames needed to make one decision
  stats.avgwd = stats.filelength ./ stats.wrongd;%Average frames needed to make one wrong decision
  stats.avgcd = stats.filelength ./ stats.correctd;%Average frames needed to make one right decision

  stats.runs = stats.filelength./stats.runs;
  stats.stops = stats.filelength ./ stats.stops;
stats.filelength
end


function  display(stats)

  figure;
  hold on;

  subplot(3,3,1);
  plot(stats.attraction);
  title('Attraction');

  subplot(3,3,2);
  plot(stats.avgspeed);
  title('Average Speed');

  subplot(3,3,3);
  plot(stats.avgcd);
  title('Frames per Correct Decision');

  subplot(3,3,4);
  plot(stats.avgwd);
  title('Frames per Wrong Decision');

  subplot(3,3,5);
  plot(stats.innerspeed);
  title('Innerspeed');

  subplot(3,3,6);
  plot(stats.midspeed);
  title('Mid Speed');

  subplot(3,3,7);
  plot(stats.outerspeed);
  title('Outer Speed');

  subplot(3,3,8);
  plot(stats.avgd);
  title('Frames per decision');

  subplot(3,3,9);
  plot(stats.drate);
  title('Decisions percentage');

  figure;
  subplot(3,3,1);
  plot(stats.runs);
  title('Frames per run');

  subplot(3,3,2);
  plot(stats.stops);
  title('Stops per frame')
  end
