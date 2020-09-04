function out = linear_reg(x,y)
%Anurag Kanase & Ahmad Zunnu Rain
%Team 10, Project
% Compute Linear Regression


S_x=sum(x);
S_y=sum(y);
S_x2=sum(x.*x);
S_xy=sum(x.*y);
n=length(x);
meanx=mean(x);
meany=mean(y);

a1= (n*S_xy- (S_x*S_y))/((n*S_x2)-S_x^2)
a0=meany-(a1*meanx)
S_t=sum((y-meany).^2); % Standard Deviation
S_r=sum((y-a0-(a1.*x)).^2); 
rsq=(S_t-S_r)/S_t; % R^2
S_yx=sqrt(S_r/(n-2));

yline=@(k) (a1.*k)+a0;
x_fit=0:0.25:7;
y_fit=yline(x_fit);
equation_str=sprintf('y=(%fx) + (%f)',a1,a0);


out={x_fit,y_fit,rsq,equation_str,a1,a0,yline};
return

end

%Anurag Kanase
