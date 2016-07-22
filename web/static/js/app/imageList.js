import Clipboard from "clipboard"
import jQuery from "jquery"
import GifPause from "../../lib/gifpause"
import LazyImages from "../../lib/lazyImages"

import Bricks from "./bricks.js"


export default {
  init() {
    this.initClipboard()
    this.initLazyImages()
    this.initBricks()
  },
  
  initLazyImages() {
    var lazyLoader = LazyImages('.lazy', 100, this.pauseGif)
    lazyLoader.init()

    jQuery(window).on('savvior:setup', () => {
      lazyLoader.processVisible()
    })
  },

  initClipboard() {
    var clipboard = new Clipboard(".thumb")
    
    clipboard.on('success', e => {
      jQuery(e.trigger).tooltip({ title: "Copied!" }).tooltip('show').on("hidden.bs.tooltip", function() {
        $(this).tooltip('destroy')
      })
      
      var $el = jQuery(e.trigger)
      var id = parseInt($el.data('id'))
      if (id) {
        jQuery.post(`api/v1/images/${id}/click`)
      }
    })
  },
  
  pauseGif($element) {
    GifPause.processImage($element.get(0), "grid-item-image")
  },
  
  initBricks() {
    Bricks.init()
  }
}
