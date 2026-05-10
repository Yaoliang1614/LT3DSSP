clear;
clc;
load carphone_0.1noise.mat
X=X;
maxP =1;
[n1,n2,n3] = size(X);
Xn = X;
rhos = 0.3;
ind = find(rand(n1*n2*n3,1)<rhos);
Xn(ind) = rand(length(ind),1);

 
for i=1:31
    figure(i)
    imshow(Xn(:,:,i));
end