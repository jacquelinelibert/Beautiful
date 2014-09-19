function expe_run(subject, phase)

% expe_run(subject, phase)
%   phase can be: 'training', 'test'

%--------------------------------------------------------------------------
% Etienne Gaudrain <etienne.gaudrain@mrc-cbu.cam.ac.uk> - 2010-03-16
% Medical Research Council, Cognition and Brain Sciences Unit, UK
%--------------------------------------------------------------------------

options = struct();
options = expe_options(options);

options.subject_name  = subject;

%-------------------------------------------------
% Set appropriate path

current_dir = fileparts(mfilename('fullpath'));
added_path  = {};

if ~exist('setPA4', 'file')
    addpath(fullfile(current_dir, 'TDT_dummy'));
    added_path{end+1} = fullfile(current_dir, 'TDT_dummy');
    disp('WARNING: TDT-Dummy used instead of TDT.');
end

if ~exist('pa', 'file')
    addpath(fullfile(current_dir, 'pa_7'));
    added_path{end+1} = fullfile(current_dir, 'pa_7');
end

%-------------------------------------------------

% Create result dir if necessary
if exist(options.result_path)~=7
    mkdir(options.result_path);
end

res_filename = fullfile(options.result_path, sprintf('%s%s.mat', options.result_prefix, subject));
options.res_filename = res_filename;

if exist(res_filename)~=2
    opt = char(questdlg(sprintf('The subject "%s" doesn''t exist. Create it?', subject),'CRM','OK','Cancel','OK'));
    switch lower(opt)
        case 'ok',
            expe_build_conditions(options);
        case 'cancel'
            return
        otherwise
            error('Unknown option: %s',opt)
    end
else
    opt = char(questdlg(sprintf('Found "%s". Use this file?', res_filename),'CRM','OK','Cancel','OK'));
    if strcmpi(opt, 'Cancel')
        return
    end
end

expe_main(options, phase);

%------------------------------------------
% Clean up the path

for i=1:length(added_path)
    rmpath(added_path{i});
end
