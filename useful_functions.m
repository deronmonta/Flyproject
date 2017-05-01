%different histograms
%After Grouping the flies into different conditions here are some useful
%histograms to compare with each other

for i = 1:length(water_non_thirsty)
  figure;
  water_non_thirsty(i).plothistogram;
end

for i = 1:length(no_water_thirsty)
  figure;
  no_water_thirsty(i).plothistogram;
end

for i = 1:20
  figure;
  water_thirsty(i).plothistogram;
end

for i = 1: length(no_water_thirsty)
  figure;
  histogram(no_water_thirsty(i).dis2center)

end

for i = 1:20
  water_thirsty(i).displayresults
end

for i = 1:length(water_thirsty)
  speedstd(i,:) = std(water_thirsty(i).size5steps)
end

for i = 1:length(no_water_thirsty)
  speedstd(i,:) = std(no_water_thirsty(i).size5steps)
end

for i = 1 : length(no_water_thirsty)
  no_water_thirsty(i).displayresults
end

for i = 1: length(water_thirsty)
  figure;
  histogram(water_thirsty(i).dis2center)
end

straight_steps = mean(vertcat(water_thirsty.size10angle)< 10)
straight_steps = mean(vertcat(no_water_thirsty.size10angle)< 10)
straight_steps = mean(vertcat(water_non_thirsty.size10angle)< 10)

i = 3;
hold on;
subplot(2,1,1)
plot(no_water_thirsty(i).dis2center)
subplot(2,1,2)
plot(no_water_thirsty(i).wholepos(:,1),no_water_thirsty(i).wholepos(:,2))



  sum(vertcat((no_water_thirsty(i).size10angle)))
