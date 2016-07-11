import imagesLoaded from "imagesloaded"

const GifPause = {}

GifPause.init = selector => {
  var images = document.querySelectorAll(selector)
  for (var i = 0, l = images.length; i < l; ++i) {
    preProcessImage(images[i])
  }
}

const preProcessImage = image => {
  var container = document.createElement('div')
  var canvas = document.createElement('canvas')
  
  container.classList.add('static-gif-container')
  canvas.classList.add('static-gif-canvas')
  
  image.parentNode.insertBefore(container, image)
  image.classList.add('static-gif-image')
  
  container.appendChild(image)
  container.appendChild(canvas)
  
  imagesLoaded(image, () => {
    processImage(image, container, canvas)
  })
}

const processImage = (image, container, canvas) => {
  var h = image.clientHeight
  var w = image.clientWidth
  
  canvas.setAttribute('width', w)
  canvas.setAttribute('height', h)
  canvas.getContext('2d').drawImage(image, 0, 0, w, h)
  
  container.addEventListener('mouseover', () => {
    console.log('hover')
    image.setAttribute('src', image.getAttribute('src'))
  })
}

export default GifPause