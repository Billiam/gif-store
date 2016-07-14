import Clipboard from "clipboard"
import jQuery from "jquery"
import GifPause from "../../lib/gifpause"

export default {
  init() {
    this.initClipboard()
    this.initGifpause()
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
  
  initGifpause() {
    jQuery(document).ready(function() {
      GifPause.init(".animated", "grid-item-image")
    })
  }
}
