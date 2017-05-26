%As the program is getting more complicated, I will now try object oriented programming in MATLAB
%This could potentially be very heavy workload, but instead of having to use many scripts and functions
%I think oop in the solution to all the problem

classdef Fly < handle

properties
    %Static variables
      plate_radius = 260;
      tzone_inner_radius = 100;%tzone stands for target zone
      tzone_outer_radius = 240;
      center = [250 250];
      dzone_inner_radius = 50;%dzone stands for decision zone
      dzone_outer_radius = 100;

      %These are variables that need to be inputed from other files
      filename;
      id;
      datecreated;
      genotype;
      wholepos;
      desiccation_hr;
      src_dir;
      save_dir;
      %These variables could be obtained by calling self methods
      totalframe;
      dis2center;
      speed;
      avgspeed;
      zone;%the posistion status of fly in each frame
      dzone%the decision posistion status of fly
      stops;
      runs;
      runsin;
      runsout;
      attraction;
      eachtimeini;
      eachtimeinm;
      eachtimeino;
      eachtimeiniavg;
      eachtimeinmavg;
      eachtimeinoavg;
      totald;
      correctd;
      wrongd;
      dpercentage;
      innerspeed;
      midspeed;
      outerspeed;
      angle;
      sharpturn;
      dperframe;
      firstenter;
      runchance;
      stopchance;
      enterspeed;
      enterspeedavg;
      exitspeed;
      exitspeedavg;
      firstten;
      firstthirty;
      firstfifty;
      firsthundred;
      errors;
      curvature;
      avgcurvature;
      sharpturnpos;
      water;
      vec;
      size5steps;
      size5angle;
      size5stepslength;
      size5sharpturn;
      size5avgangle;
      size5anglei;
      size5anglem;
      size5angleo;
      avgsize5anglei;
      avgsize5anglem;
      avgsize5angleo;

      size10steps;
      size10angle;
      size10stepslength;
      size10sharpturn;

      size20steps;
      size20stepslength;
      size20angle;
      size50steps;
      size50stepslength;
      size50angle;
      startout;




  end

methods

%---------------------------------------------------------------------------------------------------
function  self = Fly()%This is the constructor for the object

  self;

end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function self = assignment(self, fname, id, datecreated, dest, water, geno, wholepos, srcdir, savedir)% Assign variables to the object
  self.filename = fname;
  self.desiccation_hr = dest;
  self.genotype = geno;
  self.wholepos = wholepos;
  self.src_dir = srcdir;
  self.save_dir = savedir;
  self.datecreated = datecreated;
  self.id = id;
  self.water = water;
end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function self = basiccal(self)% This function is called every time

  self.totalframe = length(self.wholepos);% length of dis2center
    self.dis2center = zeros(self.totalframe,1); %Create empty array

    for i = 1 : self.totalframe

      self.dis2center(i) = sqrt(sum((self.wholepos(i,:)-self.center).^2));

    end

    %Assign speed
    self.speed = zeros(self.totalframe - 1, 1);
    self.speed = sqrt(diff(self.wholepos.^2));

end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function self = correction(self)


  diserror = find(self.dis2center > self.plate_radius); % Get the indices of the error position

  self.wholepos(diserror,:) = [];

  self.dis2center = [];
  for i = 1 : length(self.wholepos)

    self.dis2center = [self.dis2center;sqrt(sum((self.wholepos(i,:) - self.center).^2))];

  end
  newlength = length(self.wholepos);

  self.speed = [];

  %recalculate speed using corrected data
  for i = 2 : length(self.wholepos)

    self.speed = [self.speed; sqrt(sum((self.wholepos(i,:)-self.wholepos((i-1),:)).^2))];
    length(self.speed);

  end

  speederror = find(self.speed > 15);% Find speed error using new speed

  %Delete every error entiies
  self.speed(speederror,:) = [];
  self.wholepos(speederror,:) = [];
  self.dis2center(speederror) = [];
  self.errors = length(speederror) + length(diserror);
  self.avgspeed = mean(self.speed);


  % self.firstten= abs(sqrt(sum((self.wholepos(10,:) - self.wholepos(1,:)).^2)));
  % self.firstthirty = abs(sqrt(sum((self.wholepos(30,:) - self.wholepos(1,:)).^2)));
  % self.firstfifty = abs(sqrt(sum((self.wholepos(50,:) - self.wholepos(1,:)).^2)));
  % self.firsthundred = abs(sqrt(sum((self.wholepos(100,:) - self.wholepos(1,:)).^2)));
  self.vec = diff(self.wholepos);

  %The following calculates steps and steps length for different time span
  self.size5steps = diff(self.wholepos(1:5:end,:));
  self.size10steps = diff(self.wholepos(1:10:end,:));
  self.size20steps = diff(self.wholepos(1:20:end,:));
  self.size50steps = diff(self.wholepos(1:50:end,:));
  self.size5stepslength = sqrt((self.size5steps(:,1).^2) + (self.size5steps(:,2).^2));
  self.size10stepslength = sqrt((self.size10steps(:,1).^2) + (self.size10steps(:,2).^2));
  self.size20stepslength = sqrt((self.size20steps(:,1).^2) + (self.size20steps(:,2).^2));
  self.size50stepslength = sqrt((self.size50steps(:,1).^2) + (self.size50steps(:,2).^2));

