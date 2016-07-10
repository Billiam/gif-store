import jQuery from "jquery"
window.jQuery = window.$ = jQuery
import "../../third-party/selectize/selectize"
console.log('jquery:', $)

export default {
  init() {
    $(function() {
      $('.tag-field').selectize({
        plugins: ['remove_button'],
        delimiter: " ",
        persist: false,
        create(input) {
          return {
            value: input,
            text: input
          }
        }
      })
    })
  }
}