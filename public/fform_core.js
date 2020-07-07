document.addEventListener('DOMContentLoaded', () => {
  const errors = document.querySelectorAll(".fform-error")
  const blank_validations = document.querySelectorAll(".fform-js-blank-validation")
  const emailValidations = document.querySelectorAll(".fform-js-email-validation")
  const numericValidations = document.querySelectorAll(".fform-js-numeric-validation")
  const fullwidthCharValidations = document.querySelectorAll(".fform-js-fullwidth-char-validation")
  const recaptcha = document.querySelector('.g-recaptcha')
  const submit = document.querySelector(".fform-js-submit")
  let sendable = true

  for (const error of errors) {
    error.style.display = "none"
  }

  let validateBlank = () => {
    for (const elms of blank_validations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-blank")
      const status = elms.value != ""
      blockVisibility(status, error)
    }
  }

  let validateEmail = () => {
    for (const elms of emailValidations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-email")
      const regex = /^[a-zA-Z0-9.!#$%&’*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
      const status = regex.test(elms.value)
      blockVisibility(status, error)
    }
  }

  let validateNumeric = () => {
    for (const elms of numericValidations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-numeric")
      const status = Number.isInteger(parseInt(elms.value))
      blockVisibility(status, error)
    }
  }

  let validateFullwidthChar = () => {
    for (const elms of fullwidthCharValidations) {
      const parent = elms.closest("div")
      const error = parent.querySelector(".fform-js-error-fullwidth-char")
      const regex = /^[a-zA-Z0-9!-/:-@¥[-`{-~\]]*$/
      const status = regex.test(elms.value)
      blockVisibility(status, error)
    }
  }

  let blockVisibility = (status, elm) => {
    if (status) {
      elm.style.display = "none"
    } else {
      elm.style.display = "block"
      sendable = false
    }
  }

  let validateInputs = () => {
    validateBlank()
    validateNumeric()
    validateFullwidthChar()
    validateEmail()
  }

  let disableSubmit = () => {
    submit.disabled = true
  }
  if (recaptcha) { disableSubmit() }

  submit.addEventListener('click', (e) => {
    sendable = true
    validateInputs()
    if (sendable != true) {
      e.preventDefault()
    }
  })
})



function allowSubmit() {
  let submit = document.querySelector(".fform-js-submit")
  submit.disabled = false
}

function disableSubmit() {
  let submit = document.querySelector(".fform-js-submit")
  submit.disabled = true
}