end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function self = zoneid(self) % For identifying each zone

  self.zone = [];
  for k = 1 : length(self.dis2center)%Find the total zonetime and identify if fly is target zone and assign zoneid to all dis2center

    if (self.dis2center(k) < self.tzone_inner_radius)%The radius of the inner target zone
        self.zone = [self.zone;'i'];%Identify each which of the three zones the fly is in, i == inner, o == outer, m == mid
    end

    if (self.dis2center(k) > self.tzone_inner_radius && self.dis2center(k) < self.tzone_outer_radius)% Find the frame at whcih the fly is at mid zone
        self.zone = [self.zone;'m'];
    end

    if (self.dis2center(k) > self.tzone_outer_radius) %Find the frame at which the fly is at outter zone
       self.zone = [self.zone;'o'];
    end%
  end
    inindex = find(self.zone == 'i');
    midindex = find(self.zone == 'm');
    outindex = find(self.zone == 'o');
    intime = length(inindex);
    midt = length(midindex);
    outt = length(outindex);
    self.attraction = intime / length(self.zone);
  if (self.zone(1) == 'm')||(self.zone(1) =='o')

    self.startout = 1;
  elseif(self.zone(1) =='i')
    self.startout = 0;
  end


%Find the first time fly enter target zone
if ~isempty(inindex) && (~isempty(midindex) || ~isempty(outindex))

  if self.startout == 1

    self.firstenter = inindex(1);

  elseif self.startout == 0

    self.firstenter = 0;
  end

  end



%Find the speed before fly enter the target zone

for i = 1:length(self.zone) - 1

  if self.zone(i) == 'm' && self.zone(i+1) == 'i' && i > 10 && i +10 < length(self.wholepos)%From mid to inner zone
    self.enterspeed = [self.enterspeed;mean(self.speed(i-10 : i+10))]; %Find the speed of prior 30 frames
  end

  if self.zone(i) == 'i' && self.zone(i+1) == 'm' && i > 10 && i +10 < length(self.wholepos)%From inner to mid zone
    self.exitspeed = [self.exitspeed;mean(self.speed(i-10 : i+10))]; %Find the speed of prior 30 frames
  end

end
self.exitspeedavg = mean(self.exitspeed);
self.enterspeedavg = mean(self.enterspeed);


%This part is for the decision zone
  self.dzone = [];
  self.correctd = 0;
  self.wrongd = 0;
  for k = 1 : length(self.dis2center)

      if (self.dis2center(k) > self.dzone_outer_radius)%The radius of the inner decision zone
          self.dzone = [self.dzone;'o'];

      end

      if (self.dis2center(k) > self.dzone_inner_radius && self.dis2center(k) < self.dzone_outer_radius)% Find the frame at whcih the fly is at mid zone
          self.dzone = [self.dzone;'m'];
      end

      if (self.dis2center(k) < self.dzone_inner_radius) %Find the frame at which the fly is at outter zone
           self.dzone = [self.dzone;'i'];
      end

  end

%Get the number of correct decisions and wrong decisions
  for i = 1:(length(self.dzone)-1)
       if ((self.dzone(i) == 'm') && (self.dzone(i+1) == 'i'))
         self.correctd = self.correctd + 1;
       end
       %From mid zone to outter zone or from inner zone to mid zone are wrong decisions
       if ((self.dzone(i) == 'm') && (self.dzone(i+1) == 'o'))
          self.wrongd = self.wrongd + 1;
       end
  end

