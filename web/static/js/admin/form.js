import jQuery from "jquery"
window.jQuery = window.$ = jQuery

import sel from "select2"

export default {
  init() {
    $(function() {
      $('.tag-field').select2({
        tags: true,
        tokenSeparators: [",", " "]
      })
    })
  }
}