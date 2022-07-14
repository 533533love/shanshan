<template>
  <div class="public-shop-cart">
    <div class="content">
      <span>全部商品</span>
      <div class="cart-title" v-show="goods.length != 0">
        <span>
          <input type="checkbox" id="all" v-model="flag" @change="quan" />
          <label for="all">全选</label>
        </span>
        <span>商品</span>
        <span>单价</span>
        <span>数量</span>
        <span>小计</span>
        <span>操作</span>
      </div>
      <div
        class="cart-detail"
        v-for="item in goods"
        :key="item.id"
        :style="item.state ? yang : ''"
      >
        <input type="checkbox" v-model="item.state" @click="demo(item)" />
        <div class="cart-title">
          <img :src="img + item.goodsimg" alt="" />
          <div>
            <a class="a" @click="detail(item)"
              ><i style="display: none"></i>{{ item.goodsname }}</a
            >
          </div>
        </div>
        <div class="cart-price">&yen;{{ item.goodsprice }}</div>
        <div class="cart-number">
          <span class="sub" @click="jian(item)">-</span>
          <input
            type="text"
            id="mumber"
            v-model.number="item.goodsnum"
            @change="number(item)"
          />
          <span class="plus" @click="jia(item)">+</span>
        </div>
        <div class="cart-subtotal">
          &yen;{{ (item.goodsnum * item.goodsprice).toFixed(2) }}
        </div>
        <button
          class="cart-oprate"
          @click="del(item)"
          @mouseover="shubiao($event)"
        >
          删除
        </button>
      </div>
      <div class="cart-btn" v-show="goods.length != 0">
        <span>总价：</span><span> ¥{{ total }} </span
        ><button class="btn" @click="jiesuan" @mouseover="shubiao($event)">
          去结算<i>({{ num }}件)</i>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      full: "",
      state: "",
      is: "",
      flag: "",
      img: this.$imgurl,
      user: sessionStorage.getItem("username"),
      yang: {
        "background-color": "#fff4e8",
      },
      goods: [],
    };
  },
  methods: {
    detail(item) {
      let goods = {
        name: item.goodsname,
        img: item.goodsimg,
        price: item.goodsprice,
        id: item.goodsid,
      };
      this.$router.push({
        path: "/detail",
        query: goods,
      });
    },
    demo(item) {
      if (item.state == 1) {
        this.state = 3;
      } else if (item.state == 0) {
        this.state = 2;
      }
      if (this.state == 3) {
        this.state = 2;
      } else {
        this.state = 3;
      }
      this.$axios
        .post("/shop", {
          user: this.user,
          state: this.state,
          goodsid: item.goodsid,
        })
        .then((res) => {
          for (var key in res.data) {
            if (res.data[key].state == 0) {
              this.flag = false;
              break;
            }
            this.flag = true;
          }
        });
    },
    jiesuan() {
      this.$axios
        .post("/shop", { u: sessionStorage.getItem("username"),yi:1 })
        .then((res) => {
          if (res.data) {
            this.full = res.data;
            if (this.num) {
              this.$router.push({
                path: "/tijiao"
              });
            } else {
              alert("请至少勾选一种商品");
            }
          }else {
              console.log("不存在");
              this.$router.push({
                path: "/userinfo",
                query: { flag: false },
              });
            }
          console.log(this.full);
        });
    },
    shubiao(e) {
      e.target.style.cursor = "pointer";
    },
    quan() {
      if (this.flag) {
        this.is = 2;
      } else {
        this.is = 1;
      }
      this.$axios
        .post("/shop", { flag: this.is, user: this.user })
        .then((res) => {
          this.goods = res.data;
        });
      console.log(this.flag);
    },
    del(item) {
      this.$axios
        .post("/shop", { user: this.user, goodsid: item.goodsid, del: true })
        .then((res) => {
          this.goods = res.data;
          this.$bus.$emit("jia", res.data.length);
          console.log(res.data);
        });
    },
    jia(item) {
      if (item.goodsnum < 99) {
        item.goodsnum++;
        item.total = (item.goodsnum * item.goodsprice).toFixed(2);
        this.$axios.post("shop", {
          user: this.user,
          j: item.goodsnum,
          goodsid: item.goodsid,
          total: item.total,
        });
      } else {
        alert("最多购买99件");
      }
    },
    jian(item) {
      if (item.goodsnum > 1) {
        item.goodsnum--;
        item.total = (item.goodsnum * item.goodsprice).toFixed(2);
        this.$axios.post("shop", {
          user: this.user,
          jian: item.goodsnum,
          goodsid: item.goodsid,
          total: item.total,
        });
      } else {
        alert("最少购买一件");
      }
    },
    number(item) {
      console.log(item.goodsnum);
      if (item.goodsnum < 1) {
        alert("最少购买一件");
        item.goodsnum = 1;
      } else if (item.goodsnum > 99) {
        alert("最多购买99件");
        item.goodsnum = 99;
      }
      item.total = (item.goodsnum * item.goodsprice).toFixed(2);
      this.$axios.post("shop", {
        user: this.user,
        b: item.goodsnum,
        goodsid: item.goodsid,
        total: item.total,
      });
    },
  },
  components: {},
  computed: {
    num() {
      let num = 0;
      for (const key in this.goods) {
        if (this.goods[key].state) {
          num += this.goods[key].goodsnum;
        }
      }
      return num;
    },
    total() {
      let total = 0;
      for (const key in this.goods) {
        if (this.goods[key].state) {
          total += parseFloat(
            this.goods[key].goodsnum * this.goods[key].goodsprice
          );
        }
      }
      return total.toFixed(2);
    },
  },
  watch: {},
  created() {
    this.$axios.post("/shop", { user: this.user }).then((res) => {
      this.goods = res.data;
      for (var key in res.data) {
        if (res.data[key].state == 0) {
          this.flag = false;
          break;
        }
        this.flag = true;
      }
    });
  },
  mounted() {},
  activated(){
    this.$axios.post("/shop", { user: this.user }).then((res) => {
      this.goods = res.data;
      for (var key in res.data) {
        if (res.data[key].state == 0) {
          this.flag = false;
          break;
        }
        this.flag = true;
      }
    });
  }
};
</script>

