clear all;
close all;

i= input('enter number of state i=');
j= input('enter number of samples j=');

%creating state trasition matrix
for n1=1:i
 for m1=1:i
     fprintf('state transition matrix element position %d,%d \n',n1,m1);
    A(n1,m1)=input('');
 end
end

%creating state outcome proability matrix
for n1=1:i
 for m1=1:i
     fprintf('sample outcome probability matrix element position %d,%d \n',n1,m1);
    B(n1,m1)=input('');
 end
end

inz = 0.5;

%taking input sequence

l=input('enter the sequence in row vector');


b=zeros(i,length(l)); %output matrix

b(1,1)=inz*B(1,l(1)); %value of beta11
fprintf('value of beta11 : %d\n',b(1,1));

b(2,1)=inz*B(2,l(1)); %value of beta21
fprintf('value of beta21 : %d\n',b(2,1));
  
%using veterbi algorithm 
for t=2:length(l)
 for m1=1:i
     Z=zeros(1,2);
     for n1=1:i
         Z(1,n1)=b(n1,t-1)*A(n1,m1)*B(m1,l(t));
     end
     b(m1,t)=max(Z);
 end
end
disp('state transition matrix A');
disp(A);
disp('element probability matrix B');
disp(B)
disp('by veterbi algorithm')
disp(b)

%finding optimal sequence
for n1=1:length(b)
    m=max(b(1,n1),b(2,n1));
    optimalseq(n1)=find(m==b(:,n1));
end
disp(['optimal sequence: ',num2str(optimalseq)]);



