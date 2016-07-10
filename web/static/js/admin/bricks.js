// import "enquire.js"
import savvior from "savvior"

export default {
  init() {
    savvior.init(
      ".image-grid", 
      {
      "screen and (max-width: 500px": { columns: 1 },
      "screen and (min-width: 768px) and (max-width: 992px)": { columns: 2 },
      "screen and (min-width: 992px) and (max-width: 1200px)": { columns: 3 },
      "screen and (min-width: 1200px)": { columns: 4 }
    })
  }
}