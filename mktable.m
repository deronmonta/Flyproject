
filename = {flydatabase.filename}';
attraction = [flydatabase.attraction]';
speed = [flydatabase.avgspeed]';
runs = [flydatabase.runs]';
hr = [flydatabase.desiccation_hr]';
innerspeed = [flydatabase.innerspeed]';
midspeed = [flydatabase.midspeed]';
water = [flydatabase.water]';
stops = [flydatabase.stops]';
firstenter = [flydatabase.firstenter]';
avgangle = [flydatabase.size5avgangle]';
id = [flydatabase.id]';
enterspeed = [flydatabase.enterspeedavg]';
exitspeed = [flydatabase.exitspeedavg]';
period = [flydatabase.period]';

T = table(id,hr,water,attraction,speed,runs,stops,innerspeed,midspeed,avgangle,firstenter,enterspeed,exitspeed,period);
T = sortrows(T,'hr');
T
