clc;
clear all;
close all;

%reading audio file
[x,fs]=audioread('aeiou_prat.wav');
figure
subplot(3,1,1)
plot(x)
title('aeiou prat audio file');

l=length(x);
display(l);

e=0; 
for i=1:l
    e=e+x(i)*x(i);
end
normalize=e/l;
display(normalize)

%for 20ms frame length= (20/1000)*Fs
frame_l=(20/1000)*fs;
display(frame_l)
no_of_frame=l/frame_l;
display(round(no_of_frame))
    
%energy calculation part
for i=2:round(no_of_frame)-1
   e=0;
     for j=frame_l*(i-1):frame_l*(i)
            e=e+x(j)*x(j);
     end
   frame_energy(i)=e;
end 
   
subplot(3,1,2)
plot(frame_energy)
title('energy of a signal');
 
%silence removal part
count=0;
for (i=1:no_of_frame)
 frame = x((i-1)*frame_l+1:frame_l*i);
max_val=max(frame);
if(max_val>0.03)
 count=count+1;
new_sig((count-1)*frame_l+1:frame_l*count)=frame;
end
end

subplot(3,1,3)
plot(new_sig)
title('audio after removing scilence');