% MATLAB startup options

% Make figures docked by default
set(0,'DefaultFigureWindowStyle','docked');

% Disable horizontal scrolling
% !synclient HorizTwoFingerScroll=0

% Include base16 colorscheme setter
addpath('Documents/MATLAB/Base16/');
darkmode;

% Default colormap
set(0,'DefaultFigureColormap',plasma);

% Change directory
cd('~/Research/');