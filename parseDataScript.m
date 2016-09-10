%fclose('bundle.out');
fid = fopen('bundle.out');
fgetl(fid); % skip first line
line1 = fgetl(fid);
infoArray = strsplit(line1,' ');
num_cameras = eval(infoArray{1});
num_points = eval(infoArray{2}); 

% loading camera data 
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
positions = zeros(3,num_points);
cloudpts = zeros(num_cameras,num_points*3);
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
        cami = eval(arrv{i*4+1+1})+1;
        cloudpts(cami,index*3+1) = 1; % sets column 1 to true
        cloudpts(cami,index*3+2) = eval(arrv{i*4+3}); % sets x column
        cloudpts(cami,index*3+3) = eval(arrv{i*4+4}); % sets y column
    end
end

fclose('all');
    

