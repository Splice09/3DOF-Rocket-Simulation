function [ cd ] = getCD( machNumber, time, thrustDuration )
machTable = [0,     0.5,   0.75,  0.9,   0.95,  1.1,   1.2,   1.3,   1.5,   2.0,   3.0];
coeffDragCoast = [0.292, 0.264, 0.277, 0.392, 0.474, 0.557, 0.557, 0.545, 0.492, 0.428, 0.335];
coeffDragBoost = [0.148, 0.127, 0.129, 0.167, 0.197, 0.245, 0.245, 0.241, 0.227, 0.207, 0.174];

if time < thrustDuration
    cd = interp1(machTable,coeffDragBoost, machNumber);
    
else
    cd = interp1(machTable, coeffDragCoast, machNumber);
    
end
end

