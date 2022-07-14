<template>
  <div class="jue">
    <div class="top">
      <li
        v-for="(it, i) in class1"
        :key="i"
        @click="beforeget(i)"
        :class="{ current: class1[i] }"
      >
        {{ tabname(i) }}
      </li>
    </div>
    <el-alert
      :style="{ display: isalert }"
      :closable="false"
      center
      title="错误信息"
      type="error"
      description="您还没有选择星级评分"
      show-icon
    >
    </el-alert>
    <div v-for="(item, index) in shu" :key="item.id">
      <div v-if="item.type == 1" class="context">
        <div class="imgs" @click="orderdetail(item.id)">
          <img :src="img + item.goodsimg" alt="" />
        </div>
        <h1>
          <div class="f">
            <p>{{ item.goodsname }}</p>
          </div>
          <div class="r">
            <i>X{{ item.goodsnum }}</i>
            <div class="t" v-if="item.state == 1">{{ arr[index] }}</div>
            <el-button
              type="danger"
              v-if="item.state == 1"
              class="b"
              @click="quxiao(item)"
              size="small"
              round
              >取消订单</el-button
            ><el-button
              type="danger"
              v-if="item.state == 1"
              class="fu"
              size="small"
              round
              @click="buying(item)"
              >立即付款</el-button
            ><el-button
              type="danger"
              v-if="item.state == 6"
              class="b"
              size="small"
              round
              @click="quxiao(item)"
              >删除订单</el-button
            ><el-button
              type="danger"
              v-else-if="item.state != 1 && item.state != 6"
              class="b"
              @click="tuiqian(item)"
              size="small"
              round
              >申请退款</el-button
            ><el-button
              type="danger"
              v-if="item.state == 3"
              size="small"
              round
              class="c"
              @click="que(item)"
              >确认收货</el-button
            ><el-button
              type="danger"
              v-if="item.state == 4"
              size="small"
              round
              class="c"
              @click="comment(item)"
              >立即评价</el-button
            ><el-button
              type="danger"
              v-if="item.state == 5"
              size="small"
              round
              class="c"
              @click="look(item)"
              >查看评价</el-button
            >
          </div>
        </h1>
        <div class="right">
          <p>{{ item.statename }}</p>
          <p>
            ￥{{
              item.reback
                ? (
                    item.goodsprice *
                    (item.goodsnum + parseInt(item.reback))
                  ).toFixed(2)
                : (item.goodsprice * item.goodsnum).toFixed(2)
            }}
          </p>
          <span
            >共{{
              item.reback
                ? item.goodsnum + parseInt(item.reback)
                : item.goodsnum
            }}件
            <span v-if="item.reback" style="color: red"
              >已退{{ item.reback }}件</span
            ></span
          >
        </div>
      </div>
      <div v-if="item.type == 0" class="context">
        <div class="imgs" @click="orderdetail(item.id)">
          <img
            v-for="(it, i) in item.goodsimg"
            :key="i"
            :src="img + it"
            alt=""
          />
        </div>
        <h1>
          <div class="f">
            <p v-for="(it, i) in item.goodsname" :key="i">{{ it }}</p>
          </div>
          <div class="r">
            <i v-for="(it, i) in item.nums" :key="i">X{{ it }}</i>
            <div class="t" v-if="item.state == 1">{{ arr[index] }}</div>
            <el-button
              type="danger"
              v-if="item.state == 1"
              class="b"
              size="small"
              round
              @click="quxiao(item)"
              >取消订单</el-button
            ><el-button
              type="danger"
              v-if="item.state == 1"
              class="fu"
              size="small"
              round
              @click="buying(item)"
              >立即付款</el-button
            ><el-button
              type="danger"
              v-if="item.state == 6"
              class="b"
              size="small"
              @click="quxiao(item)"
              round
              >删除订单</el-button
            ><el-button
              type="danger"
              v-else-if="item.state != 1 && item.state != 6"
              class="b"
              size="small"
              round
              @click="tuiqian(item)"
              >申请退款</el-button
            ><el-button
              type="danger"
              v-if="item.state == 3"
              size="small"
              round
              class="c"
              @click="que(item)"
              >确认收货</el-button
            ><el-button
              type="danger"
              v-if="item.state == 4"
              size="small"
              round
              class="c"
              @click="comment(shu[index])"
              >立即评价</el-button
            ><el-button
              type="danger"
              v-if="item.state == 5"
              size="small"
              round
              class="c"
              @click="look(item)"
              >查看评价</el-button
            >
          </div>
        </h1>
        <div class="right">
          <p>{{ item.statename }}</p>
          <p>￥{{ item.total }}</p>
          <span
            >共{{
              item.reback
                ? parseInt(item.num) + parseInt(item.reback)
                : item.num
            }}件
            <span v-if="item.reback" style="color: red"
              >已退{{ item.reback }}件</span
            ></span
          >
        </div>
      </div>
    </div>
    <div :class="{ motai: istrue }" v-if="istrue">
      <div class="title">
        商品评价
        <div class="cla" @click="guan">X</div>
      </div>
      <div class="context1" v-if="coments.type == 1">
        <div class="h1">
          <img :src="img + coments.goodsimg" alt="" />
          <p>{{ coments.goodsname }}</p>
          <div class="li">
            综合评分{{ pingfen }}
            <li
              v-for="i1 in degrees"
              :key="i1"
              :class="{ cs: active[i1] }"
              @click="dianji(i1)"
            >
              &#9733;
            </li>
          </div>
        </div>
        <div class="h3">
          <div v-for="(i, ii) in img1" :key="ii" class="tu">
            <img :src="img1[ii]" />
            <i class="el-icon-circle-close" @click="shantu(ii)"></i>
          </div>
          <input type="file" ref="file" @change="xiantu" />
          <div class="img" @click="jiatu" :style="{ display: isimg }">
            <i class="el-icon-camera-solid"></i
            >{{
              num == 0 ? "请选择图片" : "还可上传" + parseInt(5 - num) + "张"
            }}
          </div>
        </div>
        <div class="h2">
          <textarea name="" id="" cols="30" rows="10" v-model="area"></textarea>
          <el-button size="small" type="success" @click="talk">评价</el-button>
        </div>
      </div>
      <div class="context1" v-if="coments.type == 0">
        <div
          class="duo"
          v-for="(item, i) in coments.goodsimg"
          :key="coments.goodsid[i]"
          v-show="coments.comstate[i] == 0"
        >
          <div class="h1">
            <img :src="img + item" alt="" />
            <p>{{ coments.goodsname[i] }}</p>
            <div class="li">
              综合评分{{ pingfens[i] }}
              <li
                :biaoji="i"
                ref="li"
                v-for="i1 in degrees"
                :key="i1"
                @click="dianji(i, i1)"
                :class="{ cs: active[i][i1 - 1] }"
              >
                &#9733;
              </li>
            </div>
          </div>
          <div class="h3">
            <div v-for="(i2, ii) in img1[i]" :key="ii" class="tu">
              <img :src="i2" /><i
                class="el-icon-circle-close"
                @click="shantu(i, ii)"
              ></i>
            </div>
            <input type="file" ref="file" @change="xiantu(i)" />
            <div class="img" :style="{ display: isimg[i] }" @click="jiatu(i)">
              <i class="el-icon-camera-solid"></i
              >{{
                img1[i].length == 0
                  ? "请选择图片"
                  : 5 - img1[i].length == 0
                  ? ""
                  : "还可上传" + parseInt(5 - img1[i].length) + "张"
              }}
            </div>
          </div>
          <div class="h2">
            <textarea
              name=""
              id=""
              cols="30"
              rows="10"
              v-model="area[i]"
            ></textarea>
            <el-button size="small" type="success" @click="talk(i)"
              >评价</el-button
            >
          </div>
        </div>
      </div>
    </div>
    <!-- 查看评论 -->
    <div :class="{ motai1: istrue1 }" v-if="istrue1">
      <div class="title">
        商品评价详情
        <div class="cla" @click="guan(1)">X</div>
      </div>
      <div class="h2" v-for="(item, t) in coments" :key="item.goodsid">
        <div class="goods">
          <img :src="img + item.goodsimg" alt="" />
          <div class="name">{{ item.goodsname }}</div>
          <div class="degree">
            <span>综合评分：</span>
            <li
              v-for="(y, r) in xing[t]"
              :key="r"
              class="xing"
              :class="{ cs: xing[t][r] }"
            >
              &#9733;
            </li>
          </div>
        </div>
        <div class="text">{{ text(item) }}</div>
        <div class="imgs">
          <img v-for="(o, u) in item.imgs" :key="u" :src="img + o" />
        </div>
      </div>
    </div>
    <!-- 退款界面 -->
    <div class="yin" :class="{ motai2: ismotai2 }">
      <div class="title">
        <h3>
          请选择需要操作的商品(数量)
          <i class="el-icon-close" @click="guan(2)"></i>
        </h3>
      </div>

      <div class="h1" v-if="coments.type == 1">
        <div class="num1" :class="{ plus: is1 }" @click="plus(coments.type)">
          +
        </div>
        <div class="num1" :class="{ dec: is1 }" @click="dec(coments.type)">
          -
        </div>
        <img :src="img + coments.goodsimg" alt="" />
        <div class="name">{{ coments.goodsname }}</div>
        <div class="price">{{ coments.goodsprice }}</div>
        <div class="num1" :class="{ num: isput }">X{{ coments.goodsnum }}</div>
        <input
          type="text"
          class="num1"
          v-model.number="goodsnum"
          @change="xianzhi"
          :class="{ num2: is1 }"
        />
        <div class="state">
          货物状态：<span :style="{ backgroundColor: yanse }">{{
            changge(coments)
          }}</span>
        </div>
        <div class="button">
          <el-button
            size="mini"
            :class="{ num1: disabled }"
            v-if="coments.state != 1 && coments.state != 6"
            @click="drawback(coments)"
            type="danger"
            >申请退款</el-button
          ><el-button
            size="mini"
            :style="{ marginLeft: 0 }"
            :class="{ num1: is2 }"
            v-if="coments.state != 1 && coments.state != 6"
            @click="titui(coments)"
            type="danger"
            >确认退款</el-button
          >
        </div>
      </div>

      <div
        class="h1"
        v-else-if="coments.type != 1"
        v-for="(item, i) in coments.goodsimg"
        :key="i"
      >
        <div
          class="num1"
          :class="{ plus: is1[i] }"
          @click="plus(coments.type, i)"
        >
          +
        </div>
        <div
          class="num1"
          :class="{ dec: is1[i] }"
          @click="dec(coments.type, i)"
        >
          -
        </div>
        <img :src="img + item" alt="" />
        <div class="name">{{ coments.goodsname[i] }}</div>
        <div class="price">{{ coments.goodsprice[i] }}</div>
        <div class="num1" :class="{ num: isput[i] }">X{{ goodsnum[i] }}</div>
        <input
          type="text"
          class="num1"
          @change="xianzhi(i)"
          v-model="goodsnum[i]"
          :class="{ num2: is1[i] }"
        />
        <div class="state">
          货物状态：<span
            :style="{
              backgroundColor:
                coments.states[i] == 1
                  ? 'red'
                  : 1 < coments.states[i] < 5
                  ? 'greenyellow'
                  : 'green',
            }"
            >{{
              coments.states[i] == 1
                ? "待付款"
                : coments.states[i] == 2
                ? "待发货"
                : coments.states[i] == 3
                ? "待收货"
                : coments.states[i] == 4
                ? "待评价"
                : coments.states[i] == 5
                ? "已完成"
                : "交易失败"
            }}</span
          >
        </div>
        <div class="button">
          <el-button
            size="mini"
            :class="{ num1: disabled[i] }"
            v-if="coments.states[i] != 1 && coments.states[i] != 6"
            type="danger"
            @click="drawback(coments, i)"
            >申请退款</el-button
          >
          <el-button
            size="mini"
            :class="{ num1: is2[i] }"
            :style="{ marginLeft: 0 }"
            v-if="coments.states[i] != 1 && coments.states[i] != 6"
            @click="titui(coments, i)"
            type="danger"
            >确认退款</el-button
          ><el-button
            size="mini"
            disabled
            :style="{ marginLeft: 0 }"
            v-if="coments.states[i] == 6"
            type="danger"
            >交易失败</el-button
          >
          <el-button
            size="mini"
            v-if="coments.states[i] == 3"
            type="success"
            @click="shou(item, i)"
            >确认收货</el-button
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      is2: 1, //控制确认退款按钮的显示
      disabled: false, //是否隐藏申请退款按钮
      goodsnum: "", //为数组是控制多商品订单的商品数量得以响应式
      is1: 0, ////控制订单详情页面商品数量input文本框得显示
      isput: 1, //控制订单详情页面商品数量得显示
      yanse: "", //控制订单详情页面货物状态颜色样式
      ismotai2: 0, //控制退款界面的显示
      isimg: "block", //控制添加图片按钮的显示
      isalert: "none", //控制星级评分错误警告的显示
      img1: [], //为一维数组时储存单商品订单评论图片的显示容器，二维即控制多商品
      imgform: [], //为一维数组时储存单商品订单评论图片的表单信息容器，二维即控制多商品
      num: 0, //不为数组时记录单商品订单图片个数，为数组时记录多商品
      pingfen: "", //单商品评分时‘综合评分’后面的显示
      area: "", //不为数组时记录单商品订单评论的文字内容，为数组时记录多商品
      active: [], //为一维数组时控制单商品订单评分五角星的样式。二维数组控制多商品
      degrees: [1, 2, 3, 4, 5], //生成5个无样式的五角星，数组里面的数字代表着这是第几颗星
      degree: "", //每种商品点击评论发起请求时存储点亮的星星数
      istrue: false, //点击立即评价，控制评价框的显示
      istrue1: false, //控制查看评价的显示
      coments: "", //显示立即评价或查看评价时，请求的数据的载体
      a: [], //储存未付款订单计时的定时器
      arr: [], //定时器的文字显示
      xing: [], //控制评价详情五角星的显示，为一维数组时控制单商品，多维控制多商品
      img: this.$imgurl, //后端图片的前缀域名等信息
      raw: "", //请求的未经筛选的原始数据信息
      shu: "", //订单数据的载体
      state: 0, //记录tab栏状态
      class1: [1, 0, 0, 0, 0, 0], //tab栏样式的控制
      pingfens: [], //多商品评分时‘综合评分’后面的显示
    };
  },
  methods: {
    //多商品订单确认收货
    shou(item, i) {
      this.$axios
        .post("shou", {
          id: this.coments.id,
          i: i,
          duo: 1,
          user: sessionStorage.getItem("username"),
        })
        .then((res) => {
          this.coments = res.data.bu;
          this.raw = res.data.quan;
          this.shuaixuan();
          if (this.coments.state != 3) {
            this.ismotai2 = 0;
            this.$bus.$emit("task", false);
          }
          console.log(res.data.quan);
        });
    },
    //点击申请退款后dom的隐藏
    yin() {
      this.$bus.$emit("task", false); //遮罩层关闭
      this.ismotai2 = 0; //操作页面关闭 0为隐藏 1为显示
      this.is2 = 1; //操作页面确认退款按钮隐藏 1隐藏 0 为显示
      this.isput = 1; //操作页面商品数量不是以文本框形式的显示 1为显示 0 为隐藏
      this.disabled = false; //显示操作页面申请退款按钮 true为隐藏 false为显示
      this.is1 = 0; ////操作页面商品数量以文本框形式的显示 1为显示 0 为隐藏
    },
    //确认退款
    titui(item, i) {
      //单商品点击确认退款
      if (item.type == 1) {
        this.allback(item, this.goodsnum);
      }
      //多商品点击，i表示第几个 goodsnum[i]表示哪个商品需要退款的数量
      else {
        this.allback(item, i, this.goodsnum[i]);
      }
    },
    //加商品数量
    plus(i, j) {
      if (i == 1) {
        if (this.goodsnum < this.coments.goodsnum) {
          this.goodsnum++;
        } else {
          alert("不能大于购买数量");
        }
      } else {
        if (this.goodsnum[j] < this.coments.goodsnum[j]) {
          this.$set(this.goodsnum, j, this.goodsnum[j] + 1);
        } else {
          alert("不能大于购买数量");
        }
      }
    },
    //减去商品数量
    dec(i, j) {
      if (i == 1) {
        if (this.goodsnum <= this.coments.goodsnum && this.goodsnum > 1) {
          this.goodsnum--;
        } else {
          alert("只少为1");
        }
      } else {
        if (
          this.goodsnum[j] <= this.coments.goodsnum[j] &&
          this.goodsnum[j] > 1
        ) {
          this.$set(this.goodsnum, j, this.goodsnum[j] - 1);
        } else {
          alert("只少为1");
        }
      }
    },
    //商品退款
    allback(item, i, num) {
      if (item.type == 1) {
        this.$axios.post("/quxiao", { id1: item.id, num: i }).then((res) => {
          this.coments = res.data;
          this.$axios
            .post("/getorder", { user: this.coments.username })
            .then((res) => {
              this.raw = res.data;
              this.shuaixuan();
              let lin = res.data.filter((it) => it.id == item.id);
              console.log(lin[0].state);
              if (lin[0].state == 6) {
                console.log("隐藏");
                this.yin();
              } else {
                this.is2 = 1;
                this.isput = 1;
                this.disabled = false;
                this.is1 = 0;
              }
            });
        });
      } else {
        this.$axios
          .post("/quxiao", { id1: item.id, i: i, duo: 1, num: num })
          .then((res) => {
            this.coments = res.data;
            this.is2 = []; //需要隐藏即为1
            this.isput = []; //需要显示即为1
            this.disabled = []; //需要显示即为false
            this.is1 = []; //需要隐藏即为0
            this.yanse = [];
            this.goodsnum = [];
            for (const key in this.coments.goodsimg) {
              this.yanse[key] = [];
              this.$set(this.goodsnum, key, this.coments.goodsnum[key]);
              this.$set(this.is2, key, 1);
              this.$set(this.is1, key, 0);
              this.$set(this.isput, key, 1);
              this.$set(this.disabled, key, false);
            }
            this.$axios
              .post("/getorder", { user: this.coments.username })
              .then((res) => {
                this.raw = res.data;
                this.shuaixuan();
                let lin = res.data.filter((itm) => itm.id == item.id);
                if (lin[0].state == 6) {
                  console.log("隐藏");
                  this.yin();
                }
              });
          });
      }
    },
    //订单详情页面退款按钮，真退款
    drawback(item, i) {
      //为单商品订单
      if (item.type == 1) {
        if (item.goodsnum == 1) {
          this.allback(item, 1);
          // this.yin();
        } else {
          //控制按钮的显示
          this.is2 = 0;
          this.isput = 0;
          this.disabled = true;
          this.is1 = 1;
        }
      } else {
        if (item.goodsnum[i] == 1) {
          this.allback(item, i, 1);
        } else {
          this.$set(this.is2, i, 0);
          this.$set(this.is1, i, 1);
          this.$set(this.isput, i, 0);
          this.$set(this.disabled, i, true);
        }
      }
    },
    //订单详情页面货物状态显示
    changge(i, ii) {
      if (i.type == 1) {
        if (1 < i.state < 5) {
          this.yanse = "greenyellow";
        } else {
          this.yanse = "green";
        }
        return i.statename;
      } else {
        if (i.states[ii] == 2) {
          this.$set(this.yanse, ii, "greenyellow");
          return "待发货";
        } else if (i.states[ii] == 3) {
          this.$set(this.yanse, ii, "greenyellow");
          return "待收货";
        } else if (i.states[ii] == 4) {
          this.$set(this.yanse, ii, "greenyellow");
          return "待评价";
        } else {
          this.$set(this.yanse, ii, "green");
          return "已完成";
        }
      }
    },
    //订单列表申请退款按钮
    tuiqian(i) {
      if (i.type == 1 && i.goodsnum == 1) {
        this.allback(i, 1);
      } else {
        this.ismotai2 = 1;
        this.$bus.$emit("task", true);
        this.$axios
          .post("/quxiao", {
            id: i.id,
            user: sessionStorage.getItem("username"),
          })
          .then((res) => {
            if (res.data.goods.type == 1) {
              this.yanse = "";
              this.goodsnum = res.data.goods.goodsnum;
            } else {
              this.is2 = []; //需要隐藏即为1
              this.isput = []; //需要显示即为1
              this.disabled = []; //需要显示即为false
              this.is1 = []; //需要隐藏即为0
              this.yanse = [];
              this.goodsnum = [];
              for (const key in res.data.goods.goodsimg) {
                this.yanse[key] = [];
                this.$set(this.goodsnum, key, res.data.goods.goodsnum[key]);
                this.$set(this.is2, key, 1);
                this.$set(this.is1, key, 0);
                this.$set(this.isput, key, 1);
                this.$set(this.disabled, key, false);
              }
            }
            this.coments = res.data.goods;
            console.log(this.coments);
          });
      }
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
    //改变tab栏样式，及更新数据
    change(i) {
      for (let index = 0; index < this.class1.length; index++) {
        this.$set(this.class1, index, 0);
      }
      this.$set(this.class1, i, 1);
    },
    //tab栏状态名称
    tabname(i) {
      if (i == 0) {
        return "全部";
      } else if (i == 1) {
        return "待付款";
      } else if (i == 2) {
        return "待发货";
      } else if (i == 3) {
        return "待收货";
      } else if (i == 4) {
        return "待评价";
      } else {
        return "已完成";
      }
    },
    //立即付款按钮
    buying(item) {
      let time = this.$moment().format("YYYY-MM-DD HH:mm:ss");
      let is = confirm("确认付款吗？");
      if (is) {
        this.$axios
          .post("/order", { id: item.id, time: time, geng: 1 })
          .then((res) => {
            console.log(res.data);
            this.beforeget();
          });
      }
    },
    //删除图片按钮
    //删除评价时不要的图片
    shantu(i, j) {
      if (Number.isInteger(j)) {
        this.imgform[i].splice(j, 1);
        this.img1[i].splice(j, 1);
        this.$set(this.num, i, this.num[i] - 1);
        if (this.num[i] < 5) {
          this.$set(this.isimg, i, "block");
        }
      } else {
        this.img1.splice(i, 1);
        this.imgform.splice(i, 1);
        this.num--;
        if (this.num < 5) {
          this.isimg = "block";
        }
      }
    },
    //评分函数
    dianji(i, j) {
      if (Number.isInteger(j)) {
        if (this.degree[i] < j) {
          for (let index = this.degree[i]; index < j; index++) {
            this.$set(this.active[i], index, true);
          }
          this.$set(this.degree, i, j);
          this.pingfen = ":" + this.degree[i] + "星评分";
          this.pingfens[i] = this.pingfen;
          console.log(this.active[i]);
          console.log(this.degree[i]);
        } else if (this.degree[i] > j) {
          for (let index = j; index <= 5; index++) {
            this.$set(this.active[i], index, false);
          }
          this.$set(this.degree, i, j);
          this.pingfen = ":" + this.degree[i] + "星评分";
          this.pingfens[i] = this.pingfen;
          console.log(this.active[i]);
          console.log(this.degree[i]);
        }
      } else {
        if (this.degree < i) {
          for (let index = this.degree; index <= i; index++) {
            this.$set(this.active, index, true);
            this.degree = i;
          }
          this.pingfen = ":" + i + "星评分";
        } else if (this.degree > i) {
          for (let index = i + 1; index <= 5; index++) {
            this.$set(this.active, index, false);
            this.degree = i;
          }
          this.pingfen = ":" + i + "星评分";
        } else {
          this.degree = i;
          for (let index = 1; index <= i; index++) {
            this.$set(this.active, index, true);
          }
        }
      }
    },
    //评论按钮
    talk(i) {
      let param = new FormData();
      let config = {
        headers: { "Content-Type": "multipart/form-data" },
      }; //添加请求头
      let now = this.$moment(this.createTime).format("YYYY-MM-DD HH:mm:ss");
      if (this.coments.type == 0) {
        //type为0 多种商品的订单
        let com = {
          time: now,
          user: sessionStorage.getItem("username"),
          orderid: this.coments.orderid,
          goodsid: this.coments.goodsid[i],
          comment: this.area[i],
          comstate: i,
        };
        param.append("time", com.time);
        param.append("user", com.user);
        param.append("orderid", com.orderid);
        param.append("goodsid", com.goodsid);
        param.append("comment", com.comment);
        param.append("comstate", com.comstate);
        param.append("imgnums", this.num[i]);
        for (let index = 0; index < this.imgform[i].length; index++) {
          param.append("file"[index], this.imgform[i][index]);
        }
        param.append("degree", this.degree[i]);
        if (this.degree[i]) {
          console.log(this.area[i]);
          this.$axios.post("/order", param, config).then((res) => {
            this.coments = res.data;
            if (res.data.state == 5) {
              this.istrue = false;
              this.$bus.$emit("task", false);
            }
            this.area[i] = "";
            this.beforeget();
            this.img1[i] = [];
            this.degree[i] = 0;
            this.active[i] = [];
            this.num[i] = 0;
            this.imgform[i] = [];
            console.log(this.num[i]);
          });
        } else {
          this.isalert = "";
          setTimeout(() => {
            this.isalert = "none";
          }, 2000);
        }
      } else {
        //单商品订单的时候
        let com = {
          time: now,
          user: sessionStorage.getItem("username"),
          orderid: this.coments.orderid,
          goodsid: this.coments.goodsid,
          comment: this.area,
        };
        param.append("time", com.time);
        param.append("user", com.user);
        param.append("orderid", com.orderid);
        param.append("goodsid", com.goodsid);
        param.append("comment", com.comment);
        param.append("imgnums", this.num);
        for (let index = 0; index < this.imgform.length; index++) {
          param.append("file"[index], this.imgform[index]);
        }
        param.append("degree", this.degree);
        if (this.degree) {
          console.log(this.area);
          this.$axios.post("/order", param, config).then((res) => {
            this.coments = res.data;
            this.istrue = false;
            this.$bus.$emit("task", false);
            this.beforeget();
            this.img1 = [];
            this.num = 0;
            this.degree = 0;
            this.active = [];
            this.imgform = [];
            this.area = "";
          });
        } else {
          this.isalert = "";
          setTimeout(() => {
            this.isalert = "none";
          }, 2000);
        }
      }
    },
    //评价盒子关闭按钮
    guan(i) {
      if (Number.isInteger(i)) {
        if (i == 1) {
          this.istrue1 = false;
        } else if (i == 2) {
          this.ismotai2 = 0;
          this.is1 = 0;
          this.is2 = 1;
          this.disabled = false;
          this.isput = 1; //操作页面商品数量不是以文本框形式的显示 1为显示 0 为隐藏
        }
      } else {
        this.istrue = false;
        this.area = [];
        this.img1 = [];
        this.imgform = [];
        this.num = 0;
        this.pingfen = "";
        this.active = [];
        this.degree = "";
      }
      this.$bus.$emit("task", false);
    },
    //确定收货按钮
    que(i) {
      if (i.type == 1) {
        this.$axios.post("/getorder", { id: i.id, que: 1 }).then((res) => {
          this.beforeget();
        });
      } else {
        this.ismotai2 = 1;
        this.$bus.$emit("task", true);
        this.$axios
          .post("/quxiao", {
            id: i.id,
            user: sessionStorage.getItem("username"),
          })
          .then((res) => {
            if (res.data.goods.type == 1) {
              this.yanse = "";
              this.goodsnum = res.data.goods.goodsnum;
            } else {
              this.is2 = []; //需要隐藏即为1
              this.isput = []; //需要显示即为1
              this.disabled = []; //需要显示即为false
              this.is1 = []; //需要隐藏即为0
              this.yanse = [];
              this.goodsnum = [];
              for (const key in res.data.goods.goodsimg) {
                this.yanse[key] = [];
                this.$set(this.goodsnum, key, res.data.goods.goodsnum[key]);
                this.$set(this.is2, key, 1);
                this.$set(this.is1, key, 0);
                this.$set(this.isput, key, 1);
                this.$set(this.disabled, key, false);
              }
            }
            this.coments = res.data.goods;
            console.log(this.coments);
          });
      }
    },
    //加评论图片
    jiatu(i) {
      if (Number.isInteger(i)) {
        this.$refs.file[i].click();
      } else {
        this.$refs.file.click();
      }
    },
    //订单详情申请退款文本框值得限制
    xianzhi(i) {
      if (Number.isInteger(i)) {
        if (this.goodsnum[i] > this.coments.goodsnum[i]) {
          this.goodsnum[i] = this.coments.goodsnum[i];
        } else if (this.goodsnum[i] < 1) {
          this.goodsnum[i] = 1;
        }
      } else {
        if (this.goodsnum > this.coments.goodsnum) {
          this.goodsnum = this.coments.goodsnum;
        } else if (this.goodsnum < 1) {
          this.goodsnum = 1;
        }
      }
    },
    //显示添加的评论图片
    xiantu(i) {
      let fileRead = new FileReader();
      if (Number.isInteger(i)) {
        fileRead.readAsDataURL(this.$refs.file[i].files[0]);
        fileRead.onload = (e) => {
          this.$set(this.img1[i], this.num[i], e.target.result);
          this.$set(this.imgform[i], this.num[i], this.$refs.file[i].files[0]);
          this.$set(this.num, i, this.num[i] + 1);
          this.$refs.file[i].value = "";
          if (this.num[i] == 5) {
            this.$set(this.isimg, i, "none");
          }
        };
      } else {
        fileRead.readAsDataURL(this.$refs.file.files[0]);
        fileRead.onload = (e) => {
          this.$set(this.img1, this.num, e.target.result);
          this.$set(this.imgform, this.num, this.$refs.file.files[0]);
          this.$refs.file.value = "";
          this.num++;
          if (this.num == 5) {
            this.isimg = "none";
          }
        };
      }
    },
    //立即评价按钮
    comment(i) {
      this.$bus.$emit("task", true);
      this.istrue = true;
      if (i.type == 0) {
        this.num = [];
        this.degree = [];
        this.area = [];
        this.isimg = [];
        for (const key in i.goodsimg) {
          this.$set(this.active, key, []);
          this.$set(this.area, key, "");
          for (let index = 0; index < this.degrees; index++) {
            this.$set(this.active[key], index, false);
          }
          this.$set(this.img1, key, []);
          this.$set(this.imgform, key, []);
          this.$set(this.num, key, 0);
          this.$set(this.degree, key, 0);
          this.$set(this.isimg, key, "block");
        }
      } else {
        if (this.num < 5) {
          this.isimg = "block";
        }
      }
      this.coments = i;
    },
    //查看评价按钮
    look(i) {
      this.$bus.$emit("task", true);
      this.istrue1 = true;
      //发送请求获取商品信息和评价信息
      this.$axios.post("getgp", { orderid: i.orderid }).then((res) => {
        for (const key in res.data) {
          this.$set(this.xing, key, []);
          for (let index = 0; index < res.data[key].degree; index++) {
            this.$set(this.xing[key], index, 1);
          }
        }
        this.coments = res.data;
      });
    },
    //订单详情按钮
    orderdetail(id, state) {
      this.$router.push({
        path: "/xiangqing",
        query: { id: id, state: this.state },
      });
    },
    //操作后帅选数据
    shuaixuan() {
      if (this.state == 0) {
        this.shu = this.raw;
      } else {
        this.shu = this.raw.filter((item) => item.state == this.state);
      }
    },
    //对订单操作后筛选数据
    beforeget(i) {
      if (Number.isInteger(i)) {
        this.state = i;
      }
      this.$axios
        .post("/getorder", { user: sessionStorage.getItem("username") })
        .then((res) => {
          this.raw = res.data;
          console.log(res.data);
         this.shuaixuan();
          this.change(this.state);
          this.settime();
          console.log(this.arr);
        });
    },
    //取消订单按钮
    quxiao(i) {
      this.$axios
        .post("/quxiao", {
          user: sessionStorage.getItem("username"),
          id: i.id,
          s: 1,
        })
        .then((res) => {
          this.beforeget();
        });
    },
    //未付款订单设置定时器
    settime() {
      let lin = "";
      lin = this.raw.filter((item) => item.state == 1);
      for (const key in this.a) {
        this.clear(this.a[key]);
      }
      for (const key in this.shu) {
        if (this.shu[key] != lin[key]) {
          for (const k in lin) {
            let i = this.raw.indexOf(lin[k]);
            this.a[k] = setInterval(() => {
              this.time(lin[k], i);
            }, 1000);
          }
          break;
        } else if (key == this.shu.length - 1) {
          for (const k in lin) {
            this.a[k] = setInterval(() => {
              this.time(lin[k], k);
            }, 1000);
          }
        }
      }
    },
    //清除定时器
    clear(c) {
      clearInterval(c);
    },
    //计算未付款订单剩余时间
    time(t, i) {
      var timestamp = new Date().getTime();
      var time = new Date(t.expiration);
      var chuo = time.getTime();
      var gap = chuo - timestamp;
      if (gap <= 0) {
        this.quxiao(t);
      } else {
        gap = Math.round((chuo - timestamp) / 1000);
      }
      var s = gap % 60; //剩余秒数
      var fen = parseInt(gap / 60); //总分数
      var shi = parseInt(fen / 60); //总时数
      var m = fen % 60; //剩余分钟
      var h = shi % 24; //剩余时数
      if (s < 10) {
        var sj = "该订单在" + h + "时" + m + "分0" + s + "秒" + "后失效";
      } else if (m < 10) {
        var sj = "该订单在" + h + "时0" + m + "分" + s + "秒" + "后失效";
      } else {
        var sj = "该订单在" + h + "时" + m + "分" + s + "秒" + "后失效";
      }
      this.$set(this.arr, i, sj);
    },
    // 全部0 待付款1 待发货2 待收货3 待评价4 已完成5
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    if (this.$route.query.state) {
      this.state = this.$route.query.state;
    }
    this.beforeget(this.state);
  },
  mounted() {},
  beforeDestroy() {
    for (const key in this.a) {
      clearInterval(this.a[key]);
    }
  },
  activated() {
    this.beforeget(this.state);
  },
};
</script>

