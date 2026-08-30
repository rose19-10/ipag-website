<template>
    <div class="adm-panel">
        <div class="adm-panel-intro">
            <p class="adm-panel-intro__text">
                Manage the content shown on the <strong>Milestones</strong> page — IPAG's awards, international performances, and honored productions.
            </p>
        </div>

        <div class="adm-tab-group" style="margin-bottom: 24px;">
            <button class="adm-tab" :class="{ 'is-active': tab === 'awards' }" @click="tab = 'awards'">
                🏆 Awards &amp; Honors
            </button>
            <button class="adm-tab" :class="{ 'is-active': tab === 'representations' }" @click="tab = 'representations'">
                🌍 International Performances
            </button>
            <button class="adm-tab" :class="{ 'is-active': tab === 'play_awards' }" @click="tab = 'play_awards'">
                🎭 Honored Productions
            </button>
        </div>

        <!-- Awards -->
        <SimpleListPanel
            v-if="tab === 'awards'"
            table="awards"
            entry-label="Award"
            order-by="year"
            :order-desc="true"
            :fields="[
                { key: 'year',   label: 'Year Received', type: 'text', placeholder: 'e.g. 2025' },
                { key: 'title',  label: 'Award Name',    type: 'text', full: true, placeholder: 'e.g. CCP Gawad para sa Sining' },
                { key: 'detail', label: 'Given by / Notes', type: 'text', full: true, placeholder: 'e.g. Cultural Center of the Philippines' },
            ]"
            :cols="['year','title']"
        />

        <!-- Representations -->
        <SimpleListPanel
            v-else-if="tab === 'representations'"
            table="representations"
            entry-label="Performance"
            order-by="year"
            :order-desc="true"
            :fields="[
                { key: 'year',  label: 'Year', type: 'text', placeholder: 'e.g. 2019', hint: 'Use a range like 2012–2018 if needed.' },
                { key: 'event', label: 'Event or Festival Name', type: 'text', full: true, placeholder: 'e.g. Mumbai Ramayana International Festival, India' },
            ]"
            :cols="['year','event']"
        />

        <!-- Play Awards -->
        <SimpleListPanel
            v-else-if="tab === 'play_awards'"
            table="play_awards"
            entry-label="Production Honor"
            :fields="[
                { key: 'title',  label: 'Production Title', type: 'text', placeholder: 'e.g. Sarimanok' },
                { key: 'detail', label: 'Award or Recognition', type: 'text', full: true, placeholder: 'e.g. UP Likhaan, 1986 — Published anthology' },
            ]"
            :cols="['title','detail']"
        />
    </div>
</template>

<script setup>
import { ref } from 'vue';
import SimpleListPanel from './SimpleListPanel.vue';
const tab = ref('awards');
</script>
