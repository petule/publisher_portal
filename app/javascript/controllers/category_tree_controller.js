import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["container"]
    static values = { group: String }

    connect() {
        this.initSortables(this.containerTarget, this.groupValue)
    }

    initSortables(container, groupName) {
        const options = {
            group: groupName,
            animation: 150,
            fallbackOnBody: true,
            swapThreshold: 0.65,
            onEnd: this.handleMove.bind(this)
        }

        container.querySelectorAll("ul[data-sortable-group-value]").forEach(ul => {
            if (ul.dataset.sortableGroupValue === groupName) {
                new window.Sortable(ul, options)
            }
        })
    }

    handleMove(evt) {
        const movedId = evt.item.dataset.id
        const newParentUl = evt.to.closest("ul[data-id]")
        const newParentId = newParentUl ? newParentUl.dataset.id : null

        fetch(`/admin/categories/${movedId}/move`, {
            method: "POST",
            headers: {
                "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ parent_id: newParentId })
        }).then(response => {
            if (!response.ok) alert("Přesun selhal.")
        })
    }
}
