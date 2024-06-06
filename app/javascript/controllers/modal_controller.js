import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {

  connect() {
  }

  ///



}

// const plusButton = document.getElementById("plus-button")
const modal = document.getElementById("modal")

// plusButton.addEventListener("click", function() {

//   modal.style.display = "block" ;

// })

// const closeButton = document.querySelector(".close")

// closeButton.addEventListener("click", function() {

//   modal.style.display = "none";

// })

window.addEventListener("click", function(event) {
  if ( event.target == modal ) {
    modal.style.display = "none";
  }

})
