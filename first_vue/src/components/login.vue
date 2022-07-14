<template>
  <body>
    <div class="head"></div>
    <div class="f1">
      <img src="../assets/user1.png" alt="" class="img" />
      <input
        type="text"
        name="username"
        id="username"
        v-model="user.username"
        placeholder="请输入管理员账户"
      />
      <input
        type="password"
        name="password"
        id="password"
        v-model="user.password"
        placeholder="请输入密码"
      />
      <!-- <input type="text" name="password2" id="input3" value="" placeholder="验证码"><img
            :src="imgurl"
            @click="change" alt="" id="chcimg"> -->
      <div class="h4">
        <div class="fl">
          <input type="checkbox" name="" id="" v-model="flag" />
          <div class="wen">记住密码</div>
        </div>
      </div>
      <router-link :to="'/register'">去注册</router-link
      ><button class="tijiao" @click="index"></button>
      <!-- <div class="img_err"></div> -->
      <div class="name_err">{{ name }}</div>
      <div class="password_err">{{ password }}</div>
    </div>
  </body>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      flag: "",
      rawpass: "",
      //   imgurl:'http://www.lycwssapi.com:8081/img'
      user: {
        username: "",
        password: "",
      },
      name: "",
      password: "",
    };
  },
  methods: {
    index() {
      sessionStorage.removeItem("user_name");
      if (this.user.username == "") {
        this.name = "用户名不能为空";
      } else {
        this.name = "";
      }
      if (this.user.password == "") {
        this.password = "密码不能为空";
      } else {
        this.password = "";
      }
      if (this.name == "" && this.password == "") {
        if (
          localStorage.getItem("user_name") == this.user.username &&
          this.user.password == this.rawpass
        ) {
          if (this.flag) {
            sessionStorage.setItem(
              "user_name",
              localStorage.getItem("user_name")
            );
            this.$router.push({
              path: "/index",
            });
          } else {
            sessionStorage.setItem(
              "user_name",
              localStorage.getItem("user_name")
            );
            this.$router.push({
              path: "/index",
            });
            localStorage.removeItem("user_name");
          }
        } else {
          this.$axios
            .post(
              `http://www.lycwssapi.com:8081/denglu?user=${JSON.stringify(
                this.user
              )}`
            )
            .then((res) => {
              if (res.data.code == 404) {
                this.name = res.data.name;
                this.password = res.data.password;
              } else {
                if (res.data.code == 200) {
                  sessionStorage.setItem("user_name", this.user.username);
                  if (this.flag) {
                    localStorage.setItem("user_name", this.user.username);
                  } else {
                    localStorage.removeItem("user_name");
                  }
                  this.$router.push({
                    path: "/index",
                  });
                }
              }
            });
        }
      }
    },
    // change(){
    //   this.imgurl=this.imgurl+"/"+Math.random()
    // },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    if (localStorage.getItem("user_name")) {
      this.$axios
        .post("/jizhu", { user_name: localStorage.getItem("user_name") })
        .then((res) => {
          this.flag = true;
          this.rawpass = res.data.user_password;
          this.user.username = res.data.user_name;
          this.user.password = res.data.user_password;
        });
    }
  },
  mounted() {},
};
</script>

<style scoped>
* {
  margin: 0 auto;
  padding: 0;
  box-sizing: border-box;
}
.img {
  position: absolute;
  left: 160px;
  top: 21px;
  width: 26px;
  height: 26px;
}
a {
  font-size: 12px;
  color: #666;
  text-decoration: none;
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
form {
  margin: 0;
  padding: 0;
}

input {
  font-size: 12px;
  padding: 0 0 0 40px;
}

#username {
  display: block;
  padding-left: 30px;
  border: 1px solid #ccc;
  width: 200px;
  height: 28px;
  line-height: 28px;
}

#password {
  margin: 10px auto;
  padding-left: 30px;
  display: block;
  font-size: 12px;
  font-family: Fixedsys;
  line-height: 24px;
  background: url("../assets/passwordt.png") no-repeat;
  border: 1px solid #ccc;
  color: red;
  width: 200px;
  height: 28px;
  line-height: 28px;
}

#input3 {
  display: block;
  background: url("../assets/password2.png") no-repeat;
  ime-mode: disabled;
  border: 1px solid #ccc;
  width: 200px !important;
  height: 28px;
  line-height: 28px;
}

#chcimg {
  height: 25px;
  width: 100px;
  display: block;
  position: absolute;
  top: 98px;
  left: 258px;
}

.head {
  height: 239px;
  width: 100%;
  background: url("../assets/login_03b.png") no-repeat center top;
}

.f1 {
  position: relative;
  height: 190px;
  width: 517px;
  margin: 0 auto;
  padding-top: 20px;
  background: #ebfafe;
}

a {
  color: cornflowerblue;
  width: 60px;
  height: 30px;
  position: absolute;
  font-size: 10px;
  display: inline-block;
  left: 158px;
  top: 120px;
}
.h4 {
  margin-left: 159px;
  margin-top: 15px;
}
.tijiao {
  border: 0;
  position: absolute;
  float: right;
  width: 95px;
  height: 34px;
  background: url("../assets/login_.png");
  left: 264px;
  top: 100px;
}

.img_err {
  color: red;
  height: 20px;
  width: 100px;
  font-size: 12px;
  line-height: 20px;
  float: right;
  position: absolute;
  top: 100px;
  right: 50px;
}
.name_err {
  color: red;
  height: 20px;
  width: 100px;
  font-size: 12px;
  line-height: 20px;
  position: absolute;
  top: 22px;
  right: 50px;
}
.password_err {
  color: red;
  height: 20px;
  width: 120px;
  font-size: 12px;
  line-height: 20px;
  position: absolute;
  top: 60px;
  right: 30px;
}
body {
  background: #ffffff url("../assets/login_01.png") repeat-x;
}
</style>
