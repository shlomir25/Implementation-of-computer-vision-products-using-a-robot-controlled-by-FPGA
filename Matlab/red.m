function [im_red, num]=red(crop) 
[m,n,t]=size(crop); 
im_red=zeros(m,n); 
num=0; 
for i=1:m 
    for j=1:n 
        if(crop(i,j,1)>=100&&crop(i,j,2)<=150&&crop(i,j,3)<=150&&abs(crop(i,j,3)-crop(i,j,2))<=50) %limits of R,G and B for a particular colour
            im_red(i,j)=1; 
            num=num+1; 
        end
    end
end