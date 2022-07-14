<template>
  <div class="">
    <div class="banner1">
      <div class="w clearfix">
        <div class="fl">
          <!-- <div class="head">
                    <a href="#" class="di">手机、数码、通讯</a><a href="#">〉</a><a href="#">手机</a><a href="#">〉</a><a
                        href="#">Apple苹果</a><a href="#">〉</a><a href="#">iphone 6S Plus系类</a>
                </div> -->
          <div class="body">
            <img :src="img + good.img" alt="" />
          </div>
          <!-- <div class="dibu">
                    <li>商品编号：0468256644</li>
                    <li><img src="denglupic/图层150.png" alt=""> 分享</li>
                    <li><img src="denglupic/图层149.png" alt=""> 关注 5000</li>
                    <li><input type="checkbox"> <span>对比</span></li>
                </div> -->
        </div>
        <div class="fr">
          <i class="el-icon-back" @click="fanhui()">返回商品列表</i>
          <h3>商品名称：{{ good.name }}</h3>
          <div class="hezi">
            <div class="h1 clearfix">
              <div class="zuo">价 &nbsp; &nbsp;&nbsp;格</div>
              <span>￥</span>
              <div class="zhong">{{ good.price }}</div>
            </div>
          </div>
          <div class="h2 h clearfix">
            <div class="h3 clearfix">
              <div class="zuo">支 &nbsp; &nbsp;&nbsp;持</div>
              <div class="you">以旧换新，闲置手机回收 4G套餐超值抢 礼品购</div>
            </div>
            <div class="zuo">配 送 至</div>
            <div class="you">
              {{ dizhi }} &nbsp; 有货 &nbsp; 支持&nbsp; 99元免运费 &nbsp;
              |货到付款&nbsp; |211限时达
            </div>
            <div class="xi">
              由自营发货，并提供售后服务。11:00前完成下单，预计<span
                >今天（{{ day.getMonth() + 1 }}月{{
                  day.getDate()
                }}日）送达</span
              >
            </div>
          </div>
          <div class="jiagou">
            <input type="text" v-model.number="num" /><a
              class="jia"
              @click="num < 99 ? num++ : num"
              >+</a
            ><a class="jian" @click="num > 1 ? num-- : num">-</a>
            <div class="gou" @click="jiagou">加入购物车</div>
            <div class="gou" @click="buy">立即购买</div>
          </div>
        </div>
      </div>
    </div>
    <comments />
  </div>
</template>

<script>
import comments from "../components/comments.vue";
export default {
  name: "",
  data() {
    return {
      full: "",
      xing: [],
      num: 1,
      day: new Date(),
      people: sessionStorage.getItem("username"),
      dizhi: "",
      img: this.$imgurl,
      good: this.$route.query,
    };
  },
  methods: {
    fanhui() {
     this.$router.push('/')
    },
    buy() {
      if (!this.people) {
        this.$router.push({
          path: "/",
        });
      } else {
        if (this.dizhi) {
          let goods = {
            id: this.good.id,
            num: this.num,
          };
          this.$router.push({
            path: "/tijiao",
            query: goods,
          });
        } else {
          this.$router.push({
            path: "/userinfo",
            query: { flag: false },
          });
        }
      }
    },
    jiagou() {
      let goods = {
        name: this.good.name,
        img: this.good.img,
        price: this.good.price,
        num: this.num,
        username: sessionStorage.getItem("username"),
        id: this.good.id,
      };
      // this.$bus.$emit("jia");
      if (!goods.username) {
        this.$router.push({
          path: "/",
        });
      } else {
        this.$axios.post("/buy", goods).then((res) => {
          alert("添加成功");
        });
      }
    },
  },
  components: {
    comments,
  },
  computed: {},
  watch: {
    num() {
      if (this.num >= 99) {
        this.num = 99;
      } else if (this.num <= 1) {
        this.num = 1;
      }
    },
  },
  created() {
    this.$axios.post("/shop", { u: this.people,yi:1 }).then((res) => {
      if (res.data) {
        this.full = res.data;
        let a = this.full.address.indexOf("市");
        if(a!=-1) {
          this.dizhi = res.data.address.slice(0, a + 1);
        }else{
          this.dizhi = res.data.address
        }
      }
    });
  },
  mounted() {},
  activated() {
    this.good = this.$route.query;
  },
};
</script>

