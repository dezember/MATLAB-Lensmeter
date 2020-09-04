function varargout = Team10_5020(varargin)
% Anurag Kanase & Ahmad Zunnu Rain
% gu1924 & 
% 
% TEAM10_5020 MATLAB code for Team10_5020.fig
%      TEAM10_5020, by itself, creates a new TEAM10_5020 or raises the existing
%      singleton*.
%
%      H = TEAM10_5020 returns the handle to a new TEAM10_5020 or the handle to
%      the existing singleton*.
%
%      TEAM10_5020('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEAM10_5020.M with the given input arguments.
%
%      TEAM10_5020('Property','Value',...) creates a new TEAM10_5020 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Team10_5020_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Team10_5020_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Team10_5020

% Last Modified by GUIDE v2.5 19-Apr-2019 17:29:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Team10_5020_OpeningFcn, ...
                   'gui_OutputFcn',  @Team10_5020_OutputFcn, ...
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


% --- Executes just before Team10_5020 is made visible.
function Team10_5020_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Team10_5020 (see VARARGIN)

% Choose default command line output for Team10_5020
handles.output = hObject;
%Load Non-linear Plots by default

make_plot(handles);


guidata(hObject, handles);

% UIWAIT makes Team10_5020 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Team10_5020_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function url_link_Callback(hObject, eventdata, handles)
% hObject    handle to url_link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of url_link as text
%        str2double(get(hObject,'String')) returns contents of url_link as a double

url = get(handles.url_link,'String'); % Read URL from the entered text
setappdata(0,'bg_url',url); % Make the value globally available

% --- Executes during object creation, after setting all properties.
function url_link_CreateFcn(hObject, eventdata, handles)
% hObject    handle to url_link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Rx.
function Rx_Callback(hObject, eventdata, handles)
% hObject    handle to Rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img_ratio=get(handles.image_ratio,'String');
im_ratio=0.50;
img_ratio=str2double(img_ratio)

if get(handles.choose_nearsighted,'Value')==1 && get(handles.choose_linear,'Value')==1
            r=call_DB();
            x=cell2mat(r(4));y=cell2mat(r(5));
            power_fit=linear_reg(x,y);
            a1=cell2mat(power_fit(5));
            a0=cell2mat(power_fit(6));
            yline=cell2mat(power_fit(7));
            
            lens=(img_ratio-a0)/a1;
            acc = 0.25;
            result = round(lens/acc)*acc;
            set(handles.display_Rx,'String',result)
    elseif get(handles.choose_nearsighted,'Value')==1 && get(handles.choose_nonlinear,'Value')==1
            r=call_DB();
            x=cell2mat(r(4));y=cell2mat(r(5));
            power_fit=power_reg(x,y);
            a2=cell2mat(power_fit(5));
            a1=cell2mat(power_fit(6));
            a0=cell2mat(power_fit(7));
            yline=cell2mat(power_fit(8));
            lens=roots([a2 a1 a0-img_ratio]);
            lens=lens(lens<max(lens));
            acc = 0.25;
            result = round(lens/acc)*acc;
            set(handles.display_Rx,'String',result)
    elseif get(handles.choose_farsighted,'Value')==1 && get(handles.choose_linear,'Value')==1
            r=call_DB();
            x=cell2mat(r(1));y=cell2mat(r(2));
            power_fit=linear_reg(x,y);
            a1=cell2mat(power_fit(5));
            a0=cell2mat(power_fit(6));
            yline=cell2mat(power_fit(7));
            lens=(img_ratio-a0)/a1;
            acc = 0.25;
            result = round(lens/acc)*acc
            set(handles.display_Rx,'String',result)
    elseif get(handles.choose_farsighted,'Value')==1 && get(handles.choose_nonlinear,'Value')==1
            r=call_DB();
            x=cell2mat(r(1));y=cell2mat(r(2));
            power_fit=power_reg(x,y);
            a2=cell2mat(power_fit(5));
            a1=cell2mat(power_fit(6));
            a0=cell2mat(power_fit(7));
            yline=cell2mat(power_fit(8));
            lens=roots([a2 a1 a0-img_ratio]);disp(lens)
            lens=lens(lens>0);
            acc = 0.25;
            result = round(lens/acc)*acc;
            set(handles.display_Rx,'String',result)
 end
print_rx=get(handles.display_Rx,'String')
if img_ratio>1
    print_rxx=['Rx: +',print_rx,' (±0.25)']
elseif img_ratio<1
    print_rxx=['Rx: -',print_rx,' (±0.25)']
end
set(handles.display_Rx,'String',print_rxx)
% --- Executes on slider movement.
function glasses_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to glasses_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
gl_thresh=get(handles.glasses_threshold,'Value');
cords=getappdata(0,'cordx');%imcrop(img,);
gl_gimg=getappdata(0,'gl_gimg');
gl_gimg=imcrop(gl_gimg,[cords(1) cords(2) cords(3:4)-cords(1:2)]);
gl_timg=gl_gimg>gl_thresh;
gl_timg=~gl_timg;
bin_close=imfill(gl_timg,'holes');
setappdata(0,'gl_close',bin_close); % Make it globally available
axes(handles.glasses_img);imshow(bin_close);

% --- Executes during object creation, after setting all properties.
function glasses_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to glasses_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in compute_glasses.
function compute_glasses_Callback(hObject, eventdata, handles)
% hObject    handle to compute_glasses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gl_close=getappdata(0,'gl_close');
boundaries = bwboundaries(gl_close);
for k=1:length(boundaries)
    b=  boundaries{k};
    if length(b)>700
        plot(b(:,2),b(:,1),'g','LineWidth',3);
        area=polyarea(b(:,2),b(:,1));
    end
end
setappdata(0,'gl_area',area);
set(handles.glasses_area, 'String', area);%+" sq.px");
bg_area=getappdata(0,'bg_area');
bg_gl_ratio=area/bg_area;
setappdata(0,'bg_gl_ratio',bg_gl_ratio); % Background and glasses ratio
set(handles.image_ratio,'String',bg_gl_ratio);



