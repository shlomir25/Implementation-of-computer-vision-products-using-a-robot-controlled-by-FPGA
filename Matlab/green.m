function [im_green, num]=green(crop) 
[m,n,t]=size(crop); 
im_green=zeros(m,n); 
num=0; 
for i=1:m 
    for j=1:n 
        if(crop(i,j,1)<=150&&crop(i,j,2)>=100&&crop(i,j,3)<=150&&abs(crop(i,j,1)-crop(i,j,3))<=50) %limits of R,G and B for a particular colour
            im_green(i,j)=1; 
            num=num+1; 
        end
    end
end