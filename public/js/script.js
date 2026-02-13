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

    setInterval(nextSlide, 7000);

    // Dropdown menu toggle
    const dropdownLink = document.querySelector('.dropdown > a');
    const dropdownContent = document.querySelector('.dropdown-content');

    const navbar = document.querySelector('nav');

    dropdownLink.addEventListener('click', function(e) {
      e.preventDefault();
      const isOpen = dropdownContent.style.display === 'block';
      if (isOpen) {
        dropdownContent.style.display = 'none';
        navbar.classList.remove('dropdown-active');
      } else {
        dropdownContent.style.display = 'block';
        navbar.classList.add('dropdown-active');
      }
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', function(e) {
      if (!e.target.closest('.dropdown')) {
        dropdownContent.style.display = 'none';
        navbar.classList.remove('dropdown-active');
      }
    });