figure('Position', [100, 150, 1000, 500]);  % 调整画布大小，更紧凑

% -------------------------- 子图1：House --------------------------
subplot('Position', [0.06, 0.1, 0.29, 0.8]);  % 手动设置位置：[左, 下, 宽, 高]
y_House = [29.959,28.370,26.890;  %Reomve IDSS
       32.965,29.513,26.956;   %Reomve W
      36.062,32.854,28.309;  %LT3DSSP
    ];   
bar(y_House');
title('House');
ylabel('PSNR');
set(gca, 'XTickLabel', {'0.1Noise', '0.2Noise', '0.3Noise'});
grid on;
ylim([20, 40]);  % 统一Y轴范围，视觉更协调


% -------------------------- 子图2：News --------------------------
subplot('Position', [0.38, 0.1, 0.29, 0.8]);
 y_News = [29.534,28.309,26.901;  %Reomve IDSS
      33.420,29.778,27.039;   %Reomve W
      36.054,31.972,27.879;  %LT3DSSP
    ];     
bar(y_News');
title('News');
set(gca, 'XTickLabel', {'0.1Noise', '0.2Noise', '0.3Noise'});
grid on;
ylim([20, 40]);


% -------------------------- 子图3：Carphone --------------------------
subplot('Position', [0.7, 0.1, 0.29, 0.8]);
y_Carphone =  [  30.117,28.669,27.053;  %Reomve IDSS
      32.739,29.560,26.965;   %Reomve W
      37.674,32.798,28.304;  %LT3DSSP
    ];   
bar(y_Carphone');
title('Carphone');
set(gca, 'XTickLabel', {'0.1Noise', '0.2Noise', '0.3Noise'});
grid on;
ylim([20, 40]);


% 图例放在底部（外部，水平排列）
% 图例部分修改为：
legend('LT3DSSP_{IDSS}', 'LT3DSSP_{W}', 'LT3DSSP', ...
       'Location', 'southoutside', ...
       'Orientation', 'horizontal', ...
       'FontSize', 6, ...        % 减小字体大小（原9→7）
       'Position', [0.25, 0.1, 0.25, 0.005]);

% 总标题
sgtitle('Ablation study on RGB images', 'FontSize', 12);


%%
 
figure('Position', [100, 150, 1000, 500]);  % 调整画布大小，更紧凑

% -------------------------- 子图1：RemoteImg--------------------------
subplot('Position', [0.06, 0.1, 0.29, 0.8]);  % 手动设置位置：[左, 下, 宽, 高]
y_RemoteImg = [
      44.707,41.996,38.506;  %Reomve IDSS
      44.862,41.701,37.116;   %Reomve W
      46.314,44.315,40.193;  %LT3DSSP
    ];   
bar(y_RemoteImg');
title('RemoteImg');
ylabel('PSNR');
set(gca, 'XTickLabel', {'0.1Noise', '0.2Noise', '0.3Noise'});
grid on;
ylim([30, 50]);  % 统一Y轴范围，视觉更协调


% -------------------------- 子图2：WDC --------------------------
subplot('Position', [0.38, 0.1, 0.29, 0.8]);
 y_WDC = [45.052,42.285,37.370;  %Reomve IDSS
      46.119,42.182,35.095;   %Reomve W
      48.759,45.422,40.193;  %LT3DSSP
    ];     
bar(y_WDC');
title('WDC');
set(gca, 'XTickLabel', {'0.1Noise', '0.2Noise', '0.3Noise'});
grid on;
ylim([35, 50]);


% -------------------------- 子图3：Pavia --------------------------
subplot('Position', [0.7, 0.1, 0.29, 0.8]);
y_Pavia =  [   
     49.707,47.263,44.094;  %Reomve IDSS
     52.110,47.877,43.426;   %Reomve W
     58.465,53.578,47.954;  %LT3DSSP
    ];   
bar(y_Pavia');
title('Pavia');
set(gca, 'XTickLabel', {'0.1Noise', '0.2Noise', '0.3Noise'});
grid on;
ylim([40, 60]);


% 图例放在底部（外部，水平排列）
% 图例部分修改为：
legend('LT3DSSP_{IDSS}', 'LT3DSSP_{W}', 'LT3DSSP', ...
       'Location', 'southoutside', ...
       'Orientation', 'horizontal', ...
       'FontSize', 6, ...        % 减小字体大小（原9→7）
       'Position', [0.25, 0.1, 0.25, 0.005]);

% 总标题
sgtitle('Ablation study on Hyperspectral images', 'FontSize', 12);