<style scoped>
.a:hover {
  cursor: pointer;
}
.public-shop-cart > .content {
  width: 1200px;
  background-color: #fff;
  margin: 20px auto;
  display: flex;
  flex-direction: column;
}
.public-shop-cart > .content > span {
  font-size: 20px;
  color: #e2231a;
  border-bottom: 1px solid #e2231a;
  height: 30px;
  width: 100px;
  padding: 3px;
}
.public-shop-cart > .content > .cart-title {
  height: 32px;
  background-color: #f3f3f3;
  border: 1px solid #eee;
  display: grid;
  grid-template-columns: 100px 1fr 100px 120px 100px 100px;
  align-items: center;
  padding-left: 10px;
}

/* #fff4e8 */
.public-shop-cart > .content > .cart-detail {
  background-color: #fff;
  border-bottom: 1px solid #ddd;
  padding: 20px 5px;
  display: grid;
  grid-template-columns: 40px 1fr 100px 120px 100px 100px;
  align-items: center;
}
.public-shop-cart > .content > div.cart-detail:last-of-type {
  border-bottom: none;
}
.public-shop-cart > .content > .cart-detail > .cart-title {
  display: flex;
}
.public-shop-cart > .content > .cart-detail > .cart-title > div {
  width: 300px;
  padding: 0 15px;
  display: flex;
  flex-flow: column wrap;
}
.cart-oprate {
  border: 1px solid #aaa;
  background-color: #fff;
}
i {
  font-style: normal;
  font-size: 14px;
}
.public-shop-cart > .content > .cart-detail > .cart-title > div > a > i {
  font-style: normal;
  color: #fff;
  background-color: #e2231a;
  border-radius: 3px;
  padding: 0 5px;
}
.public-shop-cart > .content > .cart-detail > .cart-title > div > a:hover {
  color: #e2231a;
}
.public-shop-cart > .content > .cart-detail > .cart-title > div > span > i {
  color: #e2231a;
  margin-right: 5px;
}
.public-shop-cart
  > .content
  > .cart-detail
  > .cart-title
  > div
  > span
  > a:hover {
  color: #e2231a;
}
.public-shop-cart > .content > .cart-detail > .cart-title > img {
  width: 80px;
  height: 80px;
}
.public-shop-cart > .content > .cart-detail > .cart-number {
  display: flex;
}
.public-shop-cart > .content > .cart-detail > .cart-number > input {
  width: 50px;
  height: 18px;
  text-align: center;
  outline: none;
  box-shadow: none;
  border: none;
  border-top: 1px solid #aaa;
  border-bottom: 1px solid #aaa;
}
.public-shop-cart > .content > .cart-detail > .cart-number > span {
  width: 20px;
  height: 20px;
  border: 1px solid #aaa;
  font-size: 15px;
  text-align: center;
}
.public-shop-cart > .content > .cart-detail > .cart-number > span:hover {
  cursor: pointer;
}
.public-shop-cart > .content > .cart-btn {
  margin-top: 50px;
  height: 50px;
  display: flex;
  justify-content: end;
  align-items: center;
  border: 1px solid #ddd;
}
.public-shop-cart > .content > .cart-btn > span:last-of-type {
  font-size: 20px;
  color: #e2231a;
  margin: 0 10px;
  font-weight: bold;
}
.public-shop-cart > .content > .cart-btn > .btn {
  height: 100%;
  font-size: 20px;
  color: #fff;
  border: none;
  background-color: #e2231a;
}
</style>
