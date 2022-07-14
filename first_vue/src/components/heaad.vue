<template>
  <div class="kuang">
    <li style="display: inline-block">{{ welcome }}品优购欢迎您！&nbsp;</li>
    <li style="display: inline-block" v-show="show">
      <img :src="userimg" alt="" class="userimg" />
    </li>
    <li style="display: inline-block">
      <router-link to="/uslogin" v-show="!show">登陆</router-link>
      <span v-show="show">{{ name }}</span>
    </li>
    <header>
      <div class="heard w">
        <!-- logo模块 -->
        <router-link to="/" class="logo"></router-link>
        <!-- search模块 -->
        <div class="search" v-show="isshow">
          <input
            type="search"
            placeholder="语言开发"
            v-model="keyword"
            @focus="kuang"
            @blur="shi($event)"
          />
          <button @click="cha" @mouseover="shubiao($event)">搜索</button>
          <div class="kuang" v-show="flag">
            <div
              class="h1"
              ref="h1"
              @click="chuan(item)"
              v-for="(item, i) in keywords"
              :key="i"
            >
              <div class="fl" @mousemove="jing = i + 1" @mouseout="jing = ''">
                {{ item }}
              </div>
              <i
                class="el-icon-close"
                @mousemove="x = i + 1"
                @mouseout="x = ''"
              ></i>
            </div>
            <button class="wen" @mousemove="x = -1" @mouseout="x = ''">
              全部删除
            </button>
          </div>
        </div>
        <!-- 购物车模块 -->
        <div class="shopcar">
          <i class="el-icon-s-goods" style="color: red"></i>
          <a class="gou" href="javascript:;" @click="toshop" >我的购物车</a>
          <i
            class="el-icon-arrow-down"
            @mouseover="xian = true"
            @mouseout="ding"
          ></i>
          <div class="logo1" v-show="show && num">{{ num }}</div>
        </div>
        <div
          class="select"
          ref="dong"
          v-show="xian"
          @mouseover="date = 1"
          @mouseout="xia()"
        >
          <div class="san"></div>
          <li @click="ge">个人中心</li>
          <li @click="order">订单管理</li>
        </div>
        <div class="sk"><img src="../assets/秒杀拷贝.png" alt="" /></div>
      </div>
    </header>
  </div>
</template>

