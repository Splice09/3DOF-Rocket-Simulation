# 3DOF-Rocket-Simulation
Using MATLAB to simulate a rocket launch with constant acceleration (3DOF).

My brother had this project in one of his Aerospace classes, and I thought it sounded like a fun project. I got the physics formulas via text documents the teacher put out with the assignment.

## Objective
Send a rocket from an initial altitude of 210m across a full parabolic flight path and end at 220m. 

This is accomplished by using MATLAB's ode45 function to integrate the calculated Velocity and Acceleration vector over each time step.

## Initial Values
- Position: 210
- Velocity: .001
- Time: 0s
- dTime: 0.1s
- rocketLength: 2.87m
- rocketDiameter: 0.122m
- wetMass: 65.6
- dryMass: 45.2
- thrustDuration: 1.8s
- thrustMagnitude: 21525
- initialTemperature: 300 (kelvin)
- initialPressure: 99000
- specificGasConstant: 287.058
- gravity: 9.8067
- lapseRate = -0.0065
