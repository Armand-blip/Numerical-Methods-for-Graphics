% Load and display the three map layers
mapLayers = loadParkingMapLayers;
plotMapLayers(mapLayers)

% Combine the three layers into a single costmap.
costmap = combineMapLayers(mapLayers);
% The costmap object represents the vehicle environment as a
% 2-D occupancy grid. 

figure
plot(costmap)

% The vehicle pose is specified as [x,y,theta] in world coordinates.
currentPose = [5,5,90]; % [x, y, theta]
goalPose = [65,15,90];

% pathPlannerRRT finds paths that avoid obstacles by checking to ensure
% that vehicle poses generated do not lie on these areas.

motionPlanner = pathPlannerRRT(costmap, 'MinIterations', 1000, ...
    'ConnectionDistance', 5, 'MinTurningRadius', 4);

% Plan a reference path using RRT* planner to the next goal pose
refPath = plan(motionPlanner, currentPose, goalPose);
hold on
% Retrieve transition poses and directions from the planned path
[refPoses, refdirections] = interpolate(refPath);

% Visualize the reference path
plot(refPath,'Vehicle','off','DisplayName','Reference path')
% Specify number of poses to return using a separation of approximately 0.1 m
approxSeparation = 0.1; % meters
numSmoothPoses   = round(refPath.Length / approxSeparation);
% Smooth the path
[smoothPoses, smoothdirections] = smoothPathSpline(refPoses, refdirections, numSmoothPoses);

% Plot the smoothed path

plot(smoothPoses(:, 1), smoothPoses(:, 2), 'y', 'LineWidth', 1, ...
    'DisplayName', 'Smooth Path');
hold off
xlim([1 70])
ylim([1 25])




