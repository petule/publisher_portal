import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["container"]

    connect() {
        this.containerTarget.classList.add("active")
        document.addEventListener("keydown", this.handleKeyDown)

    }

    disconnect() {
        document.removeEventListener("keydown", this.handleKeyDown)
    }

    open(event) {
        event.preventDefault()
        this.containerTarget.classList.add("active")
    }

    close(event) {
        event.preventDefault()
        this.containerTarget.classList.remove("active")
    }

    handleKeyDown = (event) => {
        if (event.key === "Escape") {
            this.close(event)
        }
    }
}
