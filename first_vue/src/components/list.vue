<template>
  <div class="aa">
    <heaad></heaad>
    <el-alert
    :title="xinxi"
    :type="type1"
    v-show="xian"
    center
    show-icon>
  </el-alert>
    <div class="list_md kuang"><img src="../assets/正在抢购.png" alt="" /></div>
    <div class="clearfix kuang">
      <keep-alive>
        <router-view></router-view>
      </keep-alive>
    </div>
    <fuwu class="kuang"></fuwu>
    <foot class="kuang"></foot>
    <div :class="{ task: istrue }"></div>
  </div>
</template>

<script>
import heaad from "./heaad.vue";
import fuwu from "./fuwu.vue";
import foot from "./foot.vue";
export default {
  name: "",
  data() {
    return {
      type1:'success',
      istrue: false,
        xian:0,
        xinxi:''
    };
  },
  methods: {},
  components: {
    foot,
    fuwu,
    heaad,
  },
  computed: {},
  watch: {},
  created() {},
  mounted() {
    this.$bus.$on("task", (data) => {
      this.istrue = data;
    });
    this.$bus.$on("xian", (data) => {
      this.xian = data.xian;
      this.xinxi = data.xinxi
      this.type1=data.type
      setTimeout(()=>{
        this.xian=0
        this.xianxi=''
        this.type1='success'
      },1500)
    });
  },
};
</script>

<style scoped>
.el-alert{
  position: fixed;
  top: 0px;
}
.kuang{
  width: 1200px;
  margin: 0 auto;
}
.aa{
  position: relative;
  height: 100%;
  width: 100%;
}
.task {
  width: 100%;
  position: absolute;
  height: 100%;
  top: 0;
  bottom: 0;
  left: 0;
  background-color: rgba(0, 0, 0, 0.4);
  z-index: 1;
}
.clearfix:before,
.clearfix:after {
  content: "";
  display: table;
}
.clearfix:after {
  clear: both;
}
.clearfix {
  *zoom: 1;
}
</style>
