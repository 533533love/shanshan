<template>
  <el-container>
    <el-header><hed></hed></el-header>
    <el-container>
      <el-aside width="200px"><left></left></el-aside>
      <el-container>
        <el-main><router-view></router-view></el-main>
      </el-container>
    </el-container>
  </el-container>
</template>

<script>
import hed from "./hed.vue";
import left from './left.vue';

export default {
  name: "index",
  components: {
    hed,
    left,
  },
  methods:{
   
  }
};
</script>
<style scoped>
.el-header {
  padding: 0;
  background-color: rgb(172, 165, 165);
}
</style>
