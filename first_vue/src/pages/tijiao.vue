<template>
  <div class="body w">
    <div class="h1">填写并核对订单信息</div>
    <div class="body_body">
      <div class="wit">
        <div class="s1">
          收件人信息
          <a href="#" @click="xiugai">修改收货地址</a>
        </div>
        <div class="h2">
          <div class="name">{{ info.name }} {{ info.address?info.address.slice(0, 2):''}}</div>
          <div class="dizhi">
            {{ info.name }} &nbsp; &nbsp; {{ info.address }} &nbsp;
            {{info.phone? info.phone.slice(0, 3):'' }}****{{ info.phone?info.phone.slice(7):'' }}
          </div>
        </div>
        <div class="h5">
          <div class="s1">送货清单</div>
        </div>
        <div class="h6">
          <div class="s1">配送方式：</div>
          <div class="name">天天快递</div>
          <div class="shijian">
            配送时间：当天11：00之前下单，当天下午送达，11：00之后下单，次日上送达
          </div>
        </div>
        <div class="h7" v-for="item in goods" :key="item.id">
          <img :src="img + item.goodsimg" alt="" />
          <div class="wen" @click="wen(item)">
            {{ item.goodsname }} <br />
            &nbsp; <br />
          </div>
          <div class="wen1">7天无理由退货</div>
          <div class="wen2">￥{{ item.goodsprice }}</div>
          <div class="wen3">X{{ item.goodsnum }}</div>
          <div class="wen4">有货</div>
        </div>
        <div class="h8">
          <div class="fp">发票信息</div>
          <div class="s1">
            普通发票（电子） &nbsp; &nbsp; 个人 &nbsp; &nbsp; 明细 &nbsp; &nbsp;
            <div class="blue">修改</div>
          </div>
        </div>
        <div class="h9">
          <div class="p1">
            <span>{{ totalnum }}</span
            >件商品，总商品金额：&nbsp; &nbsp; &nbsp; ¥{{
              totalprice.toFixed(2)
            }}
          </div>
          <div class="p2">返现：&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; -¥0.00</div>
          <div class="p3">运费：&nbsp; &nbsp; &nbsp; <span>¥0.00</span></div>
        </div>
      </div>
      <div class="h10">
        <div class="p1">
          应付总额 ：&nbsp; &nbsp; &nbsp;
          <span>¥{{ totalprice.toFixed(2) }}</span>
        </div>
        <div class="p2">
          寄送至：{{ info.address }} 收货人：{{ info.name }}
          {{ info.phone?info.phone.slice(0, 3):'' }}****{{info.phone? info.phone.slice(7):"" }}
        </div>
      </div>
      <div class="h11">
        <button @click="order">提交订单</button>
      </div>
    </div>
    <userinfo class="userinfo" v-show="ismotai2"></userinfo>
    <i class="el-icon-close" v-show="ismotai2" @click="bi"></i>
  </div>
</template>

