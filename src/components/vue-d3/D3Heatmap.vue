<template>
  <g >
    <!--<rect x="40.5" width="25.458333333333332" y="30.5" height="8.863013698630137" fill="rgb(250, 225, 211)"><title>January 1, 12 AM
1.88 kW</title></rect>-->

<rect v-for="(item, index) in dots" 
  :key="index" :x="item.x" :width="item.width" :y="item.y" :height="item.height" 
  :fill="item.fill">
  <title>{{item.title}}</title></rect>


  </g>
</template>

<script>
import * as d3 from 'd3-scale-chromatic'
export default {
  data() {
    return {}
  },
  props: {
    dataset: {
      type: Array,
      default() {
        return [[12, 50, 1], [40, 70,2], [50, 10,3], [80, 30,4], [143, 90, 5], [180, 20, 6]]
      }
    },
    
    blockWidth: {
      type:    Number,
      default: 0
    },
    blockHeight: {
      type:    Number,
      default: 0
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
    },
    zGetter: {
      type:    Function,
      default: function(v){
          return v[2]
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
    dots() {
      return this.dataset.map((xNy) =>{
        var x = this.xScale(xNy);
        var y = this.yScale(xNy);
        var fill = "rgb(255,0,0)";
        var z = this.zGetter(xNy);
        fill = d3.interpolateBlues(z/100.0);
        console.log("dots y:"+this.yGetter(xNy)+"scacledY:"+y+"height:"+this.blockHeight+" scaledHeight:"+this.scaleY(this.blockHeight));
        var s = 130;
        console.log("test:"+s+"scaledy:"+this.scaleY(s));
        var recalcedHeight = Math.abs(this.scaleY(1) - this.scaleY(0)) * this.blockHeight;
        var item = {x : x-this.scaleX(this.blockWidth), y: y, 
          width: this.scaleX(this.blockWidth), height: recalcedHeight, 
          fill: fill};
        return item;
      });
    }    
  }
}
</script>

<style scoped >

</style>
