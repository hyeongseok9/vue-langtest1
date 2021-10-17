<template>
    <div >
        <p>Hello World</p>
        <svg >
            
            <D3Axis :scale="axisYScale"
                 orient="left"/>
            <D3Axis :scale="axisXScale"
                 orient="bottom"/>

            <D3Heatmap :scaleX="axisXScale" :scaleY="axisYScale" 
            :dataset="sample" :blockWidth="10" :blockHeight="10"/>
        </svg>
        
    </div>
</template>

<script>

import D3Axis from './vue-d3/D3Axis'
import D3Heatmap from './vue-d3/D3Heatmap'

import {
  scaleLinear,
  scaleTime,
  scaleLog,
  scaleQuantize,
  scalePow
} from 'd3-scale'

export default {
    components:{
        D3Axis,
        D3Heatmap,
    },
    data(){
        return {
            dimensions: {
                width:  0,
                height: 0
            },
            sample:[[10, 10, 1], [20, 20, 45], [30, 90,34], [40, 110,33], [50, 130,64], [60, 150,43],[70, 130,87]]
        }
    },
    computed:{
        axisScale() {
            return scaleLinear()
                .domain([0, 100])
                .range([0, this.dimensions.width || 500])
        },
        axisXScale() {
            return scaleLinear()
                .domain([0, 100])
                .range([0, this.dimensions.width || 500])
        },
        axisYScale() {
            return scaleLinear()
                .domain([0, 200])
                .range([this.dimensions.height || 500, 0])
        }
    }    
}

</script>

<style scoped>

svg {
    width:100%;
    height:100%;
    overflow:visible;
    padding: 0 0 0 2em;
}

path {
  fill: none;
  stroke: #000;
}
</style>