import Clipboard from 'clipboard/dist/clipboard.min';
document.addEventListener('DOMContentLoaded', () => {
  new Clipboard('.clipboard-btn');

  const buttons = document.querySelectorAll('.clipboard-btn')
  for (let button of buttons) {
    button.addEventListener('click', function () {
      button.dataset.tooltip = "COPIED"
      setTimeout(() => {
        button.removeAttribute("data-tooltip")
      }, 2 * 1000)
    })
  }
})
