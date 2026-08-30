/* ─────────────────────────────────────────
   GENERAL SLIDESHOW
───────────────────────────────────────── */
let slideIndex = 0;
const slides = document.querySelectorAll('.slide');

function showSlide(index) {
  slides.forEach(slide => slide.classList.remove('active'));
  slides[index].classList.add('active');
}

function changeSlide(direction) {
  slideIndex = (slideIndex + direction + slides.length) % slides.length;
  showSlide(slideIndex);
}

function nextSlide() {
  changeSlide(1);
}

if (slides.length > 0) {
  setInterval(nextSlide, 3000);
}


/* ─────────────────────────────────────────
   DROPDOWN MENU
───────────────────────────────────────── */
const dropdownLink    = document.querySelector('.dropdown > a');
const dropdownContent = document.querySelector('.dropdown-content');
const navbar          = document.querySelector('nav');

if (dropdownLink && dropdownContent) {
  dropdownLink.addEventListener('click', function (e) {
    e.preventDefault();
    const isOpen = dropdownContent.style.display === 'block';
    dropdownContent.style.display = isOpen ? 'none' : 'block';
    navbar.classList.toggle('dropdown-active', !isOpen);
  });

  document.addEventListener('click', function (e) {
    if (!e.target.closest('.dropdown')) {
      dropdownContent.style.display = 'none';
      navbar.classList.remove('dropdown-active');
    }
  });
}


/* ─────────────────────────────────────────
   TAB NAVIGATION
───────────────────────────────────────── */
const tabLinks    = document.querySelectorAll('.tab-link');
const tabContents = document.querySelectorAll('.tab-content');

tabLinks.forEach(link => {
  link.addEventListener('click', function (e) {
    e.preventDefault();

    const target = link.getAttribute('data-tab');

    tabLinks.forEach(l => l.classList.remove('active'));
    link.classList.add('active');

    tabContents.forEach(content => content.classList.remove('active'));
    const targetSection = document.getElementById(target);
    if (targetSection) targetSection.classList.add('active');

    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
});


/* ─────────────────────────────────────────
   TFM SLIDESHOW
───────────────────────────────────────── */
document.querySelectorAll('[data-tfm-slideshow]').forEach(root => {
  const tfmSlides = [...root.querySelectorAll('.tfm-slide')];
  const dotsWrap  = root.querySelector('[data-dots]');
  const interval  = parseInt(root.dataset.interval, 10) || 6000;
  let current = 0;
  let timer;

  // Build dots dynamically
  tfmSlides.forEach((_, i) => {
    const dot = document.createElement('button');
    dot.className  = 'tfm-dot' + (i === 0 ? ' is-active' : '');
    dot.setAttribute('aria-label', `Go to slide ${i + 1}`);
    dot.addEventListener('click', () => goTo(i));
    dotsWrap.appendChild(dot);
  });

  function getDots() {
    return [...dotsWrap.querySelectorAll('.tfm-dot')];
  }

  function goTo(n) {
    tfmSlides[current].classList.remove('is-active');
    getDots()[current].classList.remove('is-active');
    current = (n + tfmSlides.length) % tfmSlides.length;
    tfmSlides[current].classList.add('is-active');
    getDots()[current].classList.add('is-active');
    restart();
  }

  function restart() {
    clearInterval(timer);
    timer = setInterval(() => goTo(current + 1), interval);
  }

  root.querySelector('[data-prev]').addEventListener('click', () => goTo(current - 1));
  root.querySelector('[data-next]').addEventListener('click', () => goTo(current + 1));
  restart();
});


/* ─────────────────────────────────────────
   SCROLL REVEAL
───────────────────────────────────────── */
const revealObserver = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('is-visible');
      revealObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('[data-reveal]').forEach(el => revealObserver.observe(el));