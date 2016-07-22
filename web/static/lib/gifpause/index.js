import imagesLoaded from "imagesloaded"

const GifPause = {}

GifPause.init = function(selector, resetSelector) {
  var images = document.querySelectorAll(selector)
  for (var i = 0, l = images.length; i < l; ++i) {
    this.processImage(images[i], resetSelector)
  }
}

GifPause.processImage = (image, resetSelector) => {
  var container = document.createElement('div')
  var canvas = document.createElement('canvas')
  
  container.classList.add('static-gif-container')
  canvas.classList.add('static-gif-canvas')
  
  image.parentNode.insertBefore(container, image)
  image.classList.add('static-gif-image')
  
  container.appendChild(image)
  container.appendChild(canvas)
  
  if (resetSelector) {
    attachGifReset(image, resetSelector)
  }
  
  imagesLoaded(image, () => {
    processImage(image, canvas)
  })
}

const attachGifReset = (image, selector) => {
  var element = closest(image, el => el.classList.contains(selector))
  if ( ! element) {
    return
  }

  element.addEventListener('mouseenter', (e) => {
    image.setAttribute('src', image.getAttribute('src'))
  })
}

const closest = (el, callback) => {
  return el && (callback(el) ? el : closest(el.parentNode, callback));
}

const processImage = (image, canvas) => {
  var h = image.clientHeight
  var w = image.clientWidth
  
  canvas.setAttribute('width', w)
  canvas.setAttribute('height', h)
  canvas.getContext('2d').drawImage(image, 0, 0, w, h)
}

export default GifPause