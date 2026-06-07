# 安全政策 / Security Policy

## 我们非常重视安全 / We Take Security Seriously

本项目致力于保护用户的隐私和数据安全。如果您发现安全漏洞，请按照本政策中的说明报告。

## 当前安全措施 / Current Security Measures

### ✅ 已实施的安全实践

1. **敏感信息保护**
   - 本项目不使用 `.env` 文件提交真实密钥
   - 所有配置文件中的敏感信息均使用占位符
   - 提交前已通过 [gitleaks](https://github.com/gitleaks/gitleaks) 扫描

2. **代码扫描**
   - 定期使用 gitleaks 进行敏感信息泄露检测
   - 代码提交前进行人工安全复核

3. **数据传输加密**
   - 使用 TLS/SSL 加密传输
   - 敏感数据采用 AES-256 加密存储

4. **身份验证**
   - 使用 Token 进行 API 鉴权
   - 支持 OAuth2 集成（未来版本）

## 安全扫描命令 / Security Scanning Commands

### 使用 gitleaks 扫描

```bash
# 安装 gitleaks
go install github.com/gitleaks/gitleaks@latest

# 扫描整个仓库
gitleaks detect --source . -v

# 扫描特定提交
gitleaks detect --source . --commit <commit-hash> -v

# 扫描 git 历史
gitleaks protect --source . -v
```

### 使用 trufflehog 扫描

```bash
# 安装 trufflehog
go install github.com/trufflesecurity/trufflehog/v3@latest

# 扫描整个仓库
trufflehog git file://. --since-commit HEAD --branch main --full-history
```

## 报告安全漏洞 / Reporting Security Vulnerabilities

如果您发现安全漏洞，请通过以下方式报告：

1. **GitHub Security Advisory**
   - 选择 "Report a vulnerability"

2. **私人 Issue**
   - 在 GitHub 上创建私人 Issue

### 报告内容要求

请包含以下信息：
- 漏洞类型（如：硬编码密钥、SQL 注入、XSS 等）
- 受影响的文件和行号
- 复现步骤
- 潜在影响
- 建议的修复方案（可选）

## 响应时间 / Response Time

- 我们会在收到报告后的 **48 小时内** 确认收到
- 初步评估将在 **7 天内** 完成
- 修复计划将在评估后 **14 天内** 公布

## 安全更新 / Security Updates

安全修复将通过以下方式发布：
- GitHub Releases 页面
- 安全公告（针对严重漏洞）

## 版本支持 / Version Support

| 版本 | 支持状态 |
|------|----------|
| 最新 release | ✅ 支持 |
| 开发分支 | ⚠️ 有限支持 |

## 免责声明 / Disclaimer

⚠️ **重要提示**：
- 本系统为概念演示系统，不提供医疗诊断功能
- 健康数据仅供参考，不作为医疗决策依据
- 在生产环境中部署时，请务必更新所有默认密码和密钥