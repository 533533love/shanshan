<template>
  <div>
    <div class="zhuc_hd">
      <!-- logo模块 -->
      <div class="lo">
        <a href="品优购.html" title="优品购商城" target="_blank"
          ><img src="../assets/logo.png" alt=""
        /></a>
      </div>
    </div>
    <div class="box kuang">
      <div class="box_hd">
        注册新用户
        <div class="fr">
          我有账号，去 <router-link to="/">登陆</router-link>
        </div>
      </div>
      <div class="box_bd kuang">
        <ul class="clearfix">
          <li>
            <label for="">账号:</label
            ><input
              type="text"
              name="username"
              class="inp"
              id="username"
              v-model="username"
            /><span>{{ user_err }}</span>
          </li>
          <li>
            <label for="">头像:</label
            ><img v-show="img_url" :src="img_url" alt="" /><input
              type="file"
              name="userimg"
              ref="img"
              @change="xiantu"
            />
          </li>
          <li>
            <label for="">登陆密码:</label
            ><input
              type="password"
              name="uspswd"
              class="inp"
              id="uspswd"
              v-model="password"
            /><span>{{ password_err }}</span>
          </li>
          <li>
            安全程度<em class="ruo">弱</em><em class="zhong">中</em
            ><em class="qiang">强</em>
          </li>
          <li>
            <label for="">确认密码:</label
            ><input
              type="password"
              name="password2"
              class="inp"
              id="password2"
              v-model="pass"
            /><span>{{ password2_err }}</span>
          </li>
          <li>
            <label for="">昵称:</label
            ><input
              type="text"
              name="username"
              class="name"
              id=""
              v-model="name"
            />
          </li>
          <li>
            <input type="submit" value="完成注册" id="ti" @click="zhuce" />
          </li>
        </ul>
      </div>
    </div>
    <foot class="kuang"></foot>
  </div>
</template>

<script>
import foot from "../components/foot.vue";
export default {
  name: "",
  data() {
    return {
      name: "",
      img_url: "",
      username: "",
      password: "",
      pass: "",
      user_err: "",
      password_err: "",
      password2_err: "",
    };
  },
  methods: {
    zhuce() {
      let formdata = new FormData();
      formdata.append("imgurl", this.$refs.img.files[0]);
      formdata.append("username", this.username);
      formdata.append("password", this.password);
      formdata.append("name", this.name);
      let config = {
        headers: { "Content-Type": "multipart/form-data" },
      }; //添加请求头
      if (this.username.length < 6) {
        this.user_err = "用户名不能少于6位";
      } else {
        this.user_err = "";
      }
      if (this.password.length < 6) {
        this.password_err = "密码不能少于6位";
      } else {
        this.password_err = "";
      }
      if (this.pass === this.password) {
        this.password2_err = "";
      } else {
        this.password2_err = "确认密码必须和密码相同";
      }
      if (
        this.user_err == "" &&
        this.password_err == "" &&
        this.password2_err == ""
      ) {
        this.$axios.post("/state", formdata, config).then((res) => {
          if (res.data.code == 404) {
            alert(res.data.error);
          } else {
            alert(res.data.user);
          }
        });
      }
    },
    xiantu() {
      let fileread = new FileReader();
      fileread.readAsDataURL(this.$refs.img.files[0]);
      fileread.onload = (e) => {
        this.img_url = e.target.result;
      };
    },
  },
  components: {
    foot,
  },
  computed: {},
  watch: {},
  created() {},
  mounted() {},
};
</script>

<style scoped>
.clearfix{
			clear: both;
		}
.name {
  margin-left: 0px;
  border: 1px solid #999999;
  height: 36px;
  width: 240px;
  margin-right: 10px;
  display: inline-block;
}
.kuang {
  width: 1200px;
  margin: 0 auto;
}
.zhuc_hd {
  width: 1200px;
  margin: 0 auto;
  padding-top: 15px;
  height: 90px;
  border-bottom: 2px solid #b1191a;
}
.box {
  margin-top: 20px;
  height: 546px;
}
i,
em {
  font-style: normal;
}
.box_hd {
  height: 42px;
  color: #333;
  font-size: 18px;
  padding: 0 10px;
  line-height: 42px;
  background-color: #ececec;
}
.box_hd .fr {
  font-size: 14px;
}
.box_hd .fr a {
  font-size: 14px;
  color: #b1191a;
}
.box_bd {
  height: 380px;
  margin: 50px auto 0;
  width: 600px;
  /* background-color: pink; */
}
.box_bd li {
  font-size: 12px;
  color: #b2b2b2;
  margin-bottom: 20px;
}
.box_bd em {
  color: #fff;
}
label {
  display: inline-block;
  height: 36px;
  width: 100px;
  font-size: 14px;
  color: #4c4c4c;
  text-align: right;
  line-height: 36px;
  margin-right: 12px;
}
img {
  line-height: 104px;
  width: 171px;
  height: 61px;
  margin-right: 15px;
}
.inp {
  border: 1px solid #999999;
  height: 36px;
  width: 240px;
  margin-right: 10px;
  display: inline-block;
}
.qiang,
.ruo,
.zhong {
  padding: 0 10px;
}
.qiang {
  background-color: #f79100;
}
.ruo {
  background-color: #de1111;
}
.zhong {
  background-color: #40b83f;
}
.box_bd li:nth-child(3) {
  margin-bottom: 10px;
}
.box_bd li:nth-child(4) {
  margin-left: 193px;
}
.box_bd li a {
  color: #1ba1e6;
}
.box_bd li span {
  color: #4d4d4d;
  padding: 0 12px;
}
.box_bd li:nth-child(6) {
  margin-top: 42px;
  margin-left: 0px;
}
input[type="checkbox"] {
  vertical-align: middle;
  height: 16px;
  width: 16px;
  border: 1px solid #999999;
}
input[type="file"] {
  border: 0px;
}
.box_bd li:nth-child(7) {
  margin-top: 50px;
  margin-left: 120px;
}
.box_bd input[type="submit"] {
  background-color: #c81623;
  width: 200px;
  height: 36px;
  font-size: 14px;
  color: #fff;
}
.box_bd button {
  background-color: #c81623;
  width: 200px;
  height: 36px;
  font-size: 14px;
  color: #fff;
}
.dibu {
  margin-top: 60px;
}
.box_bd li .e1,
.e2,
.e3 {
  float: right;
  width: 220px;
  height: 100%;
  margin-top: 10px;
}
.box_bd li .e1 img,
.e2 img,
.e3 img {
  vertical-align: middle;
}
.box_bd ul li span {
  color: red;
}
</style>
