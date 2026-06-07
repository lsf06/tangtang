#!/bin/bash

# Tangtang Release 打包脚本
# 用于构建 Release 附件

set -e  # 遇到错误立即退出

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 版本信息
VERSION="1.0.0"
BUILD_DIR="release"
PACKAGE_NAME="tangtang-${VERSION}"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Tangtang Release 打包脚本 v${VERSION}${NC}"
echo -e "${BLUE}========================================${NC}"

# 清理旧的构建文件
cleanup() {
    echo -e "${YELLOW}[1/8] 清理旧的构建文件...${NC}"
    rm -rf "${BUILD_DIR}"
    rm -rf "dist"
    rm -rf "build"
    mkdir -p "${BUILD_DIR}"
    echo -e "${GREEN}✓ 清理完成${NC}"
}

# 构建前端项目
build_frontend() {
    echo -e "${YELLOW}[2/8] 构建前端项目...${NC}"
    
    # 患者端（纯静态，无需构建）
    echo -e "  ${BLUE}→ 患者端 (patient)${NC}"
    mkdir -p "${BUILD_DIR}/web-portal/patient"
    cp -r web-portal/patient/* "${BUILD_DIR}/web-portal/patient/"
    
    # 家属端
    echo -e "  ${BLUE}→ 家属端 (family)${NC}"
    if [ -d "web-portal/family" ]; then
        cd web-portal/family
        if [ -f "package.json" ]; then
            npm install --legacy-peer-deps 2>/dev/null || npm install
            npm run build
            mkdir -p "../../${BUILD_DIR}/web-portal/family"
            cp -r dist/* "../../${BUILD_DIR}/web-portal/family/"
        fi
        cd ../..
    fi
    
    # 数据大屏
    echo -e "  ${BLUE}→ 数据大屏 (dashboard)${NC}"
    if [ -d "web-portal/dashboard" ]; then
        cd web-portal/dashboard
        if [ -f "package.json" ]; then
            npm install --legacy-peer-deps 2>/dev/null || npm install
            npm run build
            mkdir -p "../../${BUILD_DIR}/web-portal/dashboard"
            cp -r dist/* "../../${BUILD_DIR}/web-portal/dashboard/"
        fi
        cd ../..
    fi
    
    # 管理后台
    echo -e "  ${BLUE}→ 管理后台 (admin)${NC}"
    if [ -d "web-portal/admin" ]; then
        cd web-portal/admin
        if [ -f "package.json" ]; then
            npm install --legacy-peer-deps 2>/dev/null || npm install
            npm run build
            mkdir -p "../../${BUILD_DIR}/web-portal/admin"
            cp -r dist/* "../../${BUILD_DIR}/web-portal/admin/"
        fi
        cd ../..
    fi
    
    # 打包前端
    cd "${BUILD_DIR}"
    zip -r "../${PACKAGE_NAME}-web-portal.zip" web-portal
    cd ..
    rm -rf "${BUILD_DIR}/web-portal"
    
    echo -e "${GREEN}✓ 前端构建完成${NC}"
}

# 打包后端服务
package_backend() {
    echo -e "${YELLOW}[3/8] 打包后端服务...${NC}"
    
    # 创建后端目录
    mkdir -p "${BUILD_DIR}/backend"
    
    # 复制 Python 服务文件
    cp -r services/raspberry-pi/* "${BUILD_DIR}/backend/"
    cp .env.example "${BUILD_DIR}/backend/.env.example"
    cp docker-compose.yml "${BUILD_DIR}/backend/"
    
    # 复制依赖文件
    if [ -f "requirements.txt" ]; then
        cp requirements.txt "${BUILD_DIR}/backend/"
    elif [ -f "services/raspberry-pi/requirements.txt" ]; then
        cp services/raspberry-pi/requirements.txt "${BUILD_DIR}/backend/"
    fi
    
    # 创建 README
    cat > "${BUILD_DIR}/backend/README.md" << 'EOF'
# Tangtang 后端服务

## 快速开始

```bash
# 1. 创建虚拟环境
python -m venv venv

# 2. 激活虚拟环境
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# 3. 安装依赖
pip install -r requirements.txt

# 4. 配置环境变量
cp .env.example .env
# 编辑 .env 文件

# 5. 启动服务
python main.py
```

## Docker 运行

```bash
docker-compose up -d
```

## API 端点

- `GET /` - 服务信息
- `GET /api/health` - 健康检查
- `GET /api/patients` - 患者列表
- `GET /api/sensors` - 传感器状态
- `GET /api/vitals` - 生命体征
- `POST /api/v1/detect` - 触发健康检测
EOF
    
    echo -e "${GREEN}✓ 后端打包完成${NC}"
}

# 打包配置文件
package_config() {
    echo -e "${YELLOW}[4/8] 打包配置文件...${NC}"
    
    mkdir -p "${BUILD_DIR}/config"
    
    # 复制配置文件
    cp .env.example "${BUILD_DIR}/config/"
    cp services/raspberry-pi/config.yaml "${BUILD_DIR}/config/"
    
    # 创建配置说明
    cat > "${BUILD_DIR}/config/README.md" << 'EOF'
# 配置文件说明

## 文件列表

- `.env.example` - 环境变量模板
- `config.yaml` - 应用配置文件

## 配置步骤

1. 复制 `.env.example` 为 `.env`
2. 编辑 `.env` 文件，填写你的配置
3. 启动服务时会自动加载 `.env` 文件

## 配置项说明

### 环境变量 (.env)

```
# WiFi 配置
WIFI_SSID=your_wifi_name
WIFI_PASSWORD=your_wifi_password

# API 密钥
API_KEY=your_api_key

# 服务端口
PORT=8080
```

### 应用配置 (config.yaml)

```yaml
# 设备配置
device:
  serial_port: "/dev/ttyUSB0"
  baud_rate: 115200

# 网络配置
network:
  wifi_ssid: "your_wifi"
  wifi_password: "your_password"

# AI 模型配置
ai:
  model_enabled: true
  threshold:
    heart_rate_low: 50
    heart_rate_high: 100
    spo2_low: 95
    temp_high: 37.5

# 语音配置
voice:
  enabled: true
  volume: 80
  language: "zh-CN"
```
EOF
    
    echo -e "${GREEN}✓ 配置文件打包完成${NC}"
}

# 打包文档
package_docs() {
    echo -e "${YELLOW}[5/8] 打包文档...${NC}"
    
    mkdir -p "${BUILD_DIR}/docs"
    
    # 复制文档文件
    cp README.md "${BUILD_DIR}/docs/"
    cp CHANGELOG.md "${BUILD_DIR}/docs/"
    cp LICENSE "${BUILD_DIR}/docs/" 2>/dev/null || true
    
    # 复制 docs 目录内容
    if [ -d "docs" ]; then
        cp -r docs/* "${BUILD_DIR}/docs/" 2>/dev/null || true
    fi
    
    echo -e "${GREEN}✓ 文档打包完成${NC}"
}

# 创建校验和
create_checksums() {
    echo -e "${YELLOW}[6/8] 生成校验和...${NC}"
    
    cd "${BUILD_DIR}"
    
    # 创建各个包的 zip
    zip -r "../${PACKAGE_NAME}-backend.zip" backend
    zip -r "../${PACKAGE_NAME}-config.zip" config
    zip -r "../${PACKAGE_NAME}-docs.zip" docs
    
    cd ..
    
    # 生成校验和文件
    sha256sum "${PACKAGE_NAME}-backend.zip" > "${PACKAGE_NAME}-SHA256SUMS" 2>/dev/null || true
    sha256sum "${PACKAGE_NAME}-config.zip" >> "${PACKAGE_NAME}-SHA256SUMS" 2>/dev/null || true
    sha256sum "${PACKAGE_NAME}-docs.zip" >> "${PACKAGE_NAME}-SHA256SUMS" 2>/dev/null || true
    sha256sum "${PACKAGE_NAME}-web-portal.zip" >> "${PACKAGE_NAME}-SHA256SUMS" 2>/dev/null || true
    
    echo -e "${GREEN}✓ 校验和生成完成${NC}"
}

# 创建发布说明
create_release_notes() {
    echo -e "${YELLOW}[7/8] 生成发布说明...${NC}"
    
    cat > "${BUILD_DIR}/RELEASE_NOTES.txt" << EOF
Tangtang v${VERSION} Release Notes
===================================

发布日期：$(date +%Y-%m-%d)

包含的文件：
- ${PACKAGE_NAME}-backend.zip      - 后端服务
- ${PACKAGE_NAME}-web-portal.zip   - Web 前端
- ${PACKAGE_NAME}-config.zip       - 配置文件
- ${PACKAGE_NAME}-docs.zip         - 文档
- ${PACKAGE_NAME}-SHA256SUMS       - 校验和文件

快速开始：
1. 解压 backend 包
2. 配置环境变量
3. 运行 pip install -r requirements.txt
4. 运行 python main.py

更多信息请查看 docs/README.md
EOF
    
    echo -e "${GREEN}✓ 发布说明生成完成${NC}"
}

# 清理临时文件
finalize() {
    echo -e "${YELLOW}[8/8] 清理临时文件...${NC}"
    
    rm -rf "${BUILD_DIR}"
    
    # 显示最终文件列表
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  构建完成！生成的文件：${NC}"
    echo -e "${GREEN}========================================${NC}"
    ls -lh "${PACKAGE_NAME}"*.zip 2>/dev/null || echo "  无 zip 文件"
    ls -lh "${PACKAGE_NAME}"*SHA256SUMS 2>/dev/null || echo "  无校验和文件"
    echo -e "${GREEN}========================================${NC}"
}

# 主流程
main() {
    cleanup
    build_frontend
    package_backend
    package_config
    package_docs
    create_checksums
    create_release_notes
    finalize
    
    echo -e "${GREEN}✓ 所有任务完成！${NC}"
    echo -e "${BLUE}上传到 GitHub Release 时，请上传以下文件：${NC}"
    echo -e "  - ${PACKAGE_NAME}-backend.zip"
    echo -e "  - ${PACKAGE_NAME}-web-portal.zip"
    echo -e "  - ${PACKAGE_NAME}-config.zip"
    echo -e "  - ${PACKAGE_NAME}-docs.zip"
    echo -e "  - ${PACKAGE_NAME}-SHA256SUMS"
}

# 执行主流程
main