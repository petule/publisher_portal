import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "filename"]

    connect() {
        this.updateFilename()
    }

    updateFilename() {
        const files = this.inputTarget.files
        if (files.length > 0) {
            this.filenameTarget.textContent = files[0].name
        } else {
            this.filenameTarget.textContent = ""
        }
    }
}