self.dpercentage = self.correctd / (self.correctd + self.wrongd);
self.totald = self.correctd + self.wrongd;
self.dperframe = length(self.zone) / self.totald



end
%---------------------------------------------------------------------------------------------------
function self = zonecal(self)
  %This is for calculting the time span fly spent in each zone
      reversezone = self.zone';%reverse column and rows

      timestamps = find(diff([-1 reversezone -1]) ~= 0);%Where the self.zone change

      inzone = (reversezone == 'i');
      timestamps = find(diff([-1 inzone -1]) ~= 0);%Where the inzone change
      runlength = diff(timestamps);
      self.eachtimeini = runlength(1+(inzone(1) == 0 ):2:end);
      self.eachtimeiniavg = mean(self.eachtimeini)
      %self.eachtimeini = self.eachtimeini';

      timestamps = find(diff([-1 reversezone -1]) ~= 0);%Where the self.zone change
      midzone = (reversezone =='m');
      timestamps = find(diff([-1 midzone -1]) ~= 0);%Where the midzone change
      runlength = diff(timestamps);
      self.eachtimeinm = runlength(1+(midzone(1) == 0):2:end);
      self.eachtimeinmavg = mean(self.eachtimeinm)
      %self.eachtimeinm = self.eachtimeinm';

      timestamps = find(diff([-1 reversezone -1]) ~= 0);%Where the self.zone change
      outzone = (reversezone =='o');
      timestamps = [find(diff([-1 outzone -1]) ~= 0)];%Where the outzone change
      runlength = diff(timestamps);
      self.eachtimeino = runlength(1 +(outzone(1) == 0):2:end);
      self.eachtimeinoavg = mean(self.eachtimeino)

      %self.eachtimeino = self.eachtimeino';

      self.zone(end-1:end) = [];
      self.innerspeed = mean(self.speed(find(self.zone == 'i')));%This calculates the mean speed of the inner zone
      self.outerspeed = mean(self.speed(find(self.zone == 'o')));%This calculates the mean speed of the outer zone
      self.midspeed = mean(self.speed(find(self.zone == 'm')));%This calculates the mean speed of the mid zone


      %Get step parameter within each zone
      inpos = self.wholepos(find(self.zone == 'i'),:);

end
%---------------------------------------------------------------------------------------------------
function self = findrunstop(self)

  self.stops = [];
  self.runs = [];
  self.stops = length(find(self.speed < 1));
  self.runs = length(find(self.speed > 3.5));
  self.runsin = length(intersect(find(self.speed > 3.5),(find(self.zone =='i'))));% Find the runs in inner zone
  self.runsout =length(intersect(find(self.speed > 3.5),(find(self.zone =='m'))));

  self.stopchance = (self.stops) / length(self.speed);
  self.runchance = (self.runs) / length(self.speed);

end
%---------------------------------------------------------------------------------------------------

