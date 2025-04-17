import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["frame"]

    connect() {
        this.remove();
    }


    remove() {
        const frame = document.querySelector("[data-auto-fade-out-target='frame']")
        if (!frame) return;
        /*console.log('start')
        frame.style.transition = "opacity 0.5s ease-out";
        frame.style.opacity = "0";

        setTimeout(() => {
            frame.remove();
        }, 0);*/
        frame.remove();
    }
}
