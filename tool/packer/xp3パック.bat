@echo off
setlocal

if "%~1"=="" goto HELP

set RELEASER="%~dp0krkrrel"
set OUT_FOLDER=%~dp0output\
set RPF="%~dp0default.rpf"
set SIGN="%~dp0\����.bat"


if not exist %OUT_FOLDER% mkdir %OUT_FOLDER%

:REPEAT
	if exist "%~f1\" (
		%RELEASER% "%~f1" -out "%OUT_FOLDER%%~n1.xp3" -go -nowriterpf -rpf "%RPF%"
		call %SIGN% "%OUT_FOLDER%%~n1.xp3"
	)

	if "%~2"=="" goto END
	shift
goto REPEAT


:HELP
	echo �p�b�P�[�W���O����t�@�C�����w�肵�Ă��������B


:END
	endlocal

