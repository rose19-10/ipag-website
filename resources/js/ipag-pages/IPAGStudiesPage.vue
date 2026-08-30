<template>
    <div class="studies-root">

        <!-- Full-bleed dark intro -->
        <section class="studies-intro">
            <div class="studies-intro__text">
                <p class="studies-intro__label">The IPAG · Performance Education</p>
                <h1 class="studies-intro__title">IPAG<br><em>Studies</em></h1>
                <p class="studies-intro__sub">Praxis. Pedagogy. Production. Aesthetics. A program rooted in the living traditions of Mindanao — built for artists, educators, and the communities they serve.</p>
            </div>
            <div class="studies-intro__image">
                <img :src="'/images/ipag5.png'" alt="IPAG Studies">
            </div>
        </section>

        <!-- Four pillars — full bleed alternating -->
        <section class="studies-pillars">
            <div class="studies-pillars__head">
                <h2>Four Pillars</h2>
                <p>Everything IPAG Studies does flows from these four interlocking disciplines.</p>
            </div>
            <div class="studies-pillars__grid">
                <div v-for="pillar in pillars" :key="pillar.title" class="studies-pillar">
                    <span class="studies-pillar__num">{{ pillar.num }}</span>
                    <h3 class="studies-pillar__title">{{ pillar.title }}</h3>
                    <p class="studies-pillar__desc">{{ pillar.desc }}</p>
                </div>
            </div>
        </section>

        <!-- Programs — light band -->
        <section class="studies-programs">
            <div class="studies-programs__inner">
                <div class="studies-programs__head">
                    <span class="studies-label">Programs Offered</span>
                    <h2>What We Offer</h2>
                </div>
                <div class="studies-programs__list">
                    <div v-for="prog in programs" :key="prog.title" class="studies-prog">
                        <div class="studies-prog__bar"></div>
                        <h3 class="studies-prog__title">{{ prog.title }}</h3>
                        <p class="studies-prog__desc">{{ prog.desc }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Scholarship — dark quote band -->
        <section class="studies-scholarship">
            <div class="studies-scholarship__inner">
                <span class="studies-label studies-label--light">Scholarship &amp; Publication</span>
                <p class="studies-scholarship__text">The Guild's Artistic Director has published six books and numerous papers in national and international journals on Philippine dramaturgy, Transcreation, Distillation, and performance pedagogy. Featured in the <em>Harvard Asian Quarterly</em>, the <em>CCP Encyclopedia of the Arts</em>, and academic theses and dissertations worldwide.</p>
                <p class="studies-scholarship__text">IPAG Studies is an independent program of the Integrated Performing Arts Guild — growing from the Guild's nearly five decades of original performance practice, research, and community engagement across Mindanao and beyond.</p>
                <a class="tfm-btn tfm-btn--primary" href="/contact">Enroll or Inquire</a>
            </div>
        </section>

    </div>
</template>

<script setup>
const pillars = [
    { num: '01', title: 'Praxis', desc: 'Hands-on performance training grounded in IPAG\'s accumulated body of practice — physical, vocal, musical, and dramaturgical.' },
    { num: '02', title: 'Pedagogy', desc: 'A structured approach to teaching that integrates indigenous knowledge, folk traditions, and contemporary theatrical method.' },
    { num: '03', title: 'Production', desc: 'Learning through doing — students and trainees participate directly in the Guild\'s productions, road shows, and workshop performances.' },
    { num: '04', title: 'Aesthetics', desc: 'Critical study of Philippine performance aesthetics, with particular focus on Mindanao cultural forms, oral literature, and the visual and sonic languages of the South.' },
];

const programs = [
    { title: 'Performance Workshops', desc: 'Intensive short-term workshops in Philippine theater, dance, movement, and music — available for schools, universities, and cultural organizations.' },
    { title: 'Performance Courses', desc: 'Structured courses in dramaturgy, choreography, performance theory, and cultural studies, taught by IPAG faculty and visiting scholars.' },
    { title: 'Artist Training', desc: 'Multi-year developmental program for young performing artists, combining rigorous technical training with IPAG\'s repertoire and production work.' },
    { title: 'Outreach Programs', desc: 'Road show educational packages bringing live performance, demonstration, and participatory workshops to schools and communities across Mindanao and beyond.' },
    { title: 'International Exchange', desc: 'Opportunities for artists and scholars to participate in international festivals, residencies, and exchange programs through IPAG\'s global network.' },
];
</script>
