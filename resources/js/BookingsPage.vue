<template>
    <div class="bk-root">

        <header class="bk-hero">
            <div class="bk-hero__inner">
                <p class="bk-kicker">IPAG — Integrated Performing Arts Guild · Philippines</p>
                <span class="bk-rule"></span>
                <h1 class="bk-hero__title">Bookings</h1>
                <p class="bk-hero__sub">Bring IPAG to your venue — productions, road shows, workshops, and packaged performances available for local and international engagements.</p>
            </div>
        </header>

        <div class="bk-body">

            <!-- Intro -->
            <section class="bk-intro">
                <p>IPAG offers fully-produced touring productions with complete cast, crew, costumes, props, sets, and live music. Below is an overview of what the Guild provides and what a presenting venue or producer is expected to arrange.</p>
            </section>

            <!-- Responsibilities table -->
            <section class="bk-section">
                <div class="bk-section-head">
                    <span class="bk-section-head__num">01</span>
                    <h2>Production Responsibilities</h2>
                    <span class="bk-section-head__line"></span>
                </div>
                <div class="bk-resp-grid">
                    <div class="bk-resp-col bk-resp-col--ipag">
                        <h3 class="bk-resp-col__heading">IPAG Provides</h3>
                        <ul class="bk-resp-list">
                            <li v-for="item in ipagProvides" :key="item" class="bk-resp-list__item">{{ item }}</li>
                        </ul>
                    </div>
                    <div class="bk-resp-col bk-resp-col--producer">
                        <h3 class="bk-resp-col__heading">Producer / Venue Arranges</h3>
                        <ul class="bk-resp-list">
                            <li v-for="item in producerProvides" :key="item" class="bk-resp-list__item">{{ item }}</li>
                        </ul>
                    </div>
                </div>
            </section>

            <!-- Booking categories -->
            <section class="bk-section">
                <div class="bk-section-head">
                    <span class="bk-section-head__num">02</span>
                    <h2>Available Engagements</h2>
                    <span class="bk-section-head__line"></span>
                </div>
                <div class="bk-engage-grid">
                    <div v-for="eng in engagements" :key="eng.title" class="bk-engage-card">
                        <span class="bk-engage-card__icon">{{ eng.icon }}</span>
                        <h3 class="bk-engage-card__title">{{ eng.title }}</h3>
                        <p class="bk-engage-card__desc">{{ eng.desc }}</p>
                    </div>
                </div>
            </section>

            <!-- Contact to book -->
            <section class="bk-section">
                <div class="bk-section-head">
                    <span class="bk-section-head__num">03</span>
                    <h2>Get in Touch</h2>
                    <span class="bk-section-head__line"></span>
                </div>
                <div class="bk-contacts">
                    <div class="bk-contact-card">
                        <span class="bk-contact-card__type">International Bookings</span>
                        <h3 class="bk-contact-card__name">Stanley Perry C. Fernandez</h3>
                        <a class="bk-contact-card__link" href="tel:+639770314669">(+63) 977 031 4669</a>
                        <a class="bk-contact-card__link" href="tel:+639214146179">(+63) 921 414 6179</a>
                        <a class="bk-contact-card__link" href="mailto:fernandezstanleyperry@gmail.com">fernandezstanleyperry@gmail.com</a>
                    </div>
                    <div class="bk-contact-card">
                        <span class="bk-contact-card__type">Local Bookings</span>
                        <h3 class="bk-contact-card__name">Arlem M. Abanes</h3>
                        <a class="bk-contact-card__link" href="tel:+639171362275">(+63) 917 136 2275</a>
                        <a class="bk-contact-card__link" href="tel:2295178">229-5178</a>
                        <a class="bk-contact-card__link" href="mailto:ipagarts@gmail.com">ipagarts@gmail.com</a>
                    </div>
                </div>
            </section>

        </div>

        <div class="bk-cta">
            <div class="bk-cta__text">
                <p class="bk-cta__eyebrow">Ready to book?</p>
                <h2>Plan a performance<br>with <span>IPAG</span></h2>
                <p>Send your event details — venue, dates, and type of engagement — and we'll get back to you with a full proposal.</p>
            </div>
            <div class="bk-cta__actions">
                <a class="tfm-btn tfm-btn--primary" href="mailto:ipagarts@gmail.com?subject=Booking%20Inquiry">Email Us Now</a>
                <a class="tfm-btn tfm-btn--ghost" href="/contact">Contact Page</a>
            </div>
        </div>

    </div>
</template>

<script setup>
const ipagProvides = [
    'Full production — cast and staff',
    'Costumes and properties',
    'Sets and scenic elements',
    'Music instruments and live musicians',
    'Set-up and run-through schedules',
    'Packaged fee structure (template provided)',
    'Production administrative and operating costs',
    'Insurance coverage',
    'Poster samples and playbill materials',
];

const producerProvides = [
    'Round-trip transport for cast, crew, and cargo from Iligan to venue',
    'In-city and inter-city transport (theater to hotel/dorm)',
    'Accommodations for cast and crew during travel',
    'Meals during travel period',
    'Theater with lights and sound facilities',
    'Front-of-house managers, ushers, and assistants',
    'Marketing, promotions, and audience mobilization',
    'Ticket printing and sales protocols',
    'Tax arrangements',
];

const engagements = [
    { icon: '🎭', title: 'Full Production', desc: 'A complete staging of an IPAG repertoire production — Tales from Mindanao, SITA, Sarimanok, and others — with full cast, live music, and production design.' },
    { icon: '🚌', title: 'Road Show', desc: 'A touring format designed for universities, schools, cultural centers, and community venues across the Philippines.' },
    { icon: '🌏', title: 'International Tour', desc: 'IPAG is available for international festivals, cultural expos, and Philippine representation at overseas events.' },
    { icon: '📚', title: 'Workshop', desc: 'Performance workshops in Philippine theater, dance, and music led by IPAG artists and faculty.' },
    { icon: '🎪', title: 'Gala / Special Event', desc: 'A curated selection of IPAG performances for gala evenings, anniversaries, and institutional celebrations.' },
];
</script>
