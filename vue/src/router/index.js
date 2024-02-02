import Vue from 'vue'
import VueRouter from 'vue-router'
import Layout from '../views/Layout.vue'
import Home from "@/views/Home";
import User from "@/views/User";
import Login from "@/views/Login";
import Book from "@/views/Book";
import Type from "@/views/Type";
import Audit from "@/views/Audit";
import Hotel from "@/views/Hotel";
import Reserve from "@/views/Reserve";
import LogView from "@/views/LogView";
import Notice from "@/views/Notice";
import Echarts from "@/views/Echarts";


Vue.use(VueRouter)

const routes = [
    {
        path: '/login',
        name: 'login',
        component: Login,
    },
    {
        path: '/',
        name: 'layout',
        component: Layout,
        children: [
            {
                path: 'home',
                name: 'home',
                meta: {name: '系统首页'},
                component: Home
            },
            {
                path: 'user',
                name: 'user',
                meta: {name: '用户管理'},
                component: User
            },
            {
                path: 'book',
                name: 'book',
                meta: {name: '图书管理'},
                component: Book
            },
            {
                path: 'type',
                name: 'type',
                meta: {name: '图书分类'},
                component: Type
            },
            {
                path: 'audit',
                name: 'audit',
                meta: {name: '提交审核'},
                component: Audit
            },
            {
                path: 'hotel',
                name: 'hotel',
                meta: {name: '酒店管理'},
                component: Hotel
            },
            {
                path: 'reserve',
                name: 'reserve',
                meta: {name: '预订信息'},
                component: Reserve
            },
            {
                path: 'log',
                name: 'log',
                meta: {name: '日志管理'},
                component: LogView
            },
            {
                path: 'notice',
                name: 'notice',
                meta: {name: '公告管理'},
                component: Notice
            },
            {
                path: 'echarts',
                name: 'echarts',
                meta: {name: 'Echarts图表'},
                component: Echarts
            }
        ]
    },

]

const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
    if (to.path === '/login') {
        next();
    }
    const user = localStorage.getItem("user");
    if (!user && to.path !== '/login') {
        return next("/login");
    }
    next();
})

export default router
// 解决重复路由跳转问题
const originalPush = VueRouter.prototype.push

VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}