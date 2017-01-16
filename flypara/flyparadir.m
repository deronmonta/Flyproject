
% This is a program built for analyzing the fly position extracted from mytracking
%This process an entire directory of user's choice
% This will produce a single fly stat for further processing

function flyparadir()

  disp('Choose file source');
  myDir = uigetdir;
  disp ('Choose output directory');
  savedir = uigetdir;
  disp(savedir);
  myFiles = dir(fullfile(myDir,'*.mat'));
  getallfiles(myFiles,savedir);



end


function getallfiles(myFiles,savedir)%Get all the files in directory and loop through them
  %------------------------------------------------------------------------------------------------



for N = 1:length(myFiles);%Loop through every file in the directory

disp(myFiles(N).name);


wholepos =[];
tracks = struct('fname',[],'wholepos',[],'dis2center',[],'speed',[],'angspeed',[],'innertimespan',[],'midtimespan',[],'attraction',[],'zonet',[],'runs',[],...
                'stops',[],'isini',[],'center',[],'radius',[],'targetzoneouter',[],'isinm',[],'sharpturn',[],...
                'isino',[],'innerspeed',[],'midspeed',[],'outerspeed',[],'inindex',[],'outindex',[],'midindex',[],'zone',[],...
                'dzonein',[],'dzoneout',[],'dzone',[],'correctd',[],'wrongd',[],'eachtimeini',[],'eachtimeinm',[],'eachtimeino',[],'savedir',[],'attraction2',[]);
tracks.center = [250 250];%Change the center of the dish here
tracks.radius = 250;% Change the radius of the plate here
tracks.targetzoneinner = 75;% Change this variable to reidentify the inner target zone.
tracks.targetzoneouter = 240;% Change this variable to reidentify the outter target zone.
<<<<<<< HEAD
tracks.dzoneri = 75; %This is the radius of inner decision zone
tracks.dzonero = 100; % This is the radius of outer decision zone
=======
tracks.dzoneri = 50; %This is the radius of inner decision zone
tracks.dzonero = 75; % This is the radius of outer decision zone
>>>>>>> origin/master
disp(savedir)
tracks.savedir = savedir;%This is the directory of where the files will be saved
tracks.fname = myFiles(N).name;
load(myFiles(N).name);

%---------------All the subfunctions below--------------------------------
tracks.wholepos = wholepos;%Assign wholepos to tracks
tracks = redefinetrack(tracks);
tracks = correction(tracks);
tracks = zonetime(tracks);%catagorize positions to three zones
tracks = timespan(tracks);
% tracks = findrunstop(tracks);
tracks = findaspeed(tracks);%Find the angular speed
displayresults(tracks);
exceloutput(tracks);
%--------------------subfunctions end here-------------------------------

%save tracks parameters
trackfname = strcat(tracks.fname,'tracks.mat');
save(fullfile(tracks.savedir,trackfname),'tracks');
% time = length(wholepos);
% totalframe = length(wholepos);
% realtime = ((time/30)*4);
close all;
end
end


%subfunctions starts here
%-------------------------------------------------------------------------------------------

function tracks = redefinetrack(tracks)

totalframe = length(tracks.wholepos)
  tracks.dis2center = zeros(totalframe);

  for i = 1 : totalframe

tracks.dis2center(i) = sqrt(sum((tracks.wholepos(i,:)-tracks.center(1,:)).^2));


  end

end


% Correct error value
function tracks = correction(tracks)


%Identify two kinds of error: distance error and speed error

diserror = find(tracks.dis2center > tracks.radius); % Get the indices of the error position

tracks.wholepos(diserror,:) = [];

tracks.dis2center(:) = [];

for i = 1 : length(tracks.wholepos)

tracks.dis2center(i) = sqrt(sum((tracks.wholepos(i,:)-tracks.center(1,:)).^2));


  end


tracks.speed =[];



%recalculate speed using corrected data
for i = 2:length(tracks.wholepos)


    tracks.speed = [tracks.speed;sqrt(sum((tracks.wholepos(i,:)-tracks.wholepos((i-1),:)).^2))];


