<template>
  <div>
    <div style="margin-bottom: 20px">
      <el-input v-model="params.name" style="width: 200px" placeholder="请输入图书名称"></el-input>
      <el-input v-model="params.author" style="width: 200px; margin-left: 10px" placeholder="请输入图书作者"></el-input>
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
          label="图书封面"
          align="center"
          width="100px">
        <template v-slot="scope">
          <el-image
              style="width: 50px; height: 50px; border-radius: 10px"
              :src="'http://localhost:9090/api/files/' + scope.row.img"
              :preview-src-list="['http://localhost:9090/api/files/' + scope.row.img]">
          </el-image>
        </template>
      </el-table-column>
      <el-table-column
          prop="name"
          label="图书名称"
          align="center">
      </el-table-column>
      <el-table-column
          prop="price"
          label="图书价格"
          align="center">
      </el-table-column>
      <el-table-column
          prop="author"
          label="图书作者"
          align="center">
      </el-table-column>
      <el-table-column
          prop="press"
          label="图书出版社"
          align="center">
      </el-table-column>
      <el-table-column
          prop="typeName"
          label="图书分类"
          align="center">
      </el-table-column>
      <el-table-column label="操作" fixed="right" width="280px" align="center" v-if="user.role === '管理员'">
        <template slot-scope="scope">
          <el-button type="primary" plain size="medium" @click="edit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="del(scope.row.id)">
            <el-button slot="reference" type="danger" plain size="medium" style="margin-left: 5px">删除</el-button>
          </el-popconfirm>
          <el-button type="info" plain size="medium" style="margin-left: 5px" @click="down(scope.row.img)">下载
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <div>
      <el-dialog title="请填写信息" :visible.sync="dialogFormVisible" width="40%">
        <el-form :model="form">
          <el-form-item label="图书封面" label-width="20%">
            <el-upload action="http://localhost:9090/api/files/upload"
                       :on-success="successUpload"
                       :file-list="fileList"
                       list-type="picture">
              <el-button size="small" type="primary">点击上传</el-button>
            </el-upload>
          </el-form-item>
          <el-form-item label="图书名称" label-width="20%">
            <el-input v-model="form.name" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="图书价格" label-width="20%">
            <el-input v-model="form.price" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="图书作者" label-width="20%">
            <el-input v-model="form.author" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="图书出版社" label-width="20%">
            <el-input v-model="form.press" autocomplete="off" style="width: 90%"></el-input>
          </el-form-item>
          <el-form-item label="图书分类" label-width="20%">
            <el-select v-model="form.typeId" placeholder="请选择" style="width: 90%">
              <el-option v-for="item in typeObjs" :key="item.id" :label="item.name" :value="item.id"></el-option>
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
  name: "Book",
  data() {
    return {
      tableData: [],
      total: 0,
      params: {
        name: '',
        author: '',
        pageNum: 1,
        pageSize: 10
      },
      dialogFormVisible: false,
      form: {},
      fileList: [],
      typeObjs: [],
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  created() {
    this.load();
    this.findType();
  },

  methods: {
    findType() {
      request.get("/type").then(res => {
        if (res.code === '200') {
          this.typeObjs = res.data;
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    load() {
      request.get("/book/search", {params: this.params}).then(res => {
        if (res.code === '200') {
          this.tableData = res.data.list;
          this.total = res.data.total;
        }
      })
    },
    reset() {
      this.params = {
        name: '',
        author: '',
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
      request.post("/book", this.form).then(res => {
        if (res.code === '200') {
          this.$message({
            message: '操作成功',
            type: 'success'
          });
          this.dialogFormVisible = false;
          this.fileList = [];
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
      request.delete("/book/" + id).then(res => {
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

    // 文件上传
    successUpload(res) {
      this.form.img = res.data;
    },

    // 文件下载
    down(flag) {
      location.href = 'http://localhost:9090/api/files/' + flag
    }
  }
}
</script>

<style scoped>

</style>