<template>
  <div>
    <div style="margin-bottom: 20px">
      <el-input v-model="params.name" style="width: 200px" placeholder="请输入姓名"></el-input>
      <el-input v-model="params.address" style="width: 200px;margin-left: 10px" placeholder="请输入地址"></el-input>
      <el-select v-model="params.role" placeholder="请选择角色" style="width: 200px;margin-left: 10px">
        <el-option label="普通用户" value="普通用户"></el-option>
        <el-option label="教师" value="教师"></el-option>
        <el-option label="学生" value="学生"></el-option>
      </el-select>
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
          label="姓名"
          align="center">
      </el-table-column>
      <el-table-column
          prop="sex"
          label="性别"
          align="center">
      </el-table-column>
      <el-table-column
          prop="address"
          label="地址"
          align="center">
      </el-table-column>
      <el-table-column
          prop="role"
          label="角色"
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
          <el-form-item label="姓名" label-width="15%">
            <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="性别" label-width="15%">
            <el-radio v-model="form.sex" label="男">男</el-radio>
            <el-radio v-model="form.sex" label="女">女</el-radio>
          </el-form-item>
          <el-form-item label="地址" label-width="15%">
            <el-input v-model="form.address" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="角色" label-width="15%">
            <el-select v-model="form.role" placeholder="请选择" style="width: 90%">
              <el-option v-for="item in typeObjs" :key="item.id" :label="item.name" :value="item.name"></el-option>
            </el-select>
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
  name: "ElementUI",
  data() {
    return {
      tableData: [],
      total: 0,
      params: {
        name: '',
        address: '',
        role: '',
        pageNum: 1,
        pageSize: 10
      },
      dialogFormVisible: false,
      form: {},
      typeObjs: [
        {id: '1', name: '普通用户'},
        {id: '2', name: '学生'},
        {id: '3', name: '教师'},
      ],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load();
  },

  methods: {
    load() {
      request.get("/user/search", {params: this.params}).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list;
          this.total = res.data.total;
        }
      })
    },
    reset() {
      this.params = {
        name: '',
        address: '',
        role: '',
        pageNum: 1,
        pageSize: 10
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
      request.post("/user", this.form).then(res => {
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
      request.delete("/user/" + id).then(res => {
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