%As the program is getting more complicated, I will now try object oriented programming in MATLAB
%This could potentially be very heavy workload, but instead of having to use many scripts and functions
%I think oop in the solution to all the problem

classdef Fly

  properties
    filename;
    id;
    date;
    genotype;
    desiccation_hr;
    plate_center;
    plate_radius;
    tzone_inner_radius;%tzone stands for target zone
    tzone_mid_radius;
    tzone_outer_radius;
    center;
    dis2center;
    speed;
    zone;%the posistion status of fly in each frame
    dzone_inner_radius;%dzone stands for decision zone
    dzone_outer_radius;
    file_dir;
  end


  methods

  function  obj = Fly(track)

    obj.id = track;

    end


  end
  end
