import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["frame"]

    static values = {
        autoRemove: Boolean
    }

    connect() {
        console.log(this.autoRemoveValue)
        if (this.autoRemoveValue) {
            console.log('remove....'+this.hasFrameTarget)
            this.remove();
        }
    }


    remove() {
        if (!this.hasFrameTarget) return;
        console.log('start')
        this.frameTarget.style.transition = "opacity 0.5s ease-out";
        this.frameTarget.style.opacity = "0";

        setTimeout(() => {
            this.frameTarget.remove();
        }, 500);
    }
}
