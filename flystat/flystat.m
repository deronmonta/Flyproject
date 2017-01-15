%get the stats of all the fly in one directory and compute them as a population
%For the love of god, please stop these retards from interupting me when I'm doing shit they can't even understand


%Output one condition at a time e.g. 1 hour dessication as a population

function flystat()

prompt = 'Enter hour of desiccation\n';
hours = input(prompt);


myDir = uigetdir;
myfiles = dir(fullfile(myDir,'*.mat'));
popstat = struct('filenum',[],'dis2center',[],'attraction',[],'avgattraction',[],'speed',[],'avgspeed',[],'innerspeed',[],...
				'midspeed',[],'outerspeed',[],'avginnerspeed',[],'avgmidspeed',[],'avgouterspeed',[],'avginnertime',[],'avgmidtime',[],'avgoutertime',[],...
				'innertime',[],'midtime',[],'outertime',[],'destime',[],'correctd',[],'wrongd',[],'drate',[],'correctdcount',[],'avgcorrectd',[],'avgwrongd',[],...
				'attraction2',[]);

tracks = [];
popstat.filenum = length(myfiles);%The number of files to process

	for N = 1 : length(myfiles)%Load every tracks file in directory

		%load files and display their names
		load(myfiles(N).name);
		disp(myfiles(N).name);
		popstat.destime = hours;
		popstat.destime = num2str(popstat.destime);%Change it to string

		%re-assign each parameters, bulid stat as population for one condition
		tracks.dis2center = tracks.dis2center';%reverse column and row, I've made a mistake in flypara and too lazy to fix it
		popstat.dis2center = [popstat.dis2center;tracks.dis2center];
		popstat.speed = [popstat.speed;tracks.speed];% Reasign speed
		popstat.speed(popstat.speed > 30) = [];%Delete speed that are larger than 30
		popstat.attraction2 = [popstat.attraction2;tracks.attraction2];%Reasign new attracion
		popstat.attraction = [popstat.attraction;tracks.attraction];%Reasign attraction

		%Reasign decision
		popstat.wrongd = [popstat.wrongd;tracks.wrongd];
		popstat.correctd = [popstat.correctd;tracks.correctd];
		popstat.correctdcount = sum(popstat.correctd);
		popstat.avgcorrectd = popstat.correctdcount/popstat.filenum;

		popstat.avgwrongd = sum(popstat.wrongd)/popstat.filenum;
		%Reasign zone speed
		popstat.innerspeed = [popstat.innerspeed;tracks.innerspeed];
		popstat.midspeed = [popstat.midspeed;tracks.midspeed];
		popstat.outerspeed = [popstat.outerspeed;tracks.outerspeed];
		popstat.innerspeed(isnan(popstat.innerspeed)) = [];%Remove nan from all cells
		popstat.midspeed(isnan(popstat.midspeed)) = [];
		popstat.outerspeed(isnan(popstat.outerspeed))= [];

		disp(popstat.innerspeed);
		disp(popstat.midspeed);
		disp(popstat.outerspeed);

		%Reasign average time spent in each zone
		innert = length(tracks.inindex);
		outert = length(tracks.outindex);
		midt = length(tracks.midindex);

		avgi = midt/tracks.isini;
		avgm = midt/tracks.isinm;
		avgo = midt/tracks.isino;

		popstat.innertime =[popstat.innertime;avgi];
		popstat.midspeed = [popstat.midtime;avgm];
		popstat.outertime = [popstat.outertime;avgo];


	end

%-----------------------list of subfunctions ---------------------
popstat = statprocess(popstat);
resultsdisplay(popstat);
%--------------------subfunctions list ends here -------------------



%-------------------subfunctions starts here-----------------------
function popstat = statprocess(popstat) %Process the stats obtain from multiple flypara output files

popstat.avgattraction = sum(popstat.attraction)/popstat.filenum;%Get average attraction
popstat.avgspeed = sum(popstat.speed)/length(popstat.speed);%Get average speed for each file
popstat.avginnerspeed = sum(popstat.innerspeed)/length(popstat.innerspeed);
popstat.avgmidspeed = sum(popstat.midspeed)/popstat.filenum;
popstat.avgouterspeed = sum(popstat.outerspeed)/popstat.filenum;
popstat.drate = sum(popstat.correctd)/(sum(popstat.correctd) + sum(popstat.wrongd));

end




function resultsdisplay(popstat) %Display the results

saveDir = 'C:\Users\Bayesian\Documents\MATLAB\Wildtype\Popstat_file';%Get saving directory

disp 'attraction';
disp(popstat.avgattraction);
disp 'speed';
disp(popstat.avgspeed);
disp('Speed in each zone');
disp(popstat.avginnerspeed);
disp(popstat.avgmidspeed);
disp(popstat.avgouterspeed);
disp('Average Correct Decisions Made');
disp(popstat.avgcorrectd);
disp('Average Wrong Decisions Made');
disp(popstat.avgwrongd);

% disp (popstat.avginnertime);
% disp (popstat.avgmidspeed);
% disp (popstat.avgoutertime);



figure;

histogram(fix(popstat.dis2center)); %Histogram of integers
hours = strcat(popstat.destime,'hr');
histname = strcat('Spaital_Distribution_',hours);%Figure name for Histogram
saveas(gcf,fullfile(saveDir,histname));
c = unique(fix(popstat.dis2center)); %round down decimals and find unique numbers

figure;
hold on;
str1 = num2str(popstat.avgattraction);
str = strcat('Attraction index: ', str1);
dim = [.3 .4 .7 .425];
annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);

str1 = num2str(popstat.avgspeed);
str = strcat('Average speed: ', str1);
dim = [.3 .4 .7 .400];
annotation('textbox',dim,'FitBoxToText','on','LineStyle','none','String',str);


filename = strcat('Pop_stat_',hours);%File name for the popstat.mat
save(fullfile(saveDir,filename));%Save the popstat struct



end
end
