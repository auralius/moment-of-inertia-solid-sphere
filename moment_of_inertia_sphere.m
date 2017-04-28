% Calculating moment inertia of a solid sphere 
clc;
clear all;
close all;

% Properties of the solid sphere
M = 1; % Mass
R = 1; % Radius
C = [0;0;0]; % Center

% Divided into N smaller cubes
N = 0;

% Dimension of the smaller cube
delta = 0.1;

% Divide the sphere by sweeping the whole cube that contains the sphere
% Check if a point inside the sphere then keep it in the memory.
for x = -R+C(1) :delta: R+C(1)
    for y = -R+C(2):delta:R+C(2)
        for z = -R+C(3):delta:R+C(3)
            d = norm([x;y;z] - C);
            if d <= R
                N = N + 1;
                inside_pts(:,N) = [x;y;z];
            end
        end
    end
end

% This is the volume
V  = N * delta^3;

% Calculating the moment of inertia respect to the center of the sphere
m = M/N;
Ixx = 0;
Iyy = 0;
Izz = 0;
Ixy = 0;
Ixz = 0;
Iyz = 0;
for i = 1:length(inside_pts)
    x = inside_pts(1, i);
    y = inside_pts(2, i);
    z = inside_pts(3, i);
    
    Ixx = Ixx + m*((y-C(2))^2 + (z-C(3))^2);
    Iyy = Iyy + m*((x-C(1))^2 + (z-C(3))^2);
    Izz = Izz + m*((x-C(1))^2 + (y-C(2))^2);
    Ixy = Ixy - m*(x-C(1)) * (y-C(2));
    Ixz = Ixz - m*(x-C(1)) * (z-C(3));
    Iyz = Iyz - m*(y-C(2)) * (z-C(3));
end

fprintf('A solid sphere\n');
fprintf('Radius = %d\nCenter location = [%d %d %d]\nMass = %d\n\n', ...
        R, C(1), C(2), C(3), M);
fprintf('Divided into %d small cubes\n', N);
fprintf('Calculated volume = %d\n', V);
fprintf('Calculated moment of inertia:\n');
fprintf('Ixx=%d\nIyy=%d\nIzz=%d\nIxy=%d\nIxz=%d\nIyz=%d\n', ...
        Ixx, Iyy, Izz, Ixy, Ixz, Iyz);


%%
% Drawing the smaller cubes, this can take forever if delta is very small!!
x = [0 1 1 0 0 0; 1 1 0 0 1 1;1 1 0 0 1 1; 0 1 1 0 0 0] * delta;
y = [0 0 1 1 0 0; 0 1 1 0 0 0;0 1 1 0 1 1; 0 0 1 1 1 1] * delta;
z = [0 0 0 0 0 1; 0 0 0 0 0 1;1 1 1 1 0 1; 1 1 1 1 0 1] * delta;
for j = 1:length(inside_pts)
    for i = 1 : 6
        h = patch(x(:,i)+inside_pts(1,j), y(:,i)+inside_pts(2,j), ...
                  z(:,i)+inside_pts(3,j),'b');
    end
end

view([1 1 1]);
axis equal;
xlabel('x')
xlabel('y')
xlabel('z')
