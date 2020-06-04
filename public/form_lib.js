document.addEventListener('DOMContentLoaded', () => {
  const errors = document.querySelectorAll("[class^=fform-js-error]")
  const blank_validations = document.querySelectorAll(".fform-js-blank-validation")
  const emailValidations = document.querySelectorAll(".fform-js-email-validation")
  const numericValidations = document.querySelectorAll(".fform-js-numeric-validation")
  const fullwidthCharValidations = document.querySelectorAll(".fform-js-fullwidth-char-validation")
  const submit = document.querySelector(".fform-js-submit")
  let sendable = true

  for (const error of errors) {
    error.style.display = "none"
  }

  let validateBlank = () => {
    for (const elms of blank_validations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-blank")
      if (elms.value != "") {
        error.style.display = "none"
      } else {
        error.style.display = "block"
        sendable = false
      }
    }
  }

  let validateEmail = () => {
    for (const elms of emailValidations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-email")
      const regex = /^[a-zA-Z0-9.!#$%&’*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
      if (regex.test(elms.value)) {
        error.style.display = "none"
      } else {
        error.style.display = "block"
        sendable = false
      }
    }
  }

  let validateNumeric = () => {
    for (const elms of numericValidations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-numeric")
      if (Number.isInteger(parseInt(elms.value))) {
        error.style.display = "none"
      } else {
        error.style.display = "block"
        sendable = false
      }
    }
  }

  let validateFullwidthChar = () => {
    for (const elms of fullwidthCharValidations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-fullwidth-char")
      const regex = /^[a-zA-Z0-9!-/:-@¥[-`{-~\]]*$/
      if (regex.test(elms.value)) {
        error.style.display = "none"
      } else {
        error.style.display = "block"
        sendable = false
      }
    }
  }

  let validateInputs = () => {
    validateBlank()
    validateNumeric()
    validateFullwidthChar()
    validateEmail()
  }

  submit.addEventListener('click', (e) => {
    sendable = true
    validateInputs()
    if (sendable != true) {
      e.preventDefault()
    }
  })
})
