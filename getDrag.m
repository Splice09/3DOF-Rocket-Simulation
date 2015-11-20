function [ drag ] = getDrag(s, density, velocity, coeffOfDrag, magVelocity )
x = (velocity(1,1));
y = (velocity(1,2));
z = (velocity(1,3));
newDragX = -0.5*density*magVelocity*coeffOfDrag*s*x;
newDragY = -0.5*density*magVelocity*coeffOfDrag*s*y;
newDragZ = -0.5*density*magVelocity*coeffOfDrag*s*z;

drag = [newDragX, newDragY, newDragZ];


end

