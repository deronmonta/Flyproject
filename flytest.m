obj = no_water_thirsty(10);
steplength = obj.size5steps;
stepangle = obj.size5angle;
dis2center = obj.dis2center

dis5 = dis2center(1:5:end-3)
dis5near = find(dis5 >230)

anglenear = stepangle(dis5near)