<script>
export default {
  name: "",
  props: ["date1"],
  data() {
    return {
      name:'',
      welcome: "",
      isshow: true,
      date: "",
      house: new Date().getHours(),
      xian: "",
      x: "",
      jing: "",
      flag: "",
      uuid: this.$uuid.v1(),
      keywords: [],
      show: sessionStorage.getItem("username"),
      userimg: "",
      keyword: "",
      num: "",
    };
  },
  methods: {
    toshop(){
      if (sessionStorage.getItem('username')) {
        let xinxi ={
        xinxi:'欢迎来到购物车',
        xian:1,
        type:'success'
      }
      this.$bus.$emit('xian',xinxi)
        this.$router.push('/shopping')
      }else{
         let xinxi ={
        xinxi:'请先登陆哦',
        xian:1,
         type:'danger'
      }
      this.$bus.$emit('xian',xinxi)
        this.$router.push('/uslogin')
      }
    },
    order() {
      let xinxi ={
        xinxi:'欢迎来到我的订单页面',
        xian:1,
         type:'success'
      }
      this.$bus.$emit('xian',xinxi)
      this.$router.push({
        path: "/order",
      });
    },
    ge() {
      let xinxi ={
        xinxi:'欢迎来到个人信息页面',
        xian:1,
         type:'success'
      }
      this.$bus.$emit('xian',xinxi)
      this.$router.push({
        path: "/userinfo",
        query: {
          flag: false,
        },
      });
    },
    xia() {
      this.date = "";
      setTimeout(() => {
        if (this.date != 1) {
          this.date = "";
          this.xian = "";
        }
      }, 200);
    },
    ding() {
      setTimeout(() => {
        if (this.date != 1) {
          this.xian = false;
        }
      }, 200);
    },
    shubiao(e) {
      e.target.style.cursor = "pointer";
    },
    cha() {
      if (this.$route.path != "/") {
        this.$router.push({
          path: "/",
        });
      }
       this.$bus.$emit("about", this.keyword);
          if (this.keyword != "") {
            this.keywords.push(this.keyword);
            this.keywords = [...new Set(this.keywords)];
            if (this.keywords.length > 6) {
              this.keywords.shift();
            }
            console.log("添加成功");
            localStorage.setItem("keywords", JSON.stringify(this.keywords));
          }
    },
    kuang() {
      if (this.keywords.length != 0) {
        this.flag = true;
      }
    },
    shi() {
      if (this.jing != "") {
        this.$refs.h1[this.jing - 1].click();
      }
      if (this.x > 0) {
        if (this.keywords[this.x - 1] == this.keyword) {
          this.keyword = "";
        }
        this.keywords.splice(this.x - 1, 1);
        localStorage.setItem("keywords", JSON.stringify(this.keywords));
      } else if (this.x == -1) {
        this.keyword = "";
        this.keywords = [];
        localStorage.removeItem("keywords");
      }
      this.flag = false;
    },
    chuan(item) {
      this.keyword = item;
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    if (this.house >= 7 && this.house < 12) {
      this.welcome = "上午好！";
    } else if (this.house >= 12 && this.house < 13) {
      this.welcome = "中午好！";
    } else if (this.house >= 13 && this.house < 18) {
      this.welcome = "下午好！";
    } else {
      document
        .querySelector("body")
        .setAttribute("style", "background-color:#858583be");
      this.welcome = "晚上好！";
    }
    if (this.show) {
      this.$axios.post("/chatu", { user: this.show }).then((res) => {
        this.userimg = this.$imgurl + res.data.imgurl;
        this.name=res.data.name
        this.num = res.data.num;
        console.log(res.data);
      });
    }
    if (localStorage.getItem("keywords")) {
      this.keywords = JSON.parse(localStorage.getItem("keywords"));
    }
    if (this.date1) {
      this.isshow = false;
    }
  },
  mounted() {
    this.$bus.$on("jia", (data) => {
      this.num = data;
    });
  },
};
</script>

<style scoped>
.kuang {
  width: 1200px;
  margin: 0 auto;
}
/* @-webkit-keyframes slide-down{
    0%{transform: scale(1,0);}
    25%{transform: scale(1,1.2);}
    50%{transform: scale(1,0.85);}
    75%{transform: scale(1,1.05);}
    100%{transform: scale(1,1);}
} */
.san {
  margin-top: -10px;
  margin-left: 100px;
  width: 20px;
  height: 20px;
}
@keyframes frames {
  from {
    height: 0px;
  }
  to {
    height: 52px;
  }
}
.el-icon-arrow-down:hover {
  cursor: pointer;
}
.select:hover {
  display: block;
}
.select {
  animation-name: frames;
  animation-duration: 0.3s;
  border: 1px solid #dfdfdf;
  text-align: center;
  width: 140px;
  height: 52px;
  background-color: #f7f7f7;
  line-height: 20px;
  font-size: 12px;
  position: absolute;
  top: 64px;
  right: 65px;
}
.select > li {
  height: 20px;
  width: 100%;
  text-align: center;
  display: block;
}
.select > li:hover {
  cursor: pointer;
  background-color: rgb(68, 204, 228);
}
.w {
  width: 1200px;
  margin: 0px auto;
}
.w li {
  float: left;
}
.search .kuang .wen {
  float: right;
  background-color: #f7f7f7;
  font-size: 12px;
  width: 80px;
  height: 24px;
  color: #b2b2b2;
}
.heard {
  position: relative;
  height: 105px;
}
.logo {
  position: absolute;
  left: 0;
  top: 27px;
  width: 171px;
  height: 61px;
  background: url(../assets/logo.png) no-repeat;
}
input,
button {
  border: 0;
}
.userimg {
  height: 60px;
  width: 60px;
  border-radius: 50%;
  vertical-align: middle;
}
.search {
  position: absolute;
  top: 27px;
  left: 348px;
  width: 538px;
  height: 36px;
  border: 2px solid #b1191a;
}
/* .right{
  float: right;
  margin-top: 20px;
  margin-right: 20px;
} */
.search input {
  border: 0;
  float: left;
  outline: 0;
  width: 454px;
  height: 32px;
  padding-left: 10px;
}
.search .kuang {
  border: 2px solid rgba(226, 217, 217, 0.4);
  position: absolute;
  top: 38px;
  left: -2px;
  width: 454px;
}
.search .kuang .fl {
  float: left;
  width: 438px;
  height: 100%;
  font-size: 12px;
  line-height: 24px;
  color: #b2b2b2;
}
.search .kuang .h1 {
  background-color: #fff;
  display: block;
  height: 24px;
  width: 100%;
}
.search .kuang .h1 :hover {
  background-color: #dfd2d2;
}
.search .kuang .fr {
  float: right;
}
.search .kuang .wen:hover {
  background-color: #666666;
}
.search button {
  border: 0;
  outline: 0;
  float: left;
  width: 84px;
  height: 36px;
  border-radius: 0px;
  background-color: #b1191a;
  font-size: 16px;
  color: #ffffff;
}
.shopcar {
  position: absolute;
  top: 27px;
  right: 65px;
  height: 35px;
  width: 140px;
  text-align: center;
  line-height: 35px;
  font-size: 12px;
  color: #666666;
  background-color: #f7f7f7;
  border: 1px solid #dfdfdf;
}
.el-icon-close {
  line-height: 24px;
  float: right;
  height: 100%;
}
.shopcar .logo1 {
  position: absolute;
  top: -5px;
  left: 105px;
  height: 14px;
  line-height: 14px;
  color: #fefefe;
  background-color: red;
  padding: 0 5px;
  border-radius: 7px 7px 7px 0;
}
.sk {
  position: absolute;
  left: 183px;
  top: 40px;
  border-left: 1px solid #b1191a;
  padding: 3px 15px;
}
</style>
