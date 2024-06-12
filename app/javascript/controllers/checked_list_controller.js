import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  bought(event) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    console.log(this.element.action)
    fetch((this.element.action),{
      method: "PATCH",
      headers: { "Accept": "text/plain","X-CSRF-Token": csrfToken },
      body: new FormData(this.element)
    })
    .then(response => response.text())
    .then((data) => {
      this.element.outerHTML = data
    })
  }
}
