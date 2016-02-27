function varargout = final_project(varargin)
% FINAL_PROJECT MATLAB code for final_project.fig
%      FINAL_PROJECT, by itself, creates a new FINAL_PROJECT or raises the existing
%      singleton*.
%
%      H = FINAL_PROJECT returns the handle to a new FINAL_PROJECT or the handle to
%      the existing singleton*.
%
%      FINAL_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL_PROJECT.M with the given input arguments.
%
%      FINAL_PROJECT('Property','Value',...) creates a new FINAL_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final_project

% Last Modified by GUIDE v2.5 05-Dec-2015 19:39:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_project_OpeningFcn, ...
                   'gui_OutputFcn',  @final_project_OutputFcn, ...
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


% --- Executes just before final_project is made visible.
function final_project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final_project (see VARARGIN)

handles.right_flag=0;
handles.left_flag=0;
handles.forward_flag=0;
handles.backward_flag=0;
axes(handles.axes1);
set(handles.bluetooth,'Value',0);
set(handles.insert_port,'Visible','off');
set(handles.port_num,'Visible','off');
set(handles.character,'Enable','off');

% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('tech_background.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');



% Choose default command line output for final_project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes final_project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1}=handles;


% --- Executes on button press in bluetooth.
function bluetooth_Callback(hObject, eventdata, handles)
% hObject    handle to bluetooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of bluetooth


if(get(hObject,'Value'))
    set(handles.insert_port,'Visible','on');
    set(handles.port_num,'Visible','on');
else
    set(handles.character,'Enable','off');
    set(hObject, 'String','Connect');
    fclose(handles.s);
    
end;
guidata(hObject, handles);

 

function character_Callback(hObject, eventdata, handles)
% hObject    handle to character (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of character as text
%        str2double(get(hObject,'String')) returns contents of character as a double

text_send=get(hObject,'String');
set(hObject, 'String','');
fprintf(handles.s,'%c',text_send);


% --- Executes during object creation, after setting all properties.
function character_CreateFcn(hObject, eventdata, handles)
% hObject    handle to character (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function port_num_Callback(hObject, eventdata, handles)
% hObject    handle to port_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of port_num as text
%        str2double(get(hObject,'String')) returns contents of port_num as a double


instrumentObjects=instrfind;
delete(instrumentObjects);
com_num=get(hObject,'String');
COM=strcat('COM',com_num);
s=serial(COM,'TimeOut',1);
try
    fopen(s);
    handles.s=s;
    set(handles.insert_port,'Visible','off');
    set(hObject,'Visible','off');
    set(handles.character,'Enable','on');
    set(handles.bluetooth, 'String','Disconnect');
catch e
        errordlg(e.message);
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function port_num_CreateFcn(hObject, ~, handles)
% hObject    handle to port_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles,'s')
    fclose(handles.s);
end

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in camera.
function camera_Callback(hObject, eventdata, handles)
% hObject    handle to camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of camera


if(get(hObject,'Value'))
    handles.vid=videoinput('winvideo',1,'RGB24_640x480');
    hImage = image(zeros(480,640,3),'parent',handles.axes1);
    factor=pi/4;
    Alpha=0.8;
    preview(handles.vid,hImage);
    hold on;
    guidata(hObject,handles);
    
    while 1
        if(get(hObject,'Value')==0)
            break;
        end;
        im=getsnapshot(handles.vid);
        [centers,radii]=imfindcircles(im,[60 100],'ObjectPolarity','dark','Sensitivity',0.9);
        if(~isempty(radii))
            crop=imcrop(im, [(centers(1,1)-radii(1,1)) (centers(1,2)-radii(1,1)) 2*radii(1,1) 2*radii(1,1)]);
            [im_green, num]=green(crop);
            if(num>=Alpha*factor*4*radii(1,1)^2)
                h=viscircles(centers(1,:),radii(1,1),'EdgeColor','g');
                if isfield(handles,'s')
                    fwrite(handles.s,'G');
                    set(handles.forward,'BackgroundColor',[.94 .94 .94]);
                    handles.forward_flag=0;
                    set(handles.backward,'BackgroundColor',[.94 .94 .94]);
                    handles.backward_flag=0;
                    set(handles.left,'BackgroundColor',[.94 .94 .94]);
                    handles.left_flag=0;
                    set(handles.right,'BackgroundColor',[.94 .94 .94]);
                    handles.right_flag=0;
                    guidata(hObject, handles);
                end;
                pause(0.4);
                delete(h);
                continue;
            end;
            [im_red, num]=red(crop);
            if(num>=Alpha*factor*4*radii(1,1)^2)
                h=viscircles(centers(1,:),radii(1,1),'EdgeColor','r');
                if isfield(handles,'s')
                    fwrite(handles.s,'R');
                    set(handles.forward,'BackgroundColor',[.94 .94 .94]);
                    handles.forward_flag=0;
                    set(handles.backward,'BackgroundColor',[.94 .94 .94]);
                    handles.backward_flag=0;
                    set(handles.left,'BackgroundColor',[.94 .94 .94]);
                    handles.left_flag=0;
                    set(handles.right,'BackgroundColor',[.94 .94 .94]);
                    handles.right_flag=0;
                    guidata(hObject, handles);
                end;
                pause(0.4);
                delete(h);
                continue;
            end;
            [im_yellow, num]=yellow(crop);
            if(num>=Alpha*factor*4*radii(1,1)^2)
                h=viscircles(centers(1,:),radii(1,1),'EdgeColor','y');
                if isfield(handles,'s')
                    fwrite(handles.s,'Y');
                    set(handles.forward,'BackgroundColor',[.94 .94 .94]);
                    handles.forward_flag=0;
                    set(handles.backward,'BackgroundColor',[.94 .94 .94]);
                    handles.backward_flag=0;
                    set(handles.left,'BackgroundColor',[.94 .94 .94]);
                    handles.left_flag=0;
                    set(handles.right,'BackgroundColor',[.94 .94 .94]);
                    handles.right_flag=0;
                    guidata(hObject, handles);
                end;
                pause(0.4);
                delete(h);
                continue;
            end;
            pause(0.4);
        else
            pause(0.4);
        end;   
    end;
    
else
    closepreview(handles.vid);
    handles = rmfield(handles,'vid');
    delete(handles.axes1.Children);
    set(handles.axes1,'Visible','on');
    set(handles.axes1,'color','black');
    set(handles.axes1,'XTick',[]);
    set(handles.axes1,'YTick',[]);
    guidata(hObject, handles);
end

guidata(hObject, handles);


% --- Executes on button press in forward.
function forward_Callback(hObject, eventdata, handles)
% hObject    handle to forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~handles.forward_flag)
    fwrite(handles.s,'f');
    set(hObject,'BackgroundColor',[.41 .41 .41]);
    handles.forward_flag=1;
    set(handles.backward,'BackgroundColor',[.94 .94 .94]);
    handles.backward_flag=0;
    set(handles.left,'BackgroundColor',[.94 .94 .94]);
    handles.left_flag=0;
    set(handles.right,'BackgroundColor',[.94 .94 .94]);
    handles.right_flag=0;
    guidata(hObject, handles);

