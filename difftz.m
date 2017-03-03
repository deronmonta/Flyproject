% file = uigetfile;
% load(file);%Load fly database
differentfs = [];

 for r = 1 : 19 %iterate ring size from 50 to 250

  for n = 1 : length(twlve_hr_fly)% get every twlve_hr_fly
    twlve_hr_fly(n).tzone_inner_radius = 10 * r + 49; % increase targetzone size
    twlve_hr_fly(n) = twlve_hr_fly(n).correction;
    twlve_hr_fly(n) = twlve_hr_fly(n).zoneid; %Run zone id

    if ~isempty(twlve_hr_fly(n).firstenter)

      differentfs(r,n) = twlve_hr_fly(n).firstenter;

    end

  end

 end
