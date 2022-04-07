set picsize=1200
set nowpath=%~dp0
set inputpath=%1
%nowpath%/nconvert -out jpeg -ratio -resize %picsize% 0 %inputpath%
