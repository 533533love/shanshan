// 该文件专门用于创建整个应用的路由器
import VueRouter from 'vue-router'
//引入组件
import huoqu from '../pages/huoqu'
import chabiao from '../pages/chabiao'
// import Home from '../components/Home'
import index from '../pages/index'
import shopping from '../pages/shopping'
import tijiao from '../pages/tijiao'

import userinfo from '../pages/userinfo'
import editgoods from '../pages/editgoods'
import addgoods from '../pages/addgoods'
import login from '../components/login'
import uslogin from '../components/uslogin'
import register from '../pages/register'
import detail from '../pages/detail'
import usregister from '../pages/usregister'
import list from '../components/list'
import oddetail from '../pages/oddetail'
import goods from '../components/goods'
import text from '../components/text'
import order from '../pages/order'
import editorder from '../pages/editorder'

//创建并暴露一个路由器
const router = new VueRouter({
	routes: [
		{
			path: '/index',
			component: index,
			meta: { isAuth: true, title: '管理员主页' },
			children: [
				{
					path: 'huoqu',
					component: huoqu,
					meta: { isAuth: true, title: '添加授权码' },
				}, {
					path: 'chabiao',
					component: chabiao,
					meta: { isAuth: true, title: '授权码管理' },
				}, {
					path: 'add',
					component: addgoods,
					meta: { isAuth: true, title: '添加商品' },
				}, {
					path: 'edit',
					component: editgoods,
					meta: { isAuth: true, title: '商品管理' },
				},{
					path: 'editorder',
					component: editorder,
					meta: { isAuth: true, title: '订单管理' },
				},
			]
		},
		{
			path: '/login',
			component: login,
			meta: { title: '管理员登陆' },
		},
		{
			path: '/text',
			component: text,
			meta: { title: '测试' },
		},
		{
			path: '/register',
			component: register,
			meta: { title: '管理员注册' },
		},
		{
			path: '/uslogin',
			component: uslogin,

			meta: { title: '用户登陆' },

		},
		{
			path: '/usregister',
			component: usregister,
			meta: { title: '用户注册' },
		},
		{
			path: '/',
			component: list,
			meta: { title: '品优购-购物中心', Auth: true },
			children: [
				{
					path: '',
					component: goods,
					meta: { title: '商品列表' },
				},{
					path: 'xiangqing',
					component: oddetail,
					meta: { title: '订单详情', Auth: true }
				}, {
					path: 'shopping',
					component: shopping,
					meta: { title: '购物车' }
				}, {
					path: 'detail',
					component: detail,
					meta: { title: '产品信息' }
				}, {
					path: 'tijiao',
					component: tijiao,
					meta: { title: '提交订单', Auth: true }
				}, {
					path: 'order',
					component: order,
					meta: { title: '订单管理', Auth: true }
				}, {
					path: '/userinfo',
					component: userinfo,
					meta: { title: '个人中心', Auth: true }
				}
			]
		}
	]
})
router.beforeEach((to, from, next) => {
	if (to.meta.isAuth) {
		if (sessionStorage.getItem('user_name')) {
			next()
		} else {
			alert('先生女士，请先请登陆再操作哦')
			next('./login')

		}
	} else if (to.meta.Auth) {
		if (sessionStorage.getItem('username')) {
			next()
		} else {
			alert('请先请登陆再操作哦')
			next('./uslogin')
		}
	} else {
		next()
	}
})
router.afterEach((to, from) => {
	document.title = to.meta.title
})
export default router