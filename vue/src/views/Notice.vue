<template>
  <div>
    <div style="margin-bottom: 20px">
      <el-input v-model="params.name" style="width: 200px" placeholder="请输入公告名称"></el-input>
      <el-button type="primary" style="margin-left: 10px" @click="load">查询</el-button>
      <el-button type="info" style="margin-left: 10px" @click="reset">重置</el-button>
      <el-button type="warning" style="margin-left: 10px" @click="add()" v-if="user.role === '管理员'">新增</el-button>
    </div>

    <el-table
        :data="tableData"
        max-height="520"
        style="width: 100%"
        border
        stripe
        :header-cell-style="{background:'#686d7b',color:'#ffffff',fontSize: '14px'}">
      <el-table-column label="序号" type="index" width="100" align="center" fixed>
        <template slot-scope="scope">
          {{ params.pageSize * (params.pageNum - 1) + (scope.$index + 1) }}
        </template>
      </el-table-column>
      <el-table-column
          prop="name"
          label="公告名称"
          align="center">
      </el-table-column>
      <el-table-column
          prop="content"
          label="公告内容"
          align="center">
      </el-table-column>
      <el-table-column
          prop="time"
          label="发布时间"
          align="center">
      </el-table-column>
      <el-table-column label="操作" fixed="right" width="200px" align="center" v-if="user.role === '管理员'">
        <template slot-scope="scope">
          <el-button type="primary" plain size="medium" @click="edit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
            <el-button slot="reference" type="danger" plain size="medium" style="margin-left: 5px">删除</el-button>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div>
      <el-dialog title="请填写信息" :visible.sync="dialogFormVisible" width="30%">
        <el-form :model="form">
          <el-form-item label="公告标题" label-width="20%">
            <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="公告内容" label-width="20%">
            <el-input type="textarea" v-model="form.content" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="submit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
    <div style="margin-top: 10px; position: fixed; bottom: 20px;">
      <el-pagination
          background
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="params.pageNum"
          :page-sizes="[10, 20, 25, 50]"
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
  name: "Notice",
  data() {
    return {
      tableData: [],
      total: 0,
      params: {
        name: '',
        pageNum: 1,
        pageSize: 5
      },
      dialogFormVisible: false,
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load();
  },

  methods: {
    load() {
      request.get("/notice/search", {params: this.params}).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list;
          this.total = res.data.total;
        }
      })
    },
    reset() {
      this.params = {
        name: '',
        pageNum: 1,
        pageSize: 5
      }
      this.load()
    },
    handleSizeChange(pageSize) {
      this.params.pageSize = pageSize;
      this.load();
    },
    handleCurrentChange(pageNum) {
      this.params.pageNum = pageNum;
      this.load();
    },
    add() {
      this.form = {};
      this.dialogFormVisible = true;
    },
    edit(obj) {
      this.form = obj;
      this.dialogFormVisible = true;
    },
    submit() {
      request.post("/notice", this.form).then(res => {
        if (res.code === '200') {
          this.$message({
            message: '操作成功',
            type: 'success'
          });
          this.dialogFormVisible = false;
          this.load();
        } else {
          this.$message({
            message: res.msg,
            type: 'error'
          });
        }
      })
    },
    del(id) {
      request.delete("/notice/" + id).then(res => {
        if (res.code === '200') {
          this.$message({
            message: '删除成功',
            type: 'success'
          });
          this.load();
        } else {
          this.$message({
            message: res.msg,
            type: 'error'
          });
        }
      })
    }
  }
}
</script>

<style scoped>

</style>