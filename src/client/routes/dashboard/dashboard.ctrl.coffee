'use strict'

angular.module 'rainstormweb'
.controller 'DashboardCtrl', ($scope) ->
  FractalNoiseShader =
    uniforms:
      iGlobalTime:
        type: 'f', value: 0.0
      iResolution:
        type: 'v3', value: null
      iChannel0:
        type: 't', value: null
    extensions:
      derivatives: true
      shaderTextureLOD: true
    vertexShader: """
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    """
    fragmentShader: document.querySelector('script#frag').innerText
  renderer = new THREE.WebGLRenderer
    antialias: true
  renderer.setSize window.innerWidth, window.innerHeight
  renderer.setClearColor 0x009090
  document.querySelector('.dashboard-route').appendChild renderer.domElement
  clock = new THREE.Clock()
  camera = new THREE.PerspectiveCamera 40, window.innerWidth, window.innerHeight, 1, 2000
  camera.position.z = 600
  scene = new THREE.Scene()
  composer = new THREE.EffectComposer renderer
  bgShader = new THREE.ShaderPass FractalNoiseShader
  bgShader.material.extensions.derivatives = true
  bgShader.material.extensions.shaderTextureLOD = true
  bgShader.uniforms.iResolution.value = new THREE.Vector3 window.innerWidth, window.innerHeight, 1
  bgShader.uniforms.iChannel0 =
    type: 't'
    value: new THREE.TextureLoader().load('public/road.jpg')
  bgShader.renderToScreen = true
  composer.addPass bgShader
  clock.start()
  lastTime = null
  bars = {}
  nums = {}
  animate = ->
    requestAnimationFrame animate
    dx = clock.getDelta()
    bgShader.uniforms.iGlobalTime.value += dx
    composer.render()
    now = new Date()
    thisTime = now.toString().match /(\d)(\d):(\d)(\d):(\d)(\d)/
    if thisTime[0] isnt lastTime
      lastTime = thisTime[0]
      thisTime.map (val, i) ->
        if i
          n = i - 1
          bits = (+val).toString(2).padStart(4, '0').split('')
          for bit, b in bits
            if not thisElm = bars['b' + b + n]
              thisElm = bars['b' + b + n] = document.querySelector('.b' + b + n)
            if bit is '0'
              if not thisElm.className.includes 'hide'
                thisElm.className += ' hide'
            else
              thisElm.className = thisElm.className.replace ' hide', ''
        null
  animate()
  window.onresize = ->
    renderer.setSize window.innerWidth, window.innerHeight
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    bgShader.uniforms.iResolution.value = new THREE.Vector3 window.innerWidth, window.innerHeight, 1