<template>
  <div>
    <div style="margin-bottom: 20px">
      <el-input v-model="params.name" style="width: 200px" placeholder="请输入分类名称"></el-input>
      <el-input v-model="params.description" style="width: 200px; margin-left: 10px" placeholder="请输入描述信息"></el-input>
      <el-button type="primary" style="margin-left: 10px" @click="load">查询</el-button>
      <el-button type="info" style="margin-left: 10px" @click="reset">重置</el-button>
      <el-button type="primary" plain style="margin-left: 10px" @click="add()" v-if="user.role === '管理员'">添加分类
      </el-button>
      <el-popconfirm title="确定删除这些数据吗？" @confirm="delBatch()">
        <el-button slot="reference" type="danger" plain style="margin-left: 5px" v-if="user.role === '管理员'">批量删除
        </el-button>
      </el-popconfirm>
      <el-button type="warning" plain style="margin-left: 5px" @click="exp()">导出报表</el-button>
      <el-upload action="http://localhost:9090/api/type/upload" style="display: inline-block; margin-left: 10px"
                 :show-file-list="false" :on-success="successUpload">
        <el-button type="info" plain v-if="user.role === '管理员'">批量导入</el-button>
      </el-upload>
    </div>

    <el-table
        :data="tableData"
        max-height="520"
        @selection-change="handleSelectionChange"
        ref="table"
        :row-key="getRowKeys"
        style="width: 100%"
        border
        stripe
        :header-cell-style="{background:'#686d7b',color:'#ffffff',fontSize: '14px'}">
      <el-table-column type="selection" width="55" align="center" :reserve-selection="true"></el-table-column>
      <el-table-column label="序号" type="index" width="100" align="center" fixed>
        <template slot-scope="scope">
          {{ params.pageSize * (params.pageNum - 1) + (scope.$index + 1) }}
        </template>
      </el-table-column>
      <el-table-column
          prop="name"
          label="分类名称"
          align="center">
      </el-table-column>
      <el-table-column
          prop="description"
          label="描述信息"
          align="center">
      </el-table-column>
      <el-table-column label="操作" fixed="right" width="280px" align="center" v-if="user.role === '管理员'">
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
          <el-form-item label="分类名称" label-width="20%">
            <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="描述信息" label-width="20%">
            <el-input v-model="form.description" autocomplete="off" style="width: 90%"></el-input>
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
  name: "Type",
  props: {},
  components: {},
  mounted: {},
  data() {
    return {
      tableData: [],
      total: 0,
      params: {
        name: '',
        description: '',
        pageNum: 1,
        pageSize: 5
      },
      dialogFormVisible: false,
      form: {},
      multipleSelection: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load();
  },

  methods: {
    load() {
      request.get("/type/search", {params: this.params}).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list;
          this.total = res.data.total;
        }
      })
    },
    reset() {
      this.params = {
        name: '',
        description: '',
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
      request.post("/type", this.form).then(res => {
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
      request.delete("/type/" + id).then(res => {
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
    },

    delBatch() {
      if (this.multipleSelection.length === 0) {
        this.$message.warning("请勾选您要删除的项")
        return
      }
      request.put("/type/delBatch", this.multipleSelection).then(res => {
        if (res.code === '200') {
          this.$message.success("批量删除成功")
          this.reset()
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    //记录行被选中的状态
    getRowKeys(row) {
      return row.id
    },


    exp() {
      let user = localStorage.getItem("user");
      location.href = 'http://localhost:9090/api/type/export?token=' + JSON.parse(user).token
    },

    successUpload(res) {
      if (res.code === '200') {
        this.$message.success("批量导入成功")
        this.reset()
      } else {
        this.$message.error(res.msg)
      }
    }
  }
}
</script>

<style scoped>

</style>