import "jquery"
import "bootstrap/dist/js/bootstrap"

import Form from "./app/form.js"
import ImageList from "./app/imageList.js"
import Confirmable from "./app/confirmable.js"

(function() {
  ImageList.init()
  Form.init()
  Confirmable.init()
})()