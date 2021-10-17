<template>
  <div id="app">
    <img src="./assets/logo.png">
    <D3Test2/>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld'
import D3Test1 from './components/D3Test1'
import D3Test2 from './components/D3Test2'

export default {
  name: 'App',
  components: {
    HelloWorld,
    D3Test1,
    D3Test2,
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
