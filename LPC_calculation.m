clc;
clear all;
close all;

%reading audio file
[x,Fs]=audioread('aeiou_prat.wav');
l=length(x);


no_of_frames=l/(0.02*Fs);
disp(round(no_of_frames));
subplot(3,1,1)
plot(x)
title 'input audio signal'
axis tight

% pre-emphasis
for i=2:l
 y(i)=x(i)-0.95*x(i-1);
end


% windowing
y1=buffer(y,round(no_of_frames));
y2=buffer(y,round(no_of_frames),round(no_of_frames/2));
w=hamming(round(no_of_frames)); 

for i=1:round(no_of_frames)
 h(:,i)=y2(:,i).*w;%overlapping window
end
subplot(3,1,2)
stem(h);
axis tight
title 'overlap samples'

% LPC coefficient determination
[a1,b1]=lpc(h,5);%using 5 linear predictor
disp(size(a1));
subplot(3,1,3)
plot(a1)
axis tight
title 'LPC coefficients'

