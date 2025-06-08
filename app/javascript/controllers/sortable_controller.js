import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
    static targets = ['position', 'parentId']
    connect() {
       this.sortable = new Sortable(this.element, {
           animation: 150,
           fallbackOnBody: true,
           swapThreshold: 0.65,
           ghostClass: 'sortable-ghost',
           chosenClass: 'sortable-chosen',
           dragClass: 'sortable-drag',
           onEnd: (event) => this.onEnd(event, this.element)
      })
    }

    onEnd(event, container) {
        /*const item = event.item
        const position = Array.from(container.children).indexOf(item)
        const categoryId = item.dataset.id
        const parentId = container.dataset.parentId || null
        const url = this.urlTemplateValue.replace("id", categoryId)

        const form = document.getElementById('sortable-form')
        form.action = url
        this.positionTarget.value = position
        this.parentIdTarget.value = parentId
        form.requestSubmit()*/
        console.log('onEnd')
    }
}
