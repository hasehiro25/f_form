document.addEventListener('DOMContentLoaded', () => {
  const errors = document.querySelectorAll("[class^=fform-js-error]")
  console.log(errors)
  const blank_validations = document.querySelectorAll(".fform-js-blank-validation")
  const email_validations = document.querySelectorAll(".fform-js-numeric-validation")
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

  submit.addEventListener('click', (e) => {
    // e.preventDefault()
    sendable = true
    blank_validator()
    validateNumeric()
    if (sendable != true) {
      e.preventDefault()
    }
  })

})
