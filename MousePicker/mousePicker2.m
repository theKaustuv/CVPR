function varargout = mousePicker2(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mousePicker2_OpeningFcn, ...
                   'gui_OutputFcn',  @mousePicker2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mousePicker2 is made visible.
function mousePicker2_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

set(handles.langlist,'Enable','off');
set(handles.langaccept,'Enable','off');
set(handles.original,'Visible','off');
set(handles.cropped,'Visible','off');
set(handles.next,'Enable','off');
set(handles.singlescript,'Enable','off');

% --- Outputs from this function are returned to the command line.
function varargout = mousePicker2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)

impath = get(handles.filename,'String');
existance = exist(impath);
if existance==0
    errordlg('Please Insert a valid filename','Filename Invalid');
elseif existance==2
    image = imread(impath);
    image = im2bw(image, 0.60);
    image = ~(image);
    image = bwareaopen(image, 10);

    
    set(handles.original,'Visible','on');
    set(handles.next,'Enable','on');
    set(handles.singlescript,'Enable','on');


    % show image on imshow
    axes(handles.original);
    imshow(image)
    handles.image = image;
    guidata(hObject,handles);

    set(handles.langlist,'Enable','off');
    set(handles.langaccept,'Enable','off');
end


function filename_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in langlist.
function langlist_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function langlist_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in langaccept.
function langaccept_Callback(hObject, eventdata, handles)
selected = handles.selected;
selection = get(handles.langlist,'Value');
langname = '';
switch selection
    case 1
        langname = 'EN';
    case 2
        langname = 'BE';
    case 3
        langname = 'HI';
    case 4
        langname = 'AS';
    case 5
        langname = 'TA';
    case 6
        langname = 'TE';
     case 7
        langname = 'MA';
    case 8
        langname = 'GM';
    case 9
        langname = 'GR';
    case 10
        langname = 'OR';
    case 11
        langname = 'KA';
    case 12
        langname = 'UR';
    case 13
        langname = 'CO';
    case 14
        langname = 'ER';
    
        
end

