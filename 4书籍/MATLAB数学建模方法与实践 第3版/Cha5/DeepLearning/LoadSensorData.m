function LoadSensorData

if exist('rawSensorData_train.mat','file') && exist('rawSensorData_test.mat','file')
    fprintf(1,'rawSensorData_train.mat and rawSensorData_test.mat already exists at location:\n');
    disp(['* ', which('rawSensorData_train.mat')]);
    disp(['* ', which('rawSensorData_test.mat')]);
    disp(' ')
else
    %% Load training data from files
    activity_labels = {'Walking','WalkingUpstairs','WalkingDownstairs','Sitting','Standing','Laying'};
    trainActivity = categorical(importdata('UCI HAR Dataset\train\y_train.txt'),1:6,activity_labels);
    trainActivity = mergecats(trainActivity,{'WalkingUpstairs','WalkingDownstairs'},'ClimbingStairs');
    % Choose this if you want to only load the total acca and gyro data
    filestoload = strcat('UCI HAR Dataset\train\Inertial Signals\',{'*gyro*','total*'});
	% Choose this if you want to load all files
    % filestoload = strcat('UCI HAR Dataset\train\Inertial Signals\'); 

    disp('Loading training data from files:')
    try
        dstrain = datastore(filestoload,'TextscanFormats',repmat({'%f'},1,128), 'ReadVariableNames',false);
    catch err
        if strcmp(err.identifier,'MATLAB:datastoreio:pathlookup:fileNotFound')
            error('File not found. Please make sure that you download and extract the data first using ''downloadSensorData'' function')
        end
    end
    dstrain.ReadSize = 'file';
    [~,fnames] = cellfun(@fileparts,dstrain.Files,'UniformOutput',false);
    iter = 1;
%     rawSensorDataTrain = table;
    while hasdata(dstrain)
        fprintf('Importing: %16s ...',fnames{iter})
        M = table2array(read(dstrain));
        rawSensorDataTrain.(fnames{iter}) = M;
        iter = iter + 1;
        fprintf('Done\n')
    end
    rawSensorDataTrain.trainActivity = trainActivity;
    disp(' ')
    %% Load test data from files
    testActivity = categorical(importdata('UCI HAR Dataset\test\y_test.txt'),1:6,activity_labels);
    testActivity = mergecats(testActivity,{'WalkingUpstairs','WalkingDownstairs'},'ClimbingStairs');
	% Choose this if you want to only load the total acca and gyro data
    filestoload = strcat('UCI HAR Dataset\test\Inertial Signals\',{'*gyro*','total*'});
	% Choose this if you want to load all files
%     filestoload = strcat('UCI HAR Dataset\test\Inertial Signals\'); 
    disp('Loading test data from files:')
    dstest = datastore(filestoload,'TextscanFormats',repmat({'%f'},1,128),'DatastoreType','tabulartext',...
        'ReadVariableNames',false);
    [~,fnames] = cellfun(@fileparts,dstest.Files,'UniformOutput',false);
    dstest.ReadSize = 'file';
    iter = 1;
%     rawSensorDataTest = table;
    while hasdata(dstest)
        fprintf('Importing: %16s ...',fnames{iter})
        M = table2array(read(dstest));
        rawSensorDataTest.(fnames{iter}) = M;
        iter = iter + 1;
        fprintf('Done\n')
    end
	rawSensorDataTest.testActivity = testActivity;
disp(' ')
    %% Saving MAT file with raw data
    fprintf('Saving MAT files: rawSensorData_train.mat ...')
    save rawSensorData_train.mat -struct rawSensorDataTrain
    disp('Done')
    fprintf('Saving MAT files: rawSensorData_test.mat ...')
    save rawSensorData_test.mat -struct rawSensorDataTest
    disp('Done')
end

