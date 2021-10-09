%Matlab程序读取sst数据： 
close all
clear all
 
oid='sst.mnmean.nc'
sst=double(ncread(oid,'sst'));
nlat=double(ncread(oid,'lat'));
nlon=double(ncread(oid,'lon'));
 
mv=ncreadatt(oid,'/sst','missing_value');
sst(find(sst==mv))=NaN;
 
[Nlt,Nlg]=meshgrid(nlat,nlon);
 
%Plot the SST data without using the MATLAB Mapping Toolbox
 
figure
pcolor(Nlg,Nlt,sst(:,:,1));shading interp;
load coast;hold on;plot(long,lat);plot(long+360,lat);hold off
colorbar
 
%Plot the SST data using the MATLAB Mapping Toolbox
 
figure
axesm('eqdcylin','maplatlimit',[-80 80],'maplonlimit',[0 360]);  % Create a cylindrical equidistant map
pcolorm(Nlt,Nlg,sst(:,:,1))           % pseudocolor plot "stretched" to the grid
load coast                                 % add continental outlines
plotm(lat,long)
colorbar
% sst数据格式
% Variables:
% lat 
% Size: 89x1
% Dimensions: lat
% Datatype: single
% Attributes:
% units = 'degrees_north'
% long_name = 'Latitude'
% actual_range = [88 -88]
% standard_name = 'latitude_north'
% axis = 'y'
% coordinate_defines = 'center'
% 
% lon 
% Size: 180x1
% Dimensions: lon
% Datatype: single
% Attributes:
% units = 'degrees_east'
% long_name = 'Longitude'
% actual_range = [0 358]
% standard_name = 'longitude_east'
% axis = 'x'
% coordinate_defines = 'center'
% 
% time 
% Size: 1787x1
% Dimensions: time
% Datatype: double
% Attributes:
% units = 'days since 1800-1-1 00:00:00'
% long_name = 'Time'
% actual_range = [19723 74083]
% delta_t = '0000-01-00 00:00:00'
% avg_period = '0000-01-00 00:00:00'
% prev_avg_period = '0000-00-07 00:00:00'
% standard_name = 'time'
% axis = 't'
% 
% time_bnds
% Size: 2x1787
% Dimensions: nbnds,time
% Datatype: double
% Attributes:
% long_name = 'Time Boundaries'
% 
% sst 
% Size: 180x89x1787
% Dimensions: lon,lat,time
% Datatype: int16
% Attributes:
% long_name = 'Monthly Means of Sea Surface Temperature'
% valid_range = [-5 40]
% actual_range = [-1.8 36.08]
% units = 'degC'
% add_offset = 0
% scale_factor = 0.01
% missing_value = 32767
% precision = 2
% least_significant_digit = 1
% var_desc = 'Sea Surface Temperature'
% dataset = 'NOAA Extended Reconstructed SST'
% level_desc = 'Surface'
% statistic = 'Mean'
% parent_stat = 'Mean'
