function [ xDot, drag, thrust, mass, acceleration] = integrationFunction( time, x )
    gravity = 9.8067; %gravity
    initialAltitude = 210;
    rocketLength = 2.87;
    rocketDiameter = 0.122;
    thrustDuration = 1.8;
    thrustMagnitude = 21525;
    launchMass = 65.6;
    burnoutMass = 45.2;
    mass = 65.6;
    launchClear = initialAltitude + rocketLength;
    timeTable   = [0     1.8   1.8001 3];
    thrustTable = [21525 21525 0      0];
    massTable   = [65.6  45.2  45.2   45.2];
    launchClearSpeed = sqrt(2*(thrustMagnitude/launchMass)*rocketLength);
    
    position = x(1:3)';
    velocity = x(4:6)';
    altitude = position(3);
    magVelocity = (velocity(1,1).^2 + velocity(1,2).^2 + velocity(1,3).^2).^.5;
    normVel = norm(velocity);
    s = ((rocketDiameter/2)^2)*pi;
    
    [temperature, pressure, density, acousticSpeed] = getConditions(altitude);

    machNumber = normVel/acousticSpeed;
    
    coeffDrag = getCD(machNumber, time, thrustDuration);
    
    drag = getDrag(s, density, velocity, coeffDrag, magVelocity);
    
    %mass = getMass(mass, time, launchMass, burnoutMass, thrustDuration);
    mass = interp1(timeTable, massTable, time, 'linear', 'extrap');
    
    %thrust = getThrust(time, thrustDuration, thrustMagnitude, velocity, magVelocity);
    thrust = (velocity/norm(velocity))*interp1(timeTable,thrustTable,time,'linear','extrap');
    
    acceleration = getAcceleration(altitude, launchClear, thrust, drag, gravity, mass, launchClearSpeed, magVelocity);
    
    xDot = [velocity'; acceleration'];

end

