<template>
  <div class="alerts">
    <el-card>
      <template #header>
        <span>异常告警记录</span>
      </template>
      <el-timeline>
        <el-timeline-item
          v-for="alert in alerts"
          :key="alert.id"
          :timestamp="alert.time"
          placement="top"
          :type="alert.type"
        >
          <el-card>
            <p><strong>{{ alert.title }}</strong></p>
            <p>{{ alert.description }}</p>
            <el-button size="small" type="primary" @click="handleCall(alert)">一键呼叫</el-button>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'

const alerts = ref([
  { id: 1, type: 'danger', time: '2024-01-15 18:00', title: '血氧偏低预警', description: '检测到血氧饱和度降至 92%，低于正常范围' },
  { id: 2, type: 'warning', time: '2024-01-15 12:30', title: '心率异常', description: '检测到心率上升至 110 次/分' },
  { id: 3, type: 'danger', time: '2024-01-14 22:15', title: '体温异常', description: '检测到体温升至 37.8°C' }
])

const handleCall = (alert) => {
  ElMessage.info('正在呼叫家属...')
}
</script>

<style scoped>
.alerts {
  padding: 10px;
}
</style>