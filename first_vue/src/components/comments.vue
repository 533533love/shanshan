<template>
  <div class="pinglun">
    <div class="h1">
      <div class="title">宝贝评价</div>
      <el-button type="primary" size="medium" @click="getall"
        >全部{{quanshu()}}</el-button
      >
      <el-button type="success" size="medium" @click="hao">好评{{haoshu()}}</el-button>
      <el-button type="warning" size="medium" @click="zhong">中评{{zhongshu()}}</el-button
      ><el-button type="danger" size="medium" @click="cha">差评{{chashu()}}</el-button>
    </div>
    <div class="h2" v-for="(item,i) in info" :key="item.id">
      <div class="user">
        <img :src="img + item.userimg" alt="" />
        <div class="name">{{ item.username }}</div>
        <div class="degree">
          <span>综合评价：</span><li
              v-for="(y, r) in xing[i]"
              :key="r"
              class="xing"
              :class="{ cs: xing[i][r] }"
            >
              &#9733;
            </li></div>
        <div class="time">{{ changetime(item.time) }}</div>
      </div>
      <div class="text">{{ text(item) }}</div>
      <div class="imgs" v-if="item.imgnums > 1">
        <img v-for="(it, i) in item.imgs" :key="i" alt="" :src="img + it" />
      </div>
      <div class="imgs" v-else-if="item.imgnums == 1">
        <img alt="" :src="img + item.imgs" />
      </div>
    </div>
    <div v-show="is" class="h3">亲亲，暂无评价数据</div>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      haoping:'',//好评数
      zhongping:'',//中评数
      chaping:'',//差评数
      is: false,//当没数据时显示提示语
      img: this.$imgurl,
      raw: "",//请求原始数据
      info: "",//需要渲染的数据
      comnum: "",//全部评价数量
      xing:[]
    };
  },
  methods: {
    //全部评价数量显示
    quanshu(){
      if(this.comnum==0){
        return ''
      }else{
        return `(${this.comnum})`
      }
    },
     //好评数量显示
    haoshu(){
      if(this.haoping==0){
        return ''
      }else{
        return `(${this.haoping})`
      }
    },
    //中评数量显示
    zhongshu(){
      if(this.zhongping==0){
        return ''
      }else{
        return `(${this.zhongping})`
      }
    },
    //差评数量显示
    chashu(){
      if(this.chaping==0){
        return ''
      }else{
        return `(${this.chaping})`
      }
    },
    // 筛选好评
    hao() {
      if (this.num<= 5) {
        this.info = this.raw.filter((item) => item.degree == 5);
      } else {
        this.$axios
          .post("/getcom", { goodsid: this.$route.query.id, all: 1 })
          .then((res) => {
            console.log(res.data);
            this.raw = res.data.info;
            this.info = this.raw.filter((item) => item.degree == 5);
            this.initxing(this.info)
            if (this.info == 0) {
              this.is = true;
            } else {
              this.is = false;
            }
          });
      }
    },
     // 筛选中评
    zhong() {
      if (this.num<= 5) {
        this.info = this.raw.filter(
          (item) => item.degree < 5 && item.degree >= 3
        );
      } else {
        this.$axios
          .post("/getcom", { goodsid: this.$route.query.id, all: 1 })
          .then((res) => {
            console.log(res.data);
            this.raw = res.data.info;
            this.info = this.raw.filter(
              (item) => item.degree < 5 && item.degree >= 3
            );
             this.initxing(this.info)
            if (this.info == 0) {
              this.is = true;
            } else {
              this.is = false;
            }
          });
      }
    },
     // 筛选差评
    cha() {
      if (this.num<= 5) {
        this.info = this.raw.filter((item) => item.degree < 3);
      } else {
        this.$axios
          .post("/getcom", { goodsid: this.$route.query.id, all: 1 })
          .then((res) => {
            console.log(res.data);
            this.raw = res.data.info;
            this.info = this.raw.filter((item) => item.degree < 3);
            this.initxing(this.info)
            if (this.info == 0) {
              this.is = true;
            } else {
              this.is = false;
            }
          });
      }
    },
    //初始化评价星
    initxing(info){
      for (let index = 0; index < info.length; index++) {
        this.$set(this.xing,index,[])
        for (let i = 0; i< info[index].degree; i++) {
           this.$set(this.xing[index],i,1)
        }
      }
    },
    //得到全部评价
    getall() {
      this.$axios
        .post("/getcom", { goodsid: this.$route.query.id, all: 1 })
        .then((res) => {
          console.log(res.data);
          this.raw = res.data.info;
          this.info = this.raw;
           this.initxing(this.info)
          if (this.info == 0) {
            this.is = true;
          } else {
            this.is = false;
          }
        });
    },
    //改变评价上面的时间格式
    changetime(time) {
      return this.$moment(time).format("YYYY年MM月DD日");
    },
    //当用户没有评价时，系统的显示
    text(item) {
      if (item.comment == "") {
        if (item.degree == 5) {
          return "用户觉得商品很好，给出了" + item.degree + "星好评";
        } else if (item.degree >= 3 && item.degree < 5) {
          return "用户觉得商品不错，给出了" + item.degree + "星好评";
        } else {
          return "用户觉得商品一般，给出了" + item.degree + "星评价";
        }
      } else {
        return item.comment;
      }
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    this.$axios
      .post("/getcom", { goodsid: this.$route.query.id })
      .then((res) => {
        let a = res.data.info.filter(item=>item.degree>=3&&item.degree<5)
        this.zhongping =res.data.zhong
        this.haoping =res.data.hao
        this.chaping =res.data.cha
        this.comnum = res.data.num;
        this.raw = res.data.info;
        this.info = this.raw;
        this.initxing(this.info)
        if (this.info == 0) {
          this.is = true;
        } else {
          this.is = false;
        }
      });
  },
  mounted() {},
};
</script>

<style scoped>
.degree > span {
  float: left;
  height: 60px;
  line-height: 60px;
}
.degree{
  height: 60px;
  line-height: 60px;
  width: 200px;
}
li{
  float: left;
}
.user>.degree>.cs {
  z-index: 999;
  float: left;
  display: block;
  color: rgba(230, 230, 18, 0.938) !important;
}
.xing {
  display: none;
  float: left;
}
.h3 {
  width: 100%;
  height: 40px;
  font-size: 30px;
  line-height: 40px;
  text-align: center;
  text-shadow: 1px 1px 1px #ff0000;
}
.imgs {
  margin-top: 10px;
}
.imgs > img {
  height: 100px;
  width: 100px;
}
.text {
  font-size: 24px;
  margin-top: 5px;
  width: 100%;
  color: rgb(83, 81, 81);
}
.user {
  height: 60px;
  width: 100%;
}
.user > .degree {
  float: left;
  height: 60px;
  color: yellow;
  line-height: 60px;
  margin-left: 250px;
}
.user > .name {
  margin-left: 5px;
  line-height: 60px;
  float: left;
}
.user > .time {
  height: 60px;
  line-height: 60px;
  float: right;
}
.user > img {
  margin-top: 10px;
  float: left;
  height: 40px;
  width: 40px;
  border-radius: 50%;
}
.h1 > .el-button {
  margin-left: 30px;
  float: left;
  height: 100%;
  margin-top: 0;
}
.h1 > .title {
  float: left;
  background-color: rgb(97, 90, 90);
  height: 60px;
  text-align: center;
  width: 170px;
  font-size: 30px;
  color: black;
  font-weight: 600;
  line-height: 60px;
}
.h1 {
  border: 1px solid aquamarine;
  height: 60px;
  width: 100%;
}
</style>
