import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    this.element.value = '';
    flatpickr(this.element, {
      inline: false,
      mode: 'range',
      minDate: "today",
      enableTime: false,
      dateFormat: "d-m-Y",
      disableMobile: "true",
      defaultDate: null
    })
  }
}
