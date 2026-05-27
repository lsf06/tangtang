import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Dashboard',
    component: () => import('@/views/Dashboard.vue'),
    meta: { title: '健康概览' }
  },
  {
    path: '/history',
    name: 'History',
    component: () => import('@/views/History.vue'),
    meta: { title: '历史数据' }
  },
  {
    path: '/alerts',
    name: 'Alerts',
    component: () => import('@/views/Alerts.vue'),
    meta: { title: '异常告警' }
  },
  {
    path: '/call',
    name: 'Call',
    component: () => import('@/views/Call.vue'),
    meta: { title: '远程通话' }
  },
  {
    path: '/reports',
    name: 'Reports',
    component: () => import('@/views/Reports.vue'),
    meta: { title: '健康报告' }
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router