else
    fwrite(handles.s,'0');
    set(hObject,'BackgroundColor',[.94 .94 .94]);
    handles.forward_flag=0;
    guidata(hObject, handles);
end


% --- Executes on button press in backward.
function backward_Callback(hObject, eventdata, handles)
% hObject    handle to backward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~handles.backward_flag)
    fwrite(handles.s,'b');
    set(handles.forward,'BackgroundColor',[.94 .94 .94]);
    handles.forward_flag=0;
    set(hObject,'BackgroundColor',[.41 .41 .41]);
    handles.backward_flag=1;
    set(handles.left,'BackgroundColor',[.94 .94 .94]);
    handles.left_flag=0;
    set(handles.right,'BackgroundColor',[.94 .94 .94]);
    handles.right_flag=0;
    guidata(hObject, handles);

else
    fwrite(handles.s,'0');
    set(hObject,'BackgroundColor',[.94 .94 .94]);
    handles.backward_flag=0;
    guidata(hObject, handles);

end


% --- Executes on button press in left.
function left_Callback(hObject, eventdata, handles)
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~handles.left_flag)
    fwrite(handles.s,'l');
    set(handles.forward,'BackgroundColor',[.94 .94 .94]);
    handles.forward_flag=0;
    set(handles.backward,'BackgroundColor',[.94 .94 .94]);
    handles.backward_flag=0;
    set(hObject,'BackgroundColor',[.41 .41 .41]);
    handles.left_flag=1;
    set(handles.right,'BackgroundColor',[.94 .94 .94]);
    handles.right_flag=0;
    guidata(hObject, handles);
    
else
    fwrite(handles.s,'0');
    set(hObject,'BackgroundColor',[.94 .94 .94]);
    handles.left_flag=0;
    guidata(hObject, handles);
end


% --- Executes on button press in right.
function right_Callback(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(~handles.right_flag)
    fwrite(handles.s,'r');
    set(handles.forward,'BackgroundColor',[.94 .94 .94]);
    handles.forward_flag=0;
    set(handles.backward,'BackgroundColor',[.94 .94 .94]);
    handles.backward_flag=0;
    set(handles.left,'BackgroundColor',[.94 .94 .94]);
    handles.left_flag=0;
    set(hObject,'BackgroundColor',[.41 .41 .41]);
    handles.right_flag=1;
    guidata(hObject, handles);
    
else
    fwrite(handles.s,'0');
    set(hObject,'BackgroundColor',[.94 .94 .94]); 
    handles.right_flag=0;
    guidata(hObject, handles);
end