function self = findangle(self)
    vec = [];
    fifth = [];
    magnitude = [];
    self.size5angle = [];
    fifth = self.wholepos(1:5:end,:);


  size5stepszero = [self.size5steps,(zeros(size(self.size5steps,1),1))];%Append zero column to right of array

  for i = 2 : length(size5stepszero)


      %Find angle between two consecutive steps
      %if (norm(size5stepszero(i))) > 1 || (norm(size5stepszero(i+1))) > 1 || (norm(size5stepszero(i+2))) > 1   %Avoid small steps mistaken for large angles
        self.size5angle = [self.size5angle; atan2d(norm(cross(size5stepszero(i,:),size5stepszero(i-1,:))),dot(size5stepszero(i,:),size5stepszero(i-1,:)))];
      %end

  end

  size10stepszero = [self.size10steps,(zeros(size(self.size10steps,1),1))];%Append zero column to right of array

  for i = 2 : length(size10stepszero)

    if self.size10steps(i,1) ~= 0 && self.size10steps(i,2) ~= 0

      self.size10angle = [self.size10angle; atan2d(norm(cross(size10stepszero(i,:),size10stepszero(i-1,:))),dot(size10stepszero(i,:),size10stepszero(i-1,:)))];
      %Find angle between two consecutive steps
    end
  end

  for i = 2 : length(self.size20steps)

    if self.size20steps(i,1) ~= 0 && self.size20steps(i,2) ~= 0
      self.size20angle = [self.size20angle; atan2d(self.size20steps(i-1,1)*self.size20steps(i,2) - self.size20steps(i-1,2)*self.size20steps(i,1), self.size20steps(i,1)*self.size20steps(i-1,1) + self.size20steps(i,2)*self.size20steps(i-1,2))];
    %Find angle between two consecutive steps
    end

  end

  for i = 2 : length(self.size50steps)

    if self.size50steps(i,1) ~= 0 && self.size50steps(i,2) ~= 0
      self.size50angle = [self.size50angle; atan2d(self.size50steps(i-1,1)*self.size50steps(i,2) - self.size50steps(i-1,2)*self.size50steps(i,1), self.size50steps(i,1)*self.size50steps(i-1,1) + self.size50steps(i,2)*self.size50steps(i-1,2))];
    %Find angle between two consecutive steps
    end

  end

  self.size10sharpturn = sum(abs(self.size10angle) > 90);
  self.size5sharpturn = sum(abs(self.size5angle) > 60);
  % inindex = find(self.zone == 'i');
  % inindex = fix(inindex./10);
  % outindex = find(self.zone == 'o');
  % outindex = fix(outindex./10);
  %
  % if inindex(:) ~= 0
  %   innerangle = self.size10angle(inindex);
  %   outangle = self.size10angle(outindex);
  % end
  %
  %     for i = 2:length(tenth)
  %       if i < length(tenth)
  %         vec2 = [tenth(i,:)-tenth(i-1,:),0];
  %         vec = [tenth(i+1,:)-tenth(i,:),0];
  %       end
  %         angle =  (atan2d(norm(cross(vec,vec2)),dot(vec,vec2)));
  %       if ~(angle == 0)
  %         self.angle= [self.angle;angle];
  %         self.sharpturn = numel(find(self.angle > 90));
  %       end
  %         % self.sharpturn(:,2) = self.angle(find(self.angle > 90));
  %     end
    vec = diff(fifth);
    % vec(i,:) = fifth(i+1,:) - fifth(i,:); % The tagent of the curve

       magnitude = sqrt(vec(:,1).^2 + vec(:,2).^2);
       vec(:,1) = vec(:,1)./magnitude; %Trasform to unit step, x direction
       vec(:,2) = vec(:,2)./magnitude; %Trasform to unit step, x direction
       self.curvature = [];
       self.curvature = diff(vec);
       self.curvature = self.curvature(:,1).^2 + self.curvature(:,2).^2;
       self.avgcurvature = nanmean(self.curvature(:));
        % self.curvature = self.curvature';
  sharp_threshold = 1.5;
  self.sharpturnpos = find(self.curvature > sharp_threshold);
  self.sharpturn = length(find (self.curvature > sharp_threshold));
  self.size5avgangle = mean(abs(self.size5angle));
  size5angle = repelem(self.size5angle,5);
  if length(size5angle) < length(self.zone)
    zone = self.zone;
    difference = length(zone) - length(size5angle);
    zone(end-difference:end) = [];
  self.size5anglei = size5angle(find(zone == 'i'));
  self.avgsize5anglei = mean(self.size5anglei);
  self.size5anglem = size5angle(find(zone == 'm'));
  self.avgsize5anglem = mean(self.size5anglem);
  self.size5angleo = size5angle(find(zone == 'o'));
  self.avgsize5angleo = mean(self.size5angleo);
end
end

%---------------------------------------------------------------------------------------------------
function savemat(self)

  save(fullfile(self.save_dir, self.filename),'self');

end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function savefig(self)


