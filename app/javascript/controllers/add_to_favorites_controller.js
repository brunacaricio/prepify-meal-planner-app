import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["form", "button"]
  connect() {
  }
  send(event){
    event.preventDefault()
    fetch(this.formTarget.action,{
      method: "POST",
      headers: {
        "Accept": "application/json"
      }, body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      this.formTarget.outerHTML = data.form
      if (data.success){
        Swal.fire({
          title: 'Success',
          text: 'Recipe succesfully added to your favorites ;)',
          icon: 'success'
        });
      }
    })
  }
}
