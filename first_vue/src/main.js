import Vue from 'vue'
import App from './App'
import ElementUi from 'element-ui'
//引入VueRouter
import VueRouter from 'vue-router'
//引入路由器
import router from './router'
import axios from "axios"
import withUUID from "vue-uuid";
import moment from 'moment'
Vue.prototype.$moment = moment
Vue.use(withUUID);
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(VueRouter)
Vue.prototype.$axios=axios
//内网 thinkphp接口地址
Vue.prototype.$imgurl='http://www.lycwssapi.com:8081/'
Vue.prototype.$axios.defaults.baseURL = "http://www.lycwssapi.com:8081/"
//外网
// Vue.prototype.$imgurl='http://lycwss.free.idcfengye.com/public/'`
// Vue.prototype.$axios.defaults.baseURL = "http://lycwss.free.idcfengye.com/public/"
Vue.config.productionTip = false
Vue.use(ElementUi)
new Vue({
  el:'#app',
  render: h => h(App),
  router,
  beforeCreate() {
		Vue.prototype.$bus = this //安装全局事件总线
	},
})