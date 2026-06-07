# 🎉 Project1 v0.1.0-alpha - 初始版本发布

> "让手指休息，让数据说话"

---

## 📋 版本概览

| 项目 | 详情 |
|------|------|
| **版本号** | v0.1.0-alpha |
| **发布日期** | 2026-06-07 |
| **版本类型** | 概念演示 (Proof of Concept) |
| **兼容性** | 全新发布 |

---

## 🚀 什么是 Project1？

Project1（原 Tangtang）是一个基于边缘 AI 的多模态居家健康监护系统，主打**无创血糖概念验证**。我们用多模态生理感知与边缘 AI 分析技术，为居家老年患者解决传统有创血糖监测的痛点：

- ❌ 传统血糖仪：扎手指、耗材贵、操作烦
- ✅ Project1：无痛检测、零耗材、语音交互

---

## 🎯 新功能亮点

### 1️⃣ 无创血糖概念验证
- 近红外光谱传感技术
- 多模态数据融合分析
- 健康基线学习

### 2️⃣ 多模态传感器融合
- MAX30102 心率血氧传感器
- MLX90614 红外体温传感器
- 近红外光谱传感器

### 3️⃣ 语音交互系统
- 实时健康状态播报
- 异常预警语音提示
- 操作引导语音

### 4️⃣ 家属远程监护
- 实时数据查看
- 异常预警推送
- 双向视频通话

### 5️⃣ 数据可视化大屏
- 24 小时趋势图
- 健康状态热力图
- 告警信息实时滚动

---

## 📦 下载附件

| 文件名 | 说明 | 大小 |
|--------|------|------|
| `project1-backend-win64.exe` | Windows 64 位后端服务 | TBD |
| `project1-backend-linux` | Linux/树莓派后端服务 | TBD |
| `project1-web-portal-dist.zip` | Web 前端打包文件 | TBD |
| `esp32-s3-firmware.bin` | ESP32-S3-EYE 固件 | TBD |
| `config.example.yaml` | 配置文件模板 | TBD |
| `API 文档.pdf` | API 使用文档 | TBD |
| `demo.mp4` | 功能演示视频 | TBD |

---

## 🛠️ 快速开始

### 前置条件
- 树莓派 5 (运行 Raspberry Pi OS)
- ESP32-S3-EYE 开发板
- MAX30102 心率血氧传感器
- MLX90614 红外体温传感器
- WiFi 网络

### 安装步骤

```bash
# 1. 克隆仓库
git clone https://github.com/lsf06/project1.git
cd project1

# 2. 创建虚拟环境
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 3. 安装依赖
pip install -r services/raspberry-pi/requirements.txt

# 4. 配置环境变量
cp .env.example .env
# 编辑 .env 文件，配置 WiFi 等信息

# 5. 启动服务
python services/raspberry-pi/main.py
```

### Docker 部署（推荐）

```bash
# 启动完整系统
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

---

## ⚠️ 已知问题

1. **近红外血糖检测精度**
   - 目前处于概念验证阶段
   - 数据仅供参考，不作为医疗诊断依据

2. **ESP32 稳定性**
   - 偶发重启问题
   - 建议配置看门狗定时重启

3. **语音播报**
   - 中文 TTS 偶有口音问题
   - 正在优化语音模型

---

## 📚 文档链接

- [完整 README](https://github.com/lsf06/project1/blob/main/README.md)
- [更新日志](https://github.com/lsf06/project1/blob/main/CHANGELOG.md)
- [API 文档](https://github.com/lsf06/project1/blob/main/docs/API.md)
- [部署指南](https://github.com/lsf06/project1/blob/main/docs/DEPLOYMENT.md)

---

## 🔗 相关链接

- 📖 [项目主页](https://github.com/lsf06/project1)
- 🐛 [问题反馈](https://github.com/lsf06/project1/issues)
- 💡 [功能建议](https://github.com/lsf06/project1/discussions)
- 📧 联系方式：3606406829@qq.com

---

## 🙏 致谢

感谢以下开源项目：
- [ESP32-S3-EYE](https://github.com/espressif/esp-box) - 乐鑫
- [Raspberry Pi](https://www.raspberrypi.org/) - 树莓派基金会
- [Vue.js](https://vuejs.org/) - 尤雨溪
- [Flask](https://flask.palletsprojects.com/) - Pallets

---

## 📄 许可证

- 开源代码：GPL-3.0
- 核心模型：商业授权

详见 [LICENSE](https://github.com/lsf06/project1/blob/main/LICENSE)

---

> ⚠️ **免责声明**：本系统为概念演示系统，不提供医疗诊断功能。健康数据仅供参考，不作为医疗决策依据。使用前请咨询专业医生。

---

<div align="center">

**Made with ❤️ by lsf06 for EdgeAI Healthcare**

⭐ 如果这个项目对你有帮助，请给一个 Star！

</div>