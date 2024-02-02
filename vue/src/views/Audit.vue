<template>
  <div>
    <div style="margin-bottom: 15px">
      <el-input v-model="params.name" style="width: 200px" placeholder="请输入请假缘由"></el-input>
      <el-button type="warning" style="margin-left: 10px" @click="load()">查询</el-button>
      <el-button type="warning" style="margin-left: 10px" @click="reset()">清空</el-button>
      <el-button type="primary" style="margin-left: 10px" @click="add()" v-if="user.role === '学生'">新增
      </el-button>
    </div>
    <div>
      <el-table :data="tableData"
                max-height="520"
                style="width: 100%"
                border
                stripe
                :default-sort="{prop: 'time', order: 'descending'}"
                :header-cell-style="{background:'#686d7b',color:'#ffffff',fontSize: '14px'}">
        <el-table-column align="center" sortable prop="name" label="请假原由"></el-table-column>
        <el-table-column align="center" sortable prop="time" label="请假日期"></el-table-column>
        <el-table-column align="center" sortable prop="day" label="请假天数"></el-table-column>
        <el-table-column align="center" prop="userName" label="请假用户" v-if="user.role !== '学生'"></el-table-column>
        <el-table-column align="center" prop="status" label="审核状态"></el-table-column>
        <el-table-column align="center" prop="reason" label="审核意见"></el-table-column>
        <el-table-column label="操作" align="center" width="180px">
          <template slot-scope="scope">
            <el-button type="primary" @click="edit(scope.row)" v-if="user.role === '学生'">编辑</el-button>
            <el-button type="success" @click="audit(scope.row)" v-if="user.role !== '学生'">审核</el-button>
            <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
              <el-button slot="reference" type="danger" style="margin-left: 5px">删除</el-button>
            </el-popconfirm>
          </template>
        </el-table-column>
      </el-table>
    </div>
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
    <div>
      <el-dialog title="请填写信息" :visible.sync="dialogFormVisible" width="40%">
        <el-form :model="form">
          <el-form-item label="请假原由" label-width="15%">
            <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="请假日期" label-width="15%">
            <el-date-picker v-model="form.time" type="date" style="width: 90%" placeholder="选择日期"
                            value-format="yyyy-MM-dd"></el-date-picker>
          </el-form-item>
          <el-form-item label="请假天数" label-width="15%">
            <el-input v-model="form.day" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="submit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
    <div>
      <el-dialog title="请审核" :visible.sync="auditVisible" width="35%">
        <el-form :model="form">
          <el-form-item label="审核状态" label-width="20%">
            <el-radio v-model="form.status" label="审核通过"></el-radio>
            <el-radio v-model="form.status" label="审核不通过"></el-radio>
          </el-form-item>
          <el-form-item label="审核意见" label-width="20%">
            <el-input v-model="form.reason" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="auditVisible = false">取 消</el-button>
          <el-button type="primary" @click="submit()">确 定</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Audit",
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
      auditVisible: false,
      form: {},
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {}
    }
  },
  created() {
    this.load()
  },
  methods: {
    load() {
      request.get("/audit/search", {
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
      this.form.userId = this.user.id;
      this.dialogFormVisible = true;
    },
    edit(obj) {
      this.form = obj;
      this.dialogFormVisible = true;
    },
    audit(obj) {
      this.form = obj;
      this.auditVisible = true;
    },
    reset() {
      this.params = {
        pageNum: 1,
        pageSize: 5,
        name: ''
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
    submit() {
      request.post("/audit", this.form).then(res => {
        if (res.code === '200') {
          this.$message.success("操作成功")
          this.dialogFormVisible = false;
          this.auditVisible = false;
          this.load();
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    del(id) {
      request.delete("/audit/" + id).then(res => {
        if (res.code === '200') {
          this.$message.success("删除成功")
          this.load();
        } else {
          this.$message.error(res.msg)
        }
      })
    }

  },
}
</script>

<style scoped>

</style>