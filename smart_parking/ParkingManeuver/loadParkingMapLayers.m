function mapLayers = loadParkingMapLayers()

%   Load occupancy maps corresponding to 3 layers - obstacles, road
%   markings.

mapLayers.StationaryObstacles = imread('stationary.bmp');
mapLayers.RoadMarkings        = imread('road_markings.bmp');
mapLayers.ParkedCars          = imread('parked_cars.bmp');
end