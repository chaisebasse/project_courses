import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-sections"
export default class extends Controller {
  // static targets = ["sectionsList"];
  static targets = ["modal"];

  open(event) {
    const courseId = this.data.get("id")
    // Fetch course details or load content into the modal as needed
    // For simplicity, this example only shows/hides the modal
    this.modalTarget.classList.toggle("hidden");
    console.log('Hello');
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }
}
