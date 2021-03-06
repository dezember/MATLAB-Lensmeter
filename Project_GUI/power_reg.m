function out = power_reg(x,y)
%Anurag Kanase & Ahmad Zunnu Rain
%Team 10, Project
% Compute Linear Regression

%p = polyfit(x,y,2)
%yline=@(k) p(3)+(p(2).*k)+(p(1).*k.^2);
%f = polyval(p,x)
% % 
% x=log(x);
% y=log(y);
S_x=sum(x);
S_y=sum(y);
S_x2=sum(x.*x);
S_x3=sum(x.^3);
S_x4=sum(x.^4);
S_xy=sum(x.*y);
S_x2y=sum((x.^2).*y);
n=length(x);
meanx=mean(x);
meany=mean(y);
% % 

A = [n,S_x,S_x2;
    S_x,S_x2,S_x3;
    S_x2,S_x3,S_x4];

B = [S_y;S_xy;S_x2y];
X = linsolve(A,B);
yline=@(k) X(1)+(X(2).*k)+(X(3).*k.^2);
a2=X(3);
a1=X(2);
a0=X(1);

% a1= (n*S_xy- (S_x*S_y))/((n*S_x2)-S_x^2)
% a0=meany-(a1*meanx)
S_t=sum((y-meany).^2); % Standard Deviation
S_r=sum(((y-a0-(a1.*x)-(a2.*(x.^2))).^2)); 
rsq=(S_t-S_r)/S_t; % R^2
x_fit=0:0.25:7;
y_fit=yline(x_fit);
equation_str=sprintf('y=(%f) + (%fx) + (%fx^2)',X(1),X(2),X(3));


% S_yx=sqrt(S_r/(n-2));
% % 
% yline=(10^a0).*(x.^a1);
% % 
out={x_fit,y_fit,rsq,equation_str,a2,a1,a0,yline};
% return