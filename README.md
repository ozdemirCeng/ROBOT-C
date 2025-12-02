# 🤖 GuardianBot - Otonom Güvenlik ve Devriye Robotu

<div align="center">

![Robot](https://img.shields.io/badge/Robot-GuardianBot-blue?style=for-the-badge&logo=robot)
![ROS2](https://img.shields.io/badge/ROS2-Jazzy-green?style=for-the-badge&logo=ros)
![URDF](https://img.shields.io/badge/Format-URDF-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

**Kapalı bina ve kampüs ortamlarında otonom devriye görevi yapan,  
çoklu sensör mimarisi ile çevre izleme ve güvenlik değerlendirmesi gerçekleştiren  
gelişmiş bir mobil robot platformu.**

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

</div>

## 📋 İçindekiler

- [Proje Hakkında](#-proje-hakkında)
- [Özellikler](#-özellikler)
- [Teknik Spesifikasyonlar](#-teknik-spesifikasyonlar)
- [Proje Yapısı](#-proje-yapısı)
- [Kurulum ve Çalıştırma](#-kurulum-ve-çalıştırma)
- [URDF Yapısı](#-urdf-yapısı)
- [Sensör Mimarisi](#-sensör-mimarisi)
- [Ekran Görüntüleri](#-ekran-görüntüleri)
- [Lisans](#-lisans)

---

## 🎯 Proje Hakkında

**GuardianBot**, iç mekan güvenlik devriyesi için tasarlanmış otonom bir mobil robot platformudur. Clearpath Husky UGV tabanlı diferansiyel tahrik sistemi ve 3 seviyeli dikey sensör mastı ile donatılmıştır.

### Kullanım Senaryoları
- 🏢 Ofis binası güvenlik devriyesi
- 🏥 Hastane koridor izleme
- 🎓 Üniversite kampüs güvenliği
- 🏭 Endüstriyel tesis denetimi
- 🛒 Alışveriş merkezi gece devriyesi

---

## ✨ Özellikler

### 🔧 Mekanik Platform
| Özellik | Açıklama |
|---------|----------|
| **Tahrik Sistemi** | Diferansiyel sürüş (2 motorlu arka + 2 caster ön) |
| **Platform Boyutu** | 990mm x 670mm x 250mm |
| **Toplam Yükseklik** | ~1100mm (mast dahil) |
| **Ağırlık** | ~50 kg |
| **Maksimum Hız** | 1.5 m/s |

### 📡 Sensör Mimarisi
- **5x Kamera** - RGB, Termal, Derinlik, Fisheye
- **1x 360° LiDAR** - SLAM ve haritalama
- **6x IR Sensör** - Yakın mesafe engel tespiti
- **3x Ultrasonik** - Orta mesafe algılama
- **Çevresel Sensörler** - Sıcaklık, Nem, CO₂, Duman

### 🏗️ Mast Yapısı
```
┌─────────────────┐
│   SENSOR HEAD   │ ← 360° dönen kamera kafası
│   (600+ mm)     │
├─────────────────┤
│   MAST TOP      │ ← Beacon, Anten
│   (440-600mm)   │
├─────────────────┤
│   MAST MID      │ ← Termal, Derinlik Kamera
│   (240-440mm)   │
├─────────────────┤
│   MAST BASE     │ ← 360° LiDAR
│   (0-240mm)     │
└─────────────────┘
```

---

## 📊 Teknik Spesifikasyonlar

### URDF Model İstatistikleri

| Parametre | Değer |
|-----------|-------|
| 📁 Toplam Link | **43** |
| 🔗 Toplam Joint | **42** |
| 📌 Fixed Joint | 35 |
| 🔄 Continuous Joint | 6 |
| ↔️ Revolute Joint | 1 |
| 📦 Mesh Dosyası | **10** (.dae/.stl) |
| 🎨 Malzeme Tanımı | **13** |

### Joint Tipleri
- **Fixed** - Sabit bağlantılar (sensörler, gövde parçaları)
- **Continuous** - Sınırsız dönüş (tekerlekler, caster pivot)
- **Revolute** - Sınırlı dönüş (sensor head ±180°)

---

## 📁 Proje Yapısı

```
security_robot/
│
├── 📂 urdf/
│   └── security_robot.urdf      # Ana URDF robot modeli
│
├── 📂 meshes/
│   ├── base/                    # Gövde mesh dosyaları
│   │   ├── husky_base.dae
│   │   ├── husky_bumper.dae
│   │   ├── husky_top_plate.dae
│   │   ├── husky_user_rail.dae
│   │   └── fenders.stl
│   │
│   ├── wheels/                  # Tekerlek mesh dosyaları
│   │   └── husky_wheel.dae
│   │
│   └── sensors/                 # Sensör mesh dosyaları
│       ├── ir_sensor.dae
│       └── imu_sensor.stl
│
├── 📂 docs/
│   └── GuardianBot_Tasarim_Raporu.docx  # Detaylı proje raporu
│
└── 📄 README.md                 # Bu dosya
```

---

## 🚀 Kurulum ve Çalıştırma

### Gereksinimler
- Ubuntu 22.04+ veya WSL2
- ROS 2 Jazzy
- RViz2
- Gazebo (opsiyonel)

### RViz2 ile Görselleştirme

```bash
# 1. ROS 2 ortamını aktifleştir
source /opt/ros/jazzy/setup.bash

# 2. Proje dizinine git
cd ~/security_robot

# 3. URDF'i RViz2'de görüntüle
ros2 launch urdf_tutorial display.launch.py model:=urdf/security_robot.urdf
```

### Alternatif Yöntem (Manuel)

```bash
# Terminal 1 - Robot State Publisher
ros2 run robot_state_publisher robot_state_publisher --ros-args -p robot_description:="$(cat urdf/security_robot.urdf)"

# Terminal 2 - Joint State Publisher GUI
ros2 run joint_state_publisher_gui joint_state_publisher_gui

# Terminal 3 - RViz2
ros2 run rviz2 rviz2
```

---

## 🌳 URDF Yapısı

### Link-Joint Hiyerarşisi

```
base_link
└── chassis_link (fixed)
    ├── fenders_link (fixed)
    ├── front_bumper_link (fixed)
    │   └── ir_sensor_* (fixed) [x3]
    ├── rear_bumper_link (fixed)
    ├── rear_left_wheel_link (continuous)
    ├── rear_right_wheel_link (continuous)
    ├── front_left_caster_link (continuous)
    │   └── front_left_wheel_link (continuous)
    ├── front_right_caster_link (continuous)
    │   └── front_right_wheel_link (continuous)
    ├── imu_link (fixed)
    └── top_plate_link (fixed)
        ├── user_rail_link (fixed)
        ├── control_panel_link (fixed)
        │   ├── lcd_screen_link (fixed)
        │   ├── estop_button_link (fixed)
        │   └── usb_ports_link (fixed)
        ├── siren_link (fixed)
        ├── gps_link (fixed)
        ├── front_camera_link (fixed)
        └── mast_base_link (fixed)
            ├── lidar_360_link (fixed)
            ├── ultrasonic_* (fixed) [x3]
            └── mast_mid_link (fixed)
                ├── depth_camera_link (fixed)
                ├── thermal_camera_link (fixed)
                ├── environmental_sensor_link (fixed)
                ├── microphone_link (fixed)
                └── mast_top_link (fixed)
                    └── sensor_head_link (revolute)
                        ├── camera_left_link (fixed)
                        ├── camera_right_link (fixed)
                        ├── beacon_light_link (fixed)
                        └── antenna_link (fixed)
```

---

## 📡 Sensör Mimarisi

### Yükseklik Katmanları

| Katman | Yükseklik | Sensörler | Görev |
|--------|-----------|-----------|-------|
| **Zemin** | 0-30 cm | IR, Ultrasonik, Proximity | Engel tespiti |
| **İnsan** | 30-70 cm | Derinlik, Termal, Çevresel | 3D haritalama, insan tespiti |
| **Tavan** | 70+ cm | RGB Kameralar, Beacon | Genel izleme, uyarı |

### Sensör Listesi

| Sensör | Adet | Konum | Menzil |
|--------|------|-------|--------|
| 360° LiDAR | 1 | Mast Base | 12m |
| RGB Kamera | 2 | Sensor Head | - |
| Termal Kamera | 1 | Mast Mid | - |
| Derinlik Kamerası | 1 | Mast Mid | 0.1-10m |
| Fisheye Kamera | 1 | Top Plate | 180° |
| IR Sensör | 3 | Ön Bumper | 0-80cm |
| Ultrasonik | 3 | Mast Base | 20-400cm |
| Proximity | 2 | Ön Bumper | 0-30cm |

---

## 🎨 Malzeme ve Renkler

Robot modelinde 13 farklı malzeme tanımlanmıştır:

| Malzeme | Renk | Kullanım |
|---------|------|----------|
| `police_white` | Beyaz | Ana gövde |
| `tactical_black` | Siyah | Tekerlekler, paneller |
| `warning_orange` | Turuncu | Uyarı elemanları |
| `police_blue` | Mavi | Beacon ışığı |
| `emergency_red` | Kırmızı | E-Stop butonu |
| `sensor_green` | Yeşil | Sensör göstergeleri |
| `mast_silver` | Gümüş | Mast yapısı |

---

## 📸 Ekran Görüntüleri

> RViz2'de robot görselleştirmesi için `ros2 launch` komutunu çalıştırın.

**Görünüm Açıları:**
- İzometrik (45°, 135°)
- Ön / Arka / Yan
- Üst (kuş bakışı)

---

## 📄 Dokümantasyon

Detaylı proje raporu için:
📁 `docs/GuardianBot_Tasarim_Raporu.docx`

Rapor içeriği:
1. Devriye ve Güvenlik Senaryosu
2. Mekanik Platform ve Gövde Geometrisi
3. Sensör ve Aktüatör Mimarisi
4. Mast Yapısı ve Yükseklik Katmanları
5. URDF DOM Yapısı
6. Görsel ve Çarpışma Modellerinin Ayrımı
7. Araştırma ve Öğrenme Süreci
8. Sonuç ve Değerlendirme

---

## 🔗 Referanslar

Bu projede aşağıdaki kaynaklardan yararlanılmıştır:

- [Clearpath Husky UGV](https://clearpathrobotics.com/husky-unmanned-ground-vehicle-robot/)
- [ROS 2 URDF Tutorial](https://docs.ros.org/en/jazzy/Tutorials/Intermediate/URDF/URDF-Main.html)
- [Gazebo Models](https://github.com/osrf/gazebo_models)
- Knightscope K5, Cobalt Robotics, SMP Robotics referans tasarımları

---

## 📜 Lisans

Bu proje eğitim amaçlı geliştirilmiştir.

```
MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

---

<div align="center">

### 🤖 GuardianBot

**Otonom Güvenlik ve Devriye Robotu**

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

*URDF Tabanlı Mobil Robot Modelleme Projesi*

📅 Aralık 2025

</div>
