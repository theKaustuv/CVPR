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
    handles.impath = impath;
    guidata(hObject,handles);

    set(handles.langlist,'Enable','off');
    set(handles.langaccept,'Enable','off');
end


function filename_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in langlist.
function langlist_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function langlist_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
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

langfolder = strcat(tmpdir1,'\',langname);
[pth,filenameonly] = fileparts(handles.impath);
clear pth;
saveto = strcat(filenameonly,'_',num2str(handles.cropx1),...
    '_',num2str(handles.cropy1),'_',num2str(handles.cropx2),...
    '_',num2str(handles.cropy2),...
    '.tif');

folderselect = strcat(langfolder,'\',saveto);
if exist(folderselect)==0
     imwrite(selected,folderselect,'tif');
     set(handles.outfilename,'String',saveto);
elseif exist(folderselect)==2
     resp = questdlg(strcat('The file already exists !!! Maybe you have selected this before',...
         '. Want to continue anyway (OverWrite)?'),...
         'File Name Conflict','Yes','No','Yes');
     if strcmp(resp,'Yes')
        imwrite(selected,folderselect,'tif');
        set(handles.outfilename,'String',saveto);
     end
end

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
    
    [off1x,off1y,off2x,off2y,selected] = minarea(selected);
    
    axes(handles.cropped);
    imshow(selected)
    
    pos1x = pos1x + off1x;
    pos1y = pos1y + off1y;
    pos2x = pos2x - off2x;
    pos2y = pos2y - off2y;
    
    
    handles.cropx1 = pos1x;
    handles.cropx2 = pos2x;
    handles.cropy1 = pos1y;
    handles.cropy2 = pos2y;
    guidata(hObject,handles);
    
    set(handles.c1x,'String',pos1x);
    set(handles.c1y,'String',pos1y);
    set(handles.c2x,'String',pos2x);
    set(handles.c2y,'String',pos2y);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     axes(handles.cropped);
%     imshow(selected)

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

if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
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
ques = 'Yes';

for lineiter = 1:tlinenum(2)
    for rowiter = 1:wordnumperlinearray(lineiter)
        if strcmp(ques,'Yes') || strcmp(ques,'No')
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
            [off1x,off1y,off2x,off2y,selected] = minarea(selected);
    %        clear selected;
            handles.selected = selected;
            handles.cropx1 = wordpos(worditer) + off1x;
            handles.cropx2 = wordpos(worditer+1) - off2x;
            handles.cropy1 = startline(lineiter) + off1y;
            handles.cropy2 = endline(lineiter) - off2y;
            set(handles.c1x,'String',handles.cropx1);
            set(handles.c1y,'String',handles.cropy1);
            set(handles.c2x,'String',handles.cropx2);
            set(handles.c2y,'String',handles.cropy2);
            guidata(hObject,handles);
            axes(handles.cropped);
            imshow(selected)
            ques = questdlg('Is the auto-selection correct ?','Auto-Selection'...
                ,'Yes','No','Cancel','Yes');
            if strcmp(ques,'Yes')
                % WAITFOR LANGACCEPT TO BE CALLED
                waitfor(handles.langaccept,'TooltipString','tools');
            end
            set(handles.langaccept,'TooltipString','tool');
            worditer = worditer + 2;
        end
    end
end
