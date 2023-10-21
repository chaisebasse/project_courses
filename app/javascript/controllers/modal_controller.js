import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-sections"
export default class extends Controller {
  // static targets = ["sectionsList"];
  static targets = ["modal"];

  // , "modalContent"

  // connect() {
  //   this.modalTarget.style.display = "none"
  // }

  open(event) {
    const courseId = this.data.get("id")
    // Fetch course details or load content into the modal as needed
    // For simplicity, this example only shows/hides the modal
    this.modalTarget.style.display = "block"
    console.log('Hello');
  }

  close() {
    this.modalTarget.style.display = "none"
  }
}
