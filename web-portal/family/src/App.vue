<template>
  <el-container class="layout-container">
    <el-aside width="200px">
      <div class="logo">
        <h2>🏥 健康管家</h2>
      </div>
      <el-menu
        :default-active="$route.path"
        router
        background-color="#304156"
        text-color="#bfcbd9"
        active-text-color="#409EFF"
      >
        <el-menu-item index="/">
          <el-icon><DataLine /></el-icon>
          <span>健康概览</span>
        </el-menu-item>
        <el-menu-item index="/history">
          <el-icon><Histogram /></el-icon>
          <span>历史数据</span>
        </el-menu-item>
        <el-menu-item index="/alerts">
          <el-icon><Warning /></el-icon>
          <span>异常告警</span>
        </el-menu-item>
        <el-menu-item index="/call">
          <el-icon><VideoCamera /></el-icon>
          <span>远程通话</span>
        </el-menu-item>
        <el-menu-item index="/reports">
          <el-icon><Document /></el-icon>
          <span>健康报告</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header>
        <div class="header-content">
          <h3>{{ currentTitle }}</h3>
          <div class="user-info">
            <el-avatar :size="32" src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png" />
            <span class="username">家属用户</span>
          </div>
        </div>
      </el-header>
      <el-main>
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import { DataLine, Histogram, Warning, VideoCamera, Document } from '@element-plus/icons-vue'

const route = useRoute()

const currentTitle = computed(() => route.meta.title || '健康管家')
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#app {
  font-family: 'Helvetica Neue', Helvetica, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.layout-container {
  height: 100vh;
}

.el-aside {
  background-color: #304156;
  color: #fff;
}

.logo {
  padding: 20px;
  text-align: center;
  border-bottom: 1px solid #465868;
}

.logo h2 {
  color: #fff;
  font-size: 18px;
}

.el-header {
  background-color: #fff;
  border-bottom: 1px solid #e4e7ed;
  padding: 0 20px;
  display: flex;
  align-items: center;
}

.header-content {
  display: flex;
  justify-content: space-between;
  width: 100%;
  align-items: center;
}

.header-content h3 {
  font-size: 18px;
  color: #303133;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.username {
  color: #606266;
}

.el-main {
  background-color: #f0f2f5;
  padding: 20px;
}
</style>