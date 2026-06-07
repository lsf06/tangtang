# 系统架构文档

## 概述

本文档描述了基于边缘 AI 的多模态居家健康监护系统的整体架构设计。

## 系统架构图

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              用户界面层 (UI Layer)                            │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │  患者端 Web  │  │  家属端 Web  │  │  数据大屏   │  │  管理后台   │        │
│  │  (Patient)  │  │  (Family)   │  │ (Dashboard) │  │   (Admin)   │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
│         │                │                │                │                │
│         └────────────────┴────────────────┴────────────────┘                │
│                                    │                                         │
└────────────────────────────────────┼─────────────────────────────────────────┘
                                     │ HTTP/WebSocket
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              API 网关层 (API Gateway)                          │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    RESTful API + WebSocket Server                    │   │
│  │  - 设备管理 API    - 健康数据 API    - 告警通知 API    - 用户认证 API    │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                            业务服务层 (Service Layer)                         │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  数据采集服务 │  │  AI 分析服务  │  │  告警服务    │  │  语音播报服务 │    │
│  │ Data Service │  │  AI Service  │  │Alert Service │  │ Voice Service│    │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘    │
│                                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  用户管理服务  │  │  设备管理服务 │  │  数据存储服务 │  │  通知推送服务 │    │
│  │ User Service │  │Device Service│  │Data Service  │  │Push Service  │    │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘    │
└─────────────────────────────────────────────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                            数据存储层 (Data Layer)                            │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │  SQLite/MySQL│  │   Redis      │  │  文件系统    │  │  云端存储    │    │
│  │  (关系数据)  │  │  (缓存)      │  │ (日志/文件)  │  │ (备份)       │    │
│  └──────────────┘  └──────────────┘  └──────────────┘  └──────────────┘    │
└─────────────────────────────────────────────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                            硬件设备层 (Hardware Layer)                        │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    ESP32-S3-EYE 多模态采集终端                        │   │
│  ├─────────────────────────────────────────────────────────────────────┤   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │   │
│  │  │ MAX30102     │  │ MLX90614     │  │ 近红外光谱   │              │   │
│  │  │ 心率血氧     │  │ 红外体温     │  │ 传感器       │              │   │
│  │  └──────────────┘  └──────────────┘  └──────────────┘              │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    边缘算力平台 (树莓派 5)                             │   │
│  ├─────────────────────────────────────────────────────────────────────┤   │
│  │  - AI 模型推理  - 数据预处理  - 本地缓存  - 语音合成                  │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 组件详细说明

### 1. 用户界面层

#### 1.1 患者端 (Patient Portal)
- **技术栈**: 纯 HTML/CSS/JavaScript
- **功能**: 
  - 健康数据录入
  - 一键紧急呼叫
  - 语音提示引导
- **特点**: 简单直观，适合老年用户

#### 1.2 家属端 (Family Portal)
- **技术栈**: Vue 3 + Vue Router + Axios
- **功能**:
  - 实时数据查看
  - 历史数据查询
  - 异常预警接收
  - 双向视频通话

#### 1.3 数据大屏 (Dashboard)
- **技术栈**: Vue 3 + ECharts
- **功能**:
  - 实时数据可视化
  - 24 小时趋势图
  - 健康状态热力图

#### 1.4 管理后台 (Admin Portal)
- **技术栈**: Vue 3 + Element Plus + Pinia
- **功能**:
  - 用户管理
  - 设备管理
  - 系统配置
  - 数据管理

### 2. API 网关层

- **技术栈**: Python FastAPI/Flask
- **职责**:
  - 请求路由
  - 身份验证
  - 速率限制
  - 日志记录

### 3. 业务服务层

#### 3.1 数据采集服务
- 从 ESP32-S3-EYE 接收传感器数据
- 数据格式验证
- 实时数据转发

#### 3.2 AI 分析服务
- 健康基线学习
- 异常检测
- 趋势分析
- 健康评分计算

#### 3.3 告警服务
- 阈值检测
- 告警分级
- 告警通知推送

#### 3.4 语音播报服务
- TTS 文本转语音
- 播报内容管理
- 音量/语速控制

### 4. 数据存储层

#### 4.1 关系数据库
- **类型**: SQLite (边缘) / MySQL (云端)
- **存储内容**:
  - 用户信息
  - 设备绑定关系
  - 健康记录
  - 告警记录

#### 4.2 缓存
- **类型**: Redis
- **用途**:
  - 实时数据缓存
  - Session 管理
  - 速率限制

#### 4.3 数据库 ER 图

**实体关系图:**
```
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│     users       │       │    devices      │       │  health_records │
├─────────────────┤       ├─────────────────┤       ├─────────────────┤
│ id (PK)         │──┐    │ id (PK)         │──┐    │ id (PK)         │
│ username        │  │    │ user_id (FK)    │  │    │ device_id (FK)  │
│ password_hash   │  │    │ device_name     │  │    │ user_id (FK)    │
│ email           │  │    │ device_type     │  │    │ timestamp       │
│ role            │  └───▶│ mac_address     │  │    │ heart_rate      │
│ created_at      │       │ firmware_version│  │    │ blood_oxygen    │
│ updated_at      │       │ is_active       │  │    │ temperature     │
└─────────────────┘       │ last_seen       │  │    │ glucose         │
                          │ created_at      │  │    │ health_score    │
                          └─────────────────┘  │    │ created_at      │
                               │               │    └─────────────────┘
                               │               │             │
                               └───────────────┴─────────────┘
                                                 │
                                                 ▼
                                          ┌─────────────────┐
                                          │   alerts        │
                                          ├─────────────────┤
                                          │ id (PK)         │
                                          │ record_id (FK)  │
                                          │ user_id (FK)    │
                                          │ alert_type      │
                                          │ severity        │
                                          │ message         │
                                          │ is_read         │
                                          │ created_at      │
                                          └─────────────────┘
```

