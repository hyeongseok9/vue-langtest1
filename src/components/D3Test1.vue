<template>
    <div >
        <p>Hello World</p>
        <svg >
            
            <D3Axis :scale="axisYScale"
                 orient="left"/>
            <path :d="_d"></path>
            <D3Axis :scale="axisXScale"
                 orient="bottom"/>

            <D3Line :scaleX="axisXScale" :scaleY="axisYScale" :dataset="sample"/>
        </svg>
        
    </div>
</template>

<script>

import D3Axis from './vue-d3/D3Axis'
import D3Line from './vue-d3/D3Line'
import D3AxisSample from './vue-d3/D3AxisSample'
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
        D3Line,
        D3AxisSample,
    },
    data(){
        return {
            dimensions: {
                width:  0,
                height: 0
            },
            sample:[[10, 10], [20, 20], [30, 90], [40, 110], [50, 130], [60, 150]]
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