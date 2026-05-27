import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    redirect: '/dashboard'
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('@/views/Dashboard.vue'),
    meta: { title: '仪表盘' }
  },
  {
    path: '/users',
    name: 'Users',
    component: () => import('@/views/Users.vue'),
    meta: { title: '用户管理' }
  },
  {
    path: '/devices',
    name: 'Devices',
    component: () => import('@/views/Devices.vue'),
    meta: { title: '设备管理' }
  },
  {
    path: '/settings',
    name: 'Settings',
    component: () => import('@/views/Settings.vue'),
    meta: { title: '系统配置' }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router