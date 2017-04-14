%This will Group the flies according to different condition

file = uigetfile;
load(file);%Load fly database
water_thirsty = [];
water_non_thirsty = [];
no_water_thirsty = [];
water_thirsty = findobj(flydatabase,'desiccation_hr',12,'water','Y');
water_non_thirsty = findobj(flydatabase,'desiccation_hr',0,'water','Y');
no_water_thirsty = findobj(flydatabase,'water','N');