**表结构定义:**

**users (用户表)**
| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 用户 ID |
| username | VARCHAR(50) | UNIQUE NOT NULL | 用户名 |
| password_hash | VARCHAR(255) | NOT NULL | 密码哈希 |
| email | VARCHAR(100) | UNIQUE | 邮箱 |
| role | VARCHAR(20) | NOT NULL | 角色 (patient/family/admin) |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | DATETIME | ON UPDATE CURRENT_TIMESTAMP | 更新时间 |

**devices (设备表)**
| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 设备 ID |
| user_id | INTEGER | FOREIGN KEY → users.id | 绑定用户 |
| device_name | VARCHAR(100) | NOT NULL | 设备名称 |
| device_type | VARCHAR(50) | NOT NULL | 设备类型 |
| mac_address | VARCHAR(17) | UNIQUE | MAC 地址 |
| firmware_version | VARCHAR(20) | | 固件版本 |
| is_active | BOOLEAN | DEFAULT 1 | 是否在线 |
| last_seen | DATETIME | | 最后在线时间 |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

**health_records (健康记录表)**
| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 记录 ID |
| device_id | INTEGER | FOREIGN KEY → devices.id | 设备 ID |
| user_id | INTEGER | FOREIGN KEY → users.id | 用户 ID |
| timestamp | DATETIME | NOT NULL | 检测时间 |
| heart_rate | INTEGER | | 心率 (bpm) |
| blood_oxygen | DECIMAL(5,2) | | 血氧饱和度 (%) |
| temperature | DECIMAL(4,2) | | 体温 (°C) |
| glucose | INTEGER | | 血糖值 (mg/dL) |
| health_score | DECIMAL(5,2) | | 健康评分 |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

**alerts (告警表)**
| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 告警 ID |
| record_id | INTEGER | FOREIGN KEY → health_records.id | 关联记录 |
| user_id | INTEGER | FOREIGN KEY → users.id | 用户 ID |
| alert_type | VARCHAR(50) | NOT NULL | 告警类型 |
| severity | VARCHAR(20) | NOT NULL | 严重程度 (low/medium/high/critical) |
| message | TEXT | NOT NULL | 告警内容 |
| is_read | BOOLEAN | DEFAULT 0 | 是否已读 |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

**索引设计:**
```sql
-- 用户表索引
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_role ON users(role);

-- 设备表索引
CREATE INDEX idx_devices_user_id ON devices(user_id);
CREATE INDEX idx_devices_mac_address ON devices(mac_address);
CREATE INDEX idx_devices_is_active ON devices(is_active);

-- 健康记录表索引
CREATE INDEX idx_records_user_id ON health_records(user_id);
CREATE INDEX idx_records_device_id ON health_records(device_id);
CREATE INDEX idx_records_timestamp ON health_records(timestamp);
CREATE INDEX idx_records_user_timestamp ON health_records(user_id, timestamp);

-- 告警表索引
CREATE INDEX idx_alerts_user_id ON alerts(user_id);
CREATE INDEX idx_alerts_is_read ON alerts(is_read);
CREATE INDEX idx_alerts_created_at ON alerts(created_at);
```

### 5. 硬件设备层

#### 5.1 ESP32-S3-EYE
- **主控**: ESP32-S3 双核处理器
- **传感器**:
  - MAX30102: 心率血氧 (I²C)
  - MLX90614: 红外体温 (I²C)
  - 近红外光谱传感器 (UART)
- **通信**: WiFi/蓝牙

#### 5.2 树莓派 5
- **角色**: 边缘算力平台
- **功能**:
  - AI 模型推理
  - 数据聚合处理
  - 本地服务托管

## 数据流

```
传感器采集 → ESP32 预处理 → WiFi 传输 → 树莓派接收 → AI 分析 → 结果存储 → 前端展示
                                                        ↓
                                                  语音播报/告警
```

## 安全设计

### 1. 数据传输安全
- TLS/SSL 加密
- API Token 认证
- WebSocket 鉴权

### 2. 数据存储安全
- AES-256 加密存储
- 敏感信息脱敏
- 定期数据备份

### 3. 访问控制
- RBAC 权限模型
- 操作审计日志
- 会话超时管理

## 扩展性设计

### 1. 模块化
- 各服务独立部署
- 接口标准化
- 配置外部化

### 2. 水平扩展
- 无状态服务设计
- 负载均衡支持
- 数据库读写分离

### 3. 插件化
- 传感器插件接口
- AI 模型热切换
- 通知渠道扩展

## 性能指标

| 指标 | 目标值 |
|------|--------|
| 数据采集频率 | 1Hz |
| 端到端延迟 | < 1s |
| AI 推理时间 | < 500ms |
| 系统可用性 | 99.5% |
| 并发用户数 | 100+ |

## 部署架构

### 边缘部署
```
ESP32-S3-EYE ←WiFi→ 树莓派 5 ←局域网→ Web 客户端
```

### 云端部署 (可选)
```
边缘设备 → 互联网 → 云服务器 → 数据库 → Web 客户端