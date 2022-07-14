<template>
  <div class="kuang">
    <i class="el-icon-back" v-show="isfan" @click="fanhui()">返回商品列表</i>
    <div class="search" v-if="goodsnum">已为你搜索到，以下商品，一共{{this.goodsnum}}种</div>
    <div class="no" v-if="isno">亲亲，这款商品还没有上架的哦</div>
    <a v-for="item in goodsinfo" :key="item.id">
      <img :src="imgurl + item.goodsimg" alt="" @click="buy(item)"/>
      <p>{{ item.goodsname }}</p>
      <span>¥</span>{{ item.goodsprice }}
      <div class="tri" :class="{ cs: item.like }" @click="change(item)">
        <span v-show="item.likes">{{ item.likes }}</span>
        &#10084;
      </div>
      <i
        class="el-icon-shopping-cart-full"
        @click="jiagou(item)"
        @mouseover="shubiao($event)"
        @mousedown="down($event)"
        @mouseup="up($event)"
      ></i>
      <div class="qiangg">
        <button @click="buy(item)" @mouseover="shubiao($event)">
          立即抢购
        </button>
      </div>
    </a>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      isfan:0,
      isno:0,
      goodsnum:'',
      raw: "",
      goodsinfo: "",
      imgurl: this.$imgurl,
    };
  },
  methods: {
    fanhui(){
       this.$axios
      .post("/edit", { get: 1, user: sessionStorage.getItem("username") })
      .then((res) => {
        this.goodsnum=0
        this.isno=0
        this.isfan=0
        this.raw = res.data;
        this.goodsinfo = this.raw;
        
      });
    },
    change(item) {
      if (sessionStorage.getItem("username")) {
        item.like = !item.like;
        if (item.like) {
          item.likes++;
        } else {
          item.likes--;
        }
        this.$axios
          .post("collect", { num: item.likes, goodsid: item.id })
          .then((res) => {
            console.log(res.data);
            this.$axios
              .post("/collect", {
                user: sessionStorage.getItem("username"),
                id: item.id,
                flag: item.like,
              })
              .then((res) => {});
          });
      }else{
        this.$router.push({
          path:'/uslogin'
        })
      }
    },
    shubiao(e) {
      e.target.style.cursor = "pointer";
    },
    down(e) {
      e.target.style.color = "black";
    },
    up(e) {
      e.target.style.color = "red";
    },
    buy(item) {
      let goods = {
        name: item.goodsname,
        img: item.goodsimg,
        price: item.goodsprice,
        id: item.id,
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
    jiagou(item, e) {
      let goods = {
        name: item.goodsname,
        img: item.goodsimg,
        price: item.goodsprice,
        num: 1,
        username: sessionStorage.getItem("username"),
        id: item.id,
      };
      // this.$bus.$emit("jia");
      if (!goods.username) {
        this.$router.push({
          path: "./uslogin",
        });
      } else {
        this.$axios.post("/buy", goods).then((res) => {
          this.$axios.post("/chatu", { user: goods.username }).then((res) => {
            this.$bus.$emit("jia", res.data.num);
          });
        });
      }
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    this.$axios
      .post("/edit", { get: 1, user: sessionStorage.getItem("username") })
      .then((res) => {
        this.raw = res.data;
        this.goodsinfo = this.raw;
      });
  },
  mounted() {
    this.$bus.$on("about", (data) => {
      this.goodsnum=0
      this.isno=0
      this.isfan=0
      this.goodsinfo = this.raw.filter(
        (item) => item.goodsname.indexOf(data) != -1
      );
      if(data){
        this.goodsnum=this.goodsinfo.length
        this.isfan=1
        if (this.goodsnum==0) {
          this.isno=1
        }
      }
    });
  },
};
</script>

<style scoped>
.el-icon-back{
  color: red;
}
.search{
  height: 30px;line-height: 30px;
}
.no{
  height: 30px;
  line-height: 30px;
}
.kuang>i{
  margin-right: 20px;
  font-size: 30px;
  cursor: pointer;
  text-decoration: none;
  float: left;
}
a>img{
  cursor: pointer;
}
.kuang{
  width: 1200px;
}
.tri > span {
  color: aqua;
  font-size: 25px;
}
.tri {
  position: absolute;
  right: 60px;
  bottom: 62px;
  font-size: 30px;
  color: #ccc;
  cursor: pointer;
}
.cs {
  color: #f00;
}
a {
  margin: 0 auto;
  position: relative;
  overflow: hidden;
  float: left;
  border: 1px solid transparent;
  width: 24%;
  height: 460px;
  font-size: 22px;
  color: #e60012;
}
p,
span {
  font-size: 14px;
}
span {
  margin-left: 12px;
  color: #e60012;
}
p {
  padding-left: 12px;
  margin-bottom: 10px;
  color: #666;
}
i {
  margin-left: 6px;
  color: #a4a4a4;
  text-decoration: line-through;
  font-style: normal;
}
a img {
  width: 100%;
  height: 315px;
}
.qiangg button {
  height: 50px;
  width: 290px;
  line-height: 50px;
  text-align: center;
  margin-top: 8px;
  background-color: #b1191a;
  color: #fff;
  font-size: 20px;
}
.el-icon-shopping-cart-full {
  float: right;
  color: red;
  margin-right: 20px;
  font-size: 30px;
}
</style>
