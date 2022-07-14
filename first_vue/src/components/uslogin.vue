<template>
  <div>
    <div class="heard">
      <!-- logo模块 -->
      <div class="logo">
        <h1>
          <a href="" title="优品购商城">优品购商城</a>
        </h1>
      </div>
    </div>
    <div class="bo">
      <div class="wt">
        <div class="deng">
          <div class="deng_head">
            <a href="javasript:;" class="zhanghao">账号登陆</a>
          </div>
          <div class="deng_body">
            <ul>
              <li>
                <div class="h1">公共场所不建议自动登录，以免账号丢失</div>
                <div class="h2">
                  <div class="z"></div>
                  <input
                    type="text"
                    placeholder="邮箱/用户名/手机号"
                    name="username"
                    v-model="user.username"
                  /><i>{{ username_err }}</i>
                </div>
                <div class="h3">
                  <div class="z">
                    <img src="../assets/椭圆1.png" alt="" />
                  </div>
                  <input
                    type="password"
                    placeholder="请输入密码"
                    name="uspswd"
                    v-model="user.password"
                  /><i>{{ password_err }}</i>
                </div>
                <div class="h4">
                  <div class="fl">
                    <input type="checkbox" name="" id="" v-model="flag" />
                    <div class="wen">记住密码</div>
                  </div>
                  <router-link class="fr" to="/usregister"
                    >没有账户，去注册</router-link
                  >
                </div>
                <button class="h5" @click="denglu">登陆</button>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <foot class="kuang"></foot>
  </div>
</template>

<script>
import foot from "./foot.vue";
export default {
  name: "",
  data() {
    return {
      flag: "",
      rawpaa:'',
      user: {
        username: "",
        password: "",
      },
      username_err: "",
      password_err: "",
    };
  },
  methods: {
    denglu() {
      sessionStorage.removeItem("username");
      if (this.user.username == "") {
        this.username_err = "用户名不能为空";
      } else {
        this.username_err = "";
      }
      if (this.user.password == "") {
        this.password_err = "用户名不能为空";
      } else {
        this.password_err = "";
      }
      if (this.username_err == "" && this.password_err == "") {
        if (localStorage.getItem("username")==this.user.username&&this.rawpaa==this.password) {
          if (this.flag) {
            sessionStorage.setItem(
              "username",
              localStorage.getItem("username")
            );
            this.$router.push({
              path:'/'
            });
          }else{
            sessionStorage.setItem(
              "username",
              localStorage.getItem("username")
            );
            this.$router.push({
              path: "/",
            });
            localStorage.removeItem('username')
          }
        } else {
          this.$axios
            .post(`/usdenglu?user=${JSON.stringify(this.user)}`)
            .then((res) => {
              if (res.data.code == 404) {
                this.username_err = res.data.username_err;
                this.password_err = res.data.password_err;
              } else if (res.data.code == 200) {
                sessionStorage.setItem("username", this.user.username);
                if (this.flag) {
                  localStorage.setItem("username", this.user.username);
                } else {
                  localStorage.removeItem("username");
                }
                this.$router.push({
                  path: "/",
                });
              }
            });
        }
      }
    },
  },
  components: {
    foot,
  },
  computed: {},
  watch: {},
  created() {
    if (localStorage.getItem("username")) {
      this.$axios
        .post("/jizhu", { username: localStorage.getItem("username") })
        .then((res) => {
          this.flag = true;
          this.rawpaa = res.data.password
          this.user.username = res.data.username;
          this.user.password = res.data.password;
        });
    }
  },
  mounted() {},
};
</script>

<style scoped>
.kuang{
  width: 1200px;
  margin: 0 auto;
}
.bo {
  position: relative;
  background: url(../assets/图层11.png) no-repeat;
  background-size: 100% 100%;
  height: 486px;
  margin: 0 auto;
  width: 1200px;
}
* {
  box-sizing: border-box;
}
.wt {
  height: 486px;
  width: 1200px;
  position: relative;
  margin: 0 auto;
}
.fr {
  float: right;
}
.deng {
  position: absolute;
  width: 380px;
  height: 365px;
  left: 707px;
  top: 65px;
  background-color: #fff;
}
.h4 input {
  float: left;
  margin-top: 3px;
}
.h4 .fl .wen {
  float: left;
  font-size: 12px;
  color: #b2b2b2;
}
.h4 .fr {
  float: right;
  font-size: 12px;
  color: #333;
}

.saoma {
  float: left;
  width: 190px;
  height: 65px;
  padding-left: 45px;
  padding-top: 24px;
  font-size: 18px;
  color: #666;
}
.zhanghao {
  text-align: right;
  padding-top: 24px;
  padding-right: 50px;
  font-size: 18px;
  color: #c81623;
  width: 190px;
  height: 65px;
  float: left;
}
.logo a {
  float: left;
  width: 171px;
  height: 61px;
  font-size: 0px;
  background: url(../assets/logo.png) no-repeat;
}
.heard {
  position: relative;
  height: 105px;
  width: 1200px;
  margin: 0 auto;
}

.deng_body li .h1 {
  padding-left: 15px;
  line-height: 28px;
  margin-bottom: 12px;
  float: left;
  margin-left: 37px;
  color: #666;
  font-size: 12px;
  width: 300px;
  height: 28px;
  border: solid 1px #f5eecf;
  background-color: #fffdee;
}
.h2,
.h3 {
  margin-left: 37px;
  float: left;
  height: 36px;
  width: 300px;
  margin-bottom: 20px;
}
.h2 .z {
  float: left;
  width: 37px;
  height: 34px;
  background: url(../assets/账号.png) no-repeat;
  background-size: 100% 100%;
}
input {
  border-radius: 0;
  padding-left: 10px;
  color: #b2b2b2;
  font-size: 14px;
}
.h2 input {
  border: 1px solid #bbbaba;
  float: left;
  width: 263px;
  height: 34px;
}
.h3 .z {
  padding-top: 5px;
  text-align: center;
  line-height: 34px;
  float: left;
  width: 37px;
  height: 34px;
  background: url(../assets/矩形7副本.png);
}
.h3 input {
  border: 1px solid #bbbaba;
  float: left;
  width: 263px;
  height: 34px;
}
.h4 {
  padding-top: 5px;
  margin-left: 37px;
  float: left;
  height: 20px;
  width: 300px;
}
.h4 input {
  float: left;
  margin-top: 3px;
}
.h4 .fl {
  float: left;
  width: 100px;
  height: 100%;
}
.h4 .fr {
  font-size: 12px;
  width: 100px;
  height: 20px;
  float: right;
  color: #333;
  margin-bottom: 10px;
}
.h5 {
  margin-top: 20px;
  width: 300px;
  text-align: center;
  line-height: 42px;
  height: 42px;
  background-color: #c81623;
  margin-left: 37px;
  float: left;
  color: #fff;
  font-size: 16px;
}
i {
  font-size: 10px;
  color: red;
  font-style: normal;
}
.h6 {
  overflow: hidden;
  margin-left: 37px;
  margin-top: 12px;
  float: left;
  width: 300px;
  height: 54px;
}
.h6 img {
  float: left;
}
.h6 a {
  margin-top: 12px;
  float: right;
  color: #1474af;
  font-size: 14px;
}
</style>
