<template>
  <div>
    <span
        style="font-size: 24px; font-weight: bold; color:dodgerblue; display: inline-block; margin: 20px 0">Echarts图表</span>

    <div style="display: flex">
      <div style="width: 500px; margin-top: 20px">
        <div id="bie" style="width: 100%; height: 400px"></div>
      </div>

      <div style="flex: 1; margin-top: 20px">
        <div id="bar" style="width: 100%; height: 400px"></div>
      </div>

      <div style="flex: 1; margin-top: 20px">
        <div id="line" style="width: 100%; height: 400px"></div>
      </div>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts';
import request from "@/utils/request";

export default {
  name: "Echarts",
  props: {},
  components: {},
  data() {
    return {}
  },
  mounted() {
    this.initEcharts()
  },
  methods: {
    initEcharts() {
      request.get("/book/echarts/bie").then(res => {
        if (res.code === '200') {
          // 开始去渲染饼图数据啦
          this.initBie(res.data)
        } else {
          this.$message.error(res.msg)
        }
      })

      request.get("/book/echarts/bar").then(res => {
        if (res.code === '200') {
          // 开始去渲染柱状图数据啦
          let map = res.data;
          this.initBar(map.xAxis, map.yAxis)
          // 开始去渲染折线图数据啦
          this.initLine(map.xAxis, map.yAxis)
        } else {
          this.$message.error(res.msg)
        }
      })
    },

    initBie(data) {
      let chartDom = document.getElementById('bie');
      let myChart = echarts.init(chartDom);
      let option;

      option = {
        title: {
          text: '图书统计（饼图）',
          subtext: '统计维度：图书分类',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'left'
        },
        series: [
          {
            name: '图书分类',
            type: 'pie',
            radius: '50%',
            data: data,
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      };

      option && myChart.setOption(option);
    },

    initBar(xAxis, yAxis) {
      let chartDom = document.getElementById('bar');
      let myChart = echarts.init(chartDom);
      let option;

      option = {
        title: {
          text: '图书统计（柱状图）',
          subtext: '统计维度：图书分类',
          left: 'center'
        },
        xAxis: {
          type: 'category',
          data: xAxis
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            data: yAxis,
            type: 'bar',
            showBackground: true,
            backgroundStyle: {
              color: 'rgba(180, 180, 180, 0.2)'
            }
          }
        ]
      };

      option && myChart.setOption(option);
    },

    initLine(xAxis, yAxis) {
      let chartDom = document.getElementById('line');
      let myChart = echarts.init(chartDom);
      let option;

      option = {
        title: {
          text: '图书统计（折线图）',
          subtext: '统计维度：图书分类',
          left: 'center'
        },
        xAxis: {
          type: 'category',
          data: xAxis
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            data: yAxis,
            type: 'line'
          }
        ]
      };

      option && myChart.setOption(option);
    }
  },
}
</script>

<style scoped>

</style>