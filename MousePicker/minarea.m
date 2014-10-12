function [ crop_selected ] = minarea( selected )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 %%%%%%%%%%%%%%%%%%%%%%%%$$$   MINIMUM POSSIBLE AREA    $$$$%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 crop_image = selected;
 [R C] = size(crop_image);
 count=0;
 %%%%%%%%%  for minimum height  %%%%%%%%%%
 start_row =1;
 end_row = R;
  for i=1:R
     sum = 0;
     for j=1:C
         sum = sum + crop_image(i,j);
     end
     if (sum > 2 && count == 0)
         start_row = i;count=1;  %%%%%%%GETTING THE START_ROW VALUE
     end
     if(sum<2 && count == 1)      %%%%%%%GETTING THE END_ROW VALUE
         end_row = i;count=0;
     end
  end
 %%%%%%%   For MINIMUM BREADTH  %%%%%%%%%%%%% 
   for c=1:C
     sum=0;
     for r = start_row:end_row
         sum = sum + crop_image(r,c);
     end
     if(sum>4)
         start_column = c;      %%%%%%%%%%GETING THE START_COLUMN VALUE
         break;
     end
   end
   for c=C:(-1):1
     sum=0;
     for r = start_row:end_row
         sum = sum + crop_image(r,c);
     end
     
     if(sum>4 )
         end_column = c;       %%%%%%%%%%getting the end_column value
         break;
     end
   end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
crop_selected=zeros((end_row-start_row),(end_column-start_column));
%%%%%%%%%%%     final crop selection      %%%%%%%%%%%%%%%%%%%%%%
    col = 1;
    row = 1;
    for rowwise = start_column:end_column
        for colwise = start_row:end_row
            crop_selected(col,row) = crop_image(colwise,rowwise);
            col = col+1;
        end
        row = row + 1;
        col = 1;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

