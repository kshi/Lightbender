%fclose('bundle.out');
fid = fopen('bundle.out');
fgetl(fid); % skip first line - header
line1 = fgetl(fid);
infoArray = strsplit(line1,' ');
num_cameras = eval(infoArray{1}); % number of cameras - num of images
num_points = eval(infoArray{2});  

% loading camera data 
% for each camera entry (format of 'cameras' matrix)
% <f> <k1> <k2> [focal length, two radial distortion coeffs]
% <R>           [3x3 matrix representing camera rotation]
% <t>           [3-vector describing camera traslation]
cameras = zeros(num_cameras*5,3); 
for cindex = 0:(num_cameras-1)
    for dindex = 1:5
        arr = strsplit(fgetl(fid),' '); 
        for col = 1:3
            cameras(cindex*5+dindex,col) = eval(arr{col});
        end
    end
end

% loading point data

% rows: x,y,z columns: point index
positions = zeros(3,num_points); 
% rows: camera index columns: point information (exists-0/1 x y)
cloudpts = zeros(num_cameras,num_points*3); % info whether point exists in certain views/cameras

for index = 0:(num_points-1)
    %position
    arrp = strsplit(fgetl(fid),' ');
    for row = 1:3
        positions(row,index+1) = eval(arrp{row});
    end
    
    %color (skip)
    fgetl(fid);
    
    %view list
    arrv = strsplit(fgetl(fid),' ');
    nc = eval(arrv{1});
    for i = 0:(nc-1)
        cam_i = eval(arrv{i*4+1+1})+1; % +1 b/c camera index in .out starts at 0
        cloudpts(cam_i,index*3+1) = 1; % sets column 1 to true
        cloudpts(cam_i,index*3+2) = eval(arrv{i*4+3+1}); % sets x column
        cloudpts(cam_i,index*3+3) = eval(arrv{i*4+4+1}); % sets y column
    end
end

fclose('all');
    

