<template>
  <g >
    <path :d="_d" ></path>
  </g>
</template>

<script>
// import _ from 'lodash'
import * as d3 from 'd3-shape'

export default {
  data() {
    return {}
  },
  props: {
    dataset: {
      type: Array,
      default() {
        return [[12, 50], [40, 70], [50, 10], [80, 30], [143, 90], [180, 20]]
      }
    },
    
    curve: {
      type:    Function,
      default: d3.curveLinear
    },
    scaleX: {
            type:     Function,
            required: true
        },
    scaleY: {
            type:     Function,
            required: true
        },
    xGetter: {
      type:    Function,
      default: function(v){
          return v[0]
      }
    },
    yGetter: {
      type:    Function,
      default: function(v){
          return v[1]
      } 
    }
  },
  methods:{
      xScale: function(v){
          var x = this.xGetter(v)

          return this.scaleX(x)
      },
      yScale: function(v){
          var x = this.yGetter(v)

          return this.scaleY(x)
      },
  },
  computed: {
    _d() {
      return (
        d3
          .line()
          // .curve(curveCardinal)
          .curve(this.curve)
          .x(this.xScale)
          .y(this.yScale)(this.dataset)
      )
    }    
  }
}
</script>

<style scoped >
path {
  fill: none;
  stroke: #000;
}
</style>
