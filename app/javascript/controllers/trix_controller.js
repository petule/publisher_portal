import { Controller } from "@hotwired/stimulus";
import "trix";


export default class extends Controller {
    connect() {
        console.log('trix controller connected');

    }
}
