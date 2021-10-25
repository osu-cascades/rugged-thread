import {Controller} from "stimulus"

export default class extends Controller {
  static targets = ["fields"]

  hide(e){
    e.target.closest("[data-target='fields-for.fields']").style = "display: none;"
  }

  add(e){
    e.preventDefault()
    console.log("TARGET", e.target)
    console.log("FIELDS", e.target.dataset.fields)

    e.target.insertAdjacentHTML('beforebegin', e.target.dataset.fields.replace(/new_field/g, new Date().getTime()))
  }
}