<script>
import userinfo from "./userinfo.vue";
export default {
  name: "",
  data() {
    return {
      ismotai2: 0,
      totalnum: 0,
      totalprice: 0,
      img: this.$imgurl,
      info: "",
      goods: "",
    };
  },
  methods: {
     getaddrees(){
        return this.$axios.post("/shop", {
          u: sessionStorage.getItem("username"),
          yi: 1,
        });
      },
    getgoods(){
        return this.$axios.post("tijiao", { id: this.$route.query.id });
      },
    bi() {
      this.ismotai2 = 0;
      this.$bus.$emit("task", false);
    },
    xiugai() {
      this.$bus.$emit("task", true);
      this.ismotai2 = 1;
    },
    order() {
      if (confirm("确定购买吗？")) {
        let time = this.$moment().format("YYYY-MM-DD HH:mm:ss");
        if (this.$route.query.id) {
          this.$axios
            .post("/order", {
              flag: 1,
              time: time,
              user: sessionStorage.getItem("username"),
              goodsid: this.$route.query.id,
              goodsnum: this.$route.query.num,
            })
            .then((res) => {
              alert("购买成功即将跳转页面");
              setTimeout(() => {
                this.$router.push({
                  path: "/",
                });
              }, 500);
            });
        } else {
          this.$axios
            .post("/order", {
              time: time,
              user: sessionStorage.getItem("username"),
            })
            .then((res) => {
              this.$axios
                .post("/chatu", { user: sessionStorage.getItem("username") })
                .then((res) => {
                  this.$bus.$emit("jia", res.data.num);
                  let shifou = confirm("购买成功，是否查看订单？");
                  if (shifou) {
                    this.$router.push("/order");
                  } else {
                    alert("即将跳转至购物车");
                    setTimeout(() => {
                      this.$router.push({
                        path: "/shopping",
                      });
                    }, 500);
                  }
                });
            });
        }
      } else {
        let time = this.$moment(this.createTime).format("YYYY-MM-DD HH:mm:ss");
        if (this.$route.query.id) {
          this.$axios
            .post("/order", {
              type: 1,
              flag: 1,
              time: time,
              user: sessionStorage.getItem("username"),
              goodsid: this.$route.query.id,
              goodsnum: this.$route.query.num,
            })
            .then((res) => {
              alert("购买失败即将跳转页面");
              console.log(res.data);
              setTimeout(() => {
                this.$router.push({
                  path: "/",
                });
              }, 500);
            });
        } else {
          this.$axios
            .post("/order", {
              type: 1,
              time: time,
              user: sessionStorage.getItem("username"),
            })
            .then((res) => {
              this.$axios
                .post("/chatu", { user: sessionStorage.getItem("username") })
                .then((res) => {
                  this.$bus.$emit("jia", res.data.num);
                  alert("购买失败，即将跳转至购物车");
                  setTimeout(() => {
                    this.$router.push({
                      path: "/shopping",
                    });
                  }, 500);
                });
            });
        }
      }
    },
    wen(item) {
      let goods = {
        name: item.goodsname,
        img: item.goodsimg,
        price: item.goodsprice,
        id: item.goodsid,
      };
      if (!goods.username) {
        this.$router.push({
          path: "./",
        });
      }
      this.$router.push({
        path: "/detail",
        query: goods,
      });
    },
  },
  components: { userinfo },
  computed: {},
  watch: {},
  created() {
    if (this.$route.query.id) {
      this.$axios.all([this.getgoods(), this.getaddrees()]).then((res) => {
        const goods = res[0].data;
        const address = res[1].data;
        console.log(res);
        this.info = address;
        let a = [
          {
            goodsnum: this.$route.query.num,
            goodsname: goods.goodsname,
            goodsimg: goods.goodsimg,
            goodsprice: goods.goodsprice,
            id: goods.id,
          },
        ];
        this.goods = a;
        console.log(this.goods);
        this.totalnum = this.$route.query.num;
        this.totalprice = this.goods[0].goodsnum * this.goods[0].goodsprice;
      });
    } else {
      this.$axios.post('/tijiao',{user:sessionStorage.getItem('username')}).then(res=>{
        this.info = res.data.dizhi
        this.goods = res.data.goods
         for (const key in this.goods) {
            this.totalnum += parseFloat(this.goods[key].goodsnum);
            this.totalprice += parseFloat(this.goods[key].total);
          }
      })
     
    }
  },
  mounted() {
    this.$bus.$on("text", (data) => {
      for (const key in data) {
        if (data[key].flag == 1) {
          this.info = data[key];
          break;
        }
      }
    });
  },
  activated(){
    if (this.$route.query.id) {
      this.$axios.all([this.getgoods(), this.getaddrees()]).then((res) => {
        const goods = res[0].data;
        const address = res[1].data;
        console.log(res);
        this.info = address;
        let a = [
          {
            goodsnum: this.$route.query.num,
            goodsname: goods.goodsname,
            goodsimg: goods.goodsimg,
            goodsprice: goods.goodsprice,
            id: goods.id,
          },
        ];
        this.goods = a;
        console.log(this.goods);
        this.totalnum = this.$route.query.num;
        this.totalprice = this.goods[0].goodsnum * this.goods[0].goodsprice;
      });
    } else {
      this.$axios.post('/tijiao',{user:sessionStorage.getItem('username')}).then(res=>{
        this.info = res.data.dizhi
        this.goods = res.data.goods
         for (const key in this.goods) {
            this.totalnum += parseFloat(this.goods[key].goodsnum);
            this.totalprice += parseFloat(this.goods[key].total);
          }
      })
     
    }
  }
};
</script>

