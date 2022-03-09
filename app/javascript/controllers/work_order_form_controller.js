import { Controller } from "@hotwired/stimulus"
import { addDays, formatISO, parseISO } from "date-fns"

export default class extends Controller {

  async setDueDate() {
    if (this.blankElementSelected()) return
    const dueDateField = document.getElementById('work_order_due_date')
    this.prepareForAnimation(dueDateField)
    const customerId = this.element.value
    const customerTypeId = await fetch(`/customers/${customerId}.json`)
                                   .then(response => response.json())
                                   .then(data => data.customer_type_id)
    fetch(`/customer_types/${customerTypeId}.json`)
      .then(response => response.json())
      .then(data => {
        dueDateField.value = this.format(
          this.dueDate(this.inDate(), data.turn_around)
        )
        this.highlight(dueDateField)
      })
  }

  blankElementSelected = () => this.element.value === ''
  prepareForAnimation = (field) => field.classList.remove('highlight')
  inDate = () => document.getElementById('work_order_in_date').value
  dueDate = (start, turnAround) => addDays(parseISO(start), turnAround)
  format = (dueDate) => formatISO(dueDate, {representation: 'date'})
  highlight = (field) => field.classList.add('highlight')

}
