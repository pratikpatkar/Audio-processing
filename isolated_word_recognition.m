clear all;
close all;

%traning the model
%reading all the sample file

[a1,Fs]=audioread('a1.wav');
[a2,Fs]=audioread('a2.wav');
[a3,Fs]=audioread('a3.wav');
[b1,Fs]=audioread('b1.wav');
[b2,Fs]=audioread('b2.wav');
[b3,Fs]=audioread('b3.wav');
[c1,Fs]=audioread('c1.wav');
[c2,Fs]=audioread('c2.wav');
[c3,Fs]=audioread('c3.wav');

%pre-emphasis and windowing
ha1 = pre_emphasis(a1);%for sample a1
ha2 = pre_emphasis(a2);%for sample a2
ha3 = pre_emphasis(a3);%for sample a3
hb1 = pre_emphasis(b1);%for sample b1
hb2 = pre_emphasis(b2);%for sample b2
hb3 = pre_emphasis(b3);%for sample b3
hc1 = pre_emphasis(c1);%for sample c1
hc2 = pre_emphasis(c2);%for sample c2
hc3 = pre_emphasis(c3);%for sample c3

%taking mfcc coefficient
coeffsa1 =mfcc(a1,Fs);%for sample a1
coeffsa2 =mfcc(a2,Fs);%for sample a2
coeffsa3 =mfcc(a3,Fs);%for sample a3
coeffsb1 =mfcc(b1,Fs);%for sample b1
coeffsb2 =mfcc(b2,Fs);%for sample b2
coeffsb3 =mfcc(b3,Fs);%for sample b3
coeffsc1 =mfcc(c1,Fs);%for sample c1
coeffsc2 =mfcc(c2,Fs);%for sample c2
coeffsc3 =mfcc(c3,Fs);%for sample c3

%generating codebook for a utterence
Xa=[coeffsa1(1,:);coeffsa2(1,:);coeffsa3(1,:)];
[idx,Ka]=kmeans(Xa,3); 
figure
stem(Ka);
title('codebook of a');

%generating codebook for b utterence
Xb=[coeffsb1(1,:);coeffsb2(1,:);coeffsb3(1,:)];
[idx,Kb]=kmeans(Xb,3); 
figure
stem(Kb);
title('codebook of b');

%generating codebook for c utterence
Xc=[coeffsc1(1,:);coeffsc2(1,:);coeffsc3(1,:)];
[idx,Kc]=kmeans(Xc,3); 
figure
stem(Kc);
title('codebook of c');

%testing the model
[t,Fs]=audioread('a1.wav');

l=length(t);
frame_l=(20/1000)*Fs;
no_of_frame=l/frame_l;

%removing the silence part in the test signal
count=0;
for (i=1:no_of_frame)
 frame = t((i-1)*frame_l+1:frame_l*i);
max_val=max(frame);
if(max_val>0.03)
 count=count+1; 
test((count-1)*frame_l+1:frame_l*count)=frame;
end
end

%pre-emphasis and windowing the test signal
ht = pre_emphasis(test);

%taking mfcc coefficient
coeffst =mfcc(t,Fs);

%forming the codebook for test
Xt=[coeffst(1,:)];

[idx,Kt]=kmeans(Xt,1);%kmeans algorithm 
figure
stem(Kt);
title('codebook of test');

%mathing the test-signal with sample using euclidian distance formula
for i=1:3
 for j=1:14
 e(i,j)= ((Ka(i,j) - Kt(1,j)).^2);
 end
end
e1=sqrt(e);
e2=sum(e1,'all'); 


for i=1:3
 for j=1:14
 f(i,j)= ((Kb(i,j) - Kt(1,j)).^2);
 end
end
f1=sqrt(f);
f2=sum(f1,'all'); 


for i=1:3
 for j=1:14
 g(i,j)= ((Kc(i,j) - Kt(1,j)).^2);
 end
end
g1=sqrt(g);
g2=sum(g1,'all'); 

%finding the utterence
X = [e2;f2;g2]
op = min(X)
if op ==e2
    disp('utterence is a');
elseif op == f2
    disp('utterence is b');
else op == g2
    disp('utterence is c');
end

%pre_emphasis function
function pre = pre_emphasis(data)
l=length(data);
Fs = 8000;
no_of_frames=l/(0.02*Fs);
disp(round(no_of_frames));
%subplot(3,1,1)
%plot(x)
%title 'input audio signal'
%axis tight

% pre-emphasis
for i=2:l
 y(i)=data(i)-0.95*data(i-1);
end


% windowing
y1=buffer(y,round(no_of_frames));
y2=buffer(y,round(no_of_frames),round(no_of_frames/2));
w=hamming(round(no_of_frames)); 

for i=1:round(no_of_frames)
 h(:,i)=y2(:,i).*w;%overlapping window
end
pre = h;
end