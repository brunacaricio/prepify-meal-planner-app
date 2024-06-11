import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ["ingredients", "instructions", "ingredientsButton", "instructionsButton"]

  fire1() {
    this.instructionsTarget.classList.add("d-none");
    this.ingredientsTarget.classList.remove("d-none");
    this.ingredientsButtonTarget.classList.remove('showbutton')
    this.ingredientsButtonTarget.classList.add('showbutton-active')
    this.instructionsButtonTarget.classList.remove('showbutton-active')
    this.instructionsButtonTarget.classList.add('showbutton')
    }

  fire2() {
    this.ingredientsTarget.classList.add("d-none");
    this.instructionsTarget.classList.remove("d-none");
    this.ingredientsButtonTarget.classList.remove('showbutton-active')
    this.ingredientsButtonTarget.classList.add('showbutton')
    this.instructionsButtonTarget.classList.remove('showbutton')
    this.instructionsButtonTarget.classList.add('showbutton-active')
    }
}
