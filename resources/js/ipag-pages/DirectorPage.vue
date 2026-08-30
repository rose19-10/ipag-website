<template>
    <div class="dir-root">

        <div v-if="loading" class="dir-loading">Loading…</div>

        <template v-else-if="row">

            <section class="dir-feature">
                <div class="dir-feature__img">
                    <img :src="row.photo || '/images/TFM2.jpg'" :alt="row.name">
                    <div class="dir-feature__img-caption">Founding Artistic Director · 1978</div>
                </div>
                <div class="dir-feature__content">
                    <span class="dir-feature__label">The IPAG · Founding Artistic Director</span>
                    <h1 class="dir-feature__name">{{ nameFormatted }}</h1>
                    <p class="dir-feature__title">{{ row.title }}</p>
                    <div class="dir-feature__stats">
                        <div class="dir-stat">
                            <span class="dir-stat__num">{{ row.stat_productions }}</span>
                            <span class="dir-stat__label">Productions</span>
                        </div>
                        <div class="dir-stat">
                            <span class="dir-stat__num">{{ row.stat_books }}</span>
                            <span class="dir-stat__label">Books Published</span>
                        </div>
                        <div class="dir-stat">
                            <span class="dir-stat__num">{{ row.stat_years }}</span>
                            <span class="dir-stat__label">Years at IPAG</span>
                        </div>
                    </div>
                </div>
            </section>

            <section class="dir-bio">
                <div class="dir-bio__inner">
                    <div class="dir-bio__col">
                        <p>{{ row.bio_col1 }}</p>
                    </div>
                    <div class="dir-bio__col">
                        <p>{{ row.bio_col2 }}</p>
                    </div>
                </div>
            </section>

            <section v-if="row.quote" class="dir-pullquote">
                <blockquote class="dir-pullquote__text">"{{ row.quote }}"</blockquote>
            </section>

            <section v-if="distinctions.length" class="dir-awards">
                <div class="dir-awards__inner">
                    <h2 class="dir-awards__heading">Selected Distinctions</h2>
                    <div class="dir-awards__list">
                        <div v-for="award in distinctions" :key="award" class="dir-award-chip">{{ award }}</div>
                    </div>
                </div>
            </section>

        </template>

        <!-- Fallback if no director record has been saved yet -->
        <div v-else class="dir-empty">
            <p>Director bio not available yet.</p>
        </div>

    </div>
</template>

<script setup>
import { computed } from 'vue';
import { useSingle } from '../useTable';

const { row, loading } = useSingle('director');

// Break the full name at the first space for the two-line display style
const nameFormatted = computed(() => row.value?.name ?? '');

// distinctions is stored as a JSONB array of strings in Supabase
const distinctions = computed(() => {
    const d = row.value?.distinctions;
    return Array.isArray(d) ? d : [];
});
</script>
