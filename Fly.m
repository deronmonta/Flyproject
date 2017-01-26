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

  totalframe = length(self.wholepos);% length of dis2center
    self.dis2center = zeros(totalframe,1); %Create empty array

    for i = 1 : totalframe

      self.dis2center(i) = sqrt(sum((self.wholepos(i,:)-self.center).^2));

    end

    %Assign speed
    self.speed = zeros(totalframe - 1, 1);

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

  self.dis2center(i) = sqrt(sum((self.wholepos(i,:)-self.center).^2));


  end

  self.speed = zeros(totalframe - 1, 1);


  %recalculate speed using corrected data
  for i = 2:length(self.wholepos)

      self.speed = [self.speed;sqrt(sum((self.wholepos(i,:)-self.wholepos((i-1),:)).^2))];

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

  for k = 1 : length(self.dis2center)  %This part is for the decision zone



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


end
%---------------------------------------------------------------------------------------------------



end
end
