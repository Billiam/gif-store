import jQuery from "jquery"
window.jQuery = window.$ = jQuery
import "../../third-party/selectize/selectize"

export default {
  init() {
    $(function() {
      $('.tag-field').selectize({
        plugins: ['remove_button'],
        delimiter: " ",
        create(input) {
          return {
            tag: input,
            count: null
          }
        },
        minChars: 1,
        persist: false,
        createOnBlur: true,
        hideSelected: true,
        valueField: "tag",
        searchField: "tag",
        render: {
          item(data, escape) {
            return '<div class="item">' + escape(data["tag"]) + '</div>';
          },
          option(data, escape) {
            return '<div class="option"><span class="badge">' + escape(data["count"] || '') + '</span> ' + escape(data["tag"]) + '</div>';
          }
        },
        loadThrottle: 150,
        load(query, callback) {
          if (!query.length) return callback()
         
          $.ajax({
            url: '/api/v1/tags',
            data: {
              q: query
            },
            type: 'GET',
            error() {
              callback();
            },
            success(res) {
              callback(res.data);
            }
          });
        }
      })
    })
  }
}