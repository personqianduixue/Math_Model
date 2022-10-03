@echo off

set "year=%Date:~3,4%"
set "month=%Date:~8,2%"
set "day=%Date:~11,2%"
set "hour_ten=%time:~0,1%"
set "hour_one=%time:~1,1%"
set "minute=%time:~3,2%"
set "second=%time:~6,2%"

if "%hour_ten%" == " " (
    set "current_time=%year%-%month%-%day%--0%hour_one%-%minute%-%second%"
) else ( 
    set "current_time=%year%-%month%-%day%--%hour_ten%%hour_one%-%minute%-%second%"
)
echo %current_time% 
)

git add .
git reset -- ./gitpush.bat
git commit -m "update"
git push