function downloadSensorData
%% Download and extract data if data folder does not exist
if ~(exist('UCI HAR Dataset','file') == 7)
    downloadlink = 'https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip';
    toc
    disp('UCI HAR Dataset does not exist, downloading dataset...')
    fname = websave('UCI_HAR_Dataset.zip',downloadlink);
    toc
    disp('Done downloading, file downloaded to:')
    disp(fname)
    disp(' ')
    yn = input('It may be faster to extract the file manually, do you want MATLAB to extract the file (y/n)? ','s');
    if strcmp(yn,'y')
        tic
        disp('Extracting file, this may take a while...')
        foldername = unzip(fname);
        disp('Done extracting, extracted to:')
        disp(foldername)
        toc
    else 
        disp(' ')
        disp('OK, You must manually extract the file contents to the current folder before proceeding. Don''t change the default folder names.')
    end
end