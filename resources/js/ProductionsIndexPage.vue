<template>
    <div class="prod-index">
        <div class="prod-index__hero">
            <div class="prod-index__hero-inner">
                <p class="tfm-hero__kicker">IPAG — Integrated Performing Arts Guild · Philippines</p>
                <span class="tfm-hero__rule"></span>
                <h1>Productions</h1>
                <p>Nearly five decades of original Philippine performance — touring from Mindanao to the world's stages.</p>
            </div>
        </div>

        <div class="prod-index__grid-wrap">
            <div v-if="loading" class="prod-index__loading">Loading productions…</div>
            <div v-else-if="error" class="prod-index__error" style="padding:2rem;color:red;font-family:monospace;">
                Error loading productions: {{ error }}
            </div>
            <div v-else-if="!rows.length" class="prod-index__empty">No productions found.</div>
            <div v-else class="prod-index__grid">
                <a
                    v-for="production in rows"
                    :key="production.path"
                    class="prod-card"
                    :href="production.path"
                    @click.prevent="navigate(production.path)"
                >
                    <div class="prod-card__img-wrap">
                        <img :src="production.image" :alt="production.title">
                    </div>
                    <div class="prod-card__body">
                        <h2 class="prod-card__title">{{ production.title }}</h2>
                        <p class="prod-card__desc">{{ production.description }}</p>
                        <ul v-if="production.facts && production.facts.length" class="prod-card__facts">
                            <li v-for="fact in production.facts.slice(0, 2)" :key="fact.label">
                                <span class="prod-card__fact-label">{{ fact.label }}</span>
                                <span class="prod-card__fact-value">{{ fact.value }}</span>
                            </li>
                        </ul>
                        <span class="prod-card__link">View production →</span>
                    </div>
                </a>
            </div>
        </div>
    </div>
</template>

<script setup>
import { useTable } from './useTable';

const emit = defineEmits(['navigate']);

const { rows, loading, error } = useTable('productions', { orderBy: 'sort_order' });

function navigate(path) {
    emit('navigate', path);
}
</script>
