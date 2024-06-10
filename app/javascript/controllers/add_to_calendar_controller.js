import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["form","input"]
  connect() {
  }
  send(event) {
    event.preventDefault()
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

    fetch(this.formTarget.action,{
      method: "POST",
      headers: {
        "Accept":"application/json",
        "X-CSRF-Token": csrfToken
      },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data)=>{
      this.formTarget.outerHTML = data.form

      if (data.success){
        Swal.fire({
          title: 'Success',
          text: 'Recipe Succesfully added to your planned meals ;)',
          icon: 'success'
        });
      }




    })
  }
}
