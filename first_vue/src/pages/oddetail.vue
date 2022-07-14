<template>
  <div class="a">
    <div class="state">
      <i class="el-icon-arrow-left" @click="back"></i> {{ goods.statename }}
    </div>
    <div class="time" v-if="goods.state == 2">{{ tishi(goods.time) }}</div>
    <i class="el-icon-s-shop" v-if="goods.state == 2"
      ><div class="h2">您的订单开始拣货</div>
      <div class="h1">{{ goods.time }}</div>
    </i>
    <i class="el-icon-location-outline"
      ><div class="hi">
        {{ user.name }} {{ user.phone }} {{ user.address }}
      </div></i
    >
    <div class="h3" v-if="goods.state != 1">
      <div class="f">购买成功</div>
      <div class="r">
        <span v-if="goods.type == 1"
          >购买数量：{{
            goods.reback
              ? parseInt(goods.goodsnum) + parseInt(goods.reback)
              : goods.goodsnum
          }}
        </span>
        <span v-else-if="goods.type == 0"
          >购买数量：{{
            goods.reback ? goods.num + parseInt(goods.reback) : goods.num
          }}
        </span>
        总金额：{{ goods.total }}
      </div>
    </div>
    <div class="h4" v-if="goods.type == 1">
      <div class="hh">
        <img :src="img + goods.goodsimg" alt="" />
        <div class="name">
          <div class="name">{{ goods.goodsname }}</div>
          <span
            :style="{
              backgroundColor:
                goods.state == 1
                  ? 'red'
                  : 1 < goods.state < 5
                  ? 'greenyellow'
                  : 'green',
            }"
            >{{
              goods.state == 1
                ? "待付款"
                : goods.state == 2
                ? "待发货"
                : goods.state == 3
                ? "待收货"
                : goods.state == 4
                ? "待评价"
                : goods.state == 5
                ? "已完成"
                : "交易失败"
            }}</span
          >
        </div>
        <div class="button">
          <el-button
            type="danger"
            size="mini"
            round
            v-if="goods.state != 1 && goods.state != 6"
            @click="tuikuan()"
            >申请退款</el-button
          >
          <el-button
            type="success"
            size="mini"
            round
            v-if="goods.state == 3"
            @click="shou"
            >确认收货</el-button
          ><el-button
            type="success"
            size="mini"
            round
            v-if="goods.state == 4"
            @click="ping"
            >立即评价</el-button
          ><el-button
            type="success"
            size="mini"
            round
            v-if="goods.state == 5"
            @click="cha"
            >查看评价</el-button
          >
        </div>
        <div class="fr">
          <span>￥{{ goods.goodsprice }}</span
          ><span class="a">X{{ goods.goodsnum }}</span>
        </div>
      </div>
    </div>
    <div class="h4" v-else-if="goods.type == 0">
      <div v-for="(item, i) in goods.goodsimg" :key="i" class="hh">
        <img :src="img + item" alt="" />
        <div class="name">
          <div class="name">{{ goods.goodsname[i] }}</div>
          <span
            :style="{
              backgroundColor:
                goods.states[i] == 1
                  ? 'red'
                  : 1 < goods.states[i] < 5
                  ? 'greenyellow'
                  : 'green',
            }"
            >{{
              goods.states[i] == 1
                ? "待付款"
                : goods.states[i] == 2
                ? "待发货"
                : goods.states[i] == 3
                ? "待收货"
                : goods.states[i] == 4
                ? "待评价"
                : goods.states[i] == 5
                ? "已完成"
                : "交易失败"
            }}</span
          >
        </div>
        <div class="button">
          <el-button
            type="danger"
            size="mini"
            round
            @click="tuikuan(i)"
            v-if="
              goods.states[i] != 1 &&
              goods.states[i] != 6 &&
              goods.goodsnum[i] != 0
            "
            >申请退款</el-button
          >
          <el-button
            type="success"
            size="mini"
            round
            v-if="goods.states[i] == 3"
            @click="shou(i)"
            >确认收货</el-button
          ><el-button
            type="success"
            size="mini"
            round
            v-if="goods.states[i] == 4"
            @click="ping(i)"
            >立即评价</el-button
          >
          <el-button
            type="success"
            size="mini"
            round
            v-if="goods.states[i] == 5"
            @click="cha(i)"
            >查看评价</el-button
          >
        </div>
        <div class="fr">
          <span>￥{{ goods.goodsprice[i] }}</span
          ><span class="a">X{{ goods.goodsnum[i] }}</span>
        </div>
      </div>
    </div>
    <div class="h5">
      <div>订单编号：{{ goods.orderid }}</div>
      <div>支付方式：支付宝</div>
      <div>下单时间：{{ goods.time }}</div>
      <!-- 啊啊 -->
      <div class="tui" v-if="goods.reback">
        <div class="zong">总金额：{{ goods.total }}元</div>
        <i>已退</i>
        <i style="color: red; font-style: normal">{{ goods.reback }}</i
        ><i> 件，共计</i
        ><i style="color: red; font-style: normal" v-if="goods.type == 1">{{
          (parseInt(goods.reback) * goods.goodsprice).toFixed(2)
        }}</i
        ><i
          style="color: red; font-style: normal"
          v-else-if="goods.type == 0"
          >{{ goods.rebacks.toFixed(2) }}</i
        ><i>元</i>
        <div class="shi" v-if="goods.type == 0">
          实付款：{{ (goods.total - goods.rebacks).toFixed(2) }}元
        </div>
        <div class="shi" v-else-if="goods.type == 1">
          实付款：{{
            (goods.total - parseInt(goods.reback) * goods.goodsprice).toFixed(
              2
            )
          }}元
        </div>
      </div>
    </div>
    <!-- //单商品点击申请退款按钮的模态框 -->
    <div class="motai" v-if="ismotai && goods.type == 1">
      <img :src="img + goods.goodsimg" alt="" />
      <div class="name">{{ goods.goodsname }}</div>
      <div class="price">￥{{ goods.goodsprice }}</div>
      <div class="num" v-show="isnum">X{{ motai }}</div>
      <input
        type="text"
        v-model.number="motai"
        class="num"
        @change="xianzhi"
        v-show="istext"
      />
      <div class="zong">共{{ (goods.goodsprice * motai).toFixed(2) }}元</div>

      <div class="jia" @click="jia" v-show="istext">+</div>
      <div class="jian" @click="jian" v-show="istext">-</div>
      <div class="button">
        <el-button
          type="danger"
          v-if="isque == 0"
          size="mini"
          round
          @click="tuiqian"
          >申请退款</el-button
        ><el-button
          type="success"
          v-if="isque"
          size="mini"
          round
          @click="queren"
          >确认退款</el-button
        >
      </div>
      <div class="guan">
        <i class="el-icon-error" @click="guan"></i>
      </div>
    </div>
    <!-- //多商品点击申请退款按钮的模态框 -->
    <div class="motai" v-else-if="ismotai && goods.type == 0">
      <img :src="img + goods.goodsimg[index]" alt="" />
      <div class="name">{{ goods.goodsname[index] }}</div>
      <div class="price">￥{{ goods.goodsprice[index] }}</div>
      <div class="num" v-show="isnum">X{{ motai[index] }}</div>
      <input
        type="text"
        v-model.number="motai[index]"
        class="num"
        @change="xianzhi(index)"
        v-show="istext"
      />
      <div class="zong">
        共{{ (goods.goodsprice[index] * motai[index]).toFixed(2) }}元
      </div>
      <div class="jia" @click="jia(index)" v-show="istext">+</div>
      <div class="jian" @click="jian(index)" v-show="istext">-</div>
      <div class="button">
        <el-button
          type="danger"
          v-if="isque == 0"
          size="mini"
          round
          @click="tuiqian(index)"
          >申请退款</el-button
        ><el-button
          type="success"
          v-if="isque"
          size="mini"
          round
          @click="queren(index)"
          >确认退款</el-button
        >
      </div>
      <div class="guan">
        <i class="el-icon-error" @click="guan"></i>
      </div>
    </div>
    <!-- //单商品立即评价 -->
    <div class="motai1" v-if="ismotai1 && goods.type == 1">
      <i class="el-icon-error" @click="guan(1)"></i>
      <div class="h1">
        <img :src="img + goods.goodsimg" alt="" />
        <div class="name">{{ goods.goodsname }}</div>
        <li
          v-for="(item, i) in xing"
          :key="i"
          @click="xingxing(i)"
          :class="{ cs: xing[i] }"
        >
          &#9733;
        </li>
        <div class="pingjia" v-show="xingshu != 0">
          评分：{{ xingshu }}星评价
        </div>
      </div>
      <div class="h2">
        <div class="imgs" v-for="(item, i) in imgurl" :key="i">
          <img :src="item" alt="" />
          <i class="el-icon-circle-close" @click="jiantu(i)"></i>
        </div>
        <input type="file" v-show="0" ref="file" @change="geng" />
        <div class="input" @click="jiatu" v-show="isjiatu">
          <i class="el-icon-camera-solid"></i><span>请选择图片</span>
        </div>
      </div>
      <div class="h3">
        <textarea
          name=""
          id=""
          cols="30"
          rows="10"
          v-model="comment"
        ></textarea>
        <el-button type="success" size="small" round @click="tijiao"
          >提交评价</el-button
        >
      </div>
    </div>
    <!-- 多商品立即评价 -->
    <div class="motai1" v-if="ismotai1 && goods.type == 0">
      <i class="el-icon-error" @click="guan(1)"></i>
      <div class="h1">
        <img :src="img + goods.goodsimg[index]" alt="" />
        <div class="name">{{ goods.goodsname[index] }}</div>
        <li
          v-for="(item, i) in xing"
          :key="i"
          @click="xingxing(i)"
          :class="{ cs: xing[i] }"
        >
          &#9733;
        </li>
        <div class="pingjia" v-show="xingshu != 0">
          评分：{{ xingshu }}星评价
        </div>
      </div>
      <div class="h2">
        <div class="imgs" v-for="(item, i) in imgurl" :key="i">
          <img :src="item" alt="" />
          <i class="el-icon-circle-close" @click="jiantu(i)"></i>
        </div>
        <input type="file" v-show="0" ref="file" @change="geng" />
        <div class="input" @click="jiatu" v-show="isjiatu">
          <i class="el-icon-camera-solid"></i><span>请选择图片</span>
        </div>
      </div>
      <div class="h3">
        <textarea
          name=""
          id=""
          cols="30"
          rows="10"
          v-model="comment"
        ></textarea>
        <el-button type="success" size="small" round @click="tijiao"
          >提交评价</el-button
        >
      </div>
    </div>
    <!--查看评价 -->
    <div class="motai2" v-show="ismotai2">
      <div class="h1">
        <i class="el-icon-error" @click="guan(2)"></i>
        <img :src="img+chakan.goodsimg" alt="">
        <div class="name">{{chakan.goodsname}}</div>
        <div class="ping" v-show="chakan.degree"><span>评分:</span><li class="cs" v-for="(item,i) in xing" :key="i" v-show="xing[i]">&#9733;</li></div>
      </div>
      <div class="pingjia">{{chakan.comment?chakan.comment:chakan.degree==5?`用户觉得商品不错，给出了${chakan.degree}星好评`:chakan.degree>=3?`用户觉得商品不错，给出了${chakan.degree}星评价`:`用户觉得商品一般，给出了${chakan.degree}星评价`}}</div>
      <div class="imgs" v-if="chakan.imgnums"><img v-for="(item,i) in chakan.imgs" :key="i"  :src="img+item" alt=""></div>
    </div>
  </div>

  <!-- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa -->
  <!-- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa -->
  <!-- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa -->
  <!-- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa -->
  <!-- aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa -->
