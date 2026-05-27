<template>
  <div class="call">
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card>
          <template #header>
            <span>发起通话</span>
          </template>
          <div class="call-info">
            <p><strong>患者姓名：</strong>张大爷</p>
            <p><strong>设备状态：</strong><el-tag type="success">在线</el-tag></p>
            <p><strong>最后通话：</strong>2024-01-15 10:30</p>
          </div>
          <el-button type="primary" size="large" @click="startCall" style="margin-top: 20px; width: 100%">
            <el-icon><VideoCamera /></el-icon> 发起视频通话
          </el-button>
          <el-button size="large" @click="startAudioCall" style="margin-top: 10px; width: 100%">
            <el-icon><Phone /></el-icon> 发起语音通话
          </el-button>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <template #header>
            <span>通话记录</span>
          </template>
          <el-table :data="callHistory" size="small">
            <el-table-column prop="date" label="日期" width="100" />
            <el-table-column prop="time" label="时间" width="80" />
            <el-table-column prop="duration" label="时长" width="80" />
            <el-table-column prop="type" label="类型">
              <template #default="{ row }">
                <el-tag :type="row.type === 'video' ? 'primary' : 'success'" size="small">
                  {{ row.type === 'video' ? '视频' : '语音' }}
                </el-tag>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { VideoCamera, Phone } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const callHistory = ref([
  { date: '01-15', time: '10:30', duration: '5:23', type: 'video' },
  { date: '01-14', time: '20:00', duration: '3:45', type: 'audio' },
  { date: '01-13', time: '18:30', duration: '8:12', type: 'video' }
])

const startCall = () => {
  ElMessage.info('正在发起视频通话...')
}

const startAudioCall = () => {
  ElMessage.info('正在发起语音通话...')
}
</script>

<style scoped>
.call {
  padding: 10px;
}

.call-info {
  padding: 20px 0;
}

.call-info p {
  margin-bottom: 10px;
}
</style>