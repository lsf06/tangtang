<template>
  <div class="dashboard">
    <!-- 实时数据卡片 -->
    <el-row :gutter="20" class="metric-cards">
      <el-col :span="8">
        <el-card class="metric-card heart">
          <template #header>
            <div class="card-header">
              <span>💓 心率</span>
              <el-tag :type="heartStatus" size="small">{{ heartLabel }}</el-tag>
            </div>
          </template>
          <div class="metric-value">{{ healthData.heartRate }} <span class="unit">次/分</span></div>
          <div class="metric-trend">
            <el-icon :class="heartTrend > 0 ? 'up' : 'down'"><CaretTop v-if="heartTrend > 0" /><CaretBottom v-else /></el-icon>
            <span>{{ Math.abs(heartTrend) }}% 较上次</span>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="metric-card oxygen">
          <template #header>
            <div class="card-header">
              <span>🫧 血氧</span>
              <el-tag :type="oxygenStatus" size="small">{{ oxygenLabel }}</el-tag>
            </div>
          </template>
          <div class="metric-value">{{ healthData.bloodOxygen }} <span class="unit">%</span></div>
          <div class="metric-trend">
            <el-icon :class="oxygenTrend > 0 ? 'up' : 'down'"><CaretTop v-if="oxygenTrend > 0" /><CaretBottom v-else /></el-icon>
            <span>{{ Math.abs(oxygenTrend) }}% 较上次</span>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="metric-card temp">
          <template #header>
            <div class="card-header">
              <span>🌡️ 体温</span>
              <el-tag :type="tempStatus" size="small">{{ tempLabel }}</el-tag>
            </div>
          </template>
          <div class="metric-value">{{ healthData.temperature }} <span class="unit">°C</span></div>
          <div class="metric-trend">
            <el-icon :class="tempTrend > 0 ? 'up' : 'down'"><CaretTop v-if="tempTrend > 0" /><CaretBottom v-else /></el-icon>
            <span>{{ Math.abs(tempTrend) }}% 较上次</span>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 健康状态总览 -->
    <el-row :gutter="20">
      <el-col :span="16">
        <el-card class="status-card">
          <template #header>
            <div class="card-header">
              <span>健康状态总览</span>
              <el-button type="primary" size="small" @click="refreshData">刷新数据</el-button>
            </div>
          </template>
          <div class="status-display">
            <div class="status-badge" :class="healthData.status">
              <el-icon><Check v-if="healthData.status === 'normal'" /><Warning v-else /></el-icon>
              <span>{{ statusText }}</span>
            </div>
            <p class="status-desc">{{ statusDescription }}</p>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card class="info-card">
          <template #header>
            <span>设备信息</span>
          </template>
          <el-descriptions :column="1" size="small">
            <el-descriptions-item label="设备 ID">HG-2024001</el-descriptions-item>
            <el-descriptions-item label="在线状态">
              <el-tag type="success" size="small">在线</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="最后同步">{{ healthData.lastCheck }}</el-descriptions-item>
            <el-descriptions-item label="今日检测">{{ healthData.todayCount }} 次</el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>
    </el-row>

    <!-- 7 天趋势图 -->
    <el-card class="trend-card">
      <template #header>
        <span>近 7 天血氧趋势</span>
      </template>
      <div class="trend-chart">
        <div class="chart-bars">
          <div v-for="(val, i) in healthData.trend" :key="i" class="bar-wrapper">
            <div class="bar" :style="{ height: (val / 100 * 100) + '%' }"></div>
            <span class="bar-label">{{ days[i] }}</span>
            <span class="bar-value">{{ val }}%</span>
          </div>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { computed, ref } from 'vue'
import { Check, Warning, CaretTop, CaretBottom } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const days = ['周一', '周二', '周三', '周四', '周五', '周六', '周日']

