import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  setDueDate() {
    if (this.blankOptionSelected()) return
    Turbo.visit(`/customers/${this.element.value}/work_orders/new`)
  }

  blankOptionSelected = () => this.element.value === ''

}
