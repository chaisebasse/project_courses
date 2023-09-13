import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="course-sections"
export default class extends Controller {
  static targets = ["sectionsList"];
  connect() {
    console.log("Yello")
  }

  toggleSections() {
    this.sectionsListTarget.classList.toggle("hidden");
  }
}
