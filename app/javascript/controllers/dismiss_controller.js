import { Controller } from "@hotwired/stimulus"

export default class extends Controller {notification
    static targets = ["notification"]

    dismiss() {
        if (!this.hasNotificationTarget) return;

        this.notificationTarget.style.transition = "opacity 0.5s ease-out";
        this.notificationTarget.style.opacity = "0";

        setTimeout(() => {
            this.notificationTarget.remove();
        }, 500);
    }
}
