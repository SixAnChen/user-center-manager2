<template>
  <div>
    <el-container>
      <!-- 侧边栏 -->
      <el-aside :width="asideWidth">
        <div class="logo">
          <img src="@/assets/logo.png" alt="">
          <span v-show="!isCollapse">honey2024</span>
        </div>

        <el-menu :collapse="isCollapse"
                 :collapse-transition="false"
                 router
                 :default-active="$route.path">
          <el-menu-item index="/home">
            <i class="el-icon-house"></i>
            <span slot="title">系统首页</span>
          </el-menu-item>

          <el-submenu>
            <template slot="title">
              <i class="el-icon-menu"></i>
              <span>信息管理</span>
            </template>
            <el-menu-item index="/user">
              <i class="el-icon-user-solid"></i>
              <span slot="title">用户管理</span>
            </el-menu-item>
            <el-menu-item index="/book">
              <i class="el-icon-s-data"></i>
              <span slot="title">图书管理</span>
            </el-menu-item>
            <el-menu-item index="/type">
              <i class="el-icon-collection-tag"></i>
              <span slot="title">图书分类</span>
            </el-menu-item>
            <el-menu-item index="/audit">
              <i class="el-icon-document-checked"></i>
              <span slot="title">提交审核</span>
            </el-menu-item>
            <el-menu-item index="/hotel">
              <i class="el-icon-location"></i>
              <span slot="title">酒店管理</span>
            </el-menu-item>
            <el-menu-item index="/reserve">
              <i class="el-icon-s-order"></i>
              <span slot="title">预订信息</span>
            </el-menu-item>
            <el-menu-item index="/log">
              <i class="el-icon-data-analysis"></i>
              <span slot="title">日志管理</span>
            </el-menu-item>
            <el-menu-item index="/notice">
              <i class="el-icon-close-notification"></i>
              <span slot="title">公告管理</span>
            </el-menu-item>
            <el-menu-item index="/echarts">
              <i class="el-icon-s-data"></i>
              <span slot="title">Echarts图表</span>
            </el-menu-item>
          </el-submenu>
        </el-menu>

      </el-aside>

      <el-container>
        <!--头部区域-->
        <el-header>
          <!-- 左侧收缩按钮 -->
          <i :class="collapseIcon" @click="handleCollapse"></i>
          <!-- 面包屑导航 -->
          <div style="margin-left: 40px">
            <el-breadcrumb separator="/">
              <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item :to="{ path: $route.path }">{{ $route.meta.name }}</el-breadcrumb-item>
            </el-breadcrumb>
          </div>
          <!-- 个人信息 -->
          <div class="r-content">
            <el-dropdown placement="bottom">
              <div class="avatar">
                <img src="@/assets/logo.png" alt="">
                <span>{{ user.name }}</span>
              </div>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item>个人信息</el-dropdown-item>
                <el-dropdown-item>修改密码</el-dropdown-item>
                <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
        </el-header>
        <!--主体区域-->
        <el-main>
          <router-view/>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>

export default {
  name: '',
  data() {
    return {
      isCollapse: false,  // 不收缩
      asideWidth: '200px',
      collapseIcon: 'el-icon-s-fold',
      user: localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {},
    }
  },
  methods: {
    handleCollapse() {
      this.isCollapse = !this.isCollapse
      this.asideWidth = this.isCollapse ? '64px' : '200px'
      this.collapseIcon = this.isCollapse ? 'el-icon-s-unfold' : 'el-icon-s-fold'
    },

    logout() {
      localStorage.removeItem("user");
      this.$router.push("/login");
    }
  }
}
</script>

<style lang="less" scoped>


/*logo*/
.logo {
  height: 60px;
  font-size: 20px;
  display: flex;
  align-items: center;
  justify-content: center;

  img {
    width: 40px;
    height: 40px;
    margin: 0 5px
  }

  span {
    color: #333333;
    font-weight: bold;
    font-size: 20px;
  }
}


.el-menu {
  min-height: calc(100vh - 60px);
}

/*侧边栏*/
.el-aside {
  transition: width .2s;
}

/*头部*/
.el-header {
  box-shadow: 2px 0 6px rgba(0, 21, 41, .35);
  display: flex;
  align-items: center;

  i {
    font-size: 26px;
  }

  .r-content {
    flex: 1;
    width: 0;
    display: flex;
    align-items: center;
    justify-content: flex-end;

    .avatar {
      display: flex;
      align-items: center;
      cursor: default;
    }

    img {
      width: 40px;
      height: 40px;
      margin: 0 5px
    }
  }
}
</style>