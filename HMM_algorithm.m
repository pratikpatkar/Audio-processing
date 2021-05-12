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


a=zeros(i,length(l));%output matrix

a(1,1)=inz*B(1,l(1));%value of alpha11
fprintf('value of alpha11-%d\n',a(1,1));

a(2,1)=inz*B(2,l(1));%value of alpha21
fprintf('value of alpha21-%d\n',a(2,1));
  
%using HMM forward algorithm 
for t=2:length(l)
 for m1=1:i
     Z=zeros(1,2);
     for n1=1:i
         Z(1,n1)=a(n1,t-1)*A(n1,m1)*B(m1,l(t));
     end
     a(m1,t)=sum(Z);
 end
end
disp('state transition matrix B');
disp(A);
disp('element probability matrix A');
disp(B)
disp('by forward algorithm')
disp(a)



