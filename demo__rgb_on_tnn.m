clear all
clc;
 

load Carphone_0.1Noise.mat %我这里的多光谱数据不需要归一化。
%%
maxP = max(abs(X(:)));
[n1,n2,n3]=size(X);
A=[];
Xnn =  dct(Xn, [], 3);
for i=1:n3
    [U(:,:,i),S,V(:,:,i)]=svd(Xnn(:,:,i),'econ');
    s=diag(S);
    A=[A,s];
end
P=A;
%% TNN型参数设置

lambdas=1/(sqrt(max(n1,n2)));
betas=[0.01:0.01:0.1 ];  %谱误差参数
gammas=  [ 0.005 0.01 0.05 0.1 0.5];  %P调节调节参数
steps  =1 ; %步长


p=0.0;
temp=0;
besetXhat=Xn;
for jj=1:length(lambdas)
    lambda=  lambdas(jj);
    for ii=1:length(betas)
        beta=  betas(ii);
        for j=1:length(gammas)
            gamma=gammas(j);
            for i=1:length(steps)
                step=  steps(i);
                [Xhat, ErrArr,psnrrs] = TRY(Xn,P,lambda,beta,gamma,step,U,V,'tnn');
                Xhat = max(Xhat,0);
                Xhat = min(Xhat,1);
           %    [PSNR, SSIM , FSIM ] = Img_QA(X,Xhat,1);
                              [psnrs,ssims] = MSIQA(Xhat*255, X*255);
                             PSNR=mean(psnrs);
                             SSIM=mean(ssims);
                if(PSNR>temp)
                    temp=PSNR;
                    besetXhat=Xhat;
                end
                fprintf("\tTNN \tlambda=%dth, beta=%.3f, gamma=%.4f, \t PSNR=%.3f,\t SSIM=%.3f, psnrMax=%.3f\n",jj,beta,gamma,PSNR,SSIM,temp);
            end
        end
    end
    fprintf("\n");
end