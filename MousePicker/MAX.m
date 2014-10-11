function output = MAX( current_FULL_path,langname_folder )

%%% MAX will return the 'highest digit_value' among the image_names and if

%%% all the image_names contain string_name then it will return ZERO

%%%set =>  current_FULL_path = mfilename('fullpath')

%%% set =>  langname-folder = langname ##AS PER PREVIOUS MAIN CODE

%%% YOU need include the 'fname.m' file in the same directory

tmpdir1 = fileparts(current_FULL_path);
fllist = dir(strcat(tmpdir1,'\',langname_folder));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
number = numel(fllist);
i=3;
count=0;
digit_array=zeros(1,number);
digit=1;
largest = 0;
%%%%%% separating the digit containing filename%%%%%%%%%%%%%%%
while i<number
    count = 0;
    sublist = fname(fllist(i).name);
    for j=1:1:(length(sublist))
           if((sublist(j)>47) && (sublist(j)<58))
                count= count+1;
           else
                break
           end
    end
    if(count==(length(sublist)))
        digit_array(digit) = str2num(fname(fllist(i).name));
        digit = digit +1;
    end
    i=i+1;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% highest No. in the filename%%%%%%%%%%%%%%%%%%%%%
for k=1:1:number
    if(digit_array(k) >largest)
        largest = digit_array(k);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
output = largest;