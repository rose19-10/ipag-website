<template>
    <main class="tab-content active">

        <!-- Hero poster -->
        <section class="hero">
            <img
                class="hero-poster"
                :src="c.hero_poster_image || '/images/49th-Theater-Season.png'"
                :alt="c.hero_poster_alt || 'IPAG 49th Theater Season poster'"
            >
        </section>

        <!-- Intro -->
        <section class="home-intro">
            <div>
                <p class="section-kicker">{{ c.intro_kicker || 'The IPAG' }}</p>
                <h2>{{ c.intro_title || 'Stories from the South. Shared with the world.' }}</h2>
            </div>
            <p>{{ c.intro_body }}</p>
        </section>

        <!-- Season panel -->
        <section class="season-panel">
            <div class="section-heading">
                <p class="section-kicker">{{ c.season_kicker || 'August 2026 – May 2027' }}</p>
                <h2>{{ c.season_title || '49th Season: On the road to Gold' }}</h2>
                <p>{{ c.season_body }}</p>
            </div>
            <div v-if="productionsLoading" class="season-loading">Loading productions…</div>
            <div v-else class="season-grid">
                <a
                    v-for="production in seasonProductions"
                    :key="production.id"
                    class="season-item"
                    :href="production.path"
                >
                    <img :src="production.image" :alt="production.title">
                    <span>{{ production.title }}</span>
                </a>
            </div>
        </section>

        <!-- Story columns -->
        <section class="home-columns">
            <article class="home-story">
                <p class="section-kicker">{{ c.story1_kicker || 'Performance and practice' }}</p>
                <h2>{{ c.story1_heading || 'Hagup sa Kasinatian' }}</h2>
                <p>{{ c.story1_para1 }}</p>
                <p v-if="c.story1_para2">{{ c.story1_para2 }}</p>
            </article>
            <article class="home-story home-story-dark">
                <p class="section-kicker">{{ c.story2_kicker || 'Recognition' }}</p>
                <h2>{{ c.story2_heading || 'A company built beyond the center' }}</h2>
                <p>{{ c.story2_para1 }}</p>
            </article>
        </section>

        <!-- About us slideshow -->
        <section class="feature">
            <div class="feature-header"><h3>{{ c.about_heading || 'About us' }}</h3></div>
            <div class="slideshow-container">
                <button class="nav-button prev-button" aria-label="Previous slide" @click="changeSlide(-1)">&#10094;</button>
                <button class="nav-button next-button" aria-label="Next slide" @click="changeSlide(1)">&#10095;</button>

                <!-- Use Supabase-stored slides if available, fall back to local images -->
                <div
                    v-for="(image, index) in activeSlides"
                    :key="image"
                    class="slide"
                    :class="{ active: currentSlide === index }"
                >
                    <img :src="image" :alt="`About IPAG slide ${index + 1}`">
                </div>
            </div>

            <!-- About us text overlay -->
            <div v-if="c.about_para1 || c.about_para2" class="feature-text">
                <p v-if="c.about_para1">{{ c.about_para1 }}</p>
                <p v-if="c.about_para2">{{ c.about_para2 }}</p>
                <div v-if="c.about_stat1_num || c.about_stat2_num" class="feature-stats">
                    <div v-if="c.about_stat1_num" class="feature-stat">
                        <span class="feature-stat__num">{{ c.about_stat1_num }}</span>
                        <span class="feature-stat__label">{{ c.about_stat1_label }}</span>
                    </div>
                    <div v-if="c.about_stat2_num" class="feature-stat">
                        <span class="feature-stat__num">{{ c.about_stat2_num }}</span>
                        <span class="feature-stat__label">{{ c.about_stat2_label }}</span>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact band -->
        <section class="contact-band">
            <div>
                <p class="section-kicker">{{ c.contact_kicker || 'Bring IPAG to your venue' }}</p>
                <h2>{{ c.contact_heading || 'Plan a performance, road show, or workshop.' }}</h2>
            </div>
            <div>
                <p>{{ c.contact_address || 'IPAG Center, Ramiro St., Ilaya, Poblacion, Iligan City' }}</p>
                <p>
                    <a :href="`mailto:${c.contact_email || 'ipagarts@gmail.com'}`">
                        {{ c.contact_email || 'ipagarts@gmail.com' }}
                    </a>
                    · {{ c.contact_phone || '(+63) 917 136 2275' }}
                </p>
                <a class="home-button" href="/bookings">Booking information</a>
            </div>
        </section>

    </main>
</template>

<script setup>
import { computed, onBeforeUnmount, onMounted, reactive, ref } from 'vue';
import { supabase } from './supabase';
import { useTable } from './useTable';

// ── Page content ─────────────────────────────────────────
const c = reactive({
    hero_poster_image:  '/images/49th-Theater-Season.png',
    hero_poster_alt:    'IPAG 49th Theater Season poster',
    intro_kicker:       'The IPAG',
    intro_title:        'Stories from the South. Shared with the world.',
    intro_body:         '',
    season_kicker:      'August 2026 – May 2027',
    season_title:       '49th Season: On the road to Gold',
    season_body:        '',
    season_count:       '4',
    story1_kicker:      'Performance and practice',
    story1_heading:     'Hagup sa Kasinatian',
    story1_para1:       '',
    story1_para2:       '',
    story2_kicker:      'Recognition',
    story2_heading:     'A company built beyond the center',
    story2_para1:       '',
    about_heading:      'About us',
    about_para1:        '',
    about_para2:        '',
    about_stat1_num:    '',
    about_stat1_label:  '',
    about_stat2_num:    '',
    about_stat2_label:  '',
    contact_kicker:     'Bring IPAG to your venue',
    contact_heading:    'Plan a performance, road show, or workshop.',
    contact_address:    'IPAG Center, Ramiro St., Ilaya, Poblacion, Iligan City',
    contact_email:      'ipagarts@gmail.com',
    contact_phone:      '(+63) 917 136 2275',
});

// Slideshow images from Supabase; falls back to local ipag1–6.png
const storedSlides = ref([]);
const fallbackSlides = [1, 2, 3, 4, 5, 6].map(n => `/images/ipag${n}.png`);
const activeSlides = computed(() => storedSlides.value.length ? storedSlides.value : fallbackSlides);

async function loadContent() {
    const { data } = await supabase
        .from('page_content')
        .select('key, value')
        .eq('page', 'home');

    if (data) {
        data.forEach(row => {
            if (row.key === 'about_slides') {
                try { storedSlides.value = JSON.parse(row.value) || []; } catch { /* keep fallback */ }
            } else if (row.key in c) {
                c[row.key] = row.value;
            }
        });
    }
}

// ── Productions ──────────────────────────────────────────
const { rows: allProductions, loading: productionsLoading } = useTable('productions', { orderBy: 'sort_order' });
const seasonProductions = computed(() => allProductions.value.slice(0, Number(c.season_count) || 4));

// ── Slideshow ────────────────────────────────────────────
const currentSlide = ref(0);
let slideTimer;

function changeSlide(direction) {
    const len = activeSlides.value.length;
    if (!len) return;
    currentSlide.value = (currentSlide.value + direction + len) % len;
}

// Reset index when slides list changes (e.g. after content loads)
let prevLen = 0;
const unwatchSlides = computed(() => {
    const len = activeSlides.value.length;
    if (len !== prevLen) { currentSlide.value = 0; prevLen = len; }
});

onMounted(() => {
    loadContent();
    slideTimer = window.setInterval(() => changeSlide(1), 3000);
});
onBeforeUnmount(() => window.clearInterval(slideTimer));
</script>
