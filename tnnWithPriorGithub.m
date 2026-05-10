function [L, R, U, V] = tnnWithPriorGithub(PW, E, mu, G, n3, U, V, X, S, Y, step, way)
    % 核心逻辑完全复用你提供的代码，仅修正变量名笔误（temmpTensordiagSpace）
    tempQ=0.5*(PW-E)-0.5/mu*G;
    for i=1:n3
        TensordiagFrequency(:,:,i)=diag(tempQ(:,i));
    end
    for i=1:n3
        tempTensordiagSpace(:,:,i) =U(:,:,i)*TensordiagFrequency(:,:,i)*V(:,:,i)';
    end
    TensordiagSpace=real(idct(tempTensordiagSpace,[],3));
    
    % update L
    [L,R,U,V]=MyTNN(TensordiagSpace+0.5*(X-S)-0.5/mu*Y,0.5/mu,step,way);
end

function [A_tensor,R,U,V]=MyTNN(Y_tensor,alf,step,way)
[n1, n2, n3] = size(Y_tensor);
% 对输入张量 G_tensor 进行第3维傅里叶变换
Y_hat =  dct(Y_tensor, [], 3);
%%求高频切片
for i = 1:n3
    % 对每个傅里叶模式进行SVD
    [U(:,:,i),S, V(:,:,i)] = svd(squeeze(Y_hat(:, :, i)), 'econ');
    %%
    % 对奇异值进行软阈值处理
    S_y = diag(S); %为一个列向量。
    
    %% TNN或者非凸
    if(way=='tnn')
        tidu=1;%TNN
    elseif (way=='log')
       % epsilon=5; %RGB图片
        epsilon=5 ;
        tidu= 1./(epsilon+S_y);
    end
    %%
    S_y = soft_thresholding(S_y,tidu, step*alf);
    R(:,i) =S_y;
    S_temp=diag(S_y);
    Y_hat(:, :, i) = U(:,:,i) * S_temp * V(:,:,i)';
end
% 逆傅里叶变换回原空间
A_tensor =  real(idct(Y_hat, [], 3));
end

function S_thresh = soft_thresholding(Sy,tidu,tau)
%S_thresh = sign(Sy) .* max(abs(Sy) -tidu*tau, 0);
S_thresh = max(Sy -tidu*tau, 0);
end

