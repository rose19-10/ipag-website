<template>
    <div class="tfm-root production-page">

        <div v-if="loading" class="tfm-loading-state">
            <p>Loading…</p>
        </div>

        <div v-else-if="fetchError" style="padding:2rem;color:red;font-family:monospace;">
            Error: {{ fetchError }}
        </div>

        <template v-else-if="production">
            <header class="tfm-hero" :style="{ backgroundImage: `url('${production.image}')` }">
                <div class="tfm-hero__inner">
                    <p class="tfm-hero__kicker">IPAG — Integrated Performing Arts Guild · Philippines</p>
                    <span class="tfm-hero__rule"></span>
                    <h1 class="tfm-hero__title">{{ production.title }}</h1>
                    <p class="tfm-hero__subtitle">{{ production.description }}</p>
                    <div class="tfm-hero__actions">
                        <a href="#gallery" class="tfm-btn tfm-btn--primary">View Gallery</a>
                        <a href="/bookings" class="tfm-btn tfm-btn--ghost">Book a Performance</a>
                    </div>
                </div>
            </header>

            <div class="tfm-strip">
                <div v-for="fact in production.facts" :key="fact.label" class="tfm-strip__item">
                    <span class="tfm-strip__label">{{ fact.label }}</span>
                    <span class="tfm-strip__value">{{ fact.value }}</span>
                </div>
            </div>

            <main class="tfm-main">
                <!-- Highlight: first video or fallback image -->
                <section class="tfm-highlight" data-reveal>
                    <div v-if="highlightVideo" class="tfm-highlight__embed">
                        <iframe
                            :src="`https://www.youtube.com/embed/${highlightVideo.id}`"
                            :title="highlightVideo.title"
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                            allowfullscreen
                            loading="lazy"
                        ></iframe>
                    </div>
                    <div v-else class="tfm-highlight__image">
                        <img :src="production.image" :alt="production.title">
                    </div>
                    <div v-if="highlightVideo" class="tfm-highlight__caption">
                        <span class="tfm-highlight__label">{{ highlightVideo.title }}</span>
                    </div>
                </section>

                <section aria-labelledby="about-title" data-reveal>
                    <div class="tfm-section-head">
                        <span class="tfm-section-head__num">01</span>
                        <h2 id="about-title">About the Production</h2>
                        <span class="tfm-section-head__line"></span>
                    </div>
                    <p class="tfm-lead">{{ production.about }}</p>
                </section>

                <section v-if="production.history" aria-labelledby="history-title" data-reveal>
                    <div class="tfm-section-head">
                        <span class="tfm-section-head__num">02</span>
                        <h2 id="history-title">Story and History</h2>
                        <span class="tfm-section-head__line"></span>
                    </div>
                    <p class="tfm-lead">{{ production.history }}</p>
                </section>

                <section v-if="production.credits && production.credits.length" aria-labelledby="credits-title" data-reveal>
                    <div class="tfm-section-head">
                        <span class="tfm-section-head__num">03</span>
                        <h2 id="credits-title">Creative Team</h2>
                        <span class="tfm-section-head__line"></span>
                    </div>
                    <div class="tfm-credits-grid">
                        <div v-for="credit in production.credits" :key="credit.role" class="tfm-credit">
                            <span class="tfm-credit__role">{{ credit.role }}</span>
                            <span class="tfm-credit__name">{{ credit.name }}</span>
                        </div>
                    </div>
                </section>

                <section id="gallery" aria-labelledby="gallery-title" data-reveal>
                    <div class="tfm-section-head">
                        <span class="tfm-section-head__num">04</span>
                        <h2 id="gallery-title">Gallery</h2>
                        <span class="tfm-section-head__line"></span>
                    </div>
                    <div v-if="production.gallery && production.gallery.length" class="tfm-gallery__slideshow">
                        <button class="tfm-slide-btn tfm-slide-btn--left" type="button" aria-label="Previous image" @click="changeGallery(-1)">&#8249;</button>
                        <img
                            v-for="(image, index) in production.gallery"
                            :key="image"
                            class="tfm-slide"
                            :class="{ 'is-active': galleryIndex === index }"
                            :src="image"
                            :alt="`${production.title} production photo ${index + 1}`"
                        >
                        <button class="tfm-slide-btn tfm-slide-btn--right" type="button" aria-label="Next image" @click="changeGallery(1)">&#8250;</button>
                        <div class="tfm-dots">
                            <button
                                v-for="(_, index) in production.gallery"
                                :key="index"
                                class="tfm-dot"
                                :class="{ 'is-active': galleryIndex === index }"
                                :aria-label="`Go to slide ${index + 1}`"
                                @click="galleryIndex = index"
                            ></button>
                        </div>
                    </div>
                    <div v-else class="tfm-gallery__empty">No gallery images yet.</div>
                </section>

                <!-- Remaining videos (2nd onward) -->
                <section v-if="remainingVideos.length" aria-labelledby="videos-title" data-reveal>
                    <div class="tfm-section-head">
                        <span class="tfm-section-head__num">05</span>
                        <h2 id="videos-title">Watch</h2>
                        <span class="tfm-section-head__line"></span>
                    </div>
                    <div class="tfm-videos">
                        <div v-for="video in remainingVideos" :key="video.id" class="tfm-video-item">
                            <div class="tfm-video-embed">
                                <iframe
                                    :src="`https://www.youtube.com/embed/${video.id}`"
                                    :title="video.title"
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                    allowfullscreen
                                    loading="lazy"
                                ></iframe>
                            </div>
                            <p v-if="video.title" class="tfm-video-label">{{ video.title }}</p>
                        </div>
                    </div>
                </section>

                <section v-if="production.reviews && production.reviews.length" aria-labelledby="reviews-title" data-reveal>
                    <div class="tfm-section-head">
                        <span class="tfm-section-head__num">{{ reviewSectionNum }}</span>
                        <h2 id="reviews-title">Reviews</h2>
                        <span class="tfm-section-head__line"></span>
                    </div>
                    <div class="tfm-quotes">
                        <figure v-for="review in production.reviews" :key="review.source" class="tfm-quote">
                            <blockquote>{{ review.quote }}</blockquote>
                            <figcaption>{{ review.source }}</figcaption>
                        </figure>
                    </div>
                </section>
            </main>

            <div class="tfm-cta" data-reveal>
                <p class="tfm-cta__eyebrow">Book a Performance</p>
                <h2>Bring <span>{{ production.title }}</span><br>to your venue</h2>
                <p>Interested in hosting IPAG? Send us your event details and we'll get back to you.</p>
                <div class="tfm-cta__actions">
                    <a class="tfm-btn tfm-btn--primary" href="/bookings">Book a Performance</a>
                    <a class="tfm-btn tfm-btn--ghost" href="/contact">Contact IPAG</a>
                </div>
            </div>
        </template>

        <div v-else class="tfm-not-found">
            <p>Production not found.</p>
        </div>

    </div>
