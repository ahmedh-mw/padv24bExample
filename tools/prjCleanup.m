function prjCleanup()
%prjCleanup Clean up environment
%   Restore the environment before exiting the current project. This
%   function is set to run at Shutdown.
%
%   prjCleanup()

%   Copyright 2022 The MathWorks, Inc.

% Clear the workspace.
evalin('base', 'clear;');

% Close all figures.
close('all');

% Close all models.
bdclose('all');

% Close all test files and test results.
if Advisor.Utils.license('test', 'Simulink_Test')
    sltest.testmanager.clear();
    sltest.testmanager.clearResults();
    sltest.testmanager.close();
end

if Advisor.Utils.license('test', 'Simulink_Requirements')
    slreq.clear();
end