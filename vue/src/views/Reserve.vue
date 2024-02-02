<template>
  <div>
    <div style="margin-bottom: 15px">
      <el-input v-model="params.name" style="width: 200px" placeholder="请输入酒店名称"></el-input>
      <el-button type="warning" style="margin-left: 10px" @click="load()">查询</el-button>
      <el-button type="warning" style="margin-left: 10px" @click="reset()">清空</el-button>
      <el-button type="primary" style="margin-left: 10px" @click="add()" v-if="user.role === '管理员'">新增
      </el-button>
    </div>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="hotelName" label="酒店名称"></el-table-column>
      <el-table-column prop="userName" label="预订人"></el-table-column>
      <el-table-column prop="time" label="预订时间"></el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
            <el-button slot="reference" type="danger" style="margin-left: 5px" v-if="user.role === '管理员'">删除
            </el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="margin-top: 10px">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="params.pageNum"
          :page-sizes="[5, 10, 15, 20]"
          :page-size="params.pageSize"
          layout="total, sizes, prev, pager, next"
          :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Reserve",
  data() {
    return {
      params: {
        name: '',
        pageNum: 1,
        pageSize: 5
      },
      tableData: [],
      total: 0,
      dialogFormVisible: false,
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }

  },
  created() {
    this.load()
  },
  methods: {
    load() {
      request.get("/reserve/search", {
        params: this.params
      }).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list;
          this.total = res.data.total;
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    add() {
      this.form = {};
      this.dialogFormVisible = true;
    },
    edit(obj) {
      this.form = obj;
      this.dialogFormVisible = true;
    },
    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 5,
        name: '',
      }
      this.load();
    },
    handleSizeChange(pageSize) {
      this.params.pageSize = pageSize;
      this.load();
    },
    handleCurrentChange(pageNum) {
      this.params.pageNum = pageNum;
      this.load();
    },
    del(id) {
      request.delete("/reserve/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功");
          this.load();
        } else {
          this.$message.error(res.msg)
        }
      })
    },

  },
}
</script>

<style scoped>

</style>