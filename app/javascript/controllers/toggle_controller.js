import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ["ingredients", "instructions"]
  connect() {
  }

  fire1() {

    this.instructionsTarget.classList.add("d-none");
    this.ingredientsTarget.classList.remove("d-none");
    // this.instructionsTarget.classList.toggle("");
    }

  fire2() {

    this.ingredientsTarget.classList.add("d-none");
    this.instructionsTarget.classList.remove("d-none");

    // this.instructionsTarget.classList.toggle("");
    }
}
