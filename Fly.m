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

    filename;
    id;
    datecreated;
    wholepos;
    genotype;
    desiccation_hr;
    dis2center;
    speed;
    zone;%the posistion status of fly in each frame
    %Dzone related parameters
    src_dir;
    save_dir;
  end


methods

function  self = Fly()%This is the constructor for the object

  self;

end

function self = assignment(self,fname, dest, geno, wholepos, srcdir, savedir)
  self.filename = fname;
  self.desiccation_hr = dest;
  self.genotype = geno;
  self.wholepos = wholepos;
  self.src_dir = srcdir;
  self.save_dir = savedir;
end

function self = correction()% This function is called every time


end


function self = zoneid(self) % For identifying each zone

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