<style scoped>
.jue {
  position: relative;
}
.plus {
  display: block !important;
  cursor: pointer;
  line-height: 10px;
  border: 1px solid #000;
  height: 12px;
  width: 15px;
  position: absolute;
  top: 48px;
  right: 45%;
  text-align: center;
}
.dec {
  display: block !important;
  cursor: pointer;
  line-height: 10px;
  text-align: center;
  border: 1px solid #000;
  border-top: 0px;
  height: 12px;
  width: 15px;
  position: absolute;
  top: 60px;
  right: 45%;
}
.num2 {
  display: block !important;
  width: 33px;
  text-align: center;
  margin-top: 50px;
  height: 20px;
  float: left;
}
.num1 {
  display: none;
}
.yin {
  display: none;
}
.el-icon-close {
  cursor: pointer;
  position: absolute;
  top: 0;
  right: 0;
  float: right;
}
.motai2 > .h1 {
  position: relative;
  height: 120px;
  margin-top: 10px;
  border-bottom: 1px solid #000;
}
.button {
  margin-left: 15px;
  margin-top: 45px;
  float: left;
}
.h1 > .state {
  float: left;
  margin-top: 44px;
  width: 154px;
  height: 30px;
  margin-left: 15px;
  line-height: 30px;
}
.h1 > .num {
  display: block;
  margin-top: 10px;
  float: left;
  width: 33px;
  height: 100px;
  line-height: 100px;
  text-align: center;
}

