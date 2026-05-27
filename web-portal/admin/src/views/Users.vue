<template>
  <div class="users-page">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>用户列表</span>
          <div>
            <el-input v-model="searchKeyword" placeholder="搜索用户名/手机号" style="width: 200px; margin-right: 10px;" />
            <el-button type="primary">添加用户</el-button>
          </div>
        </div>
      </template>

      <el-table :data="users" style="width: 100%">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="name" label="用户名" width="120" />
        <el-table-column prop="phone" label="手机号" width="130" />
        <el-table-column prop="email" label="邮箱" width="180" />
        <el-table-column prop="role" label="角色" width="100">
          <template #default="{ row }">
            <el-tag :type="row.role === '管理员' ? 'success' : 'primary'">{{ row.role }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status ? 'success' : 'danger'">{{ row.status ? '正常' : '禁用' }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small">编辑</el-button>
            <el-button type="danger" size="small">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination">
        <el-pagination
          background
          layout="total, sizes, prev, pager, next, jumper"
          :total="100"
          :page-sizes="[10, 20, 50, 100]"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const searchKeyword = ref('')

const users = ref([
  { id: 1, name: '张三', phone: '13800138001', email: 'zhangsan@example.com', role: '用户', status: true, createTime: '2024-01-10 10:30' },
  { id: 2, name: '李四', phone: '13800138002', email: 'lisi@example.com', role: '用户', status: true, createTime: '2024-01-11 11:20' },
  { id: 3, name: '王五', phone: '13800138003', email: 'wangwu@example.com', role: '管理员', status: true, createTime: '2024-01-12 14:15' },
  { id: 4, name: '赵六', phone: '13800138004', email: 'zhaoliu@example.com', role: '用户', status: false, createTime: '2024-01-13 09:45' },
  { id: 5, name: '钱七', phone: '13800138005', email: 'qianqi@example.com', role: '用户', status: true, createTime: '2024-01-14 16:30' }
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
</style>