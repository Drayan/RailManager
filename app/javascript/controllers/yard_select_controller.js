import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    selected() {
        this.element.parentElement.parentElement.requestSubmit();
    }
}
