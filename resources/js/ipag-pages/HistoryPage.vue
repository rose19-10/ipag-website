<template>
    <div class="hist-root">

        <section class="hist-masthead">
            <div class="hist-masthead__inner">
                <div class="hist-masthead__meta">
                    <span>Est. 1978</span>
                    <span>Iligan City, Mindanao</span>
                    <span>47 Years</span>
                </div>
                <h1 class="hist-masthead__title">The History<br>of <em>IPAG</em></h1>
                <div class="hist-masthead__rule"></div>
                <p class="hist-masthead__deck">From a founding ensemble of twelve in Iligan City to one of the Philippines' most-traveled and most-awarded performing companies — a record of creation, perseverance, and cultural mission.</p>
            </div>
            <div class="hist-masthead__img">
                <img :src="'/images/ipag1.png'" alt="IPAG">
            </div>
        </section>

        <section class="hist-founding">
            <div class="hist-founding__inner">
                <p>The Integrated Performing Arts Guild was founded in <strong>1978</strong> in Iligan City, Mindanao, by Steven P.C. Fernandez and co-founder Ligaya Fernando-Amilbangsa — beginning with a small group of twelve artists, the original IPAG 12.</p>
                <p>For its first 46 seasons, IPAG was hosted by the <strong>Mindanao State University–Iligan Institute of Technology (MSU-IIT)</strong>, which provided the Guild a home as it grew into a nationally recognized and internationally touring performing company. Beginning with its 47th season, IPAG operates independently, continuing its mission as a major Philippine performing company.</p>
            </div>
        </section>

        <section class="hist-timeline-section">
            <div class="hist-timeline-section__inner">
                <div v-if="loading" class="hist-loading">Loading history…</div>
                <div v-else-if="!rows.length" class="hist-empty">No history entries yet.</div>
                <div v-else class="hist-timeline">
                    <div v-for="event in rows" :key="event.id" class="hist-entry">
                        <div class="hist-entry__year">{{ event.year }}</div>
                        <div class="hist-entry__body">
                            <h3 class="hist-entry__title">{{ event.title }}</h3>
                            <p class="hist-entry__desc">{{ event.description }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </div>
</template>

<script setup>
import { useTable } from '../useTable';

const { rows, loading } = useTable('history_events', { orderBy: 'sort_order' });
</script>
