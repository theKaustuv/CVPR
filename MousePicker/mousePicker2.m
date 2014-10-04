function varargout = mousePicker2(varargin)
% MOUSEPICKER2 MATLAB code for mousePicker2.fig
%      MOUSEPICKER2, by itself, creates a new MOUSEPICKER2 or raises the existing
%      singleton*.
%
%      H = MOUSEPICKER2 returns the handle to a new MOUSEPICKER2 or the handle to
%      the existing singleton*.
%
%      MOUSEPICKER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOUSEPICKER2.M with the given input arguments.
%
%      MOUSEPICKER2('Property','Value',...) creates a new MOUSEPICKER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mousePicker2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mousePicker2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mousePicker2

% Last Modified by GUIDE v2.5 04-Oct-2014 23:00:34

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
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mousePicker2 (see VARARGIN)

% Choose default command line output for mousePicker2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mousePicker2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mousePicker2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)

impath = get(handles.filename,'String');
image = imread(impath);
image = im2bw(image, 0.60);
image = ~(image);
image = bwareaopen(image, 10);

% show image on imshow
axes(handles.original);
imshow(image)
handles.image = image;
guidata(hObject,handles);

set(handles.langlist,'Enable','off');


% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in langlist.
function langlist_Callback(hObject, eventdata, handles)
% hObject    handle to langlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns langlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from langlist


% --- Executes during object creation, after setting all properties.
function langlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to langlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
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
filenamechoice = get(handles.outfile,'String');

folderselect = strcat(tmpdir1,'\',langname,'\',filenamechoice,'.tif');
imwrite(selected,folderselect,'tif');

% hObject    handle to langaccept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% show image on imshow
axes(handles.original);
image = handles.image;
imshow(image)

% wait for two clicks & get the position info
recorded = ginput(2);   % the recorded click-info
pos1x = floor(recorded(1,1));  % 1st position - X coordinate
pos1y = floor(recorded(1,2));  % 1st position - Y coordinate
pos2x = floor(recorded(2,1));  % 2nd position - X coordinate
pos2y = floor(recorded(2,2));  % 2nd position - Y coordinate

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
    % DO SOMETHING FOR STORING THE SELECTED PART


    % DO SOMETHING FOR STORING THE SELECTED PART
%        end
    clear selected
else
    disp('Try to drag from upper-left to lower-bottom');
end
set(handles.langlist,'Enable','on');



function outfile_Callback(hObject, eventdata, handles)
% hObject    handle to outfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outfile as text
%        str2double(get(hObject,'String')) returns contents of outfile as a double


% --- Executes during object creation, after setting all properties.
function outfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
