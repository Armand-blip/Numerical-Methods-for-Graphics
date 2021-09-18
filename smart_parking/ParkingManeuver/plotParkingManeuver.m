% Load and display three map layers
mapLayers = loadParkingMapLayers;
% Plot the multiple map layers on a figure window
plotMapLayers(mapLayers)

% combine the three layers into a single costmap.
costmap = combineMapLayers(mapLayers)

% Plot the costmap, without inflated areas
plot(costmap, 'Inflation', 'off')
hold on
plot(refPath,'DisplayName','Reference path')
[refPoses,refDirections] = interpolate(refPath);
% Specify number of poses to return using a separation of approximately 0.1 m
approxSeparation = 0.1; % meters
numSmoothPoses = round(refPath.Length / approxSeparation);
% Smooth the path
[poses,directions] = smoothPathSpline(refPoses,refDirections,numSmoothPoses);
plot(poses(:,1),poses(:,2),'LineWidth',2,'DisplayName','Smooth path')
hold off
title('Parking Maneuver')
legend('Reference path','Smooth path','Location','eastoutside')

% Zoom into parking maneuver by setting axes limits
min_ax = min([currentPose(1:2); parkPose(1:2)]);
max_ax = max([currentPose(1:2); parkPose(1:2)]);
buffer = 6; % meters
xlim([min_ax(1)-buffer max_ax(1)+buffer])
ylim([min_ax(2)-buffer max_ax(2)+buffer])
