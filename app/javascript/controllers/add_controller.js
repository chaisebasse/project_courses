import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-section-and-video"
export default class extends Controller {
  static targets = [ "addElement" ];

  addSection(event) {
    event.preventDefault();
    const newSection = this.sectionTemplateTarget.innerHTML;
    this.sectionsTarget.insertAdjacentHTML("beforeend", newSection);
  }
}
