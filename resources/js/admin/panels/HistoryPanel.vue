<template>
    <div class="adm-panel">
        <div class="adm-panel-intro">
            <p class="adm-panel-intro__text">
                Each entry appears as a milestone on the IPAG History timeline. Add one entry per significant event, year by year.
            </p>
        </div>
        <SimpleListPanel
            table="history_events"
            entry-label="Timeline Entry"
            order-by="year"
            :order-desc="false"
            :fields="[
                { key: 'year',        label: 'Year',        type: 'text',     placeholder: 'e.g. 1992',  hint: 'The year this event happened.' },
                { key: 'title',       label: 'Event Name',  type: 'text',     full: true,                placeholder: 'e.g. Tales from Mindanao Premieres' },
                { key: 'description', label: 'What happened?', type: 'textarea', full: true, rows: 4,    placeholder: 'Describe the event in a few sentences…' },
            ]"
            :cols="['year', 'title']"
        />
    </div>
</template>

<script setup>
import SimpleListPanel from './SimpleListPanel.vue';
</script>
