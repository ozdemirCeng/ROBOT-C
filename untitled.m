%% Security Patrol Robot - MATLAB Görselleştirme
% Bu script, güvenlik devriye robotunun URDF modelini MATLAB'da görselleştirir.
%
% Gereksinimler:
%   - MATLAB R2020b veya daha yeni
%   - Robotics System Toolbox
%
% Kullanım:
%   1. MATLAB'ı açın
%   2. Bu scripti çalıştırın
%   3. Robot modeli görselleştirilecektir

%% Temizlik
clear; clc; close all;

%% URDF Dosya Yolu
% Script dizinini al
scriptDir = fileparts(mfilename('fullpath'));

% URDF dosya yolu
urdfFile = fullfile(scriptDir, 'urdf', 'security_robot.urdf');

%% URDF'i Yükle
fprintf('=== Security Patrol Robot Viewer ===\n\n');

try
    % Ana URDF dosyasını dene
    fprintf('URDF yükleniyor: %s\n', urdfFile);
    robot = importrobot(urdfFile);
    fprintf('Robot başarıyla yüklendi!\n\n');
catch ME
    error('URDF dosyası yüklenemedi: %s', ME.message);
end

%% Robot Bilgileri
fprintf('Robot Bilgileri:\n');
fprintf('  - İsim: %s\n', robot.BaseName);
fprintf('  - Gövde sayısı: %d\n', robot.NumBodies);
try
    config = robot.homeConfiguration;
    fprintf('  - Eklem sayısı: %d\n', numel(config));
catch
    fprintf('  - Eklem sayısı: Hesaplanamadı\n');
end
fprintf('\n');

%% Link ve Joint Listesi
fprintf('Link Listesi:\n');
bodyNames = robot.BodyNames;
for i = 1:robot.NumBodies
    fprintf('  %2d. %s\n', i, bodyNames{i});
end
fprintf('\n');

%% Görselleştirme - Ana Görünüm
figure('Name', 'Security Patrol Robot', 'NumberTitle', 'off', ...
       'Position', [100 100 1200 800], 'Color', [0.2 0.2 0.2]);

% Robot görselleştirme
ax = show(robot);

% Görünüm ayarları
view(135, 30);
axis equal;
grid on;
title('Security Patrol Robot - 3D Model', 'Color', 'white', 'FontSize', 14);
xlabel('X (m)', 'Color', 'white');
ylabel('Y (m)', 'Color', 'white');
zlabel('Z (m)', 'Color', 'white');

% Arka plan rengi
set(gca, 'Color', [0.3 0.3 0.3]);
set(gca, 'XColor', 'white', 'YColor', 'white', 'ZColor', 'white');

% Işıklandırma
lighting gouraud;
camlight('headlight');

fprintf('Robot görselleştirildi!\n\n');

%% Çoklu Görünüm
figure('Name', 'Security Robot - Multiple Views', 'NumberTitle', 'off', ...
       'Position', [100 100 1400 700], 'Color', [0.15 0.15 0.15]);

% Ön Görünüm
subplot(2,3,1);
show(robot);
view(0, 0);
title('Ön Görünüm', 'Color', 'white');
axis equal; grid on;
set(gca, 'Color', [0.25 0.25 0.25], 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');

% Yan Görünüm
subplot(2,3,2);
show(robot);
view(90, 0);
title('Sağ Yan Görünüm', 'Color', 'white');
axis equal; grid on;
set(gca, 'Color', [0.25 0.25 0.25], 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');

% Üst Görünüm
subplot(2,3,3);
show(robot);
view(0, 90);
title('Üst Görünüm', 'Color', 'white');
axis equal; grid on;
set(gca, 'Color', [0.25 0.25 0.25], 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');

% İzometrik Görünüm 1
subplot(2,3,4);
show(robot);
view(45, 30);
title('İzometrik (45°)', 'Color', 'white');
axis equal; grid on;
set(gca, 'Color', [0.25 0.25 0.25], 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');

% İzometrik Görünüm 2
subplot(2,3,5);
show(robot);
view(135, 30);
title('İzometrik (135°)', 'Color', 'white');
axis equal; grid on;
set(gca, 'Color', [0.25 0.25 0.25], 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');

% Arka Görünüm
subplot(2,3,6);
show(robot);
view(180, 0);
title('Arka Görünüm', 'Color', 'white');
axis equal; grid on;
set(gca, 'Color', [0.25 0.25 0.25], 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w');

sgtitle('Security Patrol Robot - Çoklu Görünümler', 'Color', 'white', 'FontSize', 14);

%% Mast Hareketi Animasyonu (Opsiyonel)
fprintf('Mast animasyonu için "animateMast" fonksiyonunu çalıştırın.\n');

%% Yardımcı Fonksiyonlar
function animateMast(robot)
    % Mast animasyonu
    figure('Name', 'Mast Animation', 'Position', [200 200 800 600]);
    
    % Eklem konfigürasyonu
    config = homeConfiguration(robot);
    
    % Animasyon parametreleri
    numFrames = 50;
    
    for i = 1:numFrames
        % Mast eklemlerini hareket ettir
        angle = sin(2*pi*i/numFrames) * 0.5;
        
        % Eklem indekslerini bul ve güncelle
        for j = 1:numel(config)
            if contains(config(j).JointName, 'mast') || ...
               contains(config(j).JointName, 'shoulder') || ...
               contains(config(j).JointName, 'wrist')
                config(j).JointPosition = angle;
            end
        end
        
        % Görselleştir
        show(robot, config, 'PreservePlot', false);
        view(135, 30);
        axis equal;
        drawnow;
        pause(0.05);
    end
end

fprintf('\n=== Görselleştirme Tamamlandı ===\n');
