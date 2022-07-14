<template>
  <div class="chu">
    <div class="cropt">
      <a href="" class="a1">关于我们</a>|<a href="">联系我们</a>|<a href=""
        >联系客服</a
      >|<a href="">商家入驻</a>|<a href="">营销中心</a>|<a href="">手机品优购</a
      >|<a href="">友情链接</a>|<a href="">销售联盟</a>|<a href="">品优购社区</a
      >|<a href="">品优购公益</a>|<a href="">English Site</a>|<a href=""
        >Contact U</a
      >
      <br />
      <p>
        地址：北京市昌平区建材城西路金燕龙办公楼一层 邮编：100096
        电话：400-618-4000 传真：010-82935100 邮箱: zhanghj+itcast.cn
      </p>
      京ICP备08001421号京公网安备110108007702
    </div>
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
.cropt {
  height: 120px;
  text-align: center;
  margin-top: 20px;
  font-size: 12px;
  color: #666;
}
.cropt a {
  padding: 0 15px;
}
.cropt .a1 {
  padding-left: 0;
}
.cropt p {
  padding: 15px 0 10px;
}
dl {
  float: left;
  height: 190px;
  width: 200px;
  padding: 20px 0 0 50px;
  border-bottom: 1px solid #ededed;
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
