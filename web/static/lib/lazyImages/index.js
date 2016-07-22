import $ from "jquery"
import imagesLoaded from "imagesloaded"
import { throttle } from "lodash"

const noop = function() {}

const LazyLoader = function(selector = '.lazy', verticalBuffer = 0, callback) {
  this.selector = selector
  this.verticalBuffer = verticalBuffer
  this.processing = false
  this.callback = callback || noop
}

var proto = LazyLoader.prototype

proto.init = function() {
  this.$images = $(this.selector)

  this.bind()
  this.processVisible()
}

proto.bind = function() {
  $(window).scroll(throttle(() => {
    this.processVisible()
  }, 250))
}

proto.processVisible = function() {
  if (this.processing) {
    return
  }
  
  this.processing = true
  
  this.$images.each((index, el) => {
    if (this.isVisible(el)) {
      this.loadImage(el)
    } 
  })
  
  this.processing = false
}

proto.isVisible = function(el) {
  var rect = el.getBoundingClientRect()
  var bottom = window.innerHeight || document.documentElement.clientHeight

  return rect.bottom + this.verticalBuffer >= 0
    && rect.top <= bottom + this.verticalBuffer
}

proto.loadImage = function(el) {
  var $el = $(el)
  
  if ($el.data('loading')) {
    return
  }
  
  $el.data('loading', true) 
  
  this.$images = this.$images.not($el)
  
  $el.attr('src', '')
  $el.attr('src', $el.data('src')).addClass('lazy-loading')
  imagesLoaded($el, function() {
    $el.removeClass('lazy-loading').addClass('lazy-loaded')
    this.callback($el)
  }.bind(this))
}

export default function(selector, buffer, callback) {
  return new LazyLoader(selector, buffer, callback)
}