import savvior from "savvior"
import jQuery from "jquery"

export default {
  init() {
    jQuery(function() {
      savvior.init(
        ".image-grid",
        {
          "screen and (max-width: 500px": { columns: 1 },
          "screen and (min-width: 500px) and (max-width: 992px)": { columns: 2 },
          "screen and (min-width: 992px) and (max-width: 1200px)": { columns: 3 },
          "screen and (min-width: 1200px)": { columns: 4 }
        }
      )
    })
  }
}