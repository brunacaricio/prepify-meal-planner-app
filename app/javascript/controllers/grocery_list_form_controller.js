import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDate"];

  connect() {
  }

  validate(event) {
    if (!this.startDateTarget.value) {
      event.preventDefault();
      this.startDateTarget.classList.remove('is-valid')
      const Toast = Swal.mixin({
        toast: true,
        position: "top",
        showConfirmButton: false,
        timer: 1250,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.onmouseenter = Swal.stopTimer;
          toast.onmouseleave = Swal.resumeTimer;
        }
      });
      Toast.fire({
        icon: "error",
        title: "Please select a date before submitting.."
      });
    }

  }
}
