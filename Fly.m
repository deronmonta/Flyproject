%As the program is getting more complicated, I will now try object oriented programming in MATLAB
%This could potentially be very heavy workload, but instead of having to use many scripts and functions
%I think oop in the solution to all the problem

classdef Fly

properties
    %Static variables
      plate_radius = 250;
      tzone_inner_radius = 75;%tzone stands for target zone
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
      dis2center;
      speed;
      zone;%the posistion status of fly in each frame
      dzone%the decision posistion status of fly
      stops;
      runs;
      attraction;
      eachtimeini;
      eachtimeinm;
      eachtimeino;
      totalframe;
      correctd;
      wrongd;
      dpercentage;
  end

methods

%---------------------------------------------------------------------------------------------------
function  self = Fly()%This is the constructor for the object

  self;

end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function self = assignment(self, fname, id, datecreated, dest, geno, wholepos, srcdir, savedir)% Assign variables to the object
  self.filename = fname;
  self.desiccation_hr = dest;
  self.genotype = geno;
  self.wholepos = wholepos;
  self.src_dir = srcdir;
  self.save_dir = savedir;
  self.datecreated = datecreated;
  self.id = id;
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

    for i = 2:length(self.wholepos)


        self.speed = [self.speed;sqrt(sum((self.wholepos(i,:)-self.wholepos((i-1),:)).^2))];


    end

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

end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function self = zoneid(self) % For identifying each zone

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


%This part is for the decision zone
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


%This is for calculting the time span fly spent in each zone
    reversezone = self.zone';%reverse column and rows

    timestamps = find(diff([-1 reversezone -1]) ~= 0);%Where the self.zone change

    inzone = (reversezone == 'i');
    timestamps = find(diff([-1 inzone -1]) ~= 0);%Where the inzone change
    runlength = diff(timestamps);
    self.eachtimeini = runlength(1+(inzone(1) == 0 ):2:end);
    self.eachtimeini = self.eachtimeini';

    timestamps = find(diff([-1 reversezone -1]) ~= 0);%Where the self.zone change
    midzone = (reversezone =='m');
    timestamps = find(diff([-1 midzone -1]) ~= 0);%Where the midzone change
    runlength = diff(timestamps);
    self.eachtimeinm = runlength(1+(midzone(1) == 0):2:end);
    self.eachtimeinm = self.eachtimeinm';

    timestamps = find(diff([-1 reversezone -1]) ~= 0);%Where the self.zone change
    outzone = (reversezone =='o');
    timestamps = [find(diff([-1 outzone -1]) ~= 0)];%Where the outzone change
    runlength = diff(timestamps);
    self.eachtimeino = runlength(1 +(outzone(1) == 0):2:end);
    self.eachtimeino = self.eachtimeino';


end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function self = findrunstop(self)

  self.stops = length(find(self.speed <= 1));
  self.runs = length(find(self.speed > 3.5));


end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function savemat(self)

  save(fullfile(self.save_dir, self.filename),'self');

end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function savefig(self)


end
%---------------------------------------------------------------------------------------------------

%---------------------------------------------------------------------------------------------------
function displayresults(self)%This method is called when need to display plots

  seconds = (length(self.wholepos)*4)/30;


  figure;


  title('Track results');

  hold on
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


end
%---------------------------------------------------------------------------------------------------



end
end
