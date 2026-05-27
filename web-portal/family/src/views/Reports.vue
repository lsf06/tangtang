<template>
  <div class="reports">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>健康报告</span>
          <el-button type="primary" @click="exportReport">
            <el-icon><Download /></el-icon> 导出 PDF
          </el-button>
        </div>
      </template>
      <el-tabs v-model="activeTab">
        <el-tab-pane label="周报告" name="week">
          <div class="report-content">
            <h4>本周健康总结</h4>
            <el-descriptions :column="2" border>
              <el-descriptions-item label="检测次数">35 次</el-descriptions-item>
              <el-descriptions-item label="平均心率">71 次/分</el-descriptions-item>
              <el-descriptions-item label="平均血氧">97.5%</el-descriptions-item>
              <el-descriptions-item label="平均体温">36.5°C</el-descriptions-item>
              <el-descriptions-item label="异常次数">2 次</el-descriptions-item>
              <el-descriptions-item label="健康评分">88 分</el-descriptions-item>
            </el-descriptions>
            <p class="advice">健康建议：本周整体健康状况良好，建议继续保持规律作息。</p>
          </div>
        </el-tab-pane>
        <el-tab-pane label="月报告" name="month">
          <div class="report-content">
            <h4>本月健康总结</h4>
            <el-descriptions :column="2" border>
              <el-descriptions-item label="检测次数">150 次</el-descriptions-item>
              <el-descriptions-item label="平均心率">72 次/分</el-descriptions-item>
              <el-descriptions-item label="平均血氧">97.2%</el-descriptions-item>
              <el-descriptions-item label="平均体温">36.6°C</el-descriptions-item>
              <el-descriptions-item label="异常次数">8 次</el-descriptions-item>
              <el-descriptions-item label="健康评分">85 分</el-descriptions-item>
            </el-descriptions>
            <p class="advice">健康建议：本月健康状况稳定，建议加强运动，注意饮食健康。</p>
          </div>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Download } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const activeTab = ref('week')

const exportReport = () => {
  ElMessage.success('报告导出中...')
}
</script>

<style scoped>
.reports {
  padding: 10px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.report-content {
  padding: 20px;
}

.report-content h4 {
  margin-bottom: 20px;
  color: #303133;
}

.advice {
  margin-top: 20px;
  padding: 15px;
  background: #f0f9eb;
  border-radius: 8px;
  color: #67c23a;
}
</style>