end

speederror = find(tracks.speed > 40);% Find speed error using new speed

tracks.speedavg = tracks.speed;
tracks.speedavg(speederror,:) = [];


fprintf('dis2center');
disp(length(tracks.dis2center));
fprintf('speed');
disp(length(tracks.speed));
fprintf('wholepos');
disp(length(tracks.wholepos));
end



% This function returns the time fly spent in the target zone and the speed
% in the target zone
function tracks = zonetime(tracks)

timeenter= 0;
timeexit = 0;
tracks.isininner = [];
tracks.isinouter = [];
tracks.attraction = 0;

        for k = 1 : length(tracks.dis2center)


    %Find the total zonetime and identify if fly is target zone and assign
    %bolean to all dis2center
    if (tracks.dis2center(k) < tracks.targetzoneinner)%The radius of the inner target zone

        tracks.zone = [tracks.zone;'i'];%Identify each which of the three zones the fly is in, i == inner, o == outer, m == mid

    end

    if (tracks.dis2center(k) > tracks.targetzoneinner && tracks.dis2center(k) < tracks.targetzoneouter)% Find the frame at whcih the fly is at mid zone


        tracks.zone = [tracks.zone;'m'];

    end

    if (tracks.dis2center(k) > tracks.targetzoneouter) %Find the frame at which the fly is at outter zone

         tracks.zone = [tracks.zone;'o'];

        end

        end

     tracks.inindex = find(tracks.zone == 'i');
    tracks.outindex = find(tracks.zone == 'o');
    tracks.midindex = find(tracks.zone == 'm');
    int = length(tracks.inindex);
    midt = length(tracks.midindex);
    outt= length(tracks.outindex);
    r = tracks.targetzoneinner;
    R = tracks.targetzoneouter;
    tracks.attraction = int / length(tracks.zone);
    tracks.attraction2 = ((int / r^2) - (midt/(R^2 - r^2)))/(int + midt/(R^2));   %This is the new attraction index


  %This part is for the decision zone
 for k = 1 : length(tracks.dis2center)


    if (tracks.dis2center(k) > tracks.dzonero)%The radius of the inner decision zone

        tracks.dzone = [tracks.dzone;'o'];
    end

    if (tracks.dis2center(k) > tracks.dzoneri && tracks.dis2center(k) < tracks.dzonero)% Find the frame at whcih the fly is at mid zone


        tracks.dzone = [tracks.dzone;'m'];

    end

    if (tracks.dis2center(k) < tracks.dzoneri) %Find the frame at which the fly is at outter zone

         tracks.dzone = [tracks.dzone;'i'];

        end

        end



tracks.correctd = 0;
tracks.wrongd = 0;
% If fly goes from mid dzone to inside dzone, it's a correct decision
% If fly goes from mid dzone to outside dzone, it's a wrong decision
   for i = 1:(length(tracks.dzone)-1)

        if (tracks.dzone(i) == 'm') && (tracks.dzone(i+1) == 'i') %From mid dzone to in dzone (correct decision)

          disp(i);
          tracks.correctd = tracks.correctd + 1;
         disp('Correct decision');

        end

        if (tracks.dzone(i) == 'm') && (tracks.dzone(i+1) == 'o')%From mid dzone to out dzone (wrong decision)

            disp (i)
           disp('Wrong decision');
           tracks.wrongd = tracks.wrongd + 1;

        end

    end

    disp(length(tracks.speed));
    disp(length(tracks.zone));
    tracks.zone(end) = [];


     tracks.innerspeed = mean(tracks.speed(find(tracks.zone == 'i')));%This calculates the mean speed of the inner zone
     tracks.outerspeed = mean(tracks.speed(find(tracks.zone == 'o')));%This calculates the mean speed of the outer zone
     tracks.midspeed = mean(tracks.speed(find(tracks.zone == 'm')));%This calculates the mean speed of the mid zone
end


