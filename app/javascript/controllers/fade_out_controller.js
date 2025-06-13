import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["frame", "link"]

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
        this.frameTarget.style.transition = "opacity 0.5s ease-out";
        this.frameTarget.style.opacity = "0";

        setTimeout(() => {
            if (this.hasLinkTarget) {
                this.linkTarget.click();
            }
            this.frameTarget.remove();
        }, 500);
    }
}
