clc;
clear all;

%reading audio file
[x,fs]=audioread('aeiou_prat.wav');

subplot(3,1,1);
plot(x)
title 'input audio signal';
xlabel('sample no.');ylabel('amplitude');

%doing FFT
b=fft(x);
b1=(abs(b));
for i=1:256
    b1(i)=b1(i)*b1(i);
end
 
c=log10(b1);
%calculate frequency in Hz for every FFT bin
for i=1:128
    f(i)=22100/256*i;
end
for i=1:128
    c1(i)=c(i);
end

 %mel frequency calculation
 for i=1:128
     m(i)=2595*log(1+f(i)/700);
       
 end

subplot(3,1,2);
stem(m,c1);
title 'plot of log spectrum in Mel scale';
xlabel('frequency in Mel scale');ylabel('amplitude in dB');

%triangular mel frequency scale
for j=1:28
    sum(j)=0;
    for i=1:58
       
        if ((m(i)>300+(j-1)*150)&&(m(i)<600+(j-1)*150))
            if (m(i)<450+(j-1)*150)
                g(i)=((m(i)-(300+150*(j-1)))*1/150);
                 else
                g(i)=((600+150*(j-1)-m(i))*1/150);
            end
             
         sum(j)=sum(j)+c1(i)*g(i);
        
        end     
   end
end 
%doing the ifft
d=ifft(sum);
d=abs(d);

%extracting 14 mfcc coefficient 
for i=1:14
    x1(i)=d(i);
end
subplot(3,1,3)
stem(x1);
title 'plot of MFCC for aeiou';

xlabel('frequency in Mel scale');ylabel('amplitude in dB');
