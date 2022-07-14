<template>
  <div class="hezi">
    <div class="form">
      <h1>管理员注册</h1>
      <div class="hz1">
        <label>管理员账号:</label
        ><input
          type="text"
          name="user_name"
          v-model="user.user_name"
          placeholder="请输入管理员账户"
        /><span>{{ error.name }}</span>
      </div>
      <div class="hz2">
        <label>密码:</label
        ><input
          type="password"
          name="user_password"
          v-model="user.user_password"
          placeholder="请输入管理员密码"
        /><span>{{ error.password }}</span>
      </div>
      <div class="hz3">
        <label>确认密码:</label
        ><input
          type="password"
          name="password2"
          v-model="user.password2"
          placeholder="请确认密码"
        />
        <span>{{ error.password2 }}</span>
      </div>
      <div class="hz4">
        <label>授权码:</label
        ><input
          type="text"
          name="auth_num"
          v-model="user.auth_num"
          placeholder="请输入管理员授权码"
        /><span>{{ error.auth_num }}</span>
      </div>
      <div class="hz5">
        <label>手机号码:</label
        ><input
          type="text"
          name="user_num"
          v-model="user.user_num"
          placeholder="请输入手机号码"
        /><span>{{ error.user_num }}</span>
      </div>
      <div class="hz6">
        <label>邮箱:</label
        ><input
          type="text"
          name="user_email"
          v-model="user.user_email"
          placeholder="请输入邮箱地址"
        /><span>{{ error.user_email }}</span>
      </div>
      <!-- <div class="hz7"><label>验证码:</label><input type="text" name="check_num" v-model="user.check_num" placeholder="验证码">
            <img class="yan" :src="imgurl" @click='change'>
            <span class="im"></span>
        </div> -->
        
      <button class="zhu" @click="zhuce">点我注册</button>
      <a href="javascript:;" @click="tologin">已有管理员账号，去登陆</a>
    </div>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      user: {
        user_name: "",
        user_password: "",
        password2: "",
        auth_num: "",
        user_num: "",
        user_email: "",
        check_num: "",
      },
      error: {
        name: "",
        password: "",
        password2: "",
        auth_num: "",
        user_num: "",
        user_email: "",
        check_num: "",
      },
      // imgurl: "http://www.lycwssapi.com:8081/img",
    };
  },
  methods: {
    // change() {
    //   this.imgurl = this.imgurl + "/" + Math.random();
    // },
    tologin() {
      this.$router.push({
        path: "/login",
      });
    },
    zhuce() {
         this.error.auth_num=''
         this.error.name=''
      if (this.user.user_name.length < 6) {
        this.error.name = "用户名不少于6位数";
      } else {
        this.error.name = "";
      }
      if (this.user.user_password.length < 6) {
        this.error.password = "密码不少于6位数";
      } else {
        this.error.password = "";
      }
      if (this.user.user_password2 != this.user.password) {
        this.error.password2 = "确认密码必须和密码一致";
      } else {
        this.error.password2 = "";
      }
      //    if(this.user.user_name.length<6){
      //       this.error.name="用户名不少于6位数"
      //   }
      var numb =
        /^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\d{8}$/;
      var email =/[0-9]\d{7,10}@qq\.com/
      if (!numb.test(this.user.user_num)) {
        this.error.user_num = "手机号码不正确";
      } else {
        this.error.user_num = "";
      }
        if(!email.test(this.user.user_email)){
            this.error.user_email='邮箱格式错误'
        }else{
            this.error.user_email=''
        }
      if (
        (
          this.error.name == "" &&
          this.error.password == "" &&
          this.error.password2 == "" &&
          this.error.user_num == "" &&
          this.error.user_email==''
        )
      ) {
        this.$axios
          .post(
            `http://www.lycwssapi.com:8081/zhuce?user=${JSON.stringify(
              this.user
            )}`
          )
          .then((response) => {
            // if(response.data.code==404){
            //     this.error.auth_num=response.data.error
            //     this.error.name=response.data.user_err
            // }else{
            //   alert(response.data.msg)
            // }
           console.log( response.data);
          });
      }
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {},
  mounted() {},
};
</script>

<style scoped>
* {
  box-sizing: border-box;
  border: 0px;
  margin: 0 auto;
  padding: 0;
}

.hezi {
  width: 100%;
  height: 600px;
  margin-top: 0;
  background: url("../assets/222.png") no-repeat;
}

.form {
  position: relative;
  z-index: 1;
  background: #fff;
  width: 500px;
  height: 500px;
  margin: 0 auto;
  border: 10px #ccc solid;
  padding-left: 30px;
}

.hz1,
.hz2,
.hz3,
.hz4,
.hz5,
.hz6,
.hz7 {
  height: 40px;
  width: 500px;
  margin: 5px auto;
}

.form .hz7 input {
  width: 42px;
}

input {
  height: 20px;
  width: 130px;
  font-size: 12px;
  border: black solid 1px;
  border-radius: 5px;
  padding-left: 5px;
}
span {
  margin-left: 5px;
  color: red;
  height: 20px;
  width: 300px;
}

label {
  margin-right: 10px;
  float: left;
  width: 85px;
  height: 40px;
  text-align: right;
}
.yan {
  float: right;
  border: black solid 1px;
  height: 40px;
  width: 88px;
  margin-top: -10px;
  margin-right: 274px;
}
h1 {
  margin-left: 55px;
}
.im {
  position: absolute;
  top: 320px;
  right: -82px;
}
.zhu {
  margin: 10px 80px;
  color: #000;
  line-height: 40px;
  font-size: 30px;
  text-align: center;
  height: 40px;
  width: 150px;
  border: 1px solid #000;
}
a {
  float: right;
  text-decoration: none;
  color: aqua;
  font-size: 14px;
  width: 200px;
  height: 40px;
  line-height: 40px;
  margin-top: -36px;
}
</style>