end
%---------------------------------------------------------------------------------------------------
function replay(self)

  theta = linspace(0,2*pi);
  xc = double(self.center(1,1));
  yc = double(self.center(1,2));

  figure;
  hold on;
  axlim = 600;  % change this to change the limit of axises
  axis([-100 axlim -100 axlim]);
  set(gca,'YDir','Reverse');
  %Plot decision zone
  plot(self.center(1,:),self.center(:,1),'or');%This plots a circle at the center of the dish


  theta = linspace(0,2*pi);%Plot the dish on the tracking results

  xc = double(self.center(1,1));
  yc = double(self.center(1,2));


  x = self.plate_radius*cos(theta) + xc;
  y = self.plate_radius*sin(theta) + yc;

  plot(x,y,'k','LineWidth',3);


  x1 = self.tzone_inner_radius*cos(theta) + xc;
  y1 = self.tzone_inner_radius*sin(theta) + yc;

  plot(x1,y1,'r--');%Plot inner target zone

  x2 = self.tzone_outer_radius*cos(theta) + xc;
  y2 = self.tzone_outer_radius*sin(theta) + yc;

  plot(x2,y2,'r--');%Plot outter target zone

  x3 = self.dzone_inner_radius*cos(theta) + xc;
  y3 = self.dzone_inner_radius*sin(theta) + yc;

  %plot(x3,y3,'r--')

  h = animatedline;
  figure;
  h2 = animatedline;
  for n = 1:length(self.wholepos)

  addpoints(h,self.wholepos(n,1),self.wholepos(n,2));
  addpoints(h2,n,self.dis2center(n));
  % addpoints(h2,n,self.size10angle(fix(n/10)));
  dim = [0.2 0.5 0.3 0.3];
  drawnow;
  pause(0.01); % slow down the animation
  end


  hold off;
  end

function plothistogram(self)

  %histogram(self.size10stepslength,'Normalization','probability');
  % self.size10angle = abs(self.size10angle);
   self.size5angle = abs(self.size5angle);
   self.size10angle = abs(self.size10angle);
   histogram(self.size10steps,'Normalization','probability');
  % histogram(self.speed,'Normalization','probability');

