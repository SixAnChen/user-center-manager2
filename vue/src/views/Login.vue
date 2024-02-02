<template>
  <div class="login-container">
    <div
        class="login-form">
      <div
          style="width: 100%; font-weight: bold; font-size: 30px; line-height: 100px; text-align: center; color: dodgerblue">
        欢迎登录
      </div>
      <div style="margin-top: 25px; text-align: center; height: 320px;">
        <el-form :model="user">
          <el-form-item>
            <el-input v-model="user.name" prefix-icon="el-icon-user" style="width: 80%"
                      placeholder="请输入用户名"></el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="user.password" prefix-icon="el-icon-lock" style="width: 80%"
                      placeholder="请输入密码"></el-input>
          </el-form-item>
          <el-form-item>
            <div style="display: flex; justify-content: center">
              <el-input v-model="user.verCode" prefix-icon="el-icon-user" style="width: 40%;"
                        placeholder="请输入验证码"></el-input>
              <img :src="captchaUrl" @click="clickImg()" width="40%" height="33px"/>
            </div>
          </el-form-item>
          <el-form-item>
            <el-button style="width: 80%; margin-top: 10px" type="primary" @click="login()">登录</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Login",
  props: {},
  components: {},
  data() {
    return {
      user: {},
      key: '',
      captchaUrl: ''
    }
  },
  mounted() {
    this.key = Math.random();
    this.captchaUrl = "http://localhost:9090/api/captcha?key=" + this.key
  },

  methods: {
    clickImg() {
      this.key = Math.random();
      this.captchaUrl = 'http://localhost:9090/api/captcha?key=' + this.key;
    },
    login() {
      request.post("/user/login?key=" + this.key, this.user).then(res => {
        if (res.code === '200') {
          this.$message({
            message: '登录成功',
            type: 'success'
          });
          localStorage.setItem("user", JSON.stringify(res.data));
          this.$router.push("/");
        } else {
          this.$message({
            message: res.msg,
            type: 'error'
          });
          this.key = Math.random();
          this.captchaUrl = "http://localhost:9090/api/captcha?key=" + this.key
          this.user.verCode = ''
        }
      })
    }

  },
}
</script>

<style scoped>
.login-container {
  height: 100vh;
  background-image: url("../assets/img.png");
  background-size: cover;
  background-position: 50%;
  overflow: hidden;
}

.login-form {
  margin: 100px auto;
  background-color: rgba(255, 255, 255, 0.8);
  width: 400px;
  height: 400px;
  padding: 20px;
  border-radius: 10px;
}
</style>