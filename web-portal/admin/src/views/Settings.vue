<template>
  <div class="settings-page">
    <el-row :gutter="20">
      <el-col :span="16">
        <el-card>
          <template #header>
            <span>系统设置</span>
          </template>

          <el-form label-width="150px">
            <el-form-item label="系统名称">
              <el-input v-model="settings.systemName" placeholder="请输入系统名称" />
            </el-form-item>

            <el-form-item label="告警阈值 - 心率">
              <el-row :gutter="20">
                <el-col :span="10">
                  <el-input-number v-model="settings.heartRateMin" :min="0" :max="100" />
                </el-col>
                <el-col :span="10">
                  <el-input-number v-model="settings.heartRateMax" :min="0" :max="200" />
                </el-col>
                <el-col :span="4">
                  <span>次/分</span>
                </el-col>
              </el-row>
            </el-form-item>

            <el-form-item label="告警阈值 - 血氧">
              <el-row :gutter="20">
                <el-col :span="10">
                  <el-input-number v-model="settings.oxygenMin" :min="50" :max="100" />
                </el-col>
                <el-col :span="4">
                  <span>%</span>
                </el-col>
              </el-row>
            </el-form-item>

            <el-form-item label="告警阈值 - 体温">
              <el-row :gutter="20">
                <el-col :span="10">
                  <el-input-number v-model="settings.tempMin" :precision="1" :min="30" :max="45" />
                </el-col>
                <el-col :span="10">
                  <el-input-number v-model="settings.tempMax" :precision="1" :min="30" :max="45" />
                </el-col>
                <el-col :span="4">
                  <span>°C</span>
                </el-col>
              </el-row>
            </el-form-item>

            <el-form-item label="数据刷新间隔">
              <el-select v-model="settings.refreshInterval" placeholder="请选择">
                <el-option label="5 秒" :value="5" />
                <el-option label="10 秒" :value="10" />
                <el-option label="30 秒" :value="30" />
                <el-option label="1 分钟" :value="60" />
              </el-select>
            </el-form-item>

            <el-form-item label="告警通知方式">
              <el-checkbox-group v-model="settings.notifyMethods">
                <el-checkbox label="sms">短信</el-checkbox>
                <el-checkbox label="email">邮件</el-checkbox>
                <el-checkbox label="push">推送</el-checkbox>
              </el-checkbox-group>
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="saveSettings">保存设置</el-button>
              <el-button>重置</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card>
          <template #header>
            <span>系统信息</span>
          </template>
          <div class="system-info">
            <div class="info-item">
              <span class="label">系统版本:</span>
              <span class="value">v1.0.0</span>
            </div>
            <div class="info-item">
              <span class="label">运行时间:</span>
              <span class="value">30 天 12 小时</span>
            </div>
            <div class="info-item">
              <span class="label">用户总数:</span>
              <span class="value">1,234</span>
            </div>
            <div class="info-item">
              <span class="label">设备总数:</span>
              <span class="value">567</span>
            </div>
            <div class="info-item">
              <span class="label">今日告警:</span>
              <span class="value">23</span>
            </div>
          </div>
        </el-card>

        <el-card style="margin-top: 20px;">
          <template #header>
            <span>快捷操作</span>
          </template>
          <div class="quick-actions">
            <el-button type="primary" plain style="width: 100%; margin-bottom: 10px;">系统备份</el-button>
            <el-button type="warning" plain style="width: 100%; margin-bottom: 10px;">清除缓存</el-button>
            <el-button type="danger" plain style="width: 100%;">重启服务</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'

const settings = ref({
  systemName: '健康管家',
  heartRateMin: 50,
  heartRateMax: 120,
  oxygenMin: 90,
  tempMin: 36.0,
  tempMax: 37.5,
  refreshInterval: 10,
  notifyMethods: ['sms', 'email']
})

const saveSettings = () => {
  ElMessage.success('设置已保存')
}
</script>

<style scoped>
.settings-page {
  padding: 20px 0;
}

.system-info {
  padding: 10px 0;
}

.info-item {
  display: flex;
  justify-content: space-between;
  padding: 12px 0;
  border-bottom: 1px solid #ebeef5;
}

.info-item:last-child {
  border-bottom: none;
}

.label {
  color: #909399;
}

.value {
  font-weight: bold;
  color: #303133;
}

.quick-actions {
  padding: 10px 0;
}
</style>