const healthData = ref({
  heartRate: 72,
  bloodOxygen: 98,
  temperature: 36.5,
  status: 'normal',
  lastCheck: '2024-01-15 14:30',
  todayCount: 5,
  trend: [98, 97, 98, 99, 98, 97, 98]
})

const heartStatus = computed(() => {
  const val = healthData.value.heartRate
  if (val >= 60 && val <= 100) return 'success'
  if (val >= 50 || val <= 120) return 'warning'
  return 'danger'
})

const heartLabel = computed(() => {
  const val = healthData.value.heartRate
  if (val >= 60 && val <= 100) return '正常'
  return '异常'
})

const heartTrend = ref(2)

const oxygenStatus = computed(() => {
  const val = healthData.value.bloodOxygen
  if (val >= 95) return 'success'
  if (val >= 90) return 'warning'
  return 'danger'
})

const oxygenLabel = computed(() => {
  const val = healthData.value.bloodOxygen
  if (val >= 95) return '正常'
  return '偏低'
})

const oxygenTrend = ref(-1)

const tempStatus = computed(() => {
  const val = healthData.value.temperature
  if (val >= 36 && val <= 37.2) return 'success'
  if (val >= 35.5 || val <= 38) return 'warning'
  return 'danger'
})

const tempLabel = computed(() => {
  const val = healthData.value.temperature
  if (val >= 36 && val <= 37.2) return '正常'
  return '异常'
})

const tempTrend = ref(0)

const statusText = computed(() => {
  if (healthData.value.status === 'normal') return '状态正常'
  if (healthData.value.status === 'warning') return '需要注意'
  return '异常预警'
})

const statusDescription = computed(() => {
  if (healthData.value.status === 'normal') return '各项指标均在正常范围内，请继续保持健康的生活方式。'
  if (healthData.value.status === 'warning') return '部分指标略有异常，建议适当休息并观察变化。'
  return '检测到异常指标，请及时联系医生或家属。'
})

const refreshData = () => {
  ElMessage.success('数据已刷新')
  // 实际实现：调用 API 获取最新数据
}
</script>

<style scoped>
.dashboard {
  padding: 10px;
}

.metric-cards {
  margin-bottom: 20px;
}

.metric-card {
  margin-bottom: 10px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.metric-value {
  font-size: 32px;
  font-weight: bold;
  color: #303133;
  margin: 15px 0;
}

.metric-value .unit {
  font-size: 14px;
  color: #909399;
  margin-left: 5px;
}

.metric-trend {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 14px;
  color: #909399;
}

.metric-trend .up {
  color: #f56c6c;
}

.metric-trend .down {
  color: #67c23a;
}

.status-card {
  margin-bottom: 20px;
}

.status-display {
  text-align: center;
  padding: 30px;
}

.status-badge {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 15px 40px;
  border-radius: 50px;
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 20px;
}

.status-badge.normal {
  background: #f0f9eb;
  color: #67c23a;
}

.status-badge.warning {
  background: #fdf6ec;
  color: #e6a23c;
}

.status-badge.danger {
  background: #fef0f0;
  color: #f56c6c;
}

.status-desc {
  color: #606266;
  font-size: 16px;
}

.info-card {
  margin-bottom: 20px;
}

.trend-card {
  margin-bottom: 20px;
}

.trend-chart {
  padding: 20px 0;
}

.chart-bars {
  display: flex;
  justify-content: space-around;
  align-items: flex-end;
  height: 180px;
  gap: 10px;
}

.bar-wrapper {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  max-width: 60px;
}

.bar {
  width: 100%;
  background: linear-gradient(180deg, #409EFF 0%, #66b1ff 100%);
  border-radius: 8px 8px 0 0;
  min-height: 20px;
  transition: height 0.3s ease;
}

.bar-label {
  margin-top: 10px;
  font-size: 14px;
  color: #909399;
}

.bar-value {
  font-size: 12px;
  color: #409EFF;
  font-weight: bold;
}
</style>