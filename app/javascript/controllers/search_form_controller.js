import { Controller } from "@hotwired/stimulus"
// app/javascript/controllers/search_form_controller.js

export default class extends Controller {
    static targets = [ "input" ]

    handleKeyup(event) {
        console.log("Keyup detected!", event.key)
        this.submitForm()
    }

    submitForm() {
        this.element.requestSubmit()
    }
}
