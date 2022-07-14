<template>
  <div>
    <el-button type="primary" @click="keyong">可用的授权码</el-button>
    <el-button type="danger" @click="used">使用过的授权码</el-button>
    <el-table :data="tableData" style="width: 100%" height="380">
      <el-table-column label="id" width="180">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="授权码" width="180">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.auth_num }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            :type="scope.row.state == '可用' ? 'success' : 'warning'"
            disabled
            >{{ scope.row.state }}</el-button
          >
          <el-button
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
            >删除</el-button
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
      tableData: [],
      raw: "",
    };
  },
  methods: {
    handleDelete(index, row) {
     if(sessionStorage.getItem('user_name')=='admin'){
        this.$axios
        .get(`http://www.lycwssapi.com:8081/biao?id=${row.id}`)
        .then((response) => {
          this.tableData = this.tableData.filter((item) => item.id != row.id);
          this.getinfo();
        });
     }else{
       alert('对不起，您无操作权限')
     }
    },
    used() {
      this.tableData = this.raw.filter((item) => item.state === "禁用");
    },
    keyong() {
      this.tableData = this.raw.filter((item) => item.state === "可用");
    },
    getinfo() {
      this.$axios.get(`http://www.lycwssapi.com:8081/biao`).then((response) => {
        this.raw = response.data;
      });
    },
  },
  components: {},
  computed: {},
  watch: {},
  created() {
    this.$axios.get(`http://www.lycwssapi.com:8081/biao`).then((response) => {
      this.raw = response.data;
      this.tableData = this.raw;
    });
  },
  mounted() {},
};
</script>

<style scoped>
</style>
