import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["step"]

  connect() {
    this.showCurrentStep()
  }

  nextStep(event) {
    event.preventDefault()
    const currentStep = this.currentStep()
    const nextStep = currentStep + 1
    if (nextStep <= this.stepTargets.length) {
      this.setCurrentStep(nextStep)
      this.showCurrentStep()
    }
  }

  previousStep(event) {
    event.preventDefault()
    const currentStep = this.currentStep()
    const previousStep = currentStep - 1
    if (previousStep >= 1) {
      this.setCurrentStep(previousStep)
      this.showCurrentStep()
    }
  }

  showCurrentStep() {
    const currentStep = this.currentStep()
    this.stepTargets.forEach((element, index) => {
      element.classList.toggle("hidden", index !== currentStep - 1)
    })
  }

  currentStep() {
    console.log('step:', parseInt(this.data.get("currentStepValue")));
    return parseInt(this.data.get("currentStepValue"))
  }

  setCurrentStep(step) {
    this.data.set("currentStepValue", step)
  }
}