% --- Executes on button press in load_glasses.
function load_glasses_Callback(hObject, eventdata, handles)
% hObject    handle to load_glasses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

url=getappdata(0,'bg_url'); % Get the URL from "bg_url" 
cam=ipcam(url); %Start the IP Cam
img=snapshot(cam); % Take a snapshot of the IPCAM Image
gimg=rgb2gray(img); % Convert to gray Scale
gimg=imrotate(gimg,-90);
setappdata(0,'gl_gimg',gimg); % Make it globally available
axes(handles.glasses_img);ie=imshow(gimg);
set(ie,'ButtonDownFcn',@twoclick)


% --- Executes on slider movement.
function background_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to background_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

bg_thresh=get(handles.background_threshold,'Value');
bg_gimg=getappdata(0,'bg_gimg');
cords=getappdata(0,'cordx');%imcrop(img,);
bg_gimg=imcrop(bg_gimg,[cords(1) cords(2) cords(3:4)-cords(1:2)]);%0,800,1080,1300,,,,, [297,561,540,872])
bg_timg=bg_gimg>bg_thresh;
bg_timg=~bg_timg;
bin_close=imfill(bg_timg,'holes');
setappdata(0,'bg_close',bin_close); % Make it globally available
axes(handles.background_img);imshow(bin_close);

% --- Executes during object creation, after setting all properties.
function background_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to background_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in compute_background.
function compute_background_Callback(hObject, eventdata, handles)
% hObject    handle to compute_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

bg_close=getappdata(0,'bg_close');
boundaries = bwboundaries(bg_close);
for k=1:length(boundaries)
    b=  boundaries{k};
    if length(b)>1000
        plot(b(:,2),b(:,1),'g','LineWidth',3);
        area=polyarea(b(:,2),b(:,1));
    end
end
setappdata(0,'bg_area',area);
set(handles.background_area, 'String', area);

% --- Executes on button press in load_background.
function load_background_Callback(hObject, eventdata, handles)
% hObject    handle to load_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clearvars getappdata(0,'cordx')
url=getappdata(0,'bg_url'); % Get the URL from "bg_url" 
cam=ipcam(url); %Start the IP Cam
img=snapshot(cam); % Take a snapshot of the IPCAM Image
gimg=rgb2gray(img); % Convert to gray Scale
gimg=imrotate(gimg,-90);% To left
setappdata(0,'bg_gimg',gimg); % Make it globally available
axes(handles.background_img);
hold on;te=imshow(gimg);hold off;
set(te,'ButtonDownFcn',@twoclick) % Call function to select two coordinates of credit card

% --- Executes on selection change in sign.
function sign_Callback(hObject, eventdata, handles)
% hObject    handle to sign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sign contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sign


