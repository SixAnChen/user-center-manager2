<template>
  <div>
    <span style="font-size: 24px; font-weight: bold; color:dodgerblue; display: inline-block; margin: 20px 0">系统公告</span>
    <el-collapse v-model="activeNames" @change="handleChange">
      <el-collapse-item v-for="item in data" :title="item.name" :name="item.id">
        <div>{{ item.content }}</div>
      </el-collapse-item>
    </el-collapse>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Home",
  props: {},
  components: {},

  data() {
    return {
      activeNames: [],
      data: []
    }
  },
  mounted() {
    this.findNotice()
  },
  methods: {
    findNotice() {
      request.get("/notice").then(res => {
        if (res.code === '200') {
          this.data = res.data;
          this.activeNames = res.data[0].id
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