<style scoped>
.fr > i {
  margin-right: 20px;
  font-size: 30px;
  cursor: pointer;
  text-decoration: none;
}
.clearfix:after {
  content: "";
  display: block;
  visibility: hidden;
  clear: both;
}
.jia,
.jian:hover {
  cursor: pointer;
}
.banner1 {
  height: 500px;
}
.banner1 .fl {
  float: left;
  width: 426px;
  height: 500px;
}
.banner1 .fr {
  float: right;
  width: 774px;
  height: 500px;
}
.banner1 .fl .head {
  height: 52px;
  width: 100%;
  padding-top: 28px;
}
.banner1 .fl a {
  font-size: 12px;
  color: #666;
  margin-right: 12px;
}
.banner1 .fl .di {
  font-size: 12px;
  color: #333;
}
.banner1 .fl .body {
  width: 402px;
  height: 398px;
  border: 1px solid #ededed;
  margin-bottom: 65px;
}
.banner1 .fl .body img {
  width: 100%;
  height: 100%;
}
.banner1 .fl .xuan {
  width: 402px;
  height: 60px;
}
.xuan a {
  float: left;
}
.xuan a:first-child,
.xuan a:last-child {
  color: #ddd;
  font-size: 53px;
}
.xuan a:nth-child(2) {
  border: 1px solid #b1191a;
}
.dibu {
  color: #666;
  font-size: 12px;
  text-align: center;
  line-height: 70px;
  height: 70px;
  width: 402px;
}
.dibu li {
  float: left;
  margin-right: 35px;
}
.dibu input {
  margin-top: 3px;
}
.dibu li:last-child {
  margin-right: 0;
}
.dibu span {
  margin-top: -3px;
}
.banner1 .fr h3 {
  height: 60px;
  width: 100%;
  padding-top: 40px;
  margin-left: 57px;
  color: #333;
  font-size: 16px;
}
.banner1 .fr h4 {
  font-weight: normal;
  font-size: 12px;
  color: #e12228;
  margin-left: 57px;
  margin-top: 15px;
  margin-bottom: 20px;
}
.hezi {
  margin-left: 57px;
  width: 718px;
  height: 114px;
  background-color: #fee9eb;
  color: #666;
  font-size: 12px;
  margin-bottom: 15px;
}
.zuo {
  float: left;
  margin-top: 15px;
  margin-left: 10px;
}
.hezi span {
  margin-top: 15px;
  margin-left: 15px;
  float: left;
  color: #e12228;
}
.zhong {
  font-size: 24px;
  margin-top: 5px;
  color: #e12228;
  float: left;
  margin-right: 5px;
}
.da {
  margin-top: 15px;
  float: left;
  color: #c81623;
}
.you {
  margin-right: 10px;
  float: right;
}
.you .lei {
  float: left;
  margin-top: 10px;
}
.you span {
  margin-left: 0;
  margin-top: 10px;
  float: left;
  color: #1474af;
}
.hong {
  margin-top: 15px;
  margin-left: 15px;
  float: left;
  color: #fff;
  background-color: #c81623;
}
.xia {
  color: #c81623;
  margin-top: 45px;
  margin-left: 70px;
}
.h1 .hui {
  color: #999;
}
.h2 {
  color: #666;
  margin-bottom: 16px;
  font-size: 12px;
  margin-left: 57px;
}
.h {
  width: 546px;
  height: 98px;
  border-bottom: 1px solid #ededed;
}
.h2 .zuo {
  float: left;
  margin: 0;
}
.h3 {
  margin-bottom: 15px;
}
.h2 .you {
  float: left;
  margin-left: 15px;
  color: #999;
  font-size: 12px;
}
.h2 .xi {
  color: #999;
  float: left;
  margin-top: 10px;
  margin-left: 57px;
}
.xi span {
  font-weight: 800;
}
.h5 {
  margin-left: 57px;
  width: 800px;
  height: 50px;
}
.h6 {
  margin-left: 57px;
  width: 800px;
  height: 42px;
}
.h6 a {
  color: #666;
  font-size: 12px;
  float: left;
  text-align: center;
  line-height: 34px;
  width: 65px;
  border: 1px solid #ededed;
  margin-right: 10px;
  height: 34px;
}
.h6 .he1 {
  color: #666;
  font-size: 12px;
  float: left;
  text-align: center;
  line-height: 42px;
  width: 70px;
  height: 42px;
}
.h5 .he1 {
  color: #666;
  font-size: 12px;
  float: left;
  text-align: center;
  line-height: 50px;
  width: 70px;
  height: 50px;
}
.h5 a {
  text-align: center;
  line-height: 40px;
  float: left;
  width: 84px;
  height: 40px;
  margin-right: 10px;
  border: 1px solid #ededed;
}
.h7 {
  margin-left: 57px;
  font-size: 12px;
  color: #666;
  height: 34px;
  width: 800px;
}
.h7 .he1 {
  text-align: center;
  line-height: 34px;
  float: left;
  height: 34px;
  width: 70px;
}
.h7 li {
  float: left;
  width: 60px;
  height: 34px;
  text-align: center;
  line-height: 34px;
  border: 1px solid #ededed;
  margin-right: 10px;
}
.h8 {
  margin-left: 57px;
  color: #666;
  font-size: 12px;
  text-align: center;
  height: 42px;
  width: 800px;
}
.h8 .he1 {
  float: left;
  text-align: center;
  height: 42px;
  width: 70px;
  line-height: 42px;
}
.h8 li {
  margin-top: 8px;
  float: left;
  width: 75px;
  margin-right: 10px;
  height: 34px;
  line-height: 34px;
  border: 1px solid #ededed;
}
.jiagou {
  margin-left: 57px;
  text-align: center;
  height: 75px;
  width: 800px;
}
.jiagou input {
  border-radius: 0;
  text-align: center;
  line-height: 47px;
  float: left;
  margin-left: 10px;
  margin-top: 20px;
  height: 48px;
  width: 35px;
  border: 1px solid #ededed;
}
.jia {
  line-height: 24px;
  margin-top: 20px;
  float: left;
  height: 24px;
  width: 18px;
  border: 1px solid #ededed;
  border-left: 0;
}
.jian {
  line-height: 24px;
  float: left;
  margin-left: -18px;
  height: 24px;
  width: 18px;
  margin-top: 44px;
  border-right: 1px solid #ededed;
  border-bottom: 1px solid #ededed;
}
.gou {
  float: left;
  color: #fff;
  font-size: 18px;
  margin-left: 10px;
  margin-top: 20px;
  width: 144px;
  height: 48px;
  text-align: center;
  line-height: 48px;
  background-color: #c81623;
  cursor: pointer;
}
.xiangguan {
  height: 2404px;
  width: 1200px;
  margin: 0 auto;
}
.xiangguan .fl {
  border: 1px solid #ededed;
  width: 210px;
  height: 438px;
}
.hd {
  text-align: center;
  line-height: 34px;
  width: 100%;
  height: 34px;
}
.hd a {
  float: left;
  width: 50%;
  height: 100%;
}
.hd a:first-child {
  color: #c81623;
}
.hd a:last-child {
  background-color: #f1f1f1;
  border-left: 1px solid #ededed;
  border-bottom: 1px solid #ededed;
  color: #333;
}
.xiangguan .fl li {
  height: 30px;
  width: 190px;
  font-size: 12px;
  margin-left: 10px;
  color: #333;
  line-height: 30px;
  border-bottom: 1px dashed #ededed;
}
.xiaozuo {
  height: 100%;
  width: 50%;
  padding-left: 20px;
  float: left;
}
.xiaoyou {
  float: left;
  height: 100%;
  width: 50%;
  padding-left: 8px;
}
.te {
  color: #333;
  font-size: 14px;
  height: 35px;
  width: 190px;
  text-align: center;
  line-height: 35px;
  margin-left: 10px;
  border-bottom: 1px solid #ededed;
}
.chaoda {
  border: 1px solid #ededed;
  position: relative;
  height: 2165px;
  width: 100%;
}
.j1,
.j2,
.j3,
.j4,
.j5,
.j6 {
  position: absolute;
  font-size: 14px;
  width: 92px;
  height: 30px;
  color: #333;
  text-align: center;
  line-height: 30px;
  left: 60px;
  border: 1px solid #ededed;
  background-color: #f7f7f7;
}
.j1 {
  top: 168px;
}
.j2 {
  top: 408px;
}
.j3 {
  top: 648px;
}
.j4 {
  top: 862px;
}
.j5 {
  top: 1100px;
}
.j6 {
  top: 1340px;
}
.xiangguan .y {
  float: left;
  margin-left: 10px;
  width: 980px;
  height: 2385px;
}
.xiangguan .y .hdr {
  background-color: #f1f1f1;
  height: 40px;
  width: 100%;
  border: 2px solid #dddddd;
}
.y .xuanze {
  float: left;
  color: #fff;
  background-color: #c81623;
  font-size: 12px;
  text-align: center;
  line-height: 40px;
  margin-right: 890px;
  width: 86px;
  height: 36px;
}
.y .hh {
  padding-left: 15px;
  height: 40px;
  width: 100%;
  border-left: 1px solid #ededed;
  border-right: 1px solid #ededed;
}
.xiangguan .y .hh li {
  float: left;
  color: #999;
  font-size: 12px;
  margin-top: 12px;
  margin-right: 40px;
}
.y_body {
  height: 222px;
  width: 100%;
  padding-left: 20px;
  border-bottom: 1px solid #ededed;
  border-left: 1px solid #ededed;
  border-right: 1px solid #ededed;
  margin-bottom: 22px;
}
.y_body li {
  margin-top: 15px;
  float: left;
  width: 136px;
  height: 132px;
  margin-right: 27px;
  border: 1px solid #e12228;
  text-align: center;
  padding-top: 8px;
}
.y .y_body .bu {
  margin-right: 0;
}
.y_body span {
  float: left;
  width: 170px;
  height: 100%;
}
.y1 {
  margin-top: 5px;
  color: #e12228;
  font-size: 14px;
}
.y2 span {
  text-align: left;
  margin-left: 12px;
  margin-top: 16px;
  color: #333;
  font-size: 12px;
}
.y2 input {
  float: left;
  margin-top: 2px;
  margin-left: 12px;
  width: 12px;
  height: 12px;
}
.l {
  float: left;
  color: #e12228;
  font-size: 12px;
}
.a1 {
  color: #333;
  margin-top: 10px;
  margin-left: 15px;
  margin-bottom: 20px;
  font-size: 12px;
}
.a2 {
  color: #333;
  margin-left: 15px;
  font-size: 12px;
}
.a3 {
  margin-top: 10px;
  margin-bottom: 50px;
  font-size: 24px;
  margin-left: 15px;
  color: #e12228;
}
.a4 {
  width: 142px;
  text-align: center;
  line-height: 46px;
  height: 46px;
  font-size: 18px;
  color: #fff;
  background-color: #c81623;
}
.tab {
  height: 370px;
  width: 100%;
}
.tab_head {
  background-color: #f1f1f1;
  height: 40px;
  width: 100%;
  font-size: 12px;
  color: #333;
}
.tab_head a {
  text-align: center;
  line-height: 40px;
  float: left;
  font-size: 12px;
  padding: 0 20px;
  height: 40px;
}
.current {
  background-color: #c81623;
  color: #fff;
}
.tab_body {
  position: relative;
  height: 330px;
  width: 100%;
  padding-top: 20px;
  padding-left: 22px;
  border-bottom: 1px solid #ededed;
}
.tab_body span {
  font-size: 12px;
  display: block;
  margin-bottom: 6px;
  color: #666;
}
.cha {
  position: absolute;
  bottom: 10px;
  right: 2px;
}
.cha::after {
  font-family: "icomoon";
  content: "\ea43";
}
.cai {
  height: 338px;
  width: 1200px;
  margin: 0 auto;
}
.cai_head {
  line-height: 40px;
  padding-left: 8px;
  background-color: #f1f1f1;
  font-size: 16px;
  color: #333;
  height: 40px;
  width: 100%;
}
.cai li {
  color: #666;
  float: left;
  margin-right: 90px;
}
.cai .cai_body li:first-child {
  margin-left: 20px;
}
.cai .cai_body span {
  color: blue;
}
.pin {
  height: 30px;
  line-height: 30px;
  width: 100%;
  margin-top: 32px;
}
</style>
