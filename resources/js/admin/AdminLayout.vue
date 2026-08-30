<template>
    <div class="adm-root">
        <!-- Sidebar -->
        <aside class="adm-sidebar">
            <div class="adm-sidebar__brand">
                <img :src="'/images/ipag-logo.png'" alt="IPAG">
                <div>
                    <span class="adm-sidebar__name">IPAG Admin</span>
                    <span class="adm-sidebar__email">{{ user?.email }}</span>
                </div>
            </div>

            <nav class="adm-sidebar__nav">
                <button
                    v-for="item in sections"
                    :key="item.key"
                    class="adm-nav-item"
                    :class="{ 'is-active': active === item.key }"
                    type="button"
                    @click="active = item.key"
                >
                    <span class="adm-nav-item__icon">{{ item.icon }}</span>
                    {{ item.label }}
                </button>
            </nav>

            <div class="adm-sidebar__footer">
                <a class="adm-sidebar__public-link" href="/" @click.prevent="$emit('navigate', '/')">
                    ← Back to site
                </a>
                <button class="adm-sidebar__signout" type="button" @click="handleSignOut">Sign Out</button>
            </div>
        </aside>

        <!-- Main content -->
        <main class="adm-main">
            <div class="adm-main__header">
                <h1 class="adm-main__title">{{ currentSection.label }}</h1>
                <p class="adm-main__sub">{{ currentSection.desc }}</p>
            </div>

            <div class="adm-main__body">
                <HomePanel       v-if="active === 'home'" />
                <ProductionsPanel v-else-if="active === 'productions'" />
                <ArtistsPanel    v-else-if="active === 'artists'" />
                <MilestonesPanel v-else-if="active === 'milestones'" />
                <HistoryPanel    v-else-if="active === 'history'" />
                <DirectorPanel   v-else-if="active === 'director'" />
                <ImagesPanel     v-else-if="active === 'images'" />
            </div>
        </main>
    </div>
</template>

<script setup>
import { computed, ref } from 'vue';
import { useAuth } from '../useAuth';
import HomePanel        from './panels/HomePanel.vue';
import ProductionsPanel from './panels/ProductionsPanel.vue';
import ArtistsPanel     from './panels/ArtistsPanel.vue';
import MilestonesPanel  from './panels/MilestonesPanel.vue';
import HistoryPanel     from './panels/HistoryPanel.vue';
import DirectorPanel    from './panels/DirectorPanel.vue';
import ImagesPanel      from './panels/ImagesPanel.vue';

defineEmits(['navigate']);

const { user, signOut } = useAuth();
const active = ref('productions');

const sections = [
    { key: 'home',        icon: '🏠', label: 'Home Page',    desc: 'Edit the welcome text, season announcement, and contact details shown on the home page.' },
    { key: 'productions', icon: '🎭', label: 'Productions',  desc: 'Add, edit, or remove IPAG productions — their descriptions, photos, videos, and gallery.' },
    { key: 'artists',     icon: '👤', label: 'Artists',      desc: 'Manage the roster of Resident Artists and Apprentices shown on the Artists page.' },
    { key: 'milestones',  icon: '🏆', label: 'Milestones',   desc: 'Update IPAG\'s awards, international performances, and honored productions.' },
    { key: 'history',     icon: '📜', label: 'History',      desc: 'Add or edit entries on the IPAG History timeline.' },
    { key: 'director',    icon: '🎬', label: 'The Director', desc: 'Update the Artistic Director\'s profile, biography, photo, and awards.' },
    { key: 'images',      icon: '🖼️', label: 'Image Library', desc: 'Upload and manage photos used throughout the website.' },
];

const currentSection = computed(() => sections.find(s => s.key === active.value));

async function handleSignOut() {
    await signOut();
}
</script>
