<template>
  <div>
    <el-input v-model="input" placeholder="请输入订单号"></el-input
    ><el-button type="primary" icon="el-icon-search" @click="search"
      >搜索</el-button
    ><el-button type="danger" @click="fu">未付款订单</el-button
    ><el-button type="warning" @click="fa">待发货订单</el-button
    ><el-button type="success" @click="quan">全部订单</el-button>
    <el-table :data="tableData" style="width: 100%" height="500">
      <el-table-column label="商品ID" width="200">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.orderid }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品名字" width="300">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.goodsname }}</span>
        </template>
      </el-table-column>
      <el-table-column label="购买数量" width="100">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.goodsnum }}</span>
        </template>
      </el-table-column>
      <el-table-column label="购买用户" width="100">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.username }}</span>
        </template>
      </el-table-column>
      <el-table-column label="货物状态" width="100">
        <template slot-scope="scope">
          <span
            :style="
              scope.row.state == 2
                ? 'color: yellow'
                : scope.row.state == 1
                ? 'color: red'
                : 'color: green'
            "
            >{{ scope.row.statename }}</span
          >
        </template>
      </el-table-column>
      <el-table-column label="商品总价格" width="100">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.type==1?scope.row.total:scope.row.goodsprice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            :disabled="scope.row.state==2?false:true"
            @click="handleEdit(scope.$index, scope.row)"
            :style="
              scope.row.state == 2
                ? 'color: yellow'
                : scope.row.state == 1
                ? 'color: red'
                : 'color: green'
            "
            >{{ fahuo(scope.row.state) }}</el-button
          >
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      state: 9,
      input: "",
      tableData: [],
      raw: "",
    };
  },
  methods: {
    fahuo(i) {
      //货物状态显示
      if (i == 1) {
        return "等待付款";
      } else if (i == 2) {
        return "确认发货";
      } else if (i == 3) {
        return "已经发货";
      } else if (i == 4) {
        return "已经收货";
      } else if (i == 5) {
        return "已完成";
      }else{
        return '交易失败'
      }
    },
    fu() {
      //未付款筛选按钮
      this.state = 1;
      this.tableData = this.raw.filter((item) => item.state == 1);
    },
    fa() {
      //待发货筛选按钮
      this.state = 2;
      this.tableData = this.raw.filter((item) => item.state == 2);
    },
    quan() {
      //全部订单按钮
      this.tableData = this.raw;
      this.state = 9;
    },
    handleEdit(index, row) {
      //确认发货按钮
      if (row.state == 2) {
        this.$axios
          .post("/getorder", {
            id: row.id,
            fa: sessionStorage.getItem("user_name"),
          })
          .then((res) => {
            this.leach()
          });
      } else if (row.state == 1) {
        alert("用户还没付款");
      } else {
        alert("您已经发了货啦");
      }
    },
    leach() {
      //过滤数据函数
      if (this.state!=9) {
         this.$axios
        .post("/getorder", { manager: sessionStorage.getItem("user_name") })
        .then((res) => {
          for (const key in res.data) {
            if (res.data[key].type == 0) {
              let num = 0;
              let sum = 0;
              for (const k in res.data[key].nums) {
                num += parseInt(res.data[key].nums[k]);
                sum += parseInt(res.data[key].prices[k]);
              }
              res.data[key].goodsprice = sum.toFixed(2);
              res.data[key].goodsnum = num;
              res.data[key].goodsname = res.data[key].goodsname.toString();
            }
          }
          this.raw = res.data;
          this.tableData = this.raw.filter(item=>item.state==this.state);
        });
      }else{
        this.getinfo()
      }
    },
    search() {
      //搜索按钮
      this.tableData = this.raw.filter((item) => item.orderid == this.input);
    },
    getinfo() {
      //初始化获取数据
      this.$axios
        .post("/getorder", { manager: sessionStorage.getItem("user_name") })
        .then((res) => {
          for (const key in res.data) {
            if (res.data[key].type == 0) {
              let num = 0;
              let sum = 0;
              for (const k in res.data[key].nums) {
                num += parseInt(res.data[key].nums[k]);
                sum += parseInt(res.data[key].prices[k]);
              }
              res.data[key].goodsprice = sum.toFixed(2);
              res.data[key].goodsnum = num;
              res.data[key].goodsname = res.data[key].goodsname.toString();
            }
          }
          this.raw = res.data;
          this.tableData = this.raw;
          console.log(this.tableData);
        });
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    this.getinfo();
  },
  mounted() {},
};
</script>

<style scoped>
.el-table .el-table__cell .cell {
  text-align: center;
}

img {
  height: 100px;
  width: 100px;
}
.el-input {
  width: 500px;
}
</style>
