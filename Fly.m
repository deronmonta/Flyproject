%As the program is getting more complicated, I will now try object oriented programming in MATLAB
%This could potentially be very heavy workload, but instead of having to use many scripts and functions
%I think oop in the solution to all the problem

classdef Fly
properties
    %Static variables
    plate_radius = 250;
    tzone_inner_radius = 75;%tzone stands for target zone
    tzone_outer_radius = 240;
    center = [250, 250];
    dzone_inner_radius = 50;%dzone stands for decision zone
    dzone_outer_radius = 100;

      %These are variables that need to be inputed from other files
      filename;
      id;
      date;
      genotype;
      wholepos;
      desiccation_hr;
      src_dir;
      save_dir;

      %These variables could be obtained by calling self methods
      dis2center;
      speed;
      zone;%the posistion status of fly in each frame


  end


  methods


function  self = Fly()%This is the constructor for the object

  self;

end

function self = assignment(self, fname, id, date, dest, geno, wholepos, srcdir, savedir)% Assign variables to the object
  self.filename = fname;
  self.desiccation_hr = dest;
  self.genotype = geno;
  self.wholepos = wholepos;
  self.src_dir = srcdir;
  self.save_dir = savedir;
  self.date = date;
  self.id = id;
end



function self = correction(self)% This function is called every time

  totalframe = length(self.wholepos)
    self.dis2center = zeros(totalframe);

    for i = 1 : totalframe

      self.dis2center(i) = sqrt(sum((self.wholepos(i,:) - self.center(1,:)).^2));


    end
end





function self = zoneid(self) % For identifying each zone

  for k = 1 : length(self.dis2center)


%Find the total zonetime and identify if fly is target zone and assign
%bolean to all dis2center
if (self.dis2center(k) < tracks.tzone_inner_radius)%The radius of the inner target zone

  self.zone = [self.zone;'i'];%Identify each which of the three zones the fly is in, i == inner, o == outer, m == mid

end

if (self.dis2center(k) > tracks.tzone_inner_radius && self.dis2center(k) < tzone_outer_radius)% Find the frame at whcih the fly is at mid zone


  self.zone = [self.zone;'m'];

end

if (self.dis2center(k) > tzone_outer_radius) %Find the frame at which the fly is at outter zone

   self.zone = [self.zone;'o'];

  end


  end

end

function savemat(self)

  save(fullfile(self.save_dir, self.filename),'self');

end

function savefig(self)
end

function displayresults(self)%This method is called when need to display plots
end




end
end
