document.addEventListener('DOMContentLoaded', () => {
  const burger = document.querySelector('.navbar-burger')
  const navbar = document.querySelector('.navbar-menu')
  burger.addEventListener('click', (e) => {
    navbar.classList.toggle('is-active');
  })
})
