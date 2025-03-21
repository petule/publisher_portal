import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["frame"]

    remove() {
        if (!this.hasFrameTarget) return;

        this.frameTarget.style.transition = "opacity 0.5s ease-out";
        this.frameTarget.style.opacity = "0";

        setTimeout(() => {
            this.frameTarget.remove();
        }, 500);
    }
}
