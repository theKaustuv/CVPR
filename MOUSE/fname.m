function output = fname( input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
l = length(input);
output = [];
c = 1;
while c<=l
    if input(c)~='.'
        output = [output input(c)];
    else
        break;
    end
    c = c+1;
end