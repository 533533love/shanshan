<template>
  <div class="">
    <div class="kuang">
      <div class="hezi">
        <div class="dizhi" v-for="(item, i) in userinfo" :key="i">
          <input
            type="radio"
            :id="'radio' + i"
            :value="i"
            :disabled="item.flag"
            v-model="check"
            @change="xuanze(i, item)"
          /><label :for="'radio' + i"></label
          ><span style="width: 85px">{{ item.name }}</span
          ><span style="width: 110px">{{ item.phone }}</span
          ><span style="width: 300px">{{ item.address }}</span>
          <el-button type="success" size="mini" round @click="edit(i)"
            >编辑</el-button
          >
          <el-button type="danger" size="mini" round @click="del(i)"
            >删除</el-button
          >
        </div>
        <i class="el-icon-plus" @click="tianjia()">添加地址</i>
      </div>
      <div class="motai" v-show="ismotai">
        <i class="el-icon-close" @click="guan"></i>
        <ul>
          <li>
            <label for="">收件人:</label
            ><input
              type="text"
              name="username"
              class="inp"
              id="username"
              v-model="user.name"
            />
          </li>
          <li>
            <label for="">收货地址:</label
            ><input
              type="text"
              name="uspswd"
              class="inp"
              id="uspswd"
              v-model="user.address"
            />
          </li>
          <li>
            <label for="">手机号码:</label
            ><input
              type="text"
              name="password2"
              class="inp"
              id="password2"
              v-model="user.phone"
            />
          </li>
          <li>
            <input type="submit" value="提交" id="ti" @click="zhuce" />
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      state: '', //决定是添加还是修改地址信息
      checked: [],
      userinfo: "",
      ismotai: 0,
      check: "",
      user: {
        user: sessionStorage.getItem("username"),
        name: "",
        address: "",
        phone: "",
      },
      address: "",
      number: "",
      inputflag: this.$route.query.flag,
    };
  },
  methods: {
    //删除地址
    del(i){
      this.state=i
      let no = 0;
      if (this.userinfo[this.state].flag==true) {
        no=1
        console.log('是');
      }
      this.$axios.post('/shop',{id2: this.userinfo[this.state].id,
          shan: 1,
          username: this.user.user,
          }).then(res=>{
            this.userinfo=res.data
            if (no==1) {
              this.$bus.$emit('text',res.data)
               console.log('是');
            }
          })
    },
    //修改地址信息
    edit(i) {
      this.state = i;
      console.log(this.state);
      this.user.name = this.userinfo[i].name;
      this.user.phone = this.userinfo[i].phone;
      this.user.address = this.userinfo[i].address;
      this.ismotai = 1;
    },
    xuanze(i, item) {
      this.$axios
        .post("/shop", { id: item.id, username: this.user.user })
        .then((res) => {
          this.$bus.$emit('text',res.data)
          this.userinfo = res.data;
        });
      for (let index = 0; index < this.checked.length; index++) {
        if (index == i) {
          this.$set(this.checked, index, true);
        } else {
          this.$set(this.checked, index, false);
        }
      }
    },
    guan() {
      this.ismotai = 0;
    },
    tianjia() {
      this.ismotai = 1;
      this.user.name='';
      this.user.address='';
      this.user.phone=''
    },
    //更改地址等信息
    zhuce() {
      if (Number.isInteger(this.state)) {
        //修改地址
         let no = 0;
      if (this.userinfo[this.state].flag==true) {
        no=1
      }
        this.$axios.post("/shop", {
          id1: this.userinfo[this.state].id,
          xiu: 1,
          username: this.user.user,
          name: this.user.name,
          address: this.user.address,
          phone: this.user.phone,
        }).then(res=>{
           if (no==1) {
              this.$bus.$emit('text',res.data)
            }
          this.userinfo=res.data
           this.ismotai=0
        })
      } else {
        //添加地址
        this.$axios
          .post("/shop", {
            username: this.user.user,
            name: this.user.name,
            address: this.user.address,
            phone: this.user.phone,
            tian: 1,
          })
          .then((res) => {
            this.userinfo=res.data
            this.ismotai=0
          });
      }
    },
  },
  components: {
   
  },
  computed: {},
  watch: {},
  created() {
    this.$axios.post("/shop", { u: this.user.user }).then((res) => {
      for (let index = 0; index < res.data.length; index++) {
        this.$set(this.checked, index, false);
      }
      this.userinfo = res.data;
    });
  },
  mounted() {},
  activated() {
    this.$axios.post("/shop", { u: this.user.user }).then((res) => {
      for (let index = 0; index < res.data.length; index++) {
        this.$set(this.checked, index, false);
      }
      this.userinfo = res.data;
    });
  },
};
</script>

<style scoped>
.dizhi > label::before {
  cursor: pointer;
  text-align: center;
  line-height: 20px;
  content: "";
  top: 0px;
  left: -99px;
  position: absolute;
  width: 20px;
  height: 20px;
  border: 1px solid rgb(114, 109, 109);
  border-radius: 50%;
}
.dizhi > label::after {
  content: "默认";
  position: absolute;
  top: 0px;
  left: -77px;
}
.dizhi > input:disabled + label::before {
  color: #fff;
  content: "\2713";
  background-color: red;
}
.dizhi > input:disabled + label::after {
  content: "已设默认";
  color: red;
}
.dizhi > label {
  height: 20px;
  width: 100px;
  position: relative;
}
.dizhi > input {
  display: none;
}
.dizhi {
  margin-bottom: 20px;
}
span {
  display: inline-block;
  margin-right: 10px;
}
.motai > i {
  font-size: 30px;
  float: right;
}
.hezi {
  width: 650px;
  margin-left: 320px;
  margin-top: 35px;
}
i {
  cursor: pointer;
}
li > label {
  width: 68px;
  text-align: right;
  height: 30px;
  display: inline-block;
}
.kuang {
  position: relative;
  width: 1200px;
  margin: 0 auto;
}
.motai {
  background-color: rgb(19, 43, 109);
  position: absolute;
  width: 350px;
  height: 215px;
  top: 30%;
  right: 35%;
}
ul {
  width: 100%;
  height: 100%;
  margin-left: 5%;
  margin-top: 70px;
}
</style>
