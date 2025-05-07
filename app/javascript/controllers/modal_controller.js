// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "confirmButton", "question", "questionText"]

    open(event) {
        event.preventDefault()
        const modalId = event.currentTarget.dataset.target
        const destroyUrl = event.currentTarget.dataset.destroyUrl
        const questionText = event.currentTarget.dataset.questionText

        const modal = document.getElementById(modalId)

        if (modal) {
            modal.classList.add("active")
            document.documentElement.classList.add('clipped');
            const confirmButton = modal.querySelector("[data-modal-target='confirmButton']")
            if (confirmButton && destroyUrl) {
                confirmButton.setAttribute("href", destroyUrl)
                confirmButton.setAttribute("data-turbo-method", "delete")
            }

            const question = modal.querySelector("[data-modal-target='question']")
            if (question && questionText) {
                question.textContent = questionText
            }
        }
    }

    confirm(event) {
        const modal = event.target.closest('.modal')
        const confirmButton = modal.querySelector("[data-modal-target='confirmButton']")
        confirmButton.click()
        this.close(event)
    }

    close(event) {
        event.preventDefault()
        const modal = event.target.closest(".modal")
        if (modal) {
            modal.classList.remove("active")
        }
    }
}
