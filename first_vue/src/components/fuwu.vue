<template>
  <div class="chu">
    <dl>
      <h3><a href="#">购物指南</a></h3>
      <dt><a href="#">购物流程</a></dt>
      <dt><a href="#">会员介绍</a></dt>
      <dt><a href="#">生活旅行/团购</a></dt>
      <dt><a href="#">常见问题</a></dt>
      <dt><a href="#">大家电</a></dt>
      <dt><a href="#">联系客服</a></dt>
    </dl>
    <dl>
      <h3><a href="#">配送方式</a></h3>
      <dt><a href="#">上门自提</a></dt>
      <dt><a href="#">211限时达</a></dt>
      <dt><a href="#">配送服务查询</a></dt>
      <dt><a href="#">配送费收取标准</a></dt>
      <dt><a href="#">海外配送</a></dt>
    </dl>
    <dl>
      <h3><a href="#">支付方式</a></h3>
      <dt><a href="#">货到付款</a></dt>
      <dt><a href="#">在线支付</a></dt>
      <dt><a href="#">分期付款</a></dt>
      <dt><a href="#">邮局汇款</a></dt>
      <dt><a href="#">公司转账</a></dt>
    </dl>
    <dl>
      <h3><a href="#">售后服务</a></h3>
      <dt><a href="#">售后政策</a></dt>
      <dt><a href="#">价格保护</a></dt>
      <dt><a href="#">退款说明</a></dt>
      <dt><a href="#">返修/退换货</a></dt>
      <dt><a href="#">取消订单</a></dt>
    </dl>
    <dl>
      <h3><a href="#">帮助中心</a></h3>
      <dt>
        <a href="#" class="img1"><img src="../assets/qrcode_for_gh_c18954d5974a_1280.jpg" alt="" /></a>
      </dt>
      <dt><a href="#">品优购客户端</a></dt>
    </dl>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {};
  },
  methods: {},
  components: {},
  computed: {},
  watch: {},
  created() {},
  mounted() {},
};
</script>

<style scoped>
a>img{
  width: 95px;
  height: 95px;
}
.chu{
  height: 200px;
}
 dl {
    float: left;
    height: 190px;
    width: 190px;
    padding: 20px 0 0 49px;
    border-bottom: 1px solid #ededed;
}
 dl h3 {
    font-size: 16px;
    color: #333;
    padding-bottom: 15px;
}
dl dt {
    font-size: 12px;
    color: #666;
    padding-bottom: 5px;
}
 dl .img1 {
    width: 95px;
    height: 95px;
}
.clearfix:before,.clearfix:after {
    content:"";
    display:table; 
  }
  .clearfix:after {
    clear:both;
  }
  .clearfix {
     *zoom:1;
  }   
</style>
