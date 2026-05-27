<template>
  <div class="dashboard">
    <!-- 统计卡片 -->
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon user">👥</div>
            <div class="stat-info">
              <div class="stat-value">1,234</div>
              <div class="stat-label">总用户数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon device">📱</div>
            <div class="stat-info">
              <div class="stat-value">567</div>
              <div class="stat-label">在线设备</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon alert">⚠️</div>
            <div class="stat-info">
              <div class="stat-value">23</div>
              <div class="stat-label">今日告警</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card class="stat-card">
          <div class="stat-content">
            <div class="stat-icon health">💚</div>
            <div class="stat-info">
              <div class="stat-value">96.5%</div>
              <div class="stat-label">健康率</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 图表区域 -->
    <el-row :gutter="20" class="chart-row">
      <el-col :span="16">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>用户增长趋势</span>
            </div>
          </template>
          <div class="chart-placeholder">
            <div class="chart-line">
              <div v-for="(point, i) in userTrend" :key="i" class="line-bar" :style="{ height: point + '%' }"></div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card>
          <template #header>
            <div class="card-header">
              <span>设备类型分布</span>
            </div>
          </template>
          <div class="pie-chart">
            <div class="pie-item">
              <div class="pie-color heart"></div>
              <span>心率监测器 (45%)</span>
            </div>
            <div class="pie-item">
              <div class="pie-color oxygen"></div>
              <span>血氧仪 (30%)</span>
            </div>
            <div class="pie-item">
              <div class="pie-color temp"></div>
              <span>体温计 (15%)</span>
            </div>
            <div class="pie-item">
              <div class="pie-color other"></div>
              <span>其他 (10%)</span>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 最新告警 -->
    <el-card>
      <template #header>
        <div class="card-header">
          <span>最新告警</span>
          <el-button type="primary" size="small">查看全部</el-button>
        </div>
      </template>
      <el-table :data="alerts" style="width: 100%">
        <el-table-column prop="time" label="时间" width="180" />
        <el-table-column prop="device" label="设备" width="150" />
        <el-table-column prop="user" label="用户" width="120" />
        <el-table-column prop="message" label="告警内容" />
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === '处理' ? 'success' : 'danger'">{{ row.status }}</el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const userTrend = ref([30, 45, 55, 60, 75, 80, 85, 90, 75, 80, 90, 95])

const alerts = ref([
  { time: '2024-01-15 14:30', device: '设备 001', user: '张三', message: '心率异常 (120 次/分)', status: '未处理' },
  { time: '2024-01-15 14:25', device: '设备 002', user: '李四', message: '血氧偏低 (88%)', status: '处理' },
  { time: '2024-01-15 14:20', device: '设备 003', user: '王五', message: '体温偏高 (38.5°C)', status: '未处理' },
  { time: '2024-01-15 14:15', device: '设备 004', user: '赵六', message: '设备离线', status: '处理' }
])
</script>

<style scoped>
.dashboard {
  padding: 20px 0;
}

.stat-card {
  margin-bottom: 20px;
}

.stat-content {
  display: flex;
  align-items: center;
  gap: 15px;
}

.stat-icon {
  font-size: 40px;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(64, 158, 255, 0.1);
  border-radius: 12px;
}

.stat-icon.user { background: rgba(64, 158, 255, 0.1); }
.stat-icon.device { background: rgba(103, 194, 58, 0.1); }
.stat-icon.alert { background: rgba(245, 108, 108, 0.1); }
.stat-icon.health { background: rgba(103, 194, 58, 0.1); }

.stat-info {
  flex: 1;
}

.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}

.chart-row {
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.chart-placeholder {
  height: 200px;
  display: flex;
  align-items: flex-end;
  justify-content: space-around;
  padding: 20px 0;
}

.chart-line {
  display: flex;
  align-items: flex-end;
  gap: 10px;
  width: 100%;
  height: 100%;
}

.line-bar {
  flex: 1;
  background: linear-gradient(180deg, #409EFF 0%, #66b1ff 100%);
  border-radius: 4px 4px 0 0;
  min-height: 20px;
  transition: height 0.3s ease;
}

.pie-chart {
  padding: 20px 0;
}

.pie-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 0;
}

.pie-color {
  width: 20px;
  height: 20px;
  border-radius: 4px;
}

.pie-color.heart { background: #409EFF; }
.pie-color.oxygen { background: #67c23a; }
.pie-color.temp { background: #e6a23c; }
.pie-color.other { background: #909399; }
</style>