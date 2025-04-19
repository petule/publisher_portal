import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    connect() {
        new SlimSelect({
            select: this.element,
        })
    }
}
