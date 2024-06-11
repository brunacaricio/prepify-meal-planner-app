import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checked-list"
export default class extends Controller {
  // static targets = ["button"]
  bought(event) {
    this.element.submit(event)
  }

  // toggleChecked(event) {
  //   const itemId = event.target.dataset.itemId
  //   const bought = !event.target.querySelector("i").classList.contains("fa-solid")

  //   fetch(`/grocery_lists/checked`, {
  //     method: "PATCH",
  //     headers: { "Accept": "application/json" },
  //     body: JSON.stringify({ item_id: itemId, bought })
  //   })
  //   .then(response => response.json())
  //   .then(data => {

  //     event.target.querySelector("i").classList.toggle("fa-solid", bought)
  //     event.target.querySelector("i").classList.toggle("fa-regular", !bought)
  //   })
  //   .catch(error => console.error(error))
  // }
}
