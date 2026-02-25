clear;
clc;
load flowers_ms.mat
X=msi;
maxP =1;
[n1,n2,n3] = size(X);
Xn = X;
rhos = 0.3;
ind = find(rand(n1*n2*n3,1)<rhos);
Xn(ind) = rand(length(ind),1);

save('C:\Users\25084\Desktop\MatlabCode\?????.mat','X','Xn');
for i=1:31
    figure(i)
    imshow(Xn(:,:,i));
end