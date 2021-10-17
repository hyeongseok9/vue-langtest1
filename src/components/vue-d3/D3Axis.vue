<template>
<g  fill="none" font-size="10" font-family="sans-serif" text-anchor="middle" :transform="transformA">
  <path class="domain" stroke="currentColor" v-bind:[lineAttrKey]="lineAttrVal" :d="lined"></path>
  <g class="scale-ticks"
     :class="[position]">

    <!-- Tick instance -->
    <g v-for="(item, index) in ticks"
       :key="index"
       :transform="item.transform">

      <!-- Tick Line -->
      <line v-bind="item.lineTransform"
            stroke="#000"
            stroke-width="2" />

      <!-- Text -->
      <g v-bind="item.textTransform">
        <slot v-bind="item">
          <text fill="currentColor" v-bind:[x]="textSpacingVal" :dy="textDy">{{item.value}}</text>
        </slot>
      </g>
    </g>
  </g>
</g>  
</template>



<script>
export default {
    props: {
        scale: {
            type:     Function,
            required: true
        },
        orient: {
            type:    String,
            default: 'top',
            validator(val) {
                return ['left', 'right', 'top','bottom'].includes(val)
            }
        },
        count: {
            type: Number
        }
    },
    methods:{
        translateX(x){
            return `translate(${x} ,0)`; 
        },
        translateY(y){
            return `translate(0, ${y} ")`; 
        },
        identity(x){
            return x;
        },
        number(scale) {
            return d => +scale(d);
        },
        center(scale, offset) {
            offset = Math.max(0, scale.bandwidth() - offset * 2) / 2;
            if (scale.round()) offset = Math.round(offset);
            return d => +scale(d) + offset;
        },
        calcPosition(){
            var tickArguments = [],
                tickValues = null,
                tickFormat = null,
                tickSizeInner = 6,
                tickSizeOuter = 6,
                tickPadding = 3,
                offset = typeof window !== "undefined" && window.devicePixelRatio > 1 ? 0 : 0.5,
                k = this.orient === 'top' || this.orient === 'left' ? -1 : 1,
                x = this.orient === 'left' || this.orient === 'right' ? "x" : "y",
                transform = this.orient === 'top' || this.orient === 'bottom' ? this.translateX : this.translateY;

            var scale = this.scale.copy();

            var values = tickValues == null ? (scale.ticks ? scale.ticks.apply(scale, tickArguments) : scale.domain()) : tickValues,
                format = tickFormat == null ? (scale.tickFormat ? scale.tickFormat.apply(scale, tickArguments) : this.identity) : tickFormat,
                spacing = Math.max(tickSizeInner, 0) + tickPadding,
                range = scale.range();

            var range0 = range[0] + offset,
                range1 = range[range.length - 1] + offset,
                position = (scale.bandwidth ? this.center : this.number)(scale.copy(), offset);
            var lineAttrKey = x + "2", 
                lineAttrVal = k * tickSizeInner,
                textSpacingVal = k * spacing,
                textDy = this.orient === 'top' ? "0em" : this.orient === 'bottom' ? "0.71em" : "0.32em";
            var transformA = this.orient === 'bottom' ? "translate(0, "+range1+")": 
                this.orient === 'right'? "translate("+range0+", 0)":"";
            var ret= {tickArguments,
                tickValues,
                tickFormat,
                tickSizeInner,
                tickSizeOuter,
                tickPadding,
                offset,
                k,
                x,
                transform,
                values,
                format,
                spacing,
                range,
                range0,
                range1,
                position,
                lineAttrKey,
                lineAttrVal,
                textSpacingVal,
                textDy,
                transformA};
            return ret;
        }
    },
    data(){
        
        return this.calcPosition();
    },
    computed:{
        lined(){
            var ret = this.orient === 'left' || this.orient === 'right'
                    ? (this.tickSizeOuter ? "M" + this.k * this.tickSizeOuter + "," + this.range0 + "H" + this.offset + "V" + this.range1 + "H" + this.k * this.tickSizeOuter : "M" + this.offset + "," + this.range0 + "V" + this.range1)
                    : (this.tickSizeOuter ? "M" + this.range0 + "," + this.k * this.tickSizeOuter + "V" + this.offset + "H" + this.range1 + "V" + this.k * this.tickSizeOuter : "M" + this.range0 + "," + this.offset + "H" + this.range1);

            return ret;
        },
        ticks() {
            return this.scale.ticks(this.count).map(v => {
                const s = this.scale(v)
                const p = this.orient

                // Pixel values
                const x = p === 'left' || p === 'right' ? 0 : s
                const y = p === 'top' || p === 'bottom' ? 0 : s

                // translation
                const transform = `translate(${x} ${y})`

                const lineTransform = {
                x0: 0,
                y0: 0,
                x1: p === 'left' ? -5 : p === 'right' ? 5 : 0,
                y1: p === 'top' ? -5 : p === 'bottom' ? 5 : 0
                }

                const tx = p === 'left' ? -10 : p === 'right' ? 10 : 0
                const ty = p === 'top' ? -10 : p === 'bottom' ? 1 : 0

                const textTransform = {
                transform: `translate(${tx} ${ty})`
                }

                return {
                transform,
                lineTransform,
                textTransform,
                value: v
                }
            })
        }
    },
    watch:{
        orient: function(val, oldVal) {
            var ret = this.calcPosition();
            this.tickArguments = ret.tickArguments;
            this.tickValues = ret.tickValues;
            this.tickFormat = ret.tickFormat;
            this.tickSizeInner = ret.tickSizeInner;
            this.tickSizeOuter = ret.tickSizeOuter;
            this.tickPadding = ret.tickPadding;
            this.offset = ret.offset;
            this.k = ret.k;
            this.x = ret.x;
            this.transform = ret.transform;
            this.values = ret.values;
            this.format = ret.format;
            this.spacing = ret.spacing;
            this.range = ret.range;
            this.range0 = ret.range0;
            this.range1 = ret.range1;
            this.position = ret.position;
            this.lineAttrKey = ret.lineAttrKey;
            this.lineAttrVal = ret.lineAttrVal;
            this.textSpacingVal = ret.textSpacingVal;
            this.textDy = ret.textDy;
            this.transformA = ret.transformA;
        }
    }

}
</script>

<style scoped>


</style>