.h1 > .price {
  width: 90px;
  margin-left: 15px;
  margin-top: 10px;
  height: 100px;
  line-height: 100px;
  text-align: center;
  float: left;
}
.h1 > .name {
  width: 130px;
  margin-left: 30px;
  height: 100px;
  line-height: 100px;
  text-align: center;
  margin-top: 10px;
  float: left;
}
.h1 > img {
  margin-top: 10px;
  margin-left: 20px;
  float: left;
  height: 100px;
  width: 100px;
}
.title > h3 {
  margin: 0;
  font-size: 24px;
  height: 30px;
  line-height: 30px;
  text-align: center;
}
.motai2 {
  margin: 0 auto;
  overflow: scroll;
  display: block;
  z-index: 3;
  overflow: scroll;
  width: 800px;
  height: 600px;
  position: absolute;
  top: 2%;
  right: 20%;
  background-color: #fff;
}
.motai1 > .text {
  margin: 10px 0;
}
.motai1 > .h2 {
  border-bottom: 1px solid #000;
  border-top: 1px solid #000;
}
.h2 > .imgs {
  margin-top: 10px;
  margin-bottom: 10px;
}
.h2 > .imgs > img {
  height: 100px;
  width: 100px;
}
.degree li {
  height: 100px;
  line-height: 100px;
}
.degree > span {
  float: left;
  height: 100px;
  line-height: 100px;
}
.xing {
  display: none;
  float: left;
}
.goods {
  margin-top: 8px;
  height: 110px;
  width: 100%;
}
.goods > .name {
  float: left;
  height: 110px;
  width: 100px;
  line-height: 100px;
  text-align: center;
}
.goods > img {
  float: left;
  width: 100px;
  height: 100px;
}
.motai1 > .title {
  text-align: center;
  line-height: 30px;
  height: 30px;
  width: 100%;
  height: 30px;
  font-weight: 600;
  border-bottom: 1px solid #000;
}
.motai1 {
  overflow: scroll;
  padding-left: 10px;
  padding-right: 10px;
  padding-bottom: 20px;
  position: fixed;
  width: 500px;
  height: 550px;
  top: 3%;
  right: 31%;
  background-color: #fff;
  z-index: 2;
}
.fu {
  position: absolute;
  top: 104px;
  right: 10px;
}
.el-alert {
  position: fixed;
  width: 600px;
  top: 48%;
  left: 25%;
  z-index: 3;
}
* {
  box-sizing: border-box;
}
.h3 > .tu > img {
  width: 100%;
  height: 100%;
}
.el-icon-circle-close {
  position: absolute;
  top: -10px;
  right: -10px;
  cursor: pointer;
}
.h3 > .tu {
  position: relative;
  margin-right: 5px;
  float: left;
  width: 70px;
  height: 70px;
}
.el-icon-camera-solid:before {
  font-size: 30px;
}
.h3 > .img {
  float: left;
  padding-top: 12px;
  text-align: center;
  line-height: 16px;
  font-size: 1px;
  color: #000;
  cursor: pointer;
  height: 70px;
  font-weight: 100;
  width: 70px;
}
input[type="file"] {
  display: none;
}
.duo > .h3 {
  padding-top: 8px;
  height: 80px;
  padding-left: 5px;
}
.motai > .context1 > .h3 {
  padding-top: 8px;
  height: 80px;
  padding-left: 5px;
}
.h1 > .li > li {
  float: left;
  margin-right: 2px;
  font-size: 30px;
  color: #fff;
  cursor: pointer;
  -webkit-text-stroke: 1px #000;
}
.cs {
  float: left;
  display: block;
  color: rgba(230, 230, 18, 0.938) !important;
}
.title > .cla {
  float: right;
  cursor: pointer;
  font-size: 40px;
  height: 100%;
  line-height: 30px;
}
.motai > .context1 {
  margin-top: 10px;
  width: 100%;
}
.motai > .context1 > .h1,
.motai > .context1 > .h2,
.duo > .h1,
.duo > .h2 {
  display: flex;
  height: 100px;
  width: 100%;
}
.duo > .h1 > img {
  flex: 2;
  height: 100px;
  width: 100px;
  position: relative;
}
.duo > .h1 > .li {
  margin-top: 16px;
  margin-bottom: 16px;
  flex: 18;
  line-height: 68px;
}
.duo > .h1 > p {
  margin-left: 10px;
  line-height: 68px;
  flex: 6;
}
.duo > .h1 > img {
  flex: 2;
  height: 100px;
  width: 100px;
  position: relative;
}
.motai > .context1 > .h1 > img {
  flex: 2;
  height: 100px;
  width: 100px;
  position: relative;
}
.motai > .context1 > .h1 > .li {
  margin-top: 16px;
  margin-bottom: 16px;
  flex: 18;
  line-height: 68px;
}
.motai > .context1 > .h1 > p {
  margin-left: 10px;
  line-height: 68px;
  flex: 6;
}
.h2 > textarea {
  flex: 8;
}
.h2 > .el-button {
  flex: 1;
  height: 40px;
  margin-top: 60px;
}
.motai > .title {
  text-align: center;
  line-height: 30px;
  height: 30px;
  width: 100%;
  height: 30px;
  font-weight: 600;
  border-bottom: 1px solid #000;
}
.motai {
  overflow: scroll;
  padding-left: 10px;
  padding-right: 10px;
  padding-bottom: 20px;
  position: fixed;
  width: 600px;
  height: 550px;
  top: 3%;
  right: 31%;
  background-color: #fff;
  z-index: 2;
}
.b {
  z-index: 1;
  position: absolute;
  left: 240px;
  top: 104px;
}
.c {
  position: absolute;
  top: 105px;
  right: 10px;
}
.r > .t {
  text-align: center;
  font-size: 14px;
  font-weight: 600;
  position: absolute;
  right: 50px;
  color: red;
  top: -18px;
  width: 201px;
}
.right > p {
  margin-top: 20px;
}
h1 > .f > p {
  margin: 0;
}
.f {
  overflow: hidden;
  flex: 3;
  float: left;
}
.r {
  overflow: hidden;
  color: blueviolet;
  flex: 3;
  float: left;
  margin-left: 30px;
}
i {
  font-style: normal;
  display: block;
}
h1 {
  position: relative;
  font-weight: normal;
  display: flex;
  flex: 4;
  color: black;
  font-size: 20px;
  margin-left: 10px;
  margin-top: 15px;
}
.right > span {
  position: absolute;
  top: 90px;
  right: -20px;
  text-align: center;
  width: 200px;
  color: rgb(190, 184, 184);
}
.right {
  position: relative;
  flex: 2;
}
.context {
  padding: 5px 0 0 0;
  border-top: 1px solid rgb(97, 95, 95);
  display: flex;
  height: 160px;
}
.imgs {
  overflow: hidden;
  margin-left: 3px;
  height: 100%;
  flex: 14;
}
.imgs:hover {
  cursor: pointer;
}
.imgs > img {
  flex: 1;
  margin-right: 5px;
  border: 1px solid rgb(173, 169, 169);
  height: 100%;
  width: 160px;
}
.top {
  display: flex;
}
.current {
  color: red;
  border-bottom: 2px solid red;
}
.top li {
  height: 40px;
  font-size: 30px;
  line-height: 40px;
  flex: 1;
  text-align: center;
}
.top li:hover {
  cursor: pointer;
}
</style>
