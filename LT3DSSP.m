function [L,ErrArr ] = LT3DSSP(X,P,lambda,beta,gamma,step,U,V,way)
% way：'tnn'
% X：Observed tensor    （n1,n2,n3）维度
% P: Spectral prior    （min(n1,n2),n3）维度；
% S: sparse tensor     （n1,n2,n3）维度
% L: Low-rank tensor   （n1,n2,n3）维度
% Y: multipler tensor  （n1,n2,n3）维度
% E: sparse matrix     （min(n1,n2),n3）维度；
% W: adjust matrix     （n3,n3）维度；
% G: multipler matrix  （min(n1,n2),n3）维度；


%% 初始化
tol = 1e-5;
iter = 0;
max_iter =500 ;
rho =1.1  ;
mu = 1e-4;
max_mu =1e10;
[n1,n2,n3] = size(X);
L = zeros(n1,n2,n3);
S = L;
Y = L;

%% 频域变量的相关设置设置
mode=0;
if (n1>n2)
    mode=1;
end
r=min(n1,n2);
W  = eye(n3);
E=zeros(r,n3);
G=E;
PW=max(0,P*W);
for iter = 1 : max_iter
    
    Lk = L;
    Sk = S;
    % fprintf("iter=%d ",iter);
    %% Update L  
    [L, R, U, V] = tnnWithPriorGithub(PW, E, mu, G, n3, U, V, X, S, Y, step, way);
    %% update S
    S = prox_l1(X-L-Y/mu,lambda/mu);
    %% update e
    % E = prox_l1(P*W-R-G/mu,beta/mu ); %稀疏范数
    E=mu*(PW-R-G/mu)/(2*beta+mu); %F范数
    %% update W
    temp1=P'*P;
    W =inv(mu *temp1+2*gamma*eye(n3)) *(mu*P'*(R+E+G/mu ) );
    W =max(W ,0);
    PW=P*W; 
    dY = L+S-X;
    chgL = max(abs(Lk(:)-L(:)));
    chgS = max(abs(Sk(:)-S(:)));
    chg = max([ chgL chgS max(abs(dY(:))) ]) ;   
    Y = Y + mu*dY;
    G=G+mu *(R-PW+E);
    mu = min(rho*mu,max_mu);   
    err= norm(Lk(:)-L(:),'fro')/(eps+norm(L(:),'fro'));
    ErrArr(iter)=err;
    if(err<tol&&iter>=50)
        break;
    end
 
    %         [mpsnr] = MSIQA(Xhat*255, Xr*255);
    %          psnrs(iter)=mean(mpsnr);
    %          psnrr=psnrs(iter);
    
end
%psnrr=max(psnrs);
fprintf("outIter=%d \n",iter );
iter

end

