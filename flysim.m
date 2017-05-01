%Fly behavior Simulation
%This will simulate the behavior of a fly according to different angles and steps
obj = no_water_thirsty(10);
steplength = obj.size5steps;
stepangle = obj.size5angle;
randlength = datasample(steplength,length(steplength));%Random sampling of step size
randangle = datasample(stepangle,length(stepangle));%Random sampling of angle
slidog = sqrt(movingvar(stepangle,2));%Sliding variance of orgrinal tracks
slidsim = sqrt(movingvar(randangle,2));%Sliing variance of random tracks
disp('sliding og mean')
mean(slidog)
disp('slidng sim mean')
mean(slidsim)
pos(1,:) = [0 0];
obj.displayresults;

for  i = 2 : length(randangle)

simx = randlength(i)*cos(randangle(i));
simy = randlength(i)*sin(randangle(i));
simxy(i,:) = [simx simy];
pos(i,1) = pos(i-1,1) + simx;
pos(i,2) = pos(i-1,2) + simy;

end

%Count the number of time fly change direction
angdiffsim = diff(randangle);
angdiff = diff(stepangle);
changecountsim = sum(abs(angdiffsim) > 90);
changecount = sum(abs(angdiff) > 90);

% for n = 2 :length(angdiffsim)
%
%   if abs(angdiffsim(n-1) - angdiffsim(n)) > 90
%   changecountsim = changecountsim + 1;
%   end
% end
%
% for n = 2 :length(angdiff)
%
%   if abs(angdiff(n-1) - angdiff(n)) > 90
%   changecount = changecount + 1;
%   end
% end
obj.sharpturn
changecount
changecountsim



pos(end-1:end,:) = [];
figure;
hold on
theta = linspace(0,2*pi);%Plot the dish on the tracking results

x = 250*cos(theta);
y = 250*sin(theta);

plot(x,y,'k','LineWidth',3);
plot(pos(:,1),pos(:,2))

% figure
% hold on;
% plot(stepangle);
% plot(slidog);
% title('OG')
%
% figure;
% hold on
% plot(randangle);
% plot(slidsim);

% figure;
% h = animatedline;
% for n = 1:length(pos)
%
% addpoints(h,pos(n,1),pos(n,2));
%
% % addpoints(h2,n,self.size10angle(fix(n/10)));
% dim = [0.2 0.5 0.3 0.3];
% drawnow;
% pause(0.01); % slow down the animation
% end
