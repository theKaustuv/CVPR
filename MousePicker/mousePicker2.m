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

% --- Outputs from this function are returned to the command line.
function varargout = mousePicker2_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)

impath = get(handles.filename,'String');
filex = exist(impath);


image = imread(impath);
image = im2bw(image, 0.60);
image = ~(image);
image = bwareaopen(image, 10);

set(handles.original,'Visible','on');

set(handles.next,'Enable','on');


% show image on imshow
axes(handles.original);
imshow(image)
handles.image = image;
guidata(hObject,handles);

set(handles.langlist,'Enable','off');
set(handles.langaccept,'Enable','off');


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

set(handles.langlist,'Enable','off');
set(handles.langaccept,'Enable','off');

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

set(handles.cropped,'Visible','on');

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
