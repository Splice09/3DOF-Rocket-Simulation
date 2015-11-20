function [ temperature, pressure, density, acousticSpeed ] = getConditions( altitude )
gravity = 9.8067;
initialTemperature = 300;
initialPressure = 99000;
lapseRate = -0.0065;
initialAltitude = 210;
specificGasConstant = 287.058;

temperature = initialTemperature + lapseRate*(altitude-initialAltitude);

pressure = initialPressure*((temperature/initialTemperature)^(-gravity/(lapseRate*specificGasConstant)));

density = pressure/(specificGasConstant*temperature);

acousticSpeed = (1.4*specificGasConstant*temperature)^0.5;
end

