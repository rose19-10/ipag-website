<template>
    <div id="vue-app">
        <nav>
            <a class="brand" href="/" aria-label="Go to IPAG home" @click.prevent="navigate('/')">
                <img :src="'/images/ipag-logo.png'" alt="IPAG logo">
                <strong>Integrated Performing Arts Guild</strong>
            </a>
            <ul>
                <li><a href="/" :class="{ active: path === '/' }" @click.prevent="navigate('/')">Home</a></li>
                <li class="dropdown">
                    <button class="dropdown-trigger" type="button">The IPAG</button>
                    <div class="dropdown-content">
                        <a href="/ipag-studies" @click.prevent="navigate('/ipag-studies')">IPAG Studies</a>
                        <a href="/history" @click.prevent="navigate('/history')">History</a>
                        <a href="/mission-vision" @click.prevent="navigate('/mission-vision')">Mission &amp; Vision</a>
                        <a href="/artists" @click.prevent="navigate('/artists')">Artists</a>
                        <a href="/director" @click.prevent="navigate('/director')">Director</a>
                    </div>
                </li>
                <li class="dropdown">
                    <button class="dropdown-trigger" type="button" @click.prevent="navigate('/productions')">Productions</button>
                    <div class="dropdown-content">
                        <a href="/productions" @click.prevent="navigate('/productions')">All Productions</a>
                        <a
                            v-for="item in productionLinks"
                            :key="item.path"
                            :href="item.path"
                            @click.prevent="navigate(item.path)"
                        >{{ item.title }}</a>
                    </div>
                </li>
                <li><a href="/milestones" :class="{ active: path === '/milestones' }" @click.prevent="navigate('/milestones')">Milestones</a></li>
                <li><a href="/bookings" :class="{ active: path === '/bookings' }" @click.prevent="navigate('/bookings')">Bookings</a></li>
                <li><a href="/contact" :class="{ active: path === '/contact' }" @click.prevent="navigate('/contact')">Contact</a></li>
                <li>
                    <button class="nav-login-btn" type="button" aria-label="Sign in" @click="loginOpen = true">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="8" r="4"/>
                            <path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/>
                        </svg>
                    </button>
                </li>
            </ul>
        </nav>

        <HomePage            v-if="path === '/'" />
        <ProductionsIndexPage v-else-if="path === '/productions'" @navigate="navigate" />
        <MilestonesPage      v-else-if="path === '/milestones'" />
        <BookingsPage        v-else-if="path === '/bookings'" />
        <ContactPage         v-else-if="path === '/contact'" />
        <HistoryPage         v-else-if="path === '/history'" />
        <MissionVisionPage   v-else-if="path === '/mission-vision'" />
        <ArtistsPage         v-else-if="path === '/artists'" />
        <DirectorPage        v-else-if="path === '/director'" />
        <IPAGStudiesPage     v-else-if="path === '/ipag-studies'" />
        <AdminPage           v-else-if="path === '/admin'" @navigate="navigate" />
        <!-- For any unknown path, treat it as a production path -->
        <ProductionPage      v-else :path="path" />

        <footer>&copy; Integrated Performing Arts Guild (IPAG) Philippines</footer>

        <LoginModal :open="loginOpen" @close="loginOpen = false" @navigate="navigate" />
    </div>
</template>

<script setup>
import { onBeforeUnmount, onMounted, ref } from 'vue';
import { supabase } from './supabase';
import AdminPage from './AdminPage.vue';
import ArtistsPage from './ipag-pages/ArtistsPage.vue';
import BookingsPage from './BookingsPage.vue';
import ContactPage from './ContactPage.vue';
import DirectorPage from './ipag-pages/DirectorPage.vue';
import HistoryPage from './ipag-pages/HistoryPage.vue';
import HomePage from './HomePage.vue';
import IPAGStudiesPage from './ipag-pages/IPAGStudiesPage.vue';
import LoginModal from './LoginModal.vue';
import MilestonesPage from './MilestonesPage.vue';
import MissionVisionPage from './ipag-pages/MissionVisionPage.vue';
import ProductionPage from './ProductionPage.vue';
import ProductionsIndexPage from './ProductionsIndexPage.vue';

const path = ref(window.location.pathname);
const loginOpen = ref(false);

// Production nav links — fetched from Supabase so the admin controls them
const productionLinks = ref([]);

async function loadProductionLinks() {
    const { data } = await supabase
        .from('productions')
        .select('title, path')
        .order('sort_order');
    productionLinks.value = data ?? [];
}

const pageTitles = {
    '/milestones':     'Milestones',
    '/bookings':       'Bookings',
    '/contact':        'Contact Us',
    '/history':        'History',
    '/mission-vision': 'Mission & Vision',
    '/artists':        'Artists',
    '/director':       'The Director',
    '/ipag-studies':   'IPAG Studies',
    '/productions':    'Productions',
};

function navigate(destination) {
    window.history.pushState({}, '', destination);
    path.value = destination;
    window.scrollTo({ top: 0, behavior: 'smooth' });
    const prodLink = productionLinks.value.find(p => p.path === destination);
    const label = pageTitles[destination] || prodLink?.title || 'IPAG';
    document.title = destination === '/' ? 'IPAG Philippines' : `${label} — IPAG`;
}

function onPopState() { path.value = window.location.pathname; }

onMounted(() => {
    window.addEventListener('popstate', onPopState);
    loadProductionLinks();
});

onBeforeUnmount(() => window.removeEventListener('popstate', onPopState));
</script>