function tracks = timespan(tracks) %Find the timespan of fly spent in each zone

tracks.isini = 0;
tracks.isino = 0;
tracks.isinm = 0;
    for i = 1 : (length(tracks.zone)-1)

      if tracks.zone(i) =='m' && tracks.zone(i+1) == 'i' %fly enters inneer zone coming from mid zone

        tracks.isini = tracks.isini + 1;

      end


      if (tracks.zone(i) == 'o' && tracks.zone(i+1) == 'm') ||(tracks.zone(i) == 'i' && tracks.zone(i+1) == 'm')%fly enters mid zone from inner zone or from outer zone

        tracks.isinm = tracks.isinm + 1;
      end

      if tracks.zone(i) == 'm' && tracks.zone(i+1) == 'o' %fly enters outer zone from mid zone

        tracks.isino = tracks.isino + 1;
      end


    end

    %Find consecutive items
    % vector = diff(tracks.zone)
    % vec2 = find([vector inf] > 1);%Find consecutive inner position
    %
    %
    % tracks.eachtimeini = diff([0 vec2]);%the length of each indivdiual time span in inner zone
    % tracks.eachtimeinm = diff([0 vec2])%mid zone
    % tracks.eachtimeino = diff([0 vec2])%outer zone


%----------------------------------Magic below, do not touch-------------------------
    reversezone = tracks.zone';%reverse column and rows
    reversezone(find(reversezone == 'i')) = '1';%asign numbers to zones instead of char
    reversezone(find(reversezone == 'm')) = '2';
    reversezone(find(reversezone == 'o')) = '3';

    timestamps = [find(diff([-1 reversezone -1]) ~= 0)];%Where the tracks.zone change

      inzone = (reversezone == '1');
      timestamps = [find(diff([-1 inzone -1]) ~= 0)];%Where the inzone change
      runlength = diff(timestamps)
      tracks.eachtimeini = runlength(1+(inzone(1) == 0 ):2:end);


      timestamps = [find(diff([-1 reversezone -1]) ~= 0)];%Where the tracks.zone change
      midzone = (reversezone =='2');
      timestamps = [find(diff([-1 midzone -1]) ~= 0)];%Where the midzone change
      runlength = diff(timestamps)
      tracks.eachtimeinm = runlength(1+(midzone(1) == 0):2:end);


      timestamps = [find(diff([-1 reversezone -1]) ~= 0)];%Where the tracks.zone change
      outzone = (reversezone =='3');
      timestamps = [find(diff([-1 outzone -1]) ~= 0)];%Where the outzone change
      runlength = diff(timestamps)
      tracks.eachtimeino = runlength(1 +(outzone(1) == 0):2:end);






disp('number of times fly enterd innner zone');
disp(tracks.isini);
disp('number of times fly enterd mid zone');
disp(tracks.isinm);
disp('number of times fly enterd outer zone');
disp(tracks.isino);


end
%      if ~isempty(tracks.inindex)

%          tracks.inindex(end-1:end) = [];
%      end


%     tracks.outindex = find(tracks.isininner == false);
%       tracks.outindex(end-1:end) = [];

%     tracks.innerspeedin = mean(tracks.speed(tracks.inindex));
%     tracks.innerspeedout = mean (tracks.speed(tracks.outindex));



%     fprintf('Attraction Index');
%     disp(tracks.attraction);

%     disp innerspeedin;
%     disp(tracks.innerspeedin);

%    disp innerspeedout
%     disp(tracks.innerspeedout);


%Find each indivdiual time entered
   % for k = 2:length(tracks.dis2center)

%      if (tracks.dis2center(k-1) < tracks.targetzoneinner && tracks.dis2center(k) > tracks.targetzoneinner)

%        timeexit = cat(1,timeexit,k);

      % end

%      if (tracks.dis2center(k-1) > tracks.targetzoneinner && tracks.dis2center(k) < tracks.targetzoneinner)

%        timeenter = cat(1,timeenter,k);

%     end

%   end