end
%---------------------------------------------------------------------------------------------------
function displayresults(self)%This method is called when need to display plots

  % seconds = (length(self.wholepos)*4)/30;
  figure;

  title('Track results');

  hold on;
  set(gca,'YDir','Reverse');

  if length(self.wholepos) < 400

    plot(self.wholepos(1:end,1),self.wholepos(1:end,2),'color',[0 0 1]);

  end

  if length(self.wholepos) > 400 && length(self.wholepos) < 800

    plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
    plot(self.wholepos(401:end,1),self.wholepos(401:end,2),'color',[0 0.5 1]);

  end

  if length(self.wholepos) > 800 && length(self.wholepos) < 1200

    plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
    plot(self.wholepos(401:800,1),self.wholepos(401:800,2),'color',[0 0.5 1]);
    plot(self.wholepos(801:end,1),self.wholepos(801:end,2),'color',[0 1 1]);

  end

  if length(self.wholepos) > 1200 && length(self.wholepos) < 1600

    plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
    plot(self.wholepos(401:800,1),self.wholepos(401:800,2),'color',[0 0.5 1]);
    plot(self.wholepos(801:1200,1),self.wholepos(801:1200,2),'color',[0 1 1]);
    plot(self.wholepos(1201:end,1),self.wholepos(1201:end,2),'color',[0 1 0.5]);

  end

  if length(self.wholepos) > 1600 && length(self.wholepos) < 2000
      plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
      plot(self.wholepos(401:800,1),self.wholepos(401:800,2),'color',[0 0.5 1]);
      plot(self.wholepos(801:1200,1),self.wholepos(801:1200,2),'color',[0 1 1]);
      plot(self.wholepos(1201:1600,1),self.wholepos(1201:1600,2),'color',[0 1 0.5]);
      plot(self.wholepos(1601:end,1),self.wholepos(1601:end,2),'color',[0 1 0.5]);

  end


  if length(self.wholepos) > 2000 && length(self.wholepos) < 2400

      plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
      plot(self.wholepos(401:800,1),self.wholepos(401:800,2),'color',[0 0.5 1]);
      plot(self.wholepos(801:1200,1),self.wholepos(801:1200,2),'color',[0 1 1]);
      plot(self.wholepos(1201:1600,1),self.wholepos(1201:1600,2),'color',[0 1 0.5]);
      plot(self.wholepos(1601:2000,1),self.wholepos(1601:2000,2),'color',[0 1 0.5]);
      plot(self.wholepos(2001:end,1),self.wholepos(2001:end,2),'color',[0.5 1 0]);

  end

  if length(self.wholepos) > 2400 && length(self.wholepos) < 2800
      plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
      plot(self.wholepos(401:800,1),self.wholepos(401:800,2),'color',[0 0.5 1]);
      plot(self.wholepos(801:1200,1),self.wholepos(801:1200,2),'color',[0 1 1]);
      plot(self.wholepos(1201:1600,1),self.wholepos(1201:1600,2),'color',[0 1 0.5]);
      plot(self.wholepos(1601:2000,1),self.wholepos(1601:2000,2),'color',[0 1 0.5]);
      plot(self.wholepos(2001:2400,1),self.wholepos(2001:2400,2),'color',[0.5 1 0]);
      plot(self.wholepos(2401:end,1),self.wholepos(2401:end,2),'color',[1 1 0]);

  end

  if length(self.wholepos) > 2800 && length(self.wholepos) < 3200
      plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
      plot(self.wholepos(401:800,1),self.wholepos(401:800,2),'color',[0 0.5 1]);
      plot(self.wholepos(801:1200,1),self.wholepos(801:1200,2),'color',[0 1 1]);
      plot(self.wholepos(1201:1600,1),self.wholepos(1201:1600,2),'color',[0 1 0.5]);
      plot(self.wholepos(1601:2000,1),self.wholepos(1601:2000,2),'color',[0 1 0.5]);
      plot(self.wholepos(2001:2400,1),self.wholepos(2001:2400,2),'color',[0.5 1 0]);
      plot(self.wholepos(2401:2800,1),self.wholepos(2401:2800,2),'color',[1 1 0]);
      plot(self.wholepos(2801:end,1),self.wholepos(2801:end,2),'color',[1 0.5 0]);

  end

  if length(self.wholepos) > 3200
      plot(self.wholepos(1:400,1),self.wholepos(1:400,2),'color',[0 0 1]);
      plot(self.wholepos(401:800,1),self.wholepos(401:800,2),'color',[0 0.5 1]);
      plot(self.wholepos(801:1200,1),self.wholepos(801:1200,2),'color',[0 1 1]);
      plot(self.wholepos(1201:1600,1),self.wholepos(1201:1600,2),'color',[0 1 0.5]);
      plot(self.wholepos(1601:2000,1),self.wholepos(1601:2000,2),'color',[0 1 0.5]);
      plot(self.wholepos(2001:2400,1),self.wholepos(2001:2400,2),'color',[0.5 1 0]);
      plot(self.wholepos(2401:2800,1),self.wholepos(2401:2800,2),'color',[1 1 0]);
      plot(self.wholepos(2801:3200,1),self.wholepos(2801:3200,2),'color',[1 0.5 0]);
      plot(self.wholepos(3201:end,1),self.wholepos(3201:end,2),'color',[1 0 0]);

  end


  plot(self.center(1,:),self.center(:,1),'or');%This plots a circle at the center of the dish


  theta = linspace(0,2*pi);%Plot the dish on the tracking results

  xc = double(self.center(1,1));
  yc = double(self.center(1,2));


  x = self.plate_radius*cos(theta) + xc;
  y = self.plate_radius*sin(theta) + yc;

  plot(x,y,'k','LineWidth',3);


  x1 = self.tzone_inner_radius*cos(theta) + xc;
  y1 = self.tzone_inner_radius*sin(theta) + yc;

  plot(x1,y1,'r--');%Plot inner target zone

  x2 = self.tzone_outer_radius*cos(theta) + xc;
  y2 = self.tzone_outer_radius*sin(theta) + yc;

  plot(x2,y2,'r--');%Plot outter target zone


% size10sharpturnpos = find(self.size10angle > 120);
%   for i = 1:length(size10sharpturnpos)
%     10*size10sharpturnpos(i)
%     plot(self.wholepos(10*size10sharpturnpos(i),1),self.wholepos(10*size10sharpturnpos(i),2),'ok') % This plots all the sharp angle on the tracks
%   end

  size5sharpturnindex = find(abs(self.size5angle) > 60);
    for i = 1:length(size5sharpturnindex)
      plot(self.wholepos(5*size5sharpturnindex(i),1),self.wholepos(5*size5sharpturnindex(i),2),'ok') % This plots all the sharp angle on the tracks
    end


  % for i = 1:5:length(self.wholepos) %Size 5 steps
  %   plot(self.wholepos(i,1),self.wholepos(i,2),'ob')
  % end
end
%---------------------------------------------------------------------------------------------------



end
end
