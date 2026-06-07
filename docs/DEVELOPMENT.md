# 开发文档 (Development Guide)

本文档提供 EdgeAI 健康监护系统的开发环境设置、调试指南和开发规范。

---

## 📋 目录

- [开发环境设置](#开发环境设置)
- [项目结构](#项目结构)
- [开发流程](#开发流程)
- [调试指南](#调试指南)
- [代码规范](#代码规范)
- [常见问题](#常见问题)

---

## 开发环境设置

### 1. Python 开发环境

#### 安装 Python

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3.9 python3-pip python3-venv

# macOS
brew install python@3.9

# Windows
# 从 https://www.python.org/downloads/ 下载安装包
```

#### 创建虚拟环境

```bash
# 克隆项目
git clone https://github.com/lsf06/project1.git
cd project1

# 创建虚拟环境
python3 -m venv venv

# 激活虚拟环境
# Linux/macOS
source venv/bin/activate
# Windows
venv\Scripts\activate
```

#### 安装依赖

```bash
# 安装核心依赖
pip install -r requirements.txt

# 安装开发依赖
pip install -r requirements-dev.txt

# 安装测试依赖
pip install pytest pytest-cov pytest-asyncio
```

### 2. ESP32-S3-EYE 开发环境

#### 安装 ESP-IDF

```bash
# 进入 esp 目录
cd ~/esp

# 克隆 esp-idf
git clone -b v5.1.2 --recursive https://github.com/espressif/esp-idf.git

# 进入目录
cd esp-idf

# 安装依赖
./install.sh

# 导出环境变量
. ./export.sh
```

#### 验证安装

```bash
idf.py --version
```

### 3. 前端开发环境

#### 安装 Node.js

```bash
# 使用 nvm 安装
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
nvm use 18

# 验证
node --version  # 应输出 v18.x.x
npm --version   # 应输出 9.x.x 或更高
```

#### 安装前端依赖

```bash
# 家属端
cd web-portal/family
npm install

# 数据大屏
cd web-portal/dashboard
npm install

# 管理后台
cd web-portal/admin
npm install
```

### 4. Docker 环境（可选）

```bash
# 安装 Docker
# Ubuntu
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 验证
docker --version
docker-compose --version
```

---

## 项目结构

```
tangtang/
├── README.md                 # 项目说明
├── CONTRIBUTING.md           # 贡献指南
├── LICENSE                   # 开源协议
├── CHANGELOG.md              # 变更日志
├── SECURITY.md               # 安全策略
│
├── .github/
│   ├── workflows/            # GitHub Actions 工作流
│   │   ├── ci.yml           # 持续集成
│   │   └── release.yml      # 发布流程
│   └── ISSUE_TEMPLATE/       # Issue 模板
│       ├── bug_report.md
│       └── feature_request.md
│
├── docs/                     # 文档目录
│   ├── ARCHITECTURE.md       # 架构文档
│   ├── MODEL_CARD.md         # 模型信息卡
│   ├── HARDWARE_BUYING_GUIDE.md  # 硬件采购指南
│   ├── ROADMAP.md            # 项目路线图
│   ├── DEVELOPMENT.md        # 开发文档（本文档）
│   ├── CONTRIBUTING.md       # 贡献指南
│   ├── index.html            # 项目宣传页
│   └── images/               # 图片资源
│
├── services/                 # 后端服务
│   └── raspberry-pi/         # 树莓派边缘服务
│       ├── main.py           # 主入口
│       ├── config.yaml       # 配置文件
│       ├── requirements.txt  # Python 依赖
│       └── app/              # 应用模块
│           ├── api/          # API 接口
│           ├── models/       # 数据模型
│           ├── services/     # 业务服务
│           └── utils/        # 工具函数
│
├── firmware/                 # 固件目录
│   └── esp32-s3/             # ESP32-S3 固件
│       ├── main/             # 主程序
│       ├── components/       # 组件
│       └── CMakeLists.txt    # 构建配置
│
├── web-portal/               # Web 前端
│   ├── patient/              # 患者端（纯 HTML）
│   ├── family/               # 家属端（Vue 3）
│   ├── dashboard/            # 数据大屏（Vue 3）
│   └── admin/                # 管理后台（Vue 3 + Element Plus）
│
├── tests/                    # 测试目录
│   ├── test_api.py           # API 测试
│   └── test_sensor.py        # 传感器测试
│
├── scripts/                  # 脚本目录
│   └── build-release.sh      # 构建脚本
│
└── docker-compose.yml        # Docker 编排
```

---

## 开发流程

### 1. 分支管理

```bash
# 查看分支
git branch -a

# 创建功能分支
git checkout -b feature/new-feature

# 推送分支
git push origin feature/new-feature

# 完成开发后创建 PR
```

### 2. 开发循环

```bash
# 1. 拉取最新代码
git pull origin develop

# 2. 开发功能
# 编写代码...

# 3. 运行测试
pytest tests/ -v

# 4. 提交更改
git add .
git commit -m "feat: 添加新功能"

# 5. 推送
git push origin feature/new-feature
```

### 3. 代码审查流程

1. 创建 Pull Request
2. 等待 CI 检查通过
3. 等待至少 1 个 Reviewer 批准
4. 解决 Review 评论
5. 合并到 develop 分支

---

## 调试指南

### Python 服务调试

#### 使用 pdb 调试

```python
import pdb; pdb.set_trace()  # 设置断点
```

#### 使用 VS Code 调试

1. 安装 Python 扩展
2. 创建 `.vscode/launch.json`:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: 当前文件",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "env": {
                "PYTHONPATH": "${workspaceFolder}"
            }
        }
    ]
}
```

### ESP32 固件调试

#### 串口监控

```bash
# 使用 idf.py 查看日志
idf.py -p /dev/ttyUSB0 monitor

# 使用 screen
screen /dev/ttyUSB0 115200

# 使用 minicom
minicom -D /dev/ttyUSB0 -b 115200
```

#### GDB 调试

```bash
# 编译时添加调试信息
idf.py build

# 使用 OpenOCD + GDB
openocd -f interface/esp-builtin.cfg -f target/esp32s3.cfg
# 另一个终端
esp32s3-gdb
target remote localhost:3333
```

### 前端调试

#### 开发服务器

```bash
# 家属端
cd web-portal/family
npm run dev

# 数据大屏
cd web-portal/dashboard
npm run dev

# 管理后台
cd web-portal/admin
npm run dev
```

#### Vue DevTools

1. 安装 Vue DevTools 浏览器扩展
2. 打开开发者工具
3. 查看组件树、状态、事件

---

## 代码规范

### Python 规范

#### 命名规范

```python
# 类名：大驼峰命名
class SensorDataProcessor:
    pass

# 函数/变量：小写 + 下划线
def read_sensor_data():
    sensor_value = 0
    return sensor_value

# 常量：大写 + 下划线
MAX_TEMPERATURE = 50
MIN_HEART_RATE = 40

# 私有方法/变量：单下划线前缀
def _internal_method():
    pass

# 强私有：双下划线前缀
class MyClass:
    def __private_method(self):
        pass
```

#### 文档字符串

```python
def calculate_health_score(heart_rate, spo2, temperature):
    """
    计算健康评分
    
    Args:
        heart_rate (int): 心率 (BPM)
        spo2 (float): 血氧饱和度 (%)
        temperature (float): 体温 (°C)
    
    Returns:
        int: 健康评分 (0-100)
    
    Example:
        >>> calculate_health_score(72, 98, 36.5)
        95
    """
    pass
```

### JavaScript/Vue 规范

#### 组件命名

```vue
<!-- 文件名：PascalCase -->
<!-- 组件名：PascalCase -->
<template>
  <div class="health-monitor">
    <!-- 组件内容 -->
  </div>
</template>

<script setup>
// 组件名与文件名一致
defineOptions({
  name: 'HealthMonitor'
})
</script>
```

#### 组合式 API

```vue
<script setup>
import { ref, computed, onMounted } from 'vue'

// 响应式状态
const count = ref(0)

// 计算属性
const doubled = computed(() => count.value * 2)

// 生命周期
onMounted(() => {
  console.log('组件已挂载')
})

// 方法
function increment() {
  count.value++
}
</script>
```

---

## 常见问题

### Q1: ESP32 编译失败

**问题**: `fatal error: esp_types.h: No such file or directory`

**解决**:
```bash
# 确保已正确导出环境变量
. $IDF_PATH/export.sh

# 重新编译
idf.py fullclean
idf.py build
```

### Q2: I²C 传感器无法读取

**问题**: `I2C timeout error`

**解决**:
1. 检查接线是否正确
2. 确认电源电压匹配（3.3V vs 5V）
3. 检查 I²C 地址是否冲突
4. 使用 I²C 扫描工具检测

```python
# I²C 扫描示例
from machine import I2C, Pin

i2c = I2C(0, scl=Pin(22), sda=Pin(21))
devices = i2c.scan()
print(f'找到设备：{[hex(d) for d in devices]}')
```

### Q3: 前端构建失败

**问题**: `ERR_PNPM_OUTDATED_LOCKFILE`

**解决**:
```bash
# 删除 node_modules 和 lock 文件
rm -rf node_modules package-lock.json

# 重新安装
npm install
```

### Q4: Docker 容器无法启动

**问题**: `Error response from daemon: port is already allocated`

**解决**:
```bash
# 查看端口占用
lsof -i :8080

# 停止占用进程或修改端口
docker-compose.yml 中修改端口映射
```

### Q5: 虚拟环境无法激活

**问题**: `bash: venv/bin/activate: No such file or directory`

**解决**:
```bash
# 重新创建虚拟环境
rm -rf venv
python3 -m venv venv
source venv/bin/activate
```

---

## 性能优化

### Python 优化

```python
# 使用生成器处理大数据
def read_sensor_stream():
    while True:
        yield read_sensor()
        time.sleep(0.1)

# 使用缓存减少重复计算
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_computation(value):
    return value ** 2
```

### 前端优化

```javascript
// 使用虚拟列表处理大量数据
import { useVirtualList } from '@vueuse/core'

const { containerStyle, wrapperRef } = useVirtualList(
  data,
  { itemHeight: 50, overscan: 10 }
)
```

---

## 快速链接

- [项目主页](https://github.com/lsf06/project1)
- [架构文档](./ARCHITECTURE.md)
- [模型信息卡](./MODEL_CARD.md)
- [贡献指南](./CONTRIBUTING.md)
- [项目路线图](./ROADMAP.md)
- [硬件采购指南](./HARDWARE_BUYING_GUIDE.md)