% % fprintf('The time entered:\n');
% % disp(timeenter);
% %
% % fprintf('The time exit:\n');
% % disp(timeexit);



% %Make sure all the arrays are the same size and calculate each time span


% tracks.outime = [];

% for o = 2:length(timeenter)

%    newout = timeenter (o)- timeenter(o-1);


%    tracks.outime = [tracks.outime;newout];
% end

% disp(tracks.outime);

% if tracks.dis2center(1) > tracks.targetzoneinner

%     if length(timeexit) == length(timeenter)
%       tracks.innertimespan = timeexit - timeenter;

%     end

%     if length(timeexit) < length(timeenter)
%        timeenter(end,:) = [];
%        tracks.innertimespan = timeexit - timeenter;

%     end

%     if length(timeexit) > length(timeenter)

%     timeexit(end,:) = [];
%     tracks.innertimespan = timeexit - timeenter;

%     end
% end



%     if tracks.dis2center(1) < tracks.targetzoneinner

%     if length(timeexit) == length(timeenter)

%       tracks.outinnertimespan = timeexit - timeenter;
%       tracks.innertimespan = timeenter - timeexit;

%     end

%     if length(timeexit) < length(timeenter)

%        timeenter(end,:) = [];
%        tracks.outinnertimespan = timeexit - timeenter;
%         tracks.innertimespan = timeenter - timeexit;
%     end

%     if length(timeexit) > length(timeenter)

%     timeexit(end,:) = [];
%     tracks.innertimespan = timeexit - timeenter;
%      tracks.innertimespan = timeenter - timeexit;

%     end


%     end



% fprintf('Each time span:\n');
% disp(tracks.innertimespan);

% fprintf('Total Zone time\n');
% disp(tracks.zonet);






%This function finds the runs and stops of the fly according to the speed

% function tracks = findrunstop(tracks)


% stopcount = 0;
% stops = 0;
% runcount = 0;
% runs = 0;
% for i = 1:length(tracks.speed)


%     if tracks.speed(i) < 2 % Stop thereshold


%         stopcount = stopcount + 1;

%        if stopcount > 50

%             stops = stops + 1;

%             stopcount = 0;


%        end

%     end

% end


% tracks.stops = stops;
% disp stopcount;
% disp(stopcount);

% disp stops;
% disp(stops);

% %Find total number of runs
%     for i = 1:length(tracks.speed)


%     if tracks.speed(i) > 15 %run thereshold


%         runcount = runcount + 1;

%        if runcount > 50

%             runs = runs +1;
%             runcount = 0;

%        end

%     end
%   end
% tracks.runs = runs;
% end






%Find the angle of the fly
function tracks = findaspeed(tracks)


angspeed = [];

tenth = tracks.wholepos(1:10:length(tracks.wholepos),:);

for i = 2:length(tenth)


    if i < length(tenth)
      vec2 = [tenth(i,:)-tenth(i-1,:),0];
      vec = [tenth(i+1,:)-tenth(i,:),0];

      end
       aspeed = atan2d(norm(cross(vec,vec2)),dot(vec,vec2));% Angle between fly vector and the food


      tracks.angspeed = [tracks.angspeed;aspeed];


end

%Find sharp turns according to angle

tracks.sharpturn(:,1) = find(tracks.angspeed > 90);
tracks.sharpturn(:,2) = tracks.angspeed(find(tracks.angspeed > 90));

tracks.sharpturn;
fprintf('Angular speed');
% disp(tracks.angspeed);

end




% Plot all the results

function displayresults(tracks)

seconds = (length(tracks.wholepos)*4)/30;


figure;


title('Track results');

hold on
set(gca,'YDir','Reverse');

if length(tracks.wholepos) < 400

plot(tracks.wholepos(1:end,1),tracks.wholepos(1:end,2),'color',[0 0 1]);

end

if length(tracks.wholepos) > 400 && length(tracks.wholepos) < 800

plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
plot(tracks.wholepos(401:end,1),tracks.wholepos(401:end,2),'color',[0 0.5 1]);

