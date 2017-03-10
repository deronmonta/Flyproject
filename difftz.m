% file = uigetfile;
% load(file);%Load fly database
differentfs_water = [];
differentfs_no_water = [];
radius = [];
radius_mat = [];
 for r = 1 : 19 %iterate ring size from 50 to 250
    radius = 10 * r + 39;
    radius_mat = [radius;radius_mat];

  for n = 1 : length(twlve_hr_fly)% get every twlve_hr_fly
    twlve_hr_fly(n).tzone_inner_radius = radius ; % increase targetzone size
    no_water(n).tzone_inner_radius = radius; % increase targetzone size
    twlve_hr_fly(n) = twlve_hr_fly(n).correction;
    twlve_hr_fly(n) = twlve_hr_fly(n).zoneid; %Run zone id


    no_water(n) = no_water(n).correction;
    no_water(n) = no_water(n).zoneid; %Run zone id

    if ~isempty(twlve_hr_fly(n).firstenter)

      differentfs_water(r,n) = twlve_hr_fly(n).firstenter;
      differentfs_no_water(r,n) = no_water(n).firstenter;

    end


  end

end

water_mean = nanmean(differentfs_water,2);
no_water_mean = mean(differentfs_no_water,2);
water_diff = -diff(water_mean);
water_diff = [water_diff;0];
no_water_diff = -diff(no_water_mean);
no_water_diff = [no_water_diff;0];
water = cat(2,radius_mat,water_mean,water_diff);
no_water = cat(2,radius_mat,no_water_mean,no_water_diff);
