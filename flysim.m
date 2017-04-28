%Fly behavior Simulation
%This will simulate the behavior of a fly according to different angles and steps

steplength = water_thirsty(10).size5steps;
stepangle = water_thirsty(10).size5angle;
randlength = datasample(steplength,length(steplength));
randangle = datasample(stepangle,length(stepangle));
pos(1,:) = [0 0];

for  i = 2 : length(randangle)

simx = randlength(i)*cos(randangle(i))
simy = randlength(i)*sin(randangle(i))
pos(i,1) = pos(i-1,1) + simx;
pos(i,2) = pos(i-1,2) + simy;


end
hold on
theta = linspace(0,2*pi);%Plot the dish on the tracking results



x = 250*cos(theta);
y = 250*sin(theta);

plot(x,y,'k','LineWidth',3);
plot(pos(:,1),pos(:,2))
