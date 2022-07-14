<template>
  <el-form ref="ruleForm" label-width="100px" class="demo-ruleForm">
    <el-form-item label="商品类型">
      <el-select v-model="value" clearable placeholder="请选择">
        <el-option
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value"
        >
        </el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="商品名字">
      <el-input type="text" v-model="goods.name"></el-input>
    </el-form-item>
    <el-form-item label="商品价格">
      <el-input type="text" v-model="goods.price"></el-input>
    </el-form-item>

    <el-form-item label="商品图片" style="margin-top: 10px">
      <img v-show="img_url" :src="img_url" alt="" /><input
        type="file"
        name="userimg"
        ref="img"
        @change="xiantu"
      />
      
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm()">提交</el-button>
      <!-- <el-button type="primary" @click="xiugai" v-show="params.id">修改</el-button> -->
      <el-button @click="resetForm()">重置</el-button>
    </el-form-item>
    <el-alert :title="error.name" type="error" show-icon v-show="error.name">
    </el-alert>
    <el-alert :title="error.price" type="error" show-icon v-show="error.price">
    </el-alert>
    <el-alert
      :title="error.type"
      type="error"
      show-icon
      v-show="error.type"
    ></el-alert>
  </el-form>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      params: this.$route.query,
      goods: {
        name: "",
        price: "",
      },
      error: {
        name: "",
        price: "",
        type: "",
        img: "",
      },
      options: [
        {
          value: "1001",
          label: "手机数码",
        },
        {
          value: "1002",
          label: "电脑数码",
        },
        {
          value: "2001",
          label: "水果",
        },
        {
          value: "2002",
          label: "零食",
        },
        {
          value: "2003",
          label: "辣条",
        },
      ],
      value: "",
      img_url: "",
    };
  },
  methods: {
    submitForm() {
      if (this.value) {
        this.error.type = "";
      } else {
        this.error.type = "请选择一项商品类型";
      }
      if (this.goods.name) {
        this.error.name = "";
      } else {
        this.error.name = "商品名称不能为空";
      }
      if (this.goods.price) {
        this.error.price = "";
      } else {
        this.error.price = "商品价格不能为空";
      }
      let params = new FormData();
      params.append("goodsimg", this.$refs.img.files[0]);
      params.append("goodsname", this.goods.name);
      params.append("goodstype", this.value);
      params.append("goodsprice", this.goods.price);
      params.append('goodsman',sessionStorage.getItem('user_name'))
      let config = {
        headers: { "Content-Type": "multipart/form-data" },
      }; //添加请求头
      if (this.$refs.img.files[0]) {
        if (this.$refs.img.files[0].size > 2048000) {
          this.error.img = "上传图片不能超过2M";
        } else {
          this.error.img = "";
        }
      }else{
        alert('请选择一个图片')
      }

      if (
        this.value &&
        this.goods.name &&
        this.goods.price &&
        this.error.img == ""
      ) {
        if (this.params.id) {
          params.append("id", this.params.id);
          this.$axios.post("/add", params, config).then((res) => {
            if (res.data.code == 404) {
              alert(res.data.error);
            } else {
              alert(res.data.msg);
            }
          });
        } else {
          this.$axios.post("/add", params, config).then((res) => {
            if (res.data.code == 404) {
              alert(res.data.error);
            } else {
              console.log(res.data);
              alert(res.data.msg);
            }
          });
        }
      } else {
        alert(this.error.img);
      }
    },
    resetForm() {
      this.goods.name = "";
      this.goods.price = "";
      this.value = "";
      this.img_url = "";
    },
    xiantu() {
      let read = new FileReader();
      read.readAsDataURL(this.$refs.img.files[0]);
      read.onload = (e) => {
        this.img_url = e.target.result;
      };
    },
    // #region
    // xiugai() {
    //   let params = new FormData();
    //   params.append("goodsimg", this.$refs.img.files[0]);
    //   params.append("goodsname", this.goods.name);
    //   params.append("goodstype", this.value);
    //   params.append("goodsprice", this.goods.price);
    //   params.append("id", this.params.id);
    //   console.log(this.params.id);
    //   let config = {
    //     headers: { "Content-Type": "multipart/form-data" },
    //   }; //添加请求头
    //   this.$axios.post("/add", params, config).then((res) => {
    //     if (res.data.code == 404) {
    //       alert(res.data.error);
    //     } else {
    //       alert(res.data.msg);
    //     }
    //   });
    // },
    //#endregion
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    if (this.params.id) {
      this.goods.name = this.params.goodsname;
      this.goods.price = this.params.goodsprice;
      this.value = this.params.goodstype;
      this.img_url = this.$imgurl + this.params.goodsimg;
    } else {
      this.goods.name = "";
      this.goods.price = "";
      this.value = "";
      this.img_url = "";
    }
  },
  mounted() {},
};
</script>

<style scoped>
.el-input {
  width: 300px;
}
img {
  height: 100px;
  width: 100px;
  vertical-align: middle;
  position: absolute;
  top: -20px;
  right: 650px;
}
</style>
