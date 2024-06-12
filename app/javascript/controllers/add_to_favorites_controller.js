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
        const Toast = Swal.mixin({
          toast: true,
          position: "top-end",
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
          title: "Recipe added to your favorites"
        });
      }
    })
  }
}
