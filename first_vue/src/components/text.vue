<template>
  <div>
    <!-- <li
      v-for="i in degrees"
      :key="i"
      :class="{ cs: active[i] }"
      @click="dianji(i)"
    >
      &#9733;
    </li>
    <div>
      <img
        v-for="(i, ii) in img"
        :key="ii"
        :src="img[ii]"
        alt=""
        class="tu"
      /><input type="file" ref="file" @change="xiantu" />
      <div class="img" @click="jiatu">+</div>
      <el-button type="success" @click="ti">提交</el-button>
    </div>
    <div>
      <p class="cleanfloat starFive sF1">
        <span class="org_star">R</span><span class="org_star">R</span
        ><span class="org_star">R</span><span class="org_star">R</span
        ><span data-content="R">R</span><b>4.7分</b>
      </p>
      <p class="cleanfloat starFive sF2">
        <span class="org_star">R</span><span class="org_star">R</span
        ><span class="org_star">R</span><span data-content="R">R</span
        ><span>R</span><b>3.5分</b>
      </p>
      <p class="cleanfloat starFive sF3">
        <span class="org_star">R</span><span class="org_star">R</span
        ><span data-content="R">R</span><span>R</span><span>R</span><b>2.4分</b>
      </p>
    </div>
    <div class="wrap">
  <a href="#" class="btn" data-tip="点击作答">一个按钮</a>
 
</div> -->
<el-button @click="jian">减去</el-button>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      is:[1,2,3,4,5,6,7],
      i:'',
      // img: [],
      // imgform: [],
      // num: 0,
      // active: [],
      // degrees: [1, 2, 3, 4, 5],
      // degree: "",
    };
  },
  methods: {
   jian(){
     this.$set(i,5,i[5]-1)
     console.log(this.i[5]);
     console.log(this.is[5]);
   },
    ti() {
      let from = new FormData();
      for (const key in this.imgform) {
        from.append("file" + key, this.imgform[key]);
      }
      let config = {
        headers: { "Content-Type": "multipart/form-data" },
      }; //添加请求头
      this.$axios.post("/hello", from, config).then((res) => {
        for (const key in res.data) {
          console.log(res.data[key]);
        }
      });
    },
    xiantu() {
      let fileRead = new FileReader();
      fileRead.readAsDataURL(this.$refs.file.files[0]);
      fileRead.onload = (e) => {
        this.$set(this.img, this.num, e.target.result);
        this.$set(this.imgform, this.num, this.$refs.file.files[0]);
        this.num++;
      };
    },
    jiatu() {
      if (this.num < 5) {
        this.$refs.file.click();
      } else {
        alert("最多上传5个");
      }
    },
    dianji(i) {
      if (this.degree < i) {
        for (let index = this.degree; index <= i; index++) {
          this.$set(this.active, index, true);
          this.degree = i;
        }
      } else if (this.degree > i) {
        for (let index = i + 1; index <= 5; index++) {
          this.$set(this.active, index, false);
          this.degree = i;
        }
      } else {
        this.degree = i;
        for (let index = 1; index <= i; index++) {
          this.$set(this.active, index, true);
        }
      }

      console.log(this.degree);
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    this.i =this.is
    console.log(this.i);
    console.log(this.is);
  },
  
  mounted() {},
};
</script>

<style scoped>
.btn {
  display: inline-block;
  padding: 5px 20px;
  border-radius: 4px;
  background-color: #6495ed;
  color: #fff;
  font-size: 14px;
  text-decoration: none;
  text-align: center;
  position: relative;
}
.btn::before {
  content: attr(data-tip);
  width: 80px;
  padding: 5px 10px;
  border-radius: 4px;
  background-color: #000;
  color: #ccc;
  position: absolute;
  top: -30px;
  left: 50%;
  transform: translate(-50%);
  text-align: center;
  opacity: 0;
  transition: all .3s;
}
.btn::after {
  content: '';
  border: 8px solid transparent;
  border-top: 8px solid #000;
  position: absolute;
  top: -3px;
  left: 50%;
  transform: translate(-50%); 
  opacity: 0;
  transition: all .3s;
}
.btn:hover::before {
  top: -40px;
  opacity: 1;
}
.btn:hover::after {
  top: -13px;
  opacity: 1;
}
.cleanfloat::after {
  display: block;
  clear: both;
  content: "";
  visibility: hidden;
  height: 0;
}
* {
  margin: 0;
  padding: 0;
}

/*字体路径按照你的路径去修改*/
/* @font-face {
            font-family: 'AlluraRegular';
            src: url('../common/webFontIcon/websymbols/fonts/websymbols-regular-webfont.eot'),
                 url('../common/webFontIcon/websymbols/fonts/websymbols-regular-webfont?#iefix') format('embedded-opentype'), 
                 url('../common/webFontIcon/websymbols/fonts/websymbols-regular-webfont.woff') format('woff'),
                 url('../common/webFontIcon/websymbols/fonts/websymbols-regular-webfont.ttf') format('truetype'),
                 url('../common/webFontIcon/websymbols/fonts/websymbols-regular-webfont.svg#AlluraRegular') format('svg');
        } */
.starFive span {
  display: block;
  float: left;
  font-size: 25px;
  font-family: "AlluraRegular";
  text-align: center;
  color: #888;
  width: 27px;
  height: 33px;
  line-height: 33px;
  margin-right: 5px;
  position: relative;
  overflow: hidden;
  white-space: pre;
}
.starFive span:before {
  position: absolute;
  left: 0;
  top: 0;
  display: block;
  width: 50%;
  content: attr(data-content);
  overflow: hidden;
  color: #f63;
}
.sF1 span:before {
  width: 70%;
}
.sF2 span:before {
  width: 50%;
}
.sF3 span:before {
  width: 40%;
}
.starFive .org_star {
  color: #f63;
}
.starFive b {
  font-weight: normal;
  line-height: 40px;
  font-size: 25px;
  color: #888;
  margin-left: 10px;
}
.tu {
  width: 100px;
  height: 100px;
}
.img {
  text-align: center;
  line-height: 100px;
  font-size: 100px;
  color: #000;
  cursor: pointer;
  height: 100px;
  font-weight: 100;
  width: 100px;
}
input[type="file"] {
  display: none;
}
li {
  float: left;
  margin-right: 5px;
  font-size: 30px;
  color: #fff;
  cursor: pointer;
  -webkit-text-stroke: 1px #000;
}
.cs {
  color: rgba(230, 230, 18, 0.938);
}
</style>
