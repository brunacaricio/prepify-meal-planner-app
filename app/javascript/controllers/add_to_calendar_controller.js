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
        const Toast = Swal.mixin({
          toast: true,
          position: "top",
          showConfirmButton: false,
          timer: 1500,
          timerProgressBar: true,
          didOpen: (toast) => {
            toast.onmouseenter = Swal.stopTimer;
            toast.onmouseleave = Swal.resumeTimer;
          }
        });
        Toast.fire({
          icon: "success",
          title: "Recipe added to your calendar"
        });
      }
    })
  }
}