% --- Executes during object creation, after setting all properties.
function sign_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function power_db_Callback(hObject, eventdata, handles)
% hObject    handle to power_db (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of power_db as text
%        str2double(get(hObject,'String')) returns contents of power_db as a double


% --- Executes during object creation, after setting all properties.
function power_db_CreateFcn(hObject, eventdata, handles)
% hObject    handle to power_db (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_database.
function add_database_Callback(hObject, eventdata, handles)
% hObject    handle to add_database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles    structure with handles and user data (see GUIDATA)
sign_status=get(handles.sign,'String');
sign_index=get(handles.sign,"Value");
sign_selection=sign_status(sign_index);
bg_gl_ratio=getappdata(0,'bg_gl_ratio');

power_value=str2num(get(handles.power_db,'String'));
power_add_value=[power_value,bg_gl_ratio] % Add the value of image ratio and power to database file 
if sign_selection{1}=='+'
    dlmwrite("farsighted.txt",power_add_value,'-append');
elseif sign_selection{1}=='-'
    dlmwrite("nearsighted.txt",power_add_value,'-append');
end


% --- Executes on button press in remove_entry.
function remove_entry_Callback(hObject, eventdata, handles)
% hObject    handle to remove_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sign_status=get(handles.sign,'String');
sign_index=get(handles.sign,"Value");
sign_selection=sign_status(sign_index);
if sign_selection{1}=='+'
    correction_values=dlmread("farsighted.txt");
elseif sign_selection{1}=='-'
    correction_values=dlmread("nearsighted.txt");
end

correction_values=correction_values(1:end-1,:);
if sign_selection{1}=='+'
    dlmwrite("farsighted.txt",correction_values);
elseif sign_selection{1}=='-'
    dlmwrite("nearsighted.txt",correction_values);
end


% --- Executes on button press in demo.
function demo_Callback(hObject, eventdata, handles)
% hObject    handle to demo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bg_demo=imread('bg.jpg');bg_demo=rgb2gray(bg_demo);bg_demo=imrotate(bg_demo,-90);
ti=imshow(bg_demo,'Parent',handles.background_img);
%gimg=rgb2gray(img); % Convert to gray Scale
%gimg=imrotate(gimg,-90);% To left
setappdata(0,'bg_gimg',bg_demo);
set(ti,'ButtonDownFcn',@twoclick)
glasses_demo=imread('glass.jpg');glasses_demo=rgb2gray(glasses_demo);glasses_demo=imrotate(glasses_demo,-90);
ie=imshow(glasses_demo,'Parent',handles.glasses_img);
setappdata(0,'gl_gimg',glasses_demo); % Make it globally available
set(ie,'ButtonDownFcn',@twoclick)

%axes(handles.background_img);imshow(bg_demo);
%axes(handles.glasses_img);imshow(glasses_demo);


function make_plot(handles)
    if get(handles.choose_nearsighted,'Value')==1 && get(handles.choose_linear,'Value')==1
         cla(handles.nearsighted_plot,'reset'); 
         cla(handles.farsighted_plot,'reset');
         axes(handles.nearsighted_plot);
            nl_p=plot_linear(1);
         axes(handles.farsighted_plot);
            fl_p=plot_linear(2);
                set(handles.display_function,'String',nl_p)
    elseif get(handles.choose_nearsighted,'Value')==1 && get(handles.choose_nonlinear,'Value')==1
         cla(handles.nearsighted_plot,'reset'); 
         cla(handles.farsighted_plot,'reset');
        axes(handles.nearsighted_plot);
            nnl_p=plot_non_linear(1);
         axes(handles.farsighted_plot);
            fl_p=plot_linear(2);
                set(handles.display_function,'String',nnl_p)
    elseif get(handles.choose_farsighted,'Value')==1 && get(handles.choose_linear,'Value')==1
         cla(handles.nearsighted_plot,'reset'); 
         cla(handles.farsighted_plot,'reset');
        axes(handles.nearsighted_plot);
            nl_p=plot_linear(1);
         axes(handles.farsighted_plot);
            fl_p=plot_linear(2);
                set(handles.display_function,'String',fl_p)
    elseif get(handles.choose_farsighted,'Value')==1 && get(handles.choose_nonlinear,'Value')==1
         cla(handles.nearsighted_plot,'reset'); 
         cla(handles.farsighted_plot,'reset');
        axes(handles.nearsighted_plot);
            nnl_p=plot_linear(1);
         axes(handles.farsighted_plot);
            fnl_p=plot_non_linear(2);
                set(handles.display_function,'String',fnl_p)
    end

    


function o=plot_linear(val,hObject, eventdata, handles)
    if val==1
            r=call_DB();
            x=cell2mat(r(4));y=cell2mat(r(5));
            power_fit=linear_reg(x,y);
            x_fit=cell2mat(power_fit(1));y_fit=cell2mat(power_fit(2));
            r2=cell2mat(power_fit(3));%r2=num2str(r2(1));
            %axes(handles.nearsighted_plot);
            hold on
            plot(x,y,'o');
            plot(x_fit,y_fit);
            strk=sprintf('Fit function, R^2=%f',r2);
            legend('Database Value', strk);
            title("Near Sighted Database");
            xlabel("Power (-ve) (in Diopters, m^{-1})");
            ylabel("Image Ratio")
            hold off
            o=cell2mat(power_fit(4));
    
    elseif val==2
            r=call_DB();
            x=cell2mat(r(1));y=cell2mat(r(2));
            power_fit=linear_reg(x,y);
            x_fit=cell2mat(power_fit(1));y_fit=cell2mat(power_fit(2));
            r2=cell2mat(power_fit(3));
            %axes(handles.nearsighted_plot);
            hold on
            plot(x,y,'o');
            plot(x_fit,y_fit);
            strk=sprintf('Fit function, R^2=%f',r2);% 'location','northwest');
            legend('Database Value', strk);
            title("Far Sighted Database");
            xlabel("Power (+ve) (in Diopters, m^{-1})");
            ylabel("Image Ratio")
            hold off
            o=cell2mat(power_fit(4));
    end


function o=plot_non_linear(val,hObject, eventdata, handles)
    if val==1
            r=call_DB();
            x=cell2mat(r(4));y=cell2mat(r(5));
            power_fit=power_reg(x,y);
            x_fit=cell2mat(power_fit(1));y_fit=cell2mat(power_fit(2));
            r2=cell2mat(power_fit(3));%r2=num2str(r2(1));
            hold on
            plot(x,y,'o');
            plot(x_fit,y_fit);
            strk=sprintf('Fit function, R^2=%f',r2);
            legend('Database Value', strk);
            title("Near Sighted Database");
            xlabel("Power (-ve) (in Diopters, m^{-1})");
            ylabel("Image Ratio")
            hold off
            o=cell2mat(power_fit(4));
    
    elseif val==2
            r=call_DB();
            x=cell2mat(r(1));y=cell2mat(r(2));
            power_fit=power_reg(x,y);
            x_fit=cell2mat(power_fit(1));y_fit=cell2mat(power_fit(2));
            r2=cell2mat(power_fit(3));
            %axes(handles.nearsighted_plot);
            hold on
            plot(x,y,'o');
            plot(x_fit,y_fit);
            strk=sprintf('Fit function, R^2=%f',r2);% 'location','northwest');
            legend('Database Value', strk);
            title("Far Sighted Database");
            xlabel("Power (+ve) (in Diopters, m^{-1})");
            ylabel("Image Ratio")
            hold off
            o=cell2mat(power_fit(4));
    end

function twoclick ( objectHandle , eventData )
% This function allows to:
% Select 2 coordinates from the respective axes
    button = 1;
    total=[];
 while sum(button) <=2   % 
    axesHandle  = get(objectHandle,'Parent');
   coord= get(axesHandle,'CurrentPoint');
   [coordinates2]=round(coord(1,1:2));
   total=[total,coordinates2];
   %[x,y,button] = ginput(1)
   w = waitforbuttonpress;

   button=button+1;
 end
    setappdata(0,'cordx',total)


% --- Executes on button press in choose_nearsighted.
function choose_nearsighted_Callback(hObject, eventdata, handles)
% hObject    handle to choose_nearsighted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_nearsighted
make_plot(handles);


% --- Executes on button press in choose_farsighted.
function choose_farsighted_Callback(hObject, eventdata, handles)
% hObject    handle to choose_farsighted (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_farsighted
make_plot(handles);


% --- Executes on button press in choose_linear.
function choose_linear_Callback(hObject, eventdata, handles)
% hObject    handle to choose_linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_linear
make_plot(handles);



% --- Executes on button press in choose_nonlinear.
function choose_nonlinear_Callback(hObject, eventdata, handles)
% hObject    handle to choose_nonlinear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_nonlinear
make_plot(handles);
