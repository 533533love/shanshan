<template>
  <div>
    <label for="">授权码:</label>
    <input type="text" name="auth_num" v-model="data.auth_num" />
    <button @click="huo">获取授权码</button>
    <button @click="huoqu">添加授权码</button>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      data: {
        auth_num: "",
      },
    };
  },
  methods: {
    huo() {
      this.data.auth_num=''
      for (let i = 0; i < 6; i++) {
        this.data.auth_num += Math.floor(Math.random() * 10);
      }
    },
    huoqu() {
      this.$axios
        .post(`http://www.lycwssapi.com:8081/huo?h=${this.data.auth_num}`)
        .then((response) => {
          if (response.data.code == 200) {
            alert(response.data.msg);
          } else {
            alert(response.data.msg);
          }
        });
      this.data.auth_num = "";
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {},
  mounted() {},
};
</script>