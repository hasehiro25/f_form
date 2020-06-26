document.addEventListener('DOMContentLoaded', () => {
  const tabs = document.querySelectorAll('.js-tabs li')
  const contents = document.querySelectorAll('.tabs-content [data-tab-id]')
  for (let tab of tabs) {
    tab.addEventListener('click', (e) => {
      tabs.forEach((elm) => {
        elm.classList.remove('is-active')
      })
      contents.forEach((elm) => {
        elm.classList.remove('is-active')
      })
      tab.classList.add('is-active')
      const tabId = tab.dataset.tabId
      const content = document.querySelector(`.tabs-content__item[data-tab-id=${tabId}]`)
      content.classList.add('is-active')
    })
  }
})
