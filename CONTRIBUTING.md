# 贡献指南 / Contributing

感谢你对本项目的关注！欢迎任何形式的贡献。在开始之前，请花几分钟阅读以下指南。

## 🤝 如何贡献

### 报告问题 / Report Issues

如果你发现了 bug 或有功能建议，请使用 [GitHub Issues](https://github.com/lsf06/project1/issues)。

**报告 Bug 时请包含：**
- 问题描述
- 复现步骤
- 期望行为
- 实际行为
- 环境信息（硬件、操作系统、版本等）
- 截图或日志（如有）

**建议功能时请包含：**
- 功能描述
- 使用场景
- 预期效果
- 替代方案（如有考虑）

### 提交代码 / Submit Code

1. **Fork 本仓库**
   ```bash
   git clone https://github.com/lsf06/project1.git
   cd project1
   ```

2. **创建特性分支**
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. **进行更改并测试**
   - 确保代码符合项目规范
   - 添加必要的测试
   - 更新相关文档

4. **提交更改**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

5. **推送到分支**
   ```bash
   git push origin feature/AmazingFeature
   ```

6. **开启 Pull Request**

## 📋 开发规范 / Development Guidelines

### 分支规范 / Branch Guidelines

| 分支类型 | 前缀 | 说明 |
|----------|------|------|
| 功能开发 | `feature/` | 新功能开发 |
| Bug 修复 | `fix/` | Bug 修复 |
| 文档更新 | `docs/` | 文档更改 |
| 重构 | `refactor/` | 代码重构 |
| 测试 | `test/` | 测试相关 |
| 工具/配置 | `chore/` | 构建/工具相关 |

### 代码风格 / Code Style

**Python:**
- 遵循 [PEP 8](https://pep8.org/)
- 使用类型注解 (Type Hints)
- 函数和类添加文档字符串 (Docstrings)
- 使用 `black` 格式化代码

**JavaScript/TypeScript:**
- 使用 ESLint 和 Prettier
- 遵循项目配置的规则

**提交信息格式:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**类型包括:**
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更改
- `style`: 代码格式更改
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建/工具相关

**示例:**
```
feat(sensor): 添加血糖检测功能

实现基于近红外光谱的无创血糖检测算法

Closes #123
```

### 开发环境设置 / Development Setup

#### 后端开发

```bash
# 创建虚拟环境
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 安装依赖
pip install -r requirements.txt
pip install -r requirements-dev.txt  # 开发依赖

# 初始化数据库
python scripts/init_db.py

# 启动开发服务器
python main.py
```

#### 前端开发

```bash
# 安装依赖
cd web-portal/family
npm install

# 启动开发服务器
npm run dev
```

#### 使用 Docker 开发

```bash
# 启动完整环境
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

### 测试要求 / Testing Requirements

- 新功能和 Bug 修复必须包含测试
- 确保所有现有测试通过
- 保持或提高代码覆盖率

```bash
# 运行测试
pytest tests/

# 运行测试并生成覆盖率报告
pytest --cov=. tests/
```

### 安全规范 / Security Guidelines

- **不要提交敏感信息**（密钥、密码、Token 等）
- 使用 `.env` 文件存储本地配置，该文件已在 `.gitignore` 中
- 提交前使用 `gitleaks` 扫描
- 发现安全漏洞请立即报告（见 [SECURITY.md](SECURITY.md)）

```bash
# 提交前扫描
gitleaks detect --source . -v
```

## 📝 Pull Request 流程 / PR Process

1. **提交 PR 前检查清单:**
   - [ ] 代码符合项目规范
   - [ ] 已添加必要的测试
   - [ ] 已更新相关文档
   - [ ] 所有测试通过
   - [ ] 没有新增警告
   - [ ] 提交信息格式正确

2. **PR 描述模板:**
   ```markdown
   ## 变更类型
   - [ ] 新功能
   - [ ] Bug 修复
   - [ ] 文档更新
   - [ ] 重构
   - [ ] 其他

   ## 变更描述
   描述你的更改内容和原因。

   ## 相关 Issue
   Closes #123

   ## 测试说明
   描述你如何测试这些更改。

   ## 检查清单
   - [ ] 代码符合项目规范
   - [ ] 已添加测试
   - [ ] 已更新文档
   - [ ] 所有测试通过
   ```

3. **审查流程:**
   - 维护者会在 **3 个工作日内** 审查 PR
   - 可能需要一些迭代修改
   - 合并后会自动删除特性分支

## 🌟 成为贡献者

成为贡献者后，你将：
- 获得项目开发的参与感
- 在 README 中被致谢
- 参与项目决策讨论
- 获得社区认可

## 📄 许可证 / License

贡献即表示你同意你的贡献遵循本项目的 [MIT 许可证](LICENSE)。

## 🙏 致谢

感谢所有为本项目做出贡献的人！

---

**有问题？** 请开一个 Discussion 或在 Issue 中提问。

**需要帮助？** 查看 [README.md](README.md) 和 [文档](docs/)。