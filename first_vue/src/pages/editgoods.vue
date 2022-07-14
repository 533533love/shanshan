<template>
  <div>
    <el-input v-model="input" placeholder="请输入商品名称"></el-input><el-button type="primary" icon="el-icon-search" @click="search">搜索</el-button>
    <el-table :data="tableData" style="width: 100%" height="500">
      <el-table-column label="商品ID" width="100">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品类型" width="100">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.goodstype }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品名字" width="180">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.goodsname }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品价格" width="100">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.goodsprice }}</span>
        </template>
      </el-table-column>
      <el-table-column label="商品图片" width="180">
        <template slot-scope="scope">
          <span style="margin-left: 10px"
            ><img :src="$imgurl + scope.row.goodsimg" alt=""
          /></span>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
            >编辑</el-button
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
      input:'',
      tableData: [],
      raw:''
    };
  },
  methods: {
    handleEdit(index, row) {
      console.log(row);
      this.$router.push({
        path: "/index/add",
        query: {
          id: row.id,
          goodsname: row.goodsname,
          goodsprice: row.goodsprice,
          goodstype: row.goodstype,
          goodsimg: row.goodsimg,
        },
      });
    },
    search(){
      this.tableData=this.raw.filter(item=>
       item.goodsname.indexOf(this.input)!=-1
      )
    },
    handleDelete(index, row){
      this.$axios.post('/edit',{id:row.id}).then(res=>{
        if (res.data.code==200) {
          this.tableData = this.tableData.filter(item=>item.id!=row.id)
        }
      })
    },
    getinfo(){
      this.$axios.post("/edit",{user:sessionStorage.getItem('user_name')}).then((res) => {
        console.log(res.data);
      this.raw = res.data;
      this.tableData = this.raw
    });
    }
  },
  components: {},
  computed: {},
  watch: {},
  created() {
   this.getinfo()
  },
  mounted() {},
};
</script>

<style scoped>
img {
  height: 100px;
  width: 100px;
}
.el-input{
  width: 500px;
}
</style>
