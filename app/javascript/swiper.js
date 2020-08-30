function spotlightSwiper() {
  var mySwiper = new Swiper('.swiper-container', {
    
  direction: 'horizontal',
  loop: true,

  pagination: {
    el: '.swiper-pagination-spotlight',
    clickable: true,
  },

  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  autoplay: {
    delay: 5000,
    disableOnInteraction: false,
  },
  
})
}
window.onload = spotlightSwiper;