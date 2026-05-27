<template>
  <div class="history">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>历史数据查询</span>
          <el-date-picker
            v-model="selectedDate"
            type="date"
            placeholder="选择日期"
            @change="loadData"
          />
        </div>
      </template>
      <el-table :data="tableData" stripe style="width: 100%">
        <el-table-column prop="time" label="检测时间" width="180" />
        <el-table-column prop="heartRate" label="心率 (次/分)" />
        <el-table-column prop="bloodOxygen" label="血氧 (%)" />
        <el-table-column prop="temperature" label="体温 (°C)" />
        <el-table-column prop="status" label="状态">
          <template #default="{ row }">
            <el-tag :type="row.status === 'normal' ? 'success' : 'danger'">
              {{ row.status === 'normal' ? '正常' : '异常' }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const selectedDate = ref(new Date())

const tableData = [
  { time: '14:30', heartRate: 72, bloodOxygen: 98, temperature: 36.5, status: 'normal' },
  { time: '10:15', heartRate: 68, bloodOxygen: 97, temperature: 36.4, status: 'normal' },
  { time: '08:00', heartRate: 75, bloodOxygen: 98, temperature: 36.6, status: 'normal' },
  { time: '20:30', heartRate: 70, bloodOxygen: 96, temperature: 36.5, status: 'normal' },
  { time: '18:00', heartRate: 85, bloodOxygen: 95, temperature: 36.8, status: 'warning' }
]

const loadData = () => {
  // 实际实现：调用 API 加载选定日期的数据
}
</script>

<style scoped>
.history {
  padding: 10px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>