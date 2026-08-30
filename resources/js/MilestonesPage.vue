<template>
    <div class="ms-root">

        <!-- Hero -->
        <header class="ms-hero">
            <div class="ms-hero__bg"></div>
            <div class="ms-hero__inner">
                <p class="ms-kicker">Integrated Performing Arts Guild · Est. 1978</p>
                <h1 class="ms-hero__title">Nearly Five<br><em>Decades</em> of<br>Excellence</h1>
                <p class="ms-hero__sub">From Iligan City to the world's stages — a record of recognition, representation, and original Philippine performance.</p>
            </div>
            <div class="ms-stat-bar">
                <div class="ms-stat"><span class="ms-stat__num">47</span><span class="ms-stat__label">Years of Performance</span></div>
                <div class="ms-stat"><span class="ms-stat__num">30+</span><span class="ms-stat__label">Countries Toured</span></div>
                <div class="ms-stat"><span class="ms-stat__num">50+</span><span class="ms-stat__label">Original Productions</span></div>
                <div class="ms-stat"><span class="ms-stat__num">100+</span><span class="ms-stat__label">Cities Worldwide</span></div>
            </div>
        </header>

        <!-- Intro quote -->
        <div class="ms-intro-quote">
            <div class="ms-intro-quote__inner">
                <p class="ms-intro-quote__text">On July 7, 2022, the Cultural Center of the Philippines awarded IPAG and its Artistic Director Steven P.C. Fernandez with the 1st Gador Awards. The CCP would later award IPAG the <strong>Gawad para sa Sining</strong> — the highest distinction for a performing company — in a ceremony at the CCP Tanghalang Abelardo.</p>
                <p class="ms-intro-quote__text">These honors recall the artists, institutions, and communities that have shaped IPAG: its home, the MSU–Iligan Institute of Technology; co-founder Ligaya Fernando-Amilbangsa; the original IPAG 12; and the multitude of supporters and audiences across the Philippines and the world.</p>
            </div>
        </div>

        <div class="ms-body">

            <!-- Awards -->
            <section class="ms-section">
                <div class="ms-section-head">
                    <span class="ms-section-head__num">01</span>
                    <h2>Awards &amp; Recognition</h2>
                    <span class="ms-section-head__line"></span>
                </div>
                <div v-if="awardsLoading" class="ms-loading">Loading…</div>
                <div v-else-if="!awards.length" class="ms-empty">No awards listed yet.</div>
                <div v-else class="ms-awards-grid">
                    <div v-for="award in awards" :key="award.id" class="ms-award-card">
                        <span class="ms-award-card__year">{{ award.year }}</span>
                        <div class="ms-award-card__body">
                            <h3 class="ms-award-card__title">{{ award.title }}</h3>
                            <p v-if="award.detail" class="ms-award-card__detail">{{ award.detail }}</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Representations timeline -->
            <section class="ms-section">
                <div class="ms-section-head">
                    <span class="ms-section-head__num">02</span>
                    <h2>On the World Stage</h2>
                    <span class="ms-section-head__line"></span>
                </div>
                <div v-if="repsLoading" class="ms-loading">Loading…</div>
                <div v-else-if="!representations.length" class="ms-empty">No representations listed yet.</div>
                <div v-else class="ms-timeline">
                    <div v-for="rep in representations" :key="rep.id" class="ms-timeline__item">
                        <div class="ms-timeline__dot"></div>
                        <span class="ms-timeline__year">{{ rep.year }}</span>
                        <span class="ms-timeline__event">{{ rep.event }}</span>
                    </div>
                </div>
            </section>

            <!-- Play Awards -->
            <section class="ms-section">
                <div class="ms-section-head">
                    <span class="ms-section-head__num">03</span>
                    <h2>Play Awards</h2>
                    <span class="ms-section-head__line"></span>
                </div>
                <div v-if="playAwardsLoading" class="ms-loading">Loading…</div>
                <div v-else-if="!playAwards.length" class="ms-empty">No play awards listed yet.</div>
                <div v-else class="ms-play-awards">
                    <div v-for="p in playAwards" :key="p.id" class="ms-play-award">
                        <span class="ms-play-award__title">{{ p.title }}</span>
                        <span class="ms-play-award__detail">{{ p.detail }}</span>
                    </div>
                </div>
            </section>

        </div>

        <!-- CTA -->
        <div class="ms-cta">
            <div class="ms-cta__text">
                <p class="ms-cta__eyebrow">August 2027</p>
                <h2>On the road to <span>Gold</span></h2>
                <p>IPAG turns fifty in 2027. This season celebrates the legacy, people, and creative work carrying the Guild toward its golden anniversary.</p>
            </div>
            <div class="ms-cta__actions">
                <a class="tfm-btn tfm-btn--primary" href="/bookings">Book a Performance</a>
                <a class="tfm-btn tfm-btn--ghost" href="/contact">Contact IPAG</a>
            </div>
        </div>

    </div>
</template>

<script setup>
import { useTable } from './useTable';

const { rows: awards,          loading: awardsLoading }      = useTable('awards',          { orderBy: 'sort_order' });
const { rows: representations, loading: repsLoading }        = useTable('representations', { orderBy: 'sort_order' });
const { rows: playAwards,      loading: playAwardsLoading }  = useTable('play_awards',     { orderBy: 'sort_order' });
</script>
