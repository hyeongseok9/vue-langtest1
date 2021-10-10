<template>
    <div >
        <p>Hello World</p>
        <svg >
            <D3Axis :scale="axisYScale"
                 orient="right"/>
        
            <D3Axis :scale="axisXScale"
                 orient="bottom"/>
        </svg>
        <svg >
            <D3AxisSample />
        </svg>
    </div>
</template>

<script>
import D3Axis from './vue-d3/D3Axis'
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
        D3AxisSample,
    },
    data(){
        return {
            dimensions: {
                width:  0,
                height: 0
            }
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
        },
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
</style>