clear;
close all; 
load 48from17_5to8_5.mat

Drillstart = W.Time(1);
hoyde = 1.3; % height factor, default is 1.
figure(3)

warning off MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame % Vindusmaksimering
jFrame = get(handle(gcf),'JavaFrame'); % Vindusmaksimering
drawnow; pause(0.1); % Vindusmaksimering
jFrame.setMaximized(true);  % Vindusmaksimering

Xdata = W.Time(1:end)-Drillstart;
Xdata = Xdata(2:end);
h(1) = subplot('Position',[0.13 0.767 .775 .1577*hoyde]);
hh(1) = plot(Xdata,W.WOB(2:end),'b','LineWidth',.5);
set(gca,'XtickLabels',({}))
ylabel('WOB')
h(2) = subplot('Position',[0.13 0.548 .775 .1577*hoyde]);
hh(2) = plot(Xdata,W.RPMB(2:end),'Color',[0 .65 .20],'LineWidth',.5);
set(gca,'XtickLabels',({}))
ylabel('RPM (bit)')
h(3) = subplot('Position',[0.13 0.329 .775 .1577*hoyde]);
ROP = diff(W.DMEA)./diff(24*W.Time);
hh(3) = plot(Xdata,ROP,'Color',[1 0 0],'LineWidth',.5);
hold on
ylim([-10,200])
set(gca,'XtickLabels',({}))
ylabel('ROP  [m/h]')
h(4) = subplot('Position',[0.13 0.11 .775 .1577*hoyde]);
hh(4) = plot(Xdata,W.DMEA(2:end),'Color',[.7 0 .3],'LineWidth',1.5);
set(gca,'Ydir','reverse')
ylabel('Depth  [m]')
linkaxes(h,'x')
xlabel('Time  [Days]')
zoom on
data = uint8((1:length(Xdata))*0);
data2 = uint8((1:length(Xdata))*0);

btn = uicontrol('Style', 'pushbutton', 'String', 'Pick values','Units','normalized','Position', [.4 .976 .07 .022], 'Callback', 'brush');

btn2 = uicontrol('Style', 'pushbutton', 'String', 'Save picked values','Units','normalized','Position', [.48 .976 .07 .022],  'Callback', 'data = (data | hh(3).BrushData); indices = find(data); subplot(h(3)); if exist(''hhh'') == 1; delete(hhh); end; hhh =  plot(Xdata(indices),(ROP(indices))'',''*'',''MarkerEdgeColor'',''m''); ');

btn3 = uicontrol('Style', 'pushbutton', 'String', 'Delete saved values','Units','normalized','Position', [.56 .976 .07 .022], 'Callback', 'data = (data & ~hh(3).BrushData); indices = find(data); subplot(h(3)); if exist(''hhh'') == 1; delete(hhh); end; hhh =  plot(Xdata(indices),(ROP(indices))'',''*'',''MarkerEdgeColor'',''m''); ');

btn4 = uicontrol('Style', 'pushbutton', 'String', 'Save to section','Units','normalized','Position', [.64 .976 .07 .022],  'Callback', 'data2 = ( hh(3).BrushData); indices2 = find(data2); subplot(h(3)); if exist(''hhhh'') == 1; delete(hhhh); end; hhhh =  plot(Xdata(indices2),(ROP(indices2))'',''k''); ');

btn5 = uicontrol('Style', 'pushbutton', 'String', 'Save to file','Units','normalized','Position', [.72 .976 .07 .022], 'Callback', 'uisave({''indices'',''indices2''},''drillingactivity'');');

btn6 = uicontrol('Style', 'pushbutton', 'String', 'Open file','Units','normalized','Position', [.8 .976 .07 .022], 'Callback', 'SS = uiimport(''-file''); subplot(h(3)); if exist(''hhhhh'') == 1; delete(hhhhh); end; hhhhh =  plot(Xdata(SS.indices),(ROP(SS.indices))'',''o'',''MarkerEdgeColor'',''k'');if exist(''hhhhhh'') == 1; delete(hhhhhh); end; hhhhhh =  plot(Xdata(SS.indices2),(ROP(SS.indices2)),''b''); ');
