<template>
  <div class="dashboard">
    <!-- 头部 -->
    <header class="header">
      <h1>🏥 居家健康监护系统 - 数据大屏</h1>
      <div class="time">{{ currentTime }}</div>
    </header>

    <!-- 主要内容 -->
    <div class="content">
      <!-- 左侧：实时数据 -->
      <div class="panel left-panel">
        <div class="panel-title">实时数据</div>
        <div class="realtime-data">
          <div class="data-item heart">
            <div class="data-icon">💓</div>
            <div class="data-value">{{ realtimeData.heartRate }}</div>
            <div class="data-label">心率 (次/分)</div>
          </div>
          <div class="data-item oxygen">
            <div class="data-icon">🫧</div>
            <div class="data-value">{{ realtimeData.bloodOxygen }}%</div>
            <div class="data-label">血氧饱和度</div>
          </div>
          <div class="data-item temp">
            <div class="data-icon">🌡️</div>
            <div class="data-value">{{ realtimeData.temperature }}°C</div>
            <div class="data-label">体温</div>
          </div>
        </div>
      </div>

      <!-- 中间：趋势图 -->
      <div class="panel center-panel">
        <div class="panel-title">24 小时趋势</div>
        <div class="chart-container">
          <div class="chart-line">
            <div v-for="(point, i) in trendData" :key="i" class="line-point" :style="{ height: point + '%' }">
              <span class="point-value">{{ point }}%</span>
            </div>
          </div>
          <div class="time-labels">
            <span>00:00</span>
            <span>06:00</span>
            <span>12:00</span>
            <span>18:00</span>
            <span>24:00</span>
          </div>
        </div>
      </div>

      <!-- 右侧：统计信息 -->
      <div class="panel right-panel">
        <div class="panel-title">统计信息</div>
        <div class="stats">
          <div class="stat-item">
            <div class="stat-value">{{ stats.totalDevices }}</div>
            <div class="stat-label">在线设备</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ stats.todayTests }}</div>
            <div class="stat-label">今日检测</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ stats.alertCount }}</div>
            <div class="stat-label">异常告警</div>
          </div>
          <div class="stat-item">
            <div class="stat-value">{{ stats.healthRate }}%</div>
            <div class="stat-label">健康率</div>
          </div>
        </div>

        <!-- 告警列表 -->
        <div class="alerts-section">
          <div class="panel-title">最新告警</div>
          <div class="alert-list">
            <div v-for="alert in alerts" :key="alert.id" class="alert-item" :class="alert.level">
              <span class="alert-icon">{{ alert.level === 'danger' ? '⚠️' : '⚡' }}</span>
              <span class="alert-text">{{ alert.message }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 底部：热力图 -->
    <div class="heatmap-section">
      <div class="panel-title">24 小时健康状态热力图</div>
      <div class="heatmap">
        <div v-for="hour in 24" :key="hour" class="heatmap-cell" :style="{ backgroundColor: getHeatmapColor(hour) }">
          {{ hour }}时
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const currentTime = ref('')
const realtimeData = ref({
  heartRate: 72,
  bloodOxygen: 98,
  temperature: 36.5
})

const trendData = ref([98, 97, 96, 97, 98, 98, 99, 98, 97, 98, 98, 97, 98, 99, 98, 97, 98, 98, 97, 98, 98, 97, 98, 98])

const stats = ref({
  totalDevices: 12,
  todayTests: 156,
  alertCount: 3,
  healthRate: 94
})

const alerts = ref([
  { id: 1, level: 'danger', message: '设备 003 血氧偏低' },
  { id: 2, level: 'warning', message: '设备 007 心率异常' },
  { id: 3, level: 'danger', message: '设备 012 体温偏高' }
])

const updateTime = () => {
  const now = new Date()
  currentTime.value = now.toLocaleTimeString('zh-CN', { hour12: false })
}

const getHeatmapColor = (hour) => {
  const colors = [
    '#1a365d', '#1a365d', '#1a4066', '#1a456b', '#1a5075', '#1a6080',
    '#1a708b', '#1a8096', '#1a90a1', '#1aa0ac', '#1ab0b7', '#1ac0c2',
    '#1ad0cd', '#1ae0d8', '#1af0e3', '#20a080', '#30b090', '#40c0a0',
    '#50d0b0', '#60e0c0', '#70f0d0', '#60e0c0', '#40c0a0', '#30b090'
  ]
  return colors[hour - 1] || '#1a365d'
}

let timer = null

onMounted(() => {
  updateTime()
  timer = setInterval(updateTime, 1000)
})

onUnmounted(() => {
  if (timer) clearInterval(timer)
})
</script>

<style scoped>
.dashboard {
  min-height: 100vh;
  background: linear-gradient(135deg, #0a192f 0%, #1a294f 100%);
  padding: 20px;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  margin-bottom: 20px;
}

.header h1 {
  font-size: 28px;
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.time {
  font-size: 24px;
  font-weight: bold;
  color: #409EFF;
}

.content {
  display: grid;
  grid-template-columns: 1fr 2fr 1fr;
  gap: 20px;
  margin-bottom: 20px;
}

.panel {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  padding: 20px;
}

.panel-title {
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 20px;
  color: #fff;
  border-bottom: 2px solid #409EFF;
  padding-bottom: 10px;
}

.realtime-data {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.data-item {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 20px;
  text-align: center;
}

.data-icon {
  font-size: 32px;
  margin-bottom: 10px;
}

.data-value {
  font-size: 36px;
  font-weight: bold;
  color: #409EFF;
}

.data-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}

.chart-container {
  height: 300px;
  display: flex;
  flex-direction: column;
}

.chart-line {
  flex: 1;
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 4px;
  padding: 20px 0;
}

.line-point {
  flex: 1;
  background: linear-gradient(180deg, #409EFF 0%, #66b1ff 100%);
  border-radius: 4px 4px 0 0;
  min-height: 20px;
  position: relative;
  transition: height 0.3s ease;
}

.point-value {
  position: absolute;
  top: -25px;
  left: 50%;
  transform: translateX(-50%);
  font-size: 12px;
  color: #409EFF;
}

.time-labels {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
  color: #909399;
  font-size: 14px;
}

.stats {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
  margin-bottom: 20px;
}

.stat-item {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 20px;
  text-align: center;
}

.stat-value {
  font-size: 32px;
  font-weight: bold;
  color: #67c23a;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}

.alerts-section {
  margin-top: 20px;
}

.alert-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.alert-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
}

.alert-item.danger {
  border-left: 4px solid #f56c6c;
}

.alert-item.warning {
  border-left: 4px solid #e6a23c;
}

.alert-icon {
  font-size: 18px;
}

.alert-text {
  font-size: 14px;
  color: #e0e0e0;
}

.heatmap-section {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  padding: 20px;
}

.heatmap {
  display: grid;
  grid-template-columns: repeat(24, 1fr);
  gap: 4px;
  margin-top: 15px;
}

.heatmap-cell {
  aspect-ratio: 1;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  color: #fff;
  cursor: pointer;
  transition: transform 0.2s;
}

.heatmap-cell:hover {
  transform: scale(1.2);
}
</style>