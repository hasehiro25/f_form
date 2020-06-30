document.addEventListener('DOMContentLoaded', () => {
  const submit = document.querySelector("#sampleform_submit")
  if (!submit) { return }
  submit.addEventListener("click", (e) => {
    e.preventDefault()
  })
})
