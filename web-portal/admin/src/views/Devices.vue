<template>
  <div class="devices-page">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>设备列表</span>
          <div>
            <el-select v-model="deviceType" placeholder="设备类型" style="width: 150px; margin-right: 10px;">
              <el-option label="全部" value="" />
              <el-option label="心率监测器" value="heart" />
              <el-option label="血氧仪" value="oxygen" />
              <el-option label="体温计" value="temp" />
            </el-select>
            <el-button type="primary">添加设备</el-button>
          </div>
        </div>
      </template>

      <el-table :data="devices" style="width: 100%">
        <el-table-column prop="id" label="设备 ID" width="150" />
        <el-table-column prop="name" label="设备名称" width="150" />
        <el-table-column prop="type" label="类型" width="120">
          <template #default="{ row }">
            <el-tag>{{ row.typeName }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="user" label="绑定用户" width="120" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status ? 'success' : 'danger'">
              <span class="status-dot" :class="{ online: row.status }"></span>
              {{ row.status ? '在线' : '离线' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="battery" label="电量" width="100">
          <template #default="{ row }">
            <el-progress :percentage="row.battery" :stroke-width="10" />
          </template>
        </el-table-column>
        <el-table-column prop="lastActive" label="最后活跃" width="180" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small">详情</el-button>
            <el-button type="danger" size="small">解绑</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :total="50"
          :page-sizes="[10, 20, 50]"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const deviceType = ref('')

const devices = ref([
  { id: 'DEV001', name: '张三的心率表', type: 'heart', typeName: '心率监测器', user: '张三', status: true, battery: 85, lastActive: '2024-01-15 14:30:25' },
  { id: 'DEV002', name: '李四的血氧仪', type: 'oxygen', typeName: '血氧仪', user: '李四', status: true, battery: 62, lastActive: '2024-01-15 14:28:10' },
  { id: 'DEV003', name: '王五的体温计', type: 'temp', typeName: '体温计', user: '王五', status: false, battery: 15, lastActive: '2024-01-15 12:00:00' },
  { id: 'DEV004', name: '赵六的心率表', type: 'heart', typeName: '心率监测器', user: '赵六', status: true, battery: 92, lastActive: '2024-01-15 14:31:00' },
  { id: 'DEV005', name: '钱七的血氧仪', type: 'oxygen', typeName: '血氧仪', user: '钱七', status: true, battery: 78, lastActive: '2024-01-15 14:29:45' }
])
</script>

<style scoped>
.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}

.status-dot {
  display: inline-block;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #f56c6c;
  margin-right: 5px;
}

.status-dot.online {
  background: #67c23a;
}
</style>