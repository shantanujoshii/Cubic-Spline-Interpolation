%author: Shantanu Joshi

clc;
clear all;

% syms x
% f = s+in(x);


format long

x = [0,0.3307,0.6614,0.9921,1.3228,1.6535,1.9842,2.3149,2.6456,2.9762,3.3069,3.6376,3.9683,4.2990,4.6297,4.9604,5.2911,5.6218,5.9525,6.2832];
y = [0,0.3247,0.6142,0.8372,0.9694,0.9966,0.9158,0.7357,0.4759,0.1646,-0.1646,-0.4759,-0.7357,-0.9158,-0.9966,-0.9694,-0.8372,-0.6142,-0.3247,-0.0000];


n=length(x); %number of points of points
h=(x(n)-x(1))/(n-1);


for i= 2:n-1
     b(i-1) = 2*(x(i+1)-x(i-1));
end

for i= 2:n-2
    c(i-1)= (x(i+1)-x(i));
end

for i=3:n-1
    a(i-1) = (x(i)-x(i-1));
end

%for matrix
A=zeros(n-2,n-2);

for i=1:n-2
    A(i,i) = b(i);
end

for i=1:n-3
    A(i,i+1) = c(i);
end

for i=2:n-2
    A(i,i-1) = a(i);
end

%Right hand side 


 for i=2:n-2
       d(i)=6/(x(i+1)-x(i))*(y(i)-y(i+1))+6/(x(i+2)-x(i+1))*(y(i+2)-y(i+1));
 end

 D=d';
 f2 = A\D;  %double derivatives at end points
 
 for i=2:n-1
     ff(i)=f2(i-1); % as f''(x0)=f''(xn)=0
 end
%  f2=-y;

j=input("enter the number whose function value and derivatives you want from the splines");
for i=1:n-3
    if (j >= x(i)) && (j <= x(i+1))
        fprintf("%f is between  %f %f\n",j,x(i),x(i+1))
        fprintf("****************CALCULATIONS**********************\n\n\n\n")

        
        fx=f2(i)*(j-x(i+1))^3/(6*(x(i)-x(i+1))) +f2(i+1)*(j-x(i))^3/(6*(x(i+1)-x(i))) +( y(i)/(x(i)-x(i+1)) - ((x(i)-x(i+1))/6*f2(i) )*(j-x(i+1)))*(j-x(i+1))+ (y(i+1)/(x(i)-x(i+1)) - (x(i)-x(i+1))/6*f2(i+1))*(x(i)-j); 
        fprintf("f(x) value calculated from spline  %f\n\n",fx)
        fprintf("sin(x) value %f\n\n",sin(j))
        
        fx_d= ((f2(i)/(x(i)-x(i+1)))*((j-x(i+1)))^2)/2 + (f2(i+1)/(x(i+1)-x(i))*((j-x(i)))^2)/2 + (y(i)-y(i+1))/(x(i)-x(i+1)) -(f2(i)-f2(i+1))*(x(i)-x(i+1))/6;
        fprintf("f'(x) value calculated from spline  %f\n\n",fx_d)
        fprintf("sin'(x) value %f\n\n",cos(j))
       
        fx_dd=((j-x(i+1))/(x(i)-x(i+1)))*ff(i) +((j-x(i))/(x(i+1)-x(i)))*ff(i+1);
        fprintf("f''(x) value calculated from spline  %f\n\n",fx_dd)
        fprintf("sin''(x) value %f\n\n",-sin(j))
        
        break;
    
        
    end
    
end


 %-------------------
function y = f(x)
y = sin(x);
end
%-------------------