end

if length(tracks.wholepos) > 800 && length(tracks.wholepos) < 1200

plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
plot(tracks.wholepos(401:800,1),tracks.wholepos(401:800,2),'color',[0 0.5 1]);
plot(tracks.wholepos(801:end,1),tracks.wholepos(801:end,2),'color',[0 1 1]);

end

if length(tracks.wholepos) > 1200 && length(tracks.wholepos) < 1600

plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
plot(tracks.wholepos(401:800,1),tracks.wholepos(401:800,2),'color',[0 0.5 1]);
plot(tracks.wholepos(801:1200,1),tracks.wholepos(801:1200,2),'color',[0 1 1]);
plot(tracks.wholepos(1201:end,1),tracks.wholepos(1201:end,2),'color',[0 1 0.5]);

end

if length(tracks.wholepos) > 1600 && length(tracks.wholepos) < 2000
    plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
    plot(tracks.wholepos(401:800,1),tracks.wholepos(401:800,2),'color',[0 0.5 1]);
    plot(tracks.wholepos(801:1200,1),tracks.wholepos(801:1200,2),'color',[0 1 1]);
    plot(tracks.wholepos(1201:1600,1),tracks.wholepos(1201:1600,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(1601:end,1),tracks.wholepos(1601:end,2),'color',[0 1 0.5]);

end


if length(tracks.wholepos) > 2000 && length(tracks.wholepos) < 2400

    plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
    plot(tracks.wholepos(401:800,1),tracks.wholepos(401:800,2),'color',[0 0.5 1]);
    plot(tracks.wholepos(801:1200,1),tracks.wholepos(801:1200,2),'color',[0 1 1]);
    plot(tracks.wholepos(1201:1600,1),tracks.wholepos(1201:1600,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(1601:2000,1),tracks.wholepos(1601:2000,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(2001:end,1),tracks.wholepos(2001:end,2),'color',[0.5 1 0]);

end

if length(tracks.wholepos) > 2400 && length(tracks.wholepos) < 2800
    plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
    plot(tracks.wholepos(401:800,1),tracks.wholepos(401:800,2),'color',[0 0.5 1]);
    plot(tracks.wholepos(801:1200,1),tracks.wholepos(801:1200,2),'color',[0 1 1]);
    plot(tracks.wholepos(1201:1600,1),tracks.wholepos(1201:1600,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(1601:2000,1),tracks.wholepos(1601:2000,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(2001:2400,1),tracks.wholepos(2001:2400,2),'color',[0.5 1 0]);
    plot(tracks.wholepos(2401:end,1),tracks.wholepos(2401:end,2),'color',[1 1 0]);

end

if length(tracks.wholepos) > 2800 && length(tracks.wholepos) < 3200
     plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
    plot(tracks.wholepos(401:800,1),tracks.wholepos(401:800,2),'color',[0 0.5 1]);
    plot(tracks.wholepos(801:1200,1),tracks.wholepos(801:1200,2),'color',[0 1 1]);
    plot(tracks.wholepos(1201:1600,1),tracks.wholepos(1201:1600,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(1601:2000,1),tracks.wholepos(1601:2000,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(2001:2400,1),tracks.wholepos(2001:2400,2),'color',[0.5 1 0]);
    plot(tracks.wholepos(2401:2800,1),tracks.wholepos(2401:2800,2),'color',[1 1 0]);
    plot(tracks.wholepos(2801:end,1),tracks.wholepos(2801:end,2),'color',[1 0.5 0]);

end

if length(tracks.wholepos) > 3200
    plot(tracks.wholepos(1:400,1),tracks.wholepos(1:400,2),'color',[0 0 1]);
    plot(tracks.wholepos(401:800,1),tracks.wholepos(401:800,2),'color',[0 0.5 1]);
    plot(tracks.wholepos(801:1200,1),tracks.wholepos(801:1200,2),'color',[0 1 1]);
    plot(tracks.wholepos(1201:1600,1),tracks.wholepos(1201:1600,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(1601:2000,1),tracks.wholepos(1601:2000,2),'color',[0 1 0.5]);
    plot(tracks.wholepos(2001:2400,1),tracks.wholepos(2001:2400,2),'color',[0.5 1 0]);
    plot(tracks.wholepos(2401:2800,1),tracks.wholepos(2401:2800,2),'color',[1 1 0]);
    plot(tracks.wholepos(2801:3200,1),tracks.wholepos(2801:3200,2),'color',[1 0.5 0]);
    plot(tracks.wholepos(3201:end,1),tracks.wholepos(3201:end,2),'color',[1 0 0]);

end


plot(tracks.center(1,:),tracks.center(:,1),'or');%This plots a circle at the center of the dish


theta = linspace(0,2*pi);%Plot the dish on the tracking results

xc = double(tracks.center(1,1));
yc = double(tracks.center(1,2));


x = tracks.radius*cos(theta) + xc;
y = tracks.radius*sin(theta) + yc;

plot(x,y,'k','LineWidth',3);


x1 = tracks.targetzoneinner*cos(theta) + xc;
y1 = tracks.targetzoneinner*sin(theta) + yc;

plot(x1,y1,'r--');%Plot inner target zone

x2 = tracks.targetzoneouter*cos(theta) + xc;
y2 = tracks.targetzoneouter*sin(theta) + yc;

plot(x2,y2,'r--');%Plot outter target zone




filename = 'Tracks_results.fig';
fig1 = strcat(tracks.fname,filename);% Saves the figure as file name + track results
saveas(gcf,fig1);


hold off

                     figure;

                     subplot(2,2,1);

                    % plot(tracks.angspeed);
                    %   set(gca,'YDir','Reverse');
                      title('Parameters');

                   %Plot the distance to source
                    subplot(2,2,2)
                    title('Distance to Src');

                     hold on;
                     t = length(tracks.dis2center);



                    plot([1 t],[tracks.targetzoneouter,tracks.targetzoneouter],'m');
                     plot([1 t],[tracks.targetzoneinner,tracks.targetzoneinner],'b');%Draw a line intersection the target zone
                    plot(tracks.dis2center,'r');
                  plot([1 t],[tracks.dzoneri,tracks.dzoneri],'g');
                  plot([1 t],[tracks.dzonero,tracks.dzonero],'g');
                     hold off

                      subplot(2,2,4);



                     plot(tracks.angspeed);
                     title('Anglur Speed');

                      subplot(2,2,3);
                      plot(tracks.speed);
                      title('Speed');


                      %Display all the data on the graph

                      %1-1
                      str2 = num2str(length(tracks.sharpturn));
                      str1 = 'Turns :  ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .5];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);
                      %1-2
                      tracks.avgspeed = sum(tracks.speed(:))/length(tracks.speed);
                      str2 = num2str(tracks.avgspeed);
                      str1 = 'Average speed: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .325];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


                       str2 = num2str(tracks.innerspeed);
                      str1 = 'Inner zone speed: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .35];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


                      str2 = num2str(tracks.midspeed);
                      str1 = 'Mid zone speed: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .375];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                       str2 = num2str(tracks.attraction);
                      str1 = 'Attraction index: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .425];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      str2 = num2str(tracks.outerspeed);
                      str1 = 'Outer zone speed: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .4];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      str2 = num2str(tracks.runs);
                      str1 = 'Number of runs: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .45];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                       str2 = num2str(tracks.stops);
                      str1 = 'Number of stops:';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .475];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      %Find the length of each time zone
                      innert = length(tracks.inindex);
                      outert = length(tracks.outindex);
                      midt = length(tracks.midindex);

                      str2 = num2str(innert);
                      str1 = 'Inner zone time: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .3];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      str2 = num2str(midt);
                      str1 = 'Mid zone time: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .275];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      str2 = num2str(outert);
                      str1 = 'Outer zone time: ';
                      str = strcat(str1,str2);
                      dim = [.15 .4 .7 .25];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      %Second Row-------------------------------------------------------------------------------------------
                      str2 = num2str((tracks.correctd));
                      str1 = 'Correct decision :  ';
                      str = strcat(str1,str2);
                      dim = [.3 .4 .7 .5];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      str2 = num2str((tracks.wrongd));
                      str1 = 'Wrong decision : ';
                      str = strcat(str1,str2);
                      dim = [.3 .4 .7 .475];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


                      totald =  tracks.wrongd + tracks.correctd;

                      str2 = num2str((tracks.correctd/totald));
                      str1 = 'Correct percentage :  ';
                      str = strcat(str1,str2);
                      dim = [.3 .4 .7 .450];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

                      midt
                      tracks.isini

                      avgi = midt/tracks.isini
                      str2 = num2str(avgi);
                      str1 = 'Average time spent in inner zone :  ';
                      str = strcat(str1,str2);
                      dim = [.3 .4 .7 .425];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


                      avgm = midt/tracks.isinm
                      str2 = num2str(avgm);
                      str1 = 'Average time spent in mid zone :  ';
                      str = strcat(str1,str2);
                      dim = [.3 .4 .7 .400];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


                      avgo = midt/tracks.isino
                      str2 = num2str(avgo);
                      str1 = 'Average time spent in outer zone :  ';
                      str = strcat(str1,str2);
                      dim = [.3 .4 .7 .375];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


                      str1 = num2str(tracks.attraction2);
                      str2 = 'New Attraction Index : ';
                      str = strcat(str2,str1);
                      dim = [.3 .4 .7 .350];
                      annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


                      filename = 'Parameters1.fig';
                      fig2 = strcat(tracks.fname,filename);% Saves the figure as file name + track results
                      saveas(gcf,fig2);


                      figure; %Next figure


                      subplot(2,2,2);

                     title('Anglur Speed');
                     hold on;
                     plot(tracks.angspeed);
                     plot(tracks.sharpturn(:,1),tracks.sharpturn(:,2),'r*');
                     hold off;

                     subplot(2,2,1);

               y = [length(tracks.inindex);length(tracks.midindex);length(tracks.outindex)];


                      names = {'inner' ;'mid'; 'outer'};
                       bar(y,'y');
                       title('Time span for each zone');
                      set(gca,'xticklabel',names);
                     filename = 'Parameters2.fig';
                      fig3 = strcat(tracks.fname,filename);% Saves the figure as file name + track results
                      saveas(gcf,fig3);


                      subplot(2,2,3);
                      bar(tracks.eachtimeini);
                      title('Each time span for inner zone');
                      for i1=1:numel(tracks.eachtimeini)

                          text(i1,tracks.eachtimeini(i1),num2str(tracks.eachtimeini(i1)),...
                                     'HorizontalAlignment','center',...
                                     'VerticalAlignment','bottom')
                      end

                      subplot(2,2,4);
                      bar(tracks.eachtimeinm);
                      title('Each time time for mid zone');



                      figure;
                      subplot(2,2,1);
                      bar(tracks.eachtimeino);
                      title('Each time span for outer zone');


                      end


function exceloutput(tracks)%This ouputs parameters as excel files


outputpos = tracks.wholepos;
outputspeed = tracks.speed;
outputdis2center = tracks.dis2center;
outputaspeed = tracks.angspeed;

xlsname = strcat(tracks.fname,'positions','excel.xls');% filename for the position excel spreadsheet
xlswrite(xlsname, outputpos);

xlsname2 = strcat(tracks.fname,'speed','excel.xls');% filename for the speed excel spreadsheet
xlswrite(xlsname2,outputspeed);

xlsname3 = strcat(tracks.fname,'distancetocenter','excel.xls');% filename for the distance_to_center excel spreadsheet
%xlswrite(xlsname3,outputdis2center);

xlsname4 = strcat(tracks.fname,'anglur speed','excel.xls');%filename for the angular speed excel spreadsheet
xlswrite(xlsname4,outputaspeed);


end
