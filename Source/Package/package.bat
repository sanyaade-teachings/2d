@echo off

::
:: Helper script that builds the FBXImporter solution and then calls
:: the packaging script. Assumes you have VS2010 and Python installed.
::

set VS10_BIN=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin
set VCVARS32="%VS10_BIN%\vcvars32.bat"

if not exist %VCVARS32% goto NO_VS10

set PACKAGE_TOOL=%VISION_SDK%\Bin\win32_vs2010_anarchy\dev_dll\DX9\PackageTool.exe
set PROJECT=%~dp0\..\..\..\Assets\Sample2D.project

%PACKAGE_TOOL% -project="%PROJECT%" -profile="pcdx9,ios,android" -variant="DefaultWithPVR" -export -close

set SOLUTION=%~dp0\..\..\Workspace\2D_Toolset_Win32_VS2010_DX9_All.sln
set PACKAGE=%~dp0\package.py

goto END

:: Setup the Visual Studio environment variables
call %VCVARS32%

:: Build the 'Dev DLL' solution
msbuild %SOLUTION% /t:Build /p:Configuration="Dev DLL"

:: Run the packaging script
python %PACKAGE%

goto END

:NO_VS10

echo Failed to find Visual Studio 2010! Please ensure it's installed.
echo Environment batch not found: %VCVARS32%

:END