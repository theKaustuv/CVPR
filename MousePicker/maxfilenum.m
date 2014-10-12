function [ filenum ] = maxfilenum( dirpath )
%get the file and directory list
list = dir(dirpath);
%count number of entries
entry = length(list);
% initially '1', if no file found this will be output
filenum = '0';
%iterate through each entry
for index = 1:entry
    % if 'index'th entry is a 'numbered' file
    if ~(isnan(str2double(fname(list(index).name))))
        % if 'index'th file is a 'greater' numbered file
        if str2double(fname(list(index).name)) > str2double(filenum)
            % update the filenum variable with 'index'th number string
            filenum = fname(list(index).name);
        end
    end
end
end