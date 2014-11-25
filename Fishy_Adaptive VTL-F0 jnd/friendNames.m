function friendsID = friendNames
% extract the names of friends from the available files

    files = dir('../img/fixed/*.png');
    % BACKGROUND and FISHY are not friends;
    files = files(cellfun('isempty', strfind({files.name}, 'BACKGROUND')));
    files = files(cellfun('isempty', strfind({files.name}, 'FISHY')));
    files = files(cellfun('isempty', strfind({files.name}, 'bubbles')));
    
    % get unique identifier of each object: remove everything after first
    % underscore and use unique
    
    firstPartFriendName = regexp({files.name}, '\_', 'split', 'once');
    nNames = length(firstPartFriendName);
    cellNames = repmat({''}, 1, nNames);
    for iNames = 1 : nNames
        cellNames(iNames) = firstPartFriendName{iNames}(1);
    end
    friendsID = unique(cellNames);
end