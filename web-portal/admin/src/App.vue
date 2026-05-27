<template>
  <div class="admin-layout">
    <!-- 侧边栏 -->
    <aside class="sidebar">
      <div class="logo">
        <h2>🏥 健康管家</h2>
      </div>
      <el-menu
        :default-active="activeMenu"
        router
        background-color="#0a192f"
        text-color="#909399"
        active-text-color="#409EFF"
      >
        <el-menu-item index="/dashboard">
          <el-icon><Odometer /></el-icon>
          <span>仪表盘</span>
        </el-menu-item>
        <el-menu-item index="/users">
          <el-icon><User /></el-icon>
          <span>用户管理</span>
        </el-menu-item>
        <el-menu-item index="/devices">
          <el-icon><Cpu /></el-icon>
          <span>设备管理</span>
        </el-menu-item>
        <el-menu-item index="/settings">
          <el-icon><Setting /></el-icon>
          <span>系统配置</span>
        </el-menu-item>
      </el-menu>
    </aside>

    <!-- 主内容区 -->
    <div class="main-content">
      <!-- 头部 -->
      <header class="header">
        <div class="header-left">
          <h1>{{ currentTitle }}</h1>
        </div>
        <div class="header-right">
          <el-dropdown>
            <span class="user-info">
              <el-icon><User /></el-icon>
              <span>管理员</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item>个人中心</el-dropdown-item>
                <el-dropdown-item divided>退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </header>

      <!-- 页面内容 -->
      <main class="page-content">
        <router-view />
      </main>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { Odometer, User, Cpu, Setting } from '@element-plus/icons-vue'

const route = useRoute()

const activeMenu = computed(() => route.path)

const currentTitle = computed(() => route.meta.title || '首页')
</script>

<style scoped>
.admin-layout {
  display: flex;
  min-height: 100vh;
  background: #f5f7fa;
}

.sidebar {
  width: 240px;
  background: #0a192f;
  position: fixed;
  height: 100vh;
  overflow-y: auto;
}

.logo {
  padding: 20px;
  text-align: center;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.logo h2 {
  color: #fff;
  margin: 0;
}

:deep(.el-menu) {
  border-right: none;
}

.main-content {
  flex: 1;
  margin-left: 240px;
  display: flex;
  flex-direction: column;
}

.header {
  height: 60px;
  background: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.header-left h1 {
  font-size: 20px;
  color: #303133;
  margin: 0;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  color: #606266;
}

.page-content {
  flex: 1;
  padding: 20px;
  background: #f5f7fa;
}
</style>