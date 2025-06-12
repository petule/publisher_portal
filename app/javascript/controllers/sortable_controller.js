import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
    static targets = ["position", "parentId"]

    connect() {
        this.sortable = new Sortable(this.element, {
            group: 'nested-categories',
            animation: 150,
            fallbackOnBody: true,
            swapThreshold: 0.65,
            ghostClass: 'sortable-ghost',
            chosenClass: 'sortable-chosen',
            dragClass: 'sortable-drag',
            onEnd: (event) => this.onEnd(event)
        })
    }

    onEnd(event) {
        const item = event.item
        const newPosition = Array.from(event.to.children).indexOf(item)
        const categoryId = item.dataset.id

        console.log(`Moved category ${categoryId} to position ${newPosition}`)
        const form = document.getElementById('sortable-form')
        form.action = form.dataset.url.replace("id", categoryId)
        document.getElementById('position').value = newPosition
        form.requestSubmit()
    }
}
