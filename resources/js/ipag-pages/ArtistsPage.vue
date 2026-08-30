<template>
    <div class="art-root">

        <section class="art-header">
            <div class="art-header__bg">
                <img :src="'/images/ipag4.png'" alt="IPAG Artists">
            </div>
            <div class="art-header__overlay">
                <div class="art-header__content">
                    <span class="art-header__label">The IPAG · Season 49</span>
                    <h1 class="art-header__title">The People<br>Behind the Stage</h1>
                </div>
            </div>
        </section>

        <section class="art-intro">
            <div class="art-intro__inner">
                <p>Upon recommendation and thorough evaluation under the IPAG Membership Implementing Rules (updated October 2014), the following are designated as <strong>Resident Artists</strong> and <strong>Apprentices</strong> for Season 49. Ratings, requirements, and privileges are specified in the IPAG Membership Rules and its implementation.</p>
            </div>
        </section>

        <div v-if="loading" class="art-loading">Loading artists…</div>

        <template v-else>
            <!-- Resident Artists -->
            <section class="art-roster">
                <div class="art-roster__inner">
                    <div class="art-roster__section-head">
                        <span class="art-roster__section-label">01</span>
                        <h2 class="art-roster__heading">Resident Artists</h2>
                    </div>
                    <div v-if="!residentArtists.length" class="art-empty">No resident artists listed yet.</div>
                    <div v-else class="art-roster__grid">
                        <div v-for="artist in residentArtists" :key="artist.id" class="art-card">
                            <div class="art-card__photo">
                                <img v-if="artist.photo" :src="artist.photo" :alt="artist.name">
                                <div v-else class="art-card__photo-placeholder">
                                    <span class="art-card__initials">{{ initials(artist.name) }}</span>
                                    <span class="art-card__photo-hint">Add photo</span>
                                </div>
                            </div>
                            <div class="art-card__info">
                                <span class="art-card__role">{{ artist.role }}</span>
                                <h3 class="art-card__name">{{ artist.name }}</h3>
                                <p v-if="artist.note" class="art-card__note">{{ artist.note }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Apprentices -->
            <section class="art-roster art-roster--apprentices">
                <div class="art-roster__inner">
                    <div class="art-roster__section-head">
                        <span class="art-roster__section-label">02</span>
                        <h2 class="art-roster__heading">Apprentices</h2>
                    </div>
                    <div v-if="!apprentices.length" class="art-empty">No apprentices listed yet.</div>
                    <div v-else class="art-roster__grid">
                        <div v-for="artist in apprentices" :key="artist.id" class="art-card art-card--apprentice">
                            <div class="art-card__photo">
                                <img v-if="artist.photo" :src="artist.photo" :alt="artist.name">
                                <div v-else class="art-card__photo-placeholder art-card__photo-placeholder--apprentice">
                                    <span class="art-card__initials">{{ initials(artist.name) }}</span>
                                    <span class="art-card__photo-hint">Add photo</span>
                                </div>
                            </div>
                            <div class="art-card__info">
                                <span class="art-card__role">{{ artist.role }}</span>
                                <h3 class="art-card__name">{{ artist.name }}</h3>
                                <p v-if="artist.note" class="art-card__note">{{ artist.note }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </template>

        <section class="art-join">
            <div class="art-join__inner">
                <div class="art-join__text">
                    <h2>Join the Guild</h2>
                    <p>IPAG membership is governed by the Guild's Implementing Rules. Artists are admitted through a process of recommendation, evaluation, and ratification by the IPAG Board. For information on membership, training programs, and IPAG Studies enrollment, contact the Guild directly.</p>
                </div>
                <a class="tfm-btn tfm-btn--primary" href="/contact">Get in Touch</a>
            </div>
        </section>

    </div>
</template>

<script setup>
import { computed } from 'vue';
import { useTable } from '../useTable';

const { rows, loading } = useTable('artists', { orderBy: 'sort_order' });

const residentArtists = computed(() => rows.value.filter(a => a.type === 'resident' && a.active !== false));
const apprentices     = computed(() => rows.value.filter(a => a.type === 'apprentice' && a.active !== false));

function initials(name) {
    return (name || '?').split(' ').filter(w => w.length > 1).slice(0, 2).map(w => w[0]).join('');
}
</script>
