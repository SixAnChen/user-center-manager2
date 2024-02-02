import Vue from 'vue'
import App from './App.vue'
import router from './router'

//  ElementUI
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
//  全局css
import '@/assets/css/global.css'
import '@/assets/css/theme/index.css'

Vue.use(ElementUI, {size: 'small'});
Vue.config.productionTip = false


new Vue({
    router,
    render: h => h(App)
}).$mount('#app')