</template>
<script>
export default {
  name: "",
  data() {
    return {
      chakan:'',//查看评价中转变量
      ismotai2:0,
      comment: "",
      isjiatu: 1,
      imgnum: 0,
      ismotai1: 0,
      imgurl: [],
      imgform: [],
      xingshu: 0,
      xing: [0, 0, 0, 0, 0],
      isque: 0,
      index: "",
      motai: "",
      isnum: 1,
      istext: 0,
      ismotai: 0,
      yanse: "",
      img: this.$imgurl,
      user: "",
      goods: "",
    };
  },
  methods: {
    //查看评价
    cha(i){
      if (Number.isInteger(i)) {
        this.$axios.post('chaping',{id:this.goods.orderid,goodsid:this.goods.goodsid[i]}).then(res=>{
          this.chakan=res.data
          console.log(res.data);
          for (let index = 0; index < res.data.degree; index++) {
            this.$set(this.xing,index,1)
          }
        })
      }else{
        this.$axios.post('chaping',{id:this.goods.orderid,goodsid:this.goods.goodsid}).then(res=>{
          this.chakan=res.data
           console.log(res.data);
           for (let index = 0; index < res.data.degree; index++) {
            this.$set(this.xing,index,1)
          }
        })
      }
      this.$bus.$emit("task", true);
      this.ismotai2=1
    },
    //提交评价
    tijiao() {
      let now = this.$moment().format("YYYY-MM-DD HH:mm:ss");
      let param = new FormData();
      param.append("orderid", this.goods.orderid);
      param.append("degree", this.xingshu);
      param.append("comment", this.comment);
      param.append("time", now);
      param.append("imgnums", this.imgform.length);
      param.append("user",sessionStorage.getItem('username'));
      if (this.goods.type == 0) {
        param.append("comstate", this.index);
        param.append("goodsid", this.goods.goodsid[this.index]);
        console.log(this.goods.goodsid[this.index]);
      }else{
        param.append("goodsid", this.goods.goodsid);
      }
      for (let index = 0; index < this.imgform.length; index++) {
        param.append("file"[index], this.imgform[index]);
      }
      let config = { headers: { "Content-Type": "multipart/form-data" } };
      if (this.xingshu > 0) {
        this.$axios.post("/order", param, config).then((res) => {
          console.log(res.data);
          this.goods = res.data;
            this.ismotai1 = 0;
            this.$bus.$emit("task", false);
            this.comment=''
            this.imgurl=[]
            this.imgform=[]
            this.imgnum=0
        });
      }
    },
    //删除不要的评价图片
    jiantu(i) {
      this.imgurl.splice(i, 1);
      this.imgform.splice(i, 1);
      this.imgnum--;
      this.isjiatu = 1;
    },
    //imgs区域显示图片，imgform参数生成
    geng() {
      let fileRead = new FileReader();
      fileRead.readAsDataURL(this.$refs.file.files[0]);
      fileRead.onload = (e) => {
        this.$set(this.imgurl, this.imgnum, e.target.result);
        this.$set(this.imgform, this.imgnum, this.$refs.file.files[0]);
        this.$refs.file.value = "";
        this.imgnum++;
        if (this.imgurl.length == 5) {
          this.isjiatu = 0;
        }
      };
    },
    //添加评论图片按钮
    jiatu() {
      this.$refs.file.click();
    },
    //控制星星的样式
    xingxing(i) {
      if (this.xingshu == 0) {
        this.xingshu = i + 1;
        for (let index = 0; index <= i; index++) {
          this.$set(this.xing, index, 1);
        }
      } else {
        if (i > this.xingshu - 1) {
          for (let index = this.xingshu - 1; index <= i; index++) {
            this.$set(this.xing, index, 1);
          }
          this.xingshu = i + 1;
        } else if (i < this.xingshu - 1) {
          for (let index = i + 1; index <= this.xingshu - 1; index++) {
            this.$set(this.xing, index, 0);
          }
          this.xingshu = i + 1;
        }
      }
      console.log(i);
    },
    //立即评价按钮
    ping(i) {
      this.$bus.$emit("task", true);
      this.xingshu = 0;
      for (let index = 0; index < this.xing.length; index++) {
        this.$set(this.xing, index, 0);
      }
      if (Number.isInteger(i)) {
        this.index = i;
        this.ismotai1 = 1;
      } else {
        this.ismotai1 = 1;
      }
    },
    //确认收货按钮
    shou(i) {
      let que = confirm("确认收货吗？");
      if (que) {
        if (Number.isInteger(i)) {
          this.$axios
            .post("/shou", { id: this.goods.id, i: i, duo: 1 })
            .then((res) => {
              this.goods = res.data;
              console.log(res.data);
            });
        } else {
          this.$axios.post("/shou", { id: this.goods.id }).then((res) => {
            this.goods = res.data;
          });
        }
      }
    },
    //确认退款按钮
    queren(i) {
      if (Number.isInteger(i)) {
        this.$axios
          .post("quxiao", {
            id1: this.goods.id,
            duo: 1,
            num: this.motai[i],
            i: i,
          })
          .then((res) => {
            this.isque = 0;
            this.istext = 0;
            this.isnum = 1;
            if (res.data.goodsnum[i] == 0) {
              this.ismotai = 0;
              this.$bus.$emit("task", false);
            }
            this.goods = res.data;
            this.motai = res.data.goodsnum;
          });
      } else {
        this.$axios
          .post("quxiao", { id1: this.goods.id, num: this.motai })
          .then((res) => {
            this.isque = 0;
            this.istext = 0;
            this.isnum = 1;
            if (res.data.goodsnum == 0) {
              this.ismotai = 0;
              this.$bus.$emit("task", false);
            }
            this.goods = res.data;
            this.motai = res.data.goodsnum;
          });
      }
    },
    //模态框的×
    guan(i) {
      if (i == 1) {
        this.ismotai1 = 0;
        this.$bus.$emit("task", false);
      }else if(i==2){
        this.ismotai2 = 0;
        for (const key in this.xing) {
          this.$set(this.xing,key,0)
        }
        this.$bus.$emit("task", false);
      } else {
        this.isque = 0;
        this.ismotai = 0;
        this.isnum = 1;
        this.istext = 0;
        this.$bus.$emit("task", false);
      }
    },
    //商品数量输入的限制
    xianzhi(i) {
      if (Number.isInteger(i)) {
        console.log(this.motai[i]);
        console.log(this.goods.goodsnum[i]);
        if (this.motai[i] > this.goods.goodsnum[i]) {
          console.log("大于");
          this.$set(this.motai, i, this.goods.goodsnum[i]);
        } else if (this.motai[i] < 1) {
          this.$set(this.motai, i, 1);
        }
      } else {
        if (this.motai > this.goods.goodsnum) {
          this.motai = this.goods.goodsnum;
        } else if (this.motai < 1) {
          this.motai = 1;
        }
      }
    },
    //退款控制商品数量
    jia(i) {
      if (Number.isInteger(i)) {
        if (this.motai[i] < this.goods.goodsnum[i]) {
          this.$set(this.motai, i, this.motai[i] + 1);
        }
      } else {
        if (this.motai < this.goods.goodsnum) {
          this.motai++;
        }
      }
    },
    //退款控制数量
    jian(i) {
      if (Number.isInteger(i)) {
        if (this.motai[i] > 1) {
          console.log("大于");
          this.$set(this.motai, i, this.motai[i] - 1);
        }
      } else {
        if (this.motai > 1) {
          this.motai--;
        }
      }
    },
    //模态框申请退款按钮
    tuiqian(i) {
      this.isque = 1;
      if (Number.isInteger(i)) {
        if (this.motai[i] > 1) {
          this.isnum = 0;
          this.istext = 1;
        }
      } else {
        if (this.motai > 1) {
          this.isnum = 0;
          this.istext = 1;
        }
      }
    },
    //订单详情申请退款按钮
    tuikuan(i) {
      if (this.goods.type != 1) {
        if (this.motai[i] > 1) {
          this.$bus.$emit("task", true);
          this.index = i;
          this.ismotai = 1;
        } else {
          this.$axios
            .post("/quxiao", {
              id1: this.goods.id,
              duo: 1,
              num: this.goods.goodsnum[i],
              i: i,
            })
            .then((res) => {
              this.goods = res.data;
            });
        }
      } else {
        if (this.motai > 1) {
          this.$bus.$emit("task", true);
          this.ismotai = 1;
        } else {
          this.$axios
            .post("/quxiao", { id1: this.goods.id, num: this.goods.goodsnum })
            .then((res) => {
              this.goods = res.data;
            });
        }
      }
    },
    //#region
    // tui(i) {
    //   if (this.goods.type == 1) {
    //     this.$axios
    //       .post("/quxiao", { id1: this.goods.id, num: this.motai })
    //       .then((res) => {
    //         this.goods = res.data;
    //         this.motai = res.data.goodsnum;
    //       });
    //   } else {
    //     this.$axios
    //       .post("/quxiao", { id2: this.goods.id, num: this.motai[i], i: i })
    //       .then((res) => {
    //         this.goods = res.data;
    //         this.motai[index] = res.data.goodsnum[index];
    //       });
    //   }
    // },
    //#endregion
    //返回订单列表页面
    back() {
      this.$router.push({
        path: "/order",
        query: { state: this.$route.query.state },
      });
    },
    //控制订单状态描述
    tishi(item) {
      let a = item.indexOf(":");
      let b = item.substring(a - 2, 13);
      let tishi1 = "您的订单今天即将发出";
      if (b < 17) {
        tishi1 = "您的订单今天即将发出";
      } else {
        tishi1 = "您的订单最晚明天发出";
      }
      return tishi1;
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    this.$axios
      .post("/quxiao", {
        id: this.$route.query.id,
        user: sessionStorage.getItem("username"),
      })
      .then((res) => {
        this.user = res.data.user;
        this.goods = res.data.goods;
        this.motai = JSON.parse(JSON.stringify(this.goods.goodsnum));
        if (this.goods.type == 1) {
          this.yanse = "";
        } else {
          this.yanse = [];
          for (const key in this.goods.goodsimg) {
            this.yanse[key] = [];
          }
        }
        console.log(this.goods);
      });
  },
  mounted() {},
  activated(){
    this.$axios
      .post("/quxiao", {
        id: this.$route.query.id,
        user: sessionStorage.getItem("username"),
      })
      .then((res) => {
        this.user = res.data.user;
        this.goods = res.data.goods;
        this.motai = JSON.parse(JSON.stringify(this.goods.goodsnum));
        if (this.goods.type == 1) {
          this.yanse = "";
        } else {
          this.yanse = [];
          for (const key in this.goods.goodsimg) {
            this.yanse[key] = [];
          }
        }
        console.log(this.goods);
      });
  }
};
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
</script>
<style scoped>
.motai2>.pingjia{
  width: 100%;
}
.motai2>.imgs>img{
  width: 150px;
  height: 120px;
  float: left;
  margin-right: 10px;
}
.motai2>.imgs{
  display: flex;
}
.motai2>.h1>.name{
  font-size: 24px;
  text-align: center;
  height: 80px;
  line-height: 80px;
  flex: 1;
}
.motai2>.h1>.ping{
  flex: 2;
}
.motai2>.h1>.ping>span{
  font-size: 20px;

  float: left;
  height: 80%;
  line-height: 80px;
}
.motai2>.h1>img{
  width: 100px;
  height: 100px;
  flex: 1;
}
.motai2>.h1{
  display: flex;
  margin-left: 0;
}
.motai2{
  padding: 20px;
  z-index: 33;
  position: absolute;
  width: 800px;
  top: 153px;
  right: 0px;
  height: 300px;
  background-color: #fff;
}
.el-icon-error {
  cursor: pointer;
  position: absolute;
  top: 0px;
  right: 0px;
}
.motai1 > .h3 {
  height: 120px;
  width: 100%;
}
.h3 > textarea {
  height: 100%;
  width: 80%;
  margin-right: 20px;
}
.imgs > .el-icon-circle-close {
  position: absolute;
  top: -15px;
  right: -15px;
  cursor: pointer;
}
.h2 > .imgs {
  margin-left: 15px;
  margin-top: 10px;
  position: relative;
  height: 100px;
  width: 120px;
  float: left;
}
.imgs > img {
  height: 100px;
  width: 120px;
}
.input > .el-icon-camera-solid {
  margin-left: 36%;
}
.input > span {
  text-align: center;
  width: 100%;
  float: left;
  font-size: 20px;
}
.motai1 > .h2 {
  margin-left: 0;
  height: 120px;
  width: 100%;
}
.h2 > .input {
  height: 100px;
  width: 120px;
  float: left;
  cursor: pointer;
}
.h1 > .pingjia {
  margin-left: 20px;
  float: left;
  height: 80px;
  line-height: 80px;
}
.motai1 > .h1 {
  font-size: 20px;
  height: 120px;
  width: 100%;
}
.motai1 > .h1 > .name {
  line-height: 80px;
  height: 80px;
  width: 100px;
  float: left;
  margin-right: 20px;
}
.h1 > img {
  height: 100px;
  width: 100px;
  float: left;
}
.h1 {
  height: 120px;
  width: 100%;
}
.motai1 {
  z-index: 33;
  background-color: #fff;
  box-sizing: border-box;
  padding: 20px;
  padding-left: 35px;
  height: 400px;
  width: 800px;
  position: absolute;
  top: 111px;
  right: 0px;
}
li {
  height: 80px;
  line-height: 80px;
  float: left;
  margin-right: 5px;
  font-size: 30px;
  color: #fff;
  cursor: pointer;
  -webkit-text-stroke: 1px #000;
}
.cs {
  color: rgba(230, 230, 18, 0.938);
}
.guan {
  font-size: 24px;
  position: absolute;
  right: 0;
  top: -5px;
  cursor: pointer;
}
.motai > .zong {
  float: left;
}
.motai > .price {
  float: left;
}
.motai > .num {
  text-align: center;
  width: 24px;
  height: 24px;
  box-sizing: border-box;
  margin-left: 30px;
  margin-right: 40px;
  float: left;
}
.jian {
  cursor: pointer;
  border: 1px solid #000;
  width: 15px;
  height: 15px;
  text-align: center;
  line-height: 15px;
  border-top: 0;
  position: absolute;
  top: 30px;
  right: 319px;
}
.jia {
  cursor: pointer;
  border: 1px solid #000;
  width: 15px;
  height: 15px;
  text-align: center;
  line-height: 15px;
  position: absolute;
  top: 13px;
  right: 319px;
}
.motai > .name {
  width: 120px;
  margin-left: 30px;
  float: left;
}
.motai > img {
  height: 100px;
  width: 150px;
  float: left;
}
.motai {
  z-index: 33;
  background-color: #fff;
  box-sizing: border-box;
  padding: 20px;
  padding-left: 35px;
  height: 150px;
  width: 800px;
  position: absolute;
  top: 111px;
  right: 0px;
}
.button {
  float: left;
  margin-left: 30px;
}
.name > span {
  border: 1px solid rgb(63, 61, 61);
}
.el-icon-arrow-left {
  float: left;
  cursor: pointer;
}
.h5 > div {
  height: 30px;
  width: 100%;
  margin-top: 5px;
}
.h5 {
  margin-top: 10px;
  height: 100px;
  border-top: 1px solid #000;
  width: 100%;
  font-size: 16px;
  color: rgb(106, 110, 108);
}
.hh .fr {
  float: right;
  width: 200px;
}
.hh .fr span {
  margin-top: 4px;
  display: block;
}
.h4 {
  width: 100%;
}
.hh {
  border-top: 1px solid black;
  position: relative;
  height: 80px;
  width: 100%;
}
.h4 img {
  height: 100%;
  float: left;
  width: 100px;
}
.name > span {
  margin-left: 30px;
  float: left;
}
.name > .name {
  width: 120px;
  float: left;
  text-align: center;
}
.h4 .name {
  margin-left: 20px;
  float: left;
}
.h3 .f {
  float: left;
}
.h3 span {
  margin-right: 60px;
}
.h3 .r {
  padding-right: 10px;
  float: right;
  width: 65%;
}
.tui {
  height: 30px;
  float: right;
}
.tui > i {
  font-style: normal;
  float: left;
}
.tui > .shi {
  float: left;
  margin-left: 20px;
}
.tui > .zong {
  margin-bottom: 5px;
  width: 200px;
  float: left;
}
.h3 {
  line-height: 40px;
  height: 40px;
  width: 100%;
}
.state {
  width: 100%;
  height: 50px;
  font-size: 40px;
  text-align: center;
  line-height: 50px;
  margin: 0 auto;
}
.el-icon-location-outline::before {
  position: absolute;
}
.el-icon-location-outline > .hi {
  width: 600px;
  min-height: 50px;
  line-height: 50px;
  font-size: 30px;
  color: black;
  margin-left: 50px;
}
.el-icon-location-outline {
  width: 100%;
  border-top: 1px solid black;
  border-bottom: 1px solid black;
  font-size: 50px;
  color: rgb(126, 14, 14);
}
.time {
  margin-left: 322px;
}
.a {
  position: relative;
  width: 800px;
  margin: 0 auto;
}
.h1,
.h2 {
  flex: 1;
  font-size: 30px;
  margin-left: 50px;
}
.el-icon-s-shop:before {
  position: absolute;
  top: 25px;
  font-size: 50px;
}
.el-icon-s-shop {
  border-top: 1px solid black;
  position: relative;
  display: flex;
  flex-direction: column;
  width: 100%;
  color: rgb(26, 228, 43);
  font-size: 30px;
  line-height: 40px;
}
</style>
