document.addEventListener('DOMContentLoaded', () => {
  const errors = document.querySelectorAll("[class^=fform-js-error]")
  const blank_validations = document.querySelectorAll(".fform-js-blank-validation")
  const email_validations = document.querySelectorAll(".fform-js-numeric-validation")
  const fullwidthCharValidations = document.querySelectorAll(".fform-js-fullwidth-char-validation")
  const submit = document.querySelector(".fform-js-submit")
  let sendable = true

  for (const error of errors) {
    error.style.display = "none"
    // error.style.visibility = "hidden"
  }

  //blankのvalidation
  let blank_validator = () => {
    for (const elms of blank_validations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-blank")
      if (elms.value == "") {
        // error.style.visibility = "visible"
        error.style.display = "block"
        sendable = false
      } else {
        error.style.display = "none"
        // error.style.visibility = "hidden"
      }
    }
  }

  //numeric validation
  let validateNumeric = () => {
    for (const elms of email_validations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-numeric")
      if (!Number.isInteger(parseInt(elms.value))) {
        // error.style.visibility = "visible"
        error.style.display = "block"
        sendable = false
      } else {
        error.style.display = "none"
        // error.style.visibility = "hidden"
      }
    }
  }

  let validateFullwidthChar = () => {
    for (const elms of fullwidthCharValidations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-fullwidth-char")
      const regex = /^[a-zA-Z0-9!-/:-@¥[-`{-~\]]*$/
      if (!regex.test(elms.value)) {
        // error.style.visibility = "visible"
        error.style.display = "block"
        sendable = false
      } else {
        error.style.display = "none"
        // error.style.visibility = "hidden"
      }
    }
  }

  submit.addEventListener('click', (e) => {
    sendable = true
    blank_validator()
    validateNumeric()
    validateFullwidthChar()
    if (sendable != true) {
      e.preventDefault()
    }
  })

})
