import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ["ingredients", "instructions"]
  connect() {
  }

  fire() {

    this.ingredientsTarget.classList.toggle("d-none");
    this.instructionsTarget.classList.toggle("");
    }
}
