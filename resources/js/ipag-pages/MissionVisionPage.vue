<template>
    <div class="mv-root">

        <!-- Cinematic full-height split -->
        <section class="mv-splash">
            <div class="mv-splash__left">
                <img :src="'/images/ipag1.png'" alt="IPAG Performance">
            </div>
            <div class="mv-splash__right">
                <p class="mv-splash__label">The IPAG · Est. 1978</p>
                <h1 class="mv-splash__title">Mission<br>&amp;<br><em>Vision</em></h1>
                <p class="mv-splash__sub">The principles and purpose that have guided IPAG through nearly five decades of original Philippine performance.</p>
            </div>
        </section>

        <!-- Mission — large type, dark -->
        <section class="mv-statement mv-statement--mission">
            <div class="mv-statement__inner">
                <span class="mv-statement__label">Mission</span>
                <p class="mv-statement__text">To create, preserve, and share the living performance traditions of Mindanao and the Philippines — bringing theater, dance, music, literature, and visual design into a unified artistic practice committed to truthful storytelling and the elevation of indigenous and folk traditions to the world stage.</p>
            </div>
        </section>

        <!-- Vision — ivory, contrasting -->
        <section class="mv-statement mv-statement--vision">
            <div class="mv-statement__inner">
                <span class="mv-statement__label">Vision</span>
                <p class="mv-statement__text">A Philippines recognized globally for the depth, beauty, and humanity of its performing arts — where the stories and traditions of Mindanao are celebrated alongside the great theatrical traditions of the world.</p>
            </div>
        </section>

        <!-- Values — open grid on white -->
        <section class="mv-values-section">
            <div class="mv-values-section__inner">
                <div class="mv-values-section__head">
                    <h2>Core Values</h2>
                    <p>The qualities that define how IPAG works, creates, and engages with the world.</p>
                </div>
                <div class="mv-values-grid">
                    <div v-for="value in values" :key="value.title" class="mv-value">
                        <span class="mv-value__icon">{{ value.icon }}</span>
                        <h3 class="mv-value__title">{{ value.title }}</h3>
                        <p class="mv-value__desc">{{ value.desc }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Principles — maroon band -->
        <section class="mv-principles">
            <div class="mv-principles__inner">
                <span class="mv-principles__label">Performance Principles</span>
                <h2 class="mv-principles__title">The IPAG Method</h2>
                <div class="mv-principles__grid">
                    <div v-for="p in principles" :key="p.title" class="mv-principle">
                        <h3 class="mv-principle__title">{{ p.title }}</h3>
                        <p class="mv-principle__desc">{{ p.desc }}</p>
                    </div>
                </div>
            </div>
        </section>

    </div>
</template>

<script setup>
const values = [
    { icon: '🌿', title: 'Rootedness', desc: 'All IPAG work draws from the living cultures, oral traditions, and indigenous forms of Mindanao and the Philippines.' },
    { icon: '🎭', title: 'Craft', desc: 'The Guild holds its artists to the highest standards of physical, vocal, and musical performance through continuous training.' },
    { icon: '🤝', title: 'Community', desc: 'IPAG is built on the collective — a shared endeavor between artists, scholars, educators, and audiences.' },
    { icon: '🌏', title: 'Exchange', desc: 'Through international touring, IPAG builds bridges between Philippine culture and the world.' },
    { icon: '📚', title: 'Scholarship', desc: 'Performance at IPAG is inseparable from research, documentation, and the study of Philippine cultural heritage.' },
    { icon: '✨', title: 'Innovation', desc: 'Tradition is a resource, not a constraint. IPAG continuously reimagines inherited forms for contemporary audiences.' },
];

const principles = [
    { title: 'Transcreation', desc: 'Reforming source material — epic, folk, or literary — into a new theatrical language that retains the original\'s spirit while speaking to present-day audiences.' },
    { title: 'Distillation', desc: 'Removing the non-essential to arrive at the core truth of a performance. Maximum impact from precisely chosen elements.' },
    { title: 'Collage Dramaturgy', desc: 'Overlapping actions, spaces, and timeframes to mirror how meaning is made — non-linear, layered, open to interpretation.' },
    { title: 'Living Tradition', desc: 'Indigenous and folk performance forms are active, evolving sources — not museum pieces but living languages capable of speaking to the present.' },
];
</script>
