function [ newAcceleration] = getAcceleration(altitude, launchClear, thrust, drag, gravity, mass, launchClearSpeed, magVelocity)
newAccelerationX = (thrust(1,1)+(drag(1,1)))/(mass);
newAccelerationY = (thrust(1,2)+(drag(1,2)))/(mass);

if launchClearSpeed > magVelocity
    newAccelerationZ = (thrust(1,3)+(drag(1,3)))/(mass);
else
    newAccelerationZ = ((thrust(1,3)+(drag(1,3)))- mass*gravity)/(mass);
end
newAcceleration = [newAccelerationX, newAccelerationY, newAccelerationZ];


end

