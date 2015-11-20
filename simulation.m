clc
clear 
close all
clear classes

time = 0;
dt = 0.1;
position = [0,0,210];
velocity = .001;
azimuth = 45;         %Degrees
angleOfAttack = 45;   %Degrees
thrustDuration = 1.8;
altitude = 210;
returnData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
theta = 90 - angleOfAttack;
phi = 90 - azimuth;
range = 0;
velocityX = velocity*sind(theta)*cosd(phi);
velocityY = velocity*sind(theta)*sind(phi);
velocityZ = velocity*cosd(theta);

velocityVector = [velocityX, velocityY, velocityZ];

while altitude <= 220
    initialState = [position';velocityVector'];
    [t, solution] = ode45(@integrationFunction, [time, time+dt], initialState);
    [xDot, drag, thrust, mass, acceleration] = integrationFunction(time+dt, initialState);
    newState = solution(end,:);
    
    normVelocityOutter = norm(velocityVector);
    normAcceleration = norm(acceleration);
    range = norm(position);
%     posH = position(1,1)/(cosd(phi));
    magXY = (((velocityVector(1,1)^2)+(velocityVector(1,2)^2))^.5);
    flightAngle = atand(velocityVector(1,3)/magXY);
%     flightAngle = asind(((((9.8066)*(range)/normVelocityOutter))^0.5)+45); 
    newIterationData = [time,position(1,1),position(1,2),position(1,3), velocityVector(1,1), velocityVector(1,2), velocityVector(1,3), normVelocityOutter, acceleration(1,1), acceleration(1,2), acceleration(1,3), normAcceleration, drag(1,1), drag(1,2), drag(1,3), mass, flightAngle];
    
    position = newState(1:3)';
    velocityVector = newState(4:6)';
    time = time + dt;
    altitude = position(3);
    
    returnData = cat(1,returnData, newIterationData);
    position = position';
    velocityVector = velocityVector';
% % %     normVelocityOutter = norm(velocityVector);
end

while altitude > 220
    initialState = [position';velocityVector'];
    [t, solution] = ode45(@integrationFunction, [time, time+dt], initialState);
    [xDot, drag, thrust, mass, acceleration] = integrationFunction(time+dt, initialState);
    newState = solution(end,:);
    
    normVelocityOutter = norm(velocityVector);
    normAcceleration = norm(acceleration);
    range = norm(position);
%     posH = position(1,1)*(cosd(phi));
%     flightAngle = asind(((((9.8066)*(range)/normVelocityOutter))^0.5)+45);
    magXY = (((velocityVector(1,1)^2)+(velocityVector(1,2)^2))^.5);
    flightAngle = atand(velocityVector(1,3)/magXY);
    newIterationData = [time,position(1,1),position(1,2),position(1,3), velocityVector(1,1), velocityVector(1,2), velocityVector(1,3), normVelocityOutter, acceleration(1,1), acceleration(1,2), acceleration(1,3), normAcceleration, drag(1,1), drag(1,2), drag(1,3), mass, flightAngle];
    
    if newState(1,3) < 220
        newState = solution(12,:);
        position = newState(1:3);
        time = t(12,:);
        velocityVector = newState(4:6);
        newIterationData = [time,position(1,1),position(1,2),position(1,3), velocityVector(1,1), velocityVector(1,2), velocityVector(1,3), normVelocityOutter, acceleration(1,1), acceleration(1,2), acceleration(1,3), normAcceleration, drag(1,1), drag(1,2), drag(1,3), mass, flightAngle];
        altitude = 219;
    else
        position = newState(1:3)';
        velocityVector = newState(4:6)';
        altitude = position(3);
    end
    
    time = time + dt;
    
    
    returnData = cat(1,returnData, newIterationData);
    position = position';
    velocityVector = velocityVector'; 
end

timeData = returnData(:,1);
xdata = returnData(:,2);
ydata = returnData(:,3);
zdata = returnData(:,4);
normVData = returnData(:,8);
normAData = returnData(:,12);
fPAngleData = returnData(:,17);
dataTable = [timeData, xdata, ydata, zdata];
csvwrite('john_fleming_outputData.txt',dataTable);

figure(1)
plot(ydata,zdata)
title('Z vs Y')
xlabel('Y')
ylabel('Z')

figure(2)
plot(timeData,zdata)
title('Z vs Time')
xlabel('Time')
ylabel('Z')

figure(3)
plot(timeData,normVData)
title('Speed vs Time')
xlabel('Time')
ylabel('Speed')

figure(4)
plot(timeData,normAData)
title('Acceleration Magnitude vs Time')
xlabel('Time')
ylabel('Acceleration Magnitude')

figure(5)
plot(timeData,fPAngleData)
title('Flight Path Angle vs Time')
xlabel('Time')
ylabel('Flight Path Angle')

disp('Important Values:');
disp('');
stuff1 = ['Range: ', range]; 
disp('Range:');
disp(range);
disp('');
disp('Time of Flight:');
disp(timeData(end,:));
disp('');
disp('Impact Coordinates:');
disp(xdata(end,:));
disp(ydata(end,:));
disp(zdata(end,:));
disp('');
disp('Max Velocity:');
disp(normVData(20,:));
disp('at time:');
disp(timeData(20,:));