</template>

<script setup>
import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue';
import { supabase } from './supabase';

const props = defineProps({
    /** The URL path for this production, e.g. '/tales-from-mindanao' */
    path: { type: String, required: true },
});

const production = ref(null);
const loading = ref(true);
const fetchError = ref(null);
const galleryIndex = ref(0);
let galleryTimer;

async function fetchProduction(path) {
    loading.value = true;
    fetchError.value = null;
    galleryIndex.value = 0;
    const { data, error } = await supabase
        .from('productions')
        .select('*')
        .eq('path', path)
        .single();
    if (error && error.code !== 'PGRST116') {
        fetchError.value = error.message;
        console.error('[ProductionPage] fetch error:', error);
    }
    production.value = data ?? null;
    loading.value = false;
    // Wait for Vue to render the fetched content, then reveal it
    await nextTick();
    revealSections();
}

// First video is the highlight embed
const highlightVideo = computed(() => {
    const videos = production.value?.videos;
    return videos && videos.length ? videos[0] : null;
});

// Remaining videos go in the Watch section
const remainingVideos = computed(() => {
    const videos = production.value?.videos;
    return videos && videos.length > 1 ? videos.slice(1) : [];
});

const reviewSectionNum = computed(() => remainingVideos.value.length ? '06' : '05');

function changeGallery(direction) {
    const len = production.value?.gallery?.length ?? 0;
    if (!len) return;
    galleryIndex.value = (galleryIndex.value + direction + len) % len;
}

function revealSections() {
    document.querySelectorAll('.production-page [data-reveal]').forEach((el) => {
        el.classList.add('is-visible');
    });
}

// Re-fetch when the path prop changes (navigating between productions)
watch(() => props.path, fetchProduction, { immediate: true });

onMounted(() => {
    galleryTimer = window.setInterval(() => changeGallery(1), 5000);
});

onBeforeUnmount(() => window.clearInterval(galleryTimer));
</script>
