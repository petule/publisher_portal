import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["content", "icon"]

    toggle() {
        const content = this.contentTarget
        const icon = this.iconTarget

        if (content.classList.contains("max-h-0")) {
            content.classList.remove("max-h-0", "opacity-0")
            content.classList.add("max-h-[1000px]", "opacity-100")
            icon.classList.remove("mdi-plus")
            icon.classList.add("mdi-minus")
        } else {
            content.classList.remove("max-h-[1000px]", "opacity-100")
            content.classList.add("max-h-0", "opacity-0")
            icon.classList.remove("mdi-minus")
            icon.classList.add("mdi-plus")
        }
    }
}
