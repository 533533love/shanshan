<template>
  <el-col :span="12">
    <h5>欢迎登陆 {{user}}</h5>
    <el-menu
      default-active="2"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b"
    >
      <el-submenu index="1">
        <template slot="title">
          <i class="el-icon-location"></i>
          <span>授权码管理</span>
        </template>
        <el-menu-item-group>
          <el-menu-item index="1-1" @click="huoqu">
           获取授权码
          </el-menu-item>
          <el-menu-item index="1-2"
            @click="cha">授权码管理</el-menu-item
          >
        </el-menu-item-group>
      </el-submenu>
      <el-submenu index="2">
        <template slot="title">
          <i class="el-icon-location"></i>
          <span>商品管理</span>
        </template>
        <el-menu-item-group>
          <el-menu-item index="2-1" @click="add">添加商品</el-menu-item>
          <el-menu-item index="2-2" @click="edit">商品管理</el-menu-item>
        </el-menu-item-group>
      </el-submenu>
      <el-submenu index="3">
        <template slot="title">
          <i class="el-icon-location"></i>
          <span>订单管理</span>
        </template>
        <el-menu-item-group>
          <el-menu-item index="3-1">订单查询</el-menu-item>
          <el-menu-item index="3-2" @click="editorder">修改订单</el-menu-item>
        </el-menu-item-group>
      </el-submenu>
      <el-submenu index="4">
        <template slot="title">
          <i class="el-icon-location"></i>
          <span>用户管理</span>
        </template>
        <el-menu-item-group>
          <el-menu-item index="4-1">用户管理</el-menu-item>
          <el-menu-item index="4-2">活动授权</el-menu-item>
        </el-menu-item-group>
      </el-submenu>
    </el-menu>
  </el-col>
</template>

<script>
import { Alert } from 'element-ui';
export default {
  name: "",
  data() {
    return {
      user:sessionStorage.getItem('user_name')
    };
  },
  methods: {
    handleOpen(key, keyPath) {
      console.log(key, keyPath);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    },
    huoqu(){
      if(sessionStorage.getItem('user_name')=='admin'){
        this.$router.push({
					path:'/index/huoqu'
				})
      }else{
        alert('对不起，您无访问权限')
      }
      
    },
    cha(){
       this.$router.push({
					path:'/index/chabiao'
				})
    },add(){
       this.$router.push({
					path:'/index/add'
				})
    },
    edit(){
       this.$router.push({
					path:'/index/edit'
       })
    },editorder(){
      this.$router.push({
        path:'/index/editorder'
      })
    }
  },
  components: {},
  computed: {},
  watch: {},
  created() {},
  mounted() {},
};
</script>

<style scoped>
.el-submenu {
  width: 200px;
}
.el-menu-item a {
  width: 100%;
  height: 100%;
}

</style>