tmppath = mfilename('fullpath');
tmpdir1 = fileparts(tmppath);
fllist = dir(strcat(tmpdir1,'\',langname));
lastfile = fllist(length(fllist));
lastfilename = lastfile.name;
if strcmp(lastfilename,'..')
    lastfilename = '1';
else
    lastfilenumber = str2num(fname(lastfilename));
    lastfilenumber = lastfilenumber +1;
    lastfilename = num2str(lastfilenumber);
end

folderselect = strcat(tmpdir1,'\',langname,'\',strcat(lastfilename,'.tif'));
imwrite(selected,folderselect,'tif');

set(handles.outfilename,'String',strcat(lastfilename,'.tif'));

set(handles.langaccept,'TooltipString','tools');

% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)

% show image on imshow
axes(handles.original);
image = handles.image;
imshow(image)

set(handles.outfilename,'String','');


% wait for two clicks & get the position info
recorded = ginput(2);   % the recorded click-info
pos1x = floor(recorded(1,1));  % 1st position - X coordinate
pos1y = floor(recorded(1,2));  % 1st position - Y coordinate
pos2x = floor(recorded(2,1));  % 2nd position - X coordinate
pos2y = floor(recorded(2,2));  % 2nd position - Y coordinate

set(handles.c1x,'String',pos1x);
set(handles.c1y,'String',pos1y);
set(handles.c2x,'String',pos2x);
set(handles.c2y,'String',pos2y);

%set(handles.cropped,'Visible','on');

% Selected area validity check
if ((pos2x>pos1x) && (pos2y>pos1y))
    selected = zeros(pos2y - pos1y,pos2x - pos1x);
    col = 1;
    row = 1;
    for rowwise = pos1x:pos2x
        for colwise = pos1y:pos2y
            selected(col,row) = image(colwise,rowwise);
            col = col+1;
        end
        row = row + 1;
        col = 1;
    end
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
     if (sum > 3 && count == 0)
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
 axes(handles.cropped);
 imshow(crop_selected);
 selected=crop_selected;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    axes(handles.cropped);
    imshow(selected)

    handles.selected = selected;
    guidata(hObject,handles);
    clear selected
    set(handles.langlist,'Enable','on');
    set(handles.langaccept,'Enable','on');
else
    errordlg(...
        'Try to make the selection from Upper-Left to Lower-Right',...
        'Wrong selection pattern');
end


function outfile_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function outfile_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmppath = mfilename('fullpath');
tmpdir1 = fileparts(tmppath);
searchpath = strcat(tmpdir1,'\*.tif');
[file,path] = uigetfile({'*.tif';'*.png';'*.jpg';'*.gif';'*.bmp'},...
    'Choose a Script image',searchpath);
if ischar(file)
    set(handles.filename,'String',strcat(path,file));
end


% --- Executes on button press in singlescript.
function singlescript_Callback(hObject, eventdata, handles)
% handles.image visible from here

set(handles.langlist,'Enable','on');
set(handles.langaccept,'Enable','on');

img = handles.image;
previous = 0;
startline = [];
endline = [];

original = img;
sizeHW = size(img);  %get the size matrix of the image
sizeH = sizeHW(1);  % get Height - from the sizeHW
sizeW = sizeHW(2);  % get Width - from the sizeHW

for colindex = 2:sizeH
    if ((sum(img(colindex,:)')== 0) && (previous == 1)) % blank line
        previous = 0;
        endline = [endline colindex];
        original(colindex,:) = zeros(1,sizeW);
    elseif (sum(img(colindex,:)') ~= 0) && (previous == 0) %got some letters
        previous = 1;
        startline = [startline colindex-1];
        original(colindex-1,:) = zeros(1,sizeW);
    elseif (sum(img(colindex,:)') ~= 0) && (previous ==1) && (colindex==sizeH)
        previous = 0;
        endline = [endline colindex];
        original(colindex,:) = zeros(1,sizeW);
    end
end

%line validity check
linethickness = 10;
validstart = [];
validend = [];
for n = 1:length(startline) % OR it can be endline also
    if (endline(n)-startline(n))>linethickness
        validstart = [validstart startline(n)];
        validend = [validend endline(n)];
    end
end
startline = validstart;
endline = validend;
clear validstart
clear validend
% invalid lines sorted out


tlinenum = size(startline);
inlinesum = 0;
prevmark = 0;
gapping = 0;
threshold = 7;
linethreshold = 5;

wordpos = [];
wordnumperline = 0;
wordnumperlinearray = [];

for totalline = 1:tlinenum(2)
    for rowwise = 1:sizeW
        for inline = startline(totalline)+1:endline(totalline)-1
            inlinesum = inlinesum + img(inline,rowwise);
        end
        % word seg marking should be done here
        if inlinesum~=0 && prevmark==0
            for inline = startline(totalline)+1:endline(totalline)-1
                original(inline,rowwise-1) = 0 ;
            end
            %mark the start of a word
            wordpos = [wordpos rowwise];
            prevmark = 1;
        elseif inlinesum==0 && prevmark==1 && gapping<threshold            
            % mark the end of word
            if rowwise < (sizeW-linethreshold)
                gapping = gapping + 1;
                prevmark = 1;
            else
                for inline = startline(totalline)+1:endline(totalline)-1
                    original(inline,rowwise) = 0 ;
                end
                wordpos = [wordpos rowwise];
                wordnumperline = wordnumperline + 1;
                gapping = 0;
                prevmark = 0;
                %almost END OF LINE
            end
        elseif inlinesum==0 && prevmark==1 && gapping==threshold
            for inline = startline(totalline)+1:endline(totalline)-1
                original(inline,rowwise-threshold) = 0 ;
            end 
            wordpos = [wordpos rowwise];
            wordnumperline = wordnumperline + 1;
            gapping = 0;
            prevmark = 0;
        elseif inlinesum~=0 && prevmark==1
            gapping = 0;
            prevmark = 1;
        end
        % marking done goto next 'rowwise'
        inlinesum = 0;
    end
    wordnumperlinearray = [wordnumperlinearray wordnumperline];
    wordnumperline = 0;
    %wordpos
    gapping = 0;
    prevmark = 0;
end

worditer = 1;

for lineiter = 1:tlinenum(2)
    for rowiter = 1:wordnumperlinearray(lineiter)
        c = 1;
        r = 1;
        selected = [];
        for hlrow = wordpos(worditer):wordpos(worditer+1)
            for hlcol = startline(lineiter):endline(lineiter)
                selected(c,r) = img(hlcol,hlrow);
                c = c + 1;
            end
            r = r + 1;
            c = 1;
        end
%        clear selected;
        handles.selected = selected;
        guidata(hObject,handles);
        axes(handles.cropped);
        imshow(selected)
        % WAITFOR LANGACCEPT TO BE CALLED
        waitfor(handles.langaccept,'TooltipString','tools');
        set(handles.langaccept,'TooltipString','tool');
        worditer = worditer + 2;
    end
end