<style scoped>
.el-icon-close {
  z-index: 33;
  font-size: 40px;
  position: fixed;
  top: 92px;
  right: 24px;
  cursor: pointer;
}
.userinfo {
  z-index: 33;
  position: fixed;
  top: 100px;
  background-color: #fff;
}
.body {
  height: 1085px;
}
.body .h1 {
  height: 35px;
  width: 100%;
  font-size: 16px;
  color: #666;
}
.body_body {
  height: 790px;
  width: 100%;
  border: 1px solid #ededed;
}
.wit {
  width: 1152px;
  margin: 0 auto;
}
button:hover {
  cursor: pointer;
}
.body_body .s1 {
  color: #333;
  font-size: 14px;
  margin-top: 38px;
  margin-left: 28px;
  font-weight: 550;
}
.body_body .s1 a {
  float: right;
  margin-right: 32px;
  color: #1474af;
  font-size: 12px;
}
.body_body .h2 {
  height: 98px;
  width: 100%;
  padding-left: 49px;
  padding-top: 15px;
  border-bottom: 1px solid #ededed;
}
.name {
  margin-right: 12px;
  float: left;
  text-align: center;
  line-height: 30px;
  color: #666;
  font-size: 12px;
  height: 30px;
  width: 144px;
  border: 2px solid #b1191a;
}
.dizhi {
  height: 30px;
  width: 800px;
  color: #666;
  line-height: 30px;
  font-size: 12px;
}
.dizhi span {
  display: block;
  margin-top: 15px;
}
.dizhi span::after {
  content: "\ea43";
  font-family: "icomoon";
}
.h3 {
  padding-left: 49px;
  padding-top: 15px;
  border-bottom: 1px solid #ededed;
  height: 70px;
  width: 100%;
}
.name1 {
  margin-right: 12px;
  float: left;
  text-align: center;
  line-height: 30px;
  color: #666;
  font-size: 12px;
  height: 30px;
  width: 144px;
  border: 1px solid #ededed;
}
.h4 {
  height: 86px;
  width: 100%;
  border-bottom: 1px solid #ededed;
}
.h4 .s1 {
  color: #333;
  font-size: 14px;
  margin-top: 20px;
  margin-left: 28px;
  font-weight: 550;
  margin-bottom: 20px;
}
.h2 .s1 {
  color: #333;
  font-size: 14px;
  margin-top: 20px;
  margin-left: 28px;
  font-weight: 550;
  margin-bottom: 20px;
}
.fang {
  float: left;
  margin-left: 58px;
  width: 196px;
  height: 30px;
  border: 2px solid #ededed;
  border-right: 0;
}
.fang a {
  text-align: center;
  line-height: 30px;
  float: left;
  width: 97px;
  height: 28px;
  border-right: 2px solid #ededed;
}
.h4 span {
  text-align: center;
  line-height: 30px;
  float: left;
  color: #666;
  margin-left: 10px;
  height: 30px;
  width: 98px;
  border: 2px solid #b1191a;
}
.gengduo {
  height: 30px;
  width: 60px;
  color: #666;
  margin-left: 25px;
  text-align: center;
  line-height: 30px;
  float: left;
}
.h5 {
  height: 58px;
  width: 100%;
  margin-top: 0;
  line-height: 58px;
  border-bottom: 1px solid #ededed;
}
.h5 .s1 {
  margin-top: 0;
  color: #333;
  font-size: 14px;
  margin-left: 28px;
  font-weight: 550;
}
.h6 {
  background-color: #f4f4f4;
  color: #666;
  font-size: 12px;
  height: 101px;
  width: 100%;
  border-bottom: 1px solid #ededed;
}
.h6 .s1 {
  margin: 0;
  padding-top: 20px;
  padding-left: 28px;
}
.h6 .name {
  margin-left: 57px;
  margin-right: 50px;
  margin-top: 15px;
  float: left;
  text-align: center;
  line-height: 30px;
  color: #666;
  font-size: 12px;
  height: 30px;
  width: 144px;
  border: 2px solid #b1191a;
}
.h6 .shijian {
  margin-top: 15px;
  height: 30px;
  width: 100%;
  color: #666;
  line-height: 30px;
  font-size: 12px;
}
.shijian span {
  float: right;
  margin-right: 36px;
  color: #1474af;
}
.h7 {
  position: relative;
  height: 152px;
  width: 100%;
  border-bottom: 1px solid #ededed;
  background-color: #feedef;
}
.h7 .s1 {
  margin: 0;
  padding-top: 20px;
  padding-left: 28px;
}
.h7 img {
  margin-left: 47px;
  margin-top: 15px;
  margin-right: 108px;
  width: 16%;
  height: 90%;
}
.wen {
  color: #666;
  font-size: 12px;
  top: 54px;
  left: 244px;
  position: absolute;
}
.wen:hover {
  cursor: pointer;
}
.wen1 {
  font-size: 12px;

  position: absolute;
  color: #c81623;
  left: 244px;
  top: 110px;
}
.wen2 {
  position: absolute;
  top: 62px;
  right: 196px;
  color: #e12228;
  font-size: 14px;
}
.wen3 {
  position: absolute;
  top: 62px;
  right: 132px;
  color: #666;
  font-size: 12px;
}
.wen4 {
  position: absolute;
  top: 62px;
  right: 32px;
  color: #666;
  font-size: 12px;
}
.h8 {
  margin-top: 20px;
  border-top: 1px solid #ededed;
  height: 120px;
  width: 100%;
}
.fp {
  margin-left: 28px;
  margin-top: 20px;
  font-size: 14px;
  color: #333;
  font-weight: 550;
}
.h8 .s1 {
  margin-left: 47px;
  margin-top: 15px;
  color: #666;
  font-size: 12px;
  font-weight: normal;
}
.blue {
  display: inline;
  margin-left: 20px;
  color: #1474af;
}
.ff {
  margin-left: 28px;
  margin-top: 15px;
  font-size: 14px;
  color: #333;
  font-weight: 550;
}
.h8 .ff::after {
  font-family: "icomoon";
  content: "\ea43";
}
.h9 {
  font-size: 12px;
  color: #333;
  height: 94px;
  width: 100%;
  padding-top: 24px;
  padding-left: 918px;
}
.p1 span,
.p3 span {
  color: #e12228;
}
.p2 {
  margin-left: 91px;
}
.p3 {
  margin-left: 91px;
}
.h10 {
  padding-left: 728px;
  padding-top: 16px;
  margin: 0 auto;
  font-size: 12px;
  color: #333;
  height: 72px;
  border: 1px solid #ededed;
  width: 100%;
  background-color: #f4f4f4;
}
.h10 .p1 {
  margin-left: 277px;
}
.h10 .p1 span {
  font-size: 16px;
  color: #e12228;
}
.h10 .p2 {
  margin-left: 8px;
}
.h11 {
  font-size: 18px;
  color: #ffffff;
  height: 98px;
  width: 100%;
}
.h11 button {
  margin-top: 20px;
  margin-right: 32px;
  float: right;
  color: #ffffff;
  background-color: #c81623;
  width: 148px;
  height: 50px;
  text-align: center;
  line-height: 50px;
}
</style>
