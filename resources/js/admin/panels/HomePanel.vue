<template>
    <div class="adm-panel">
        <div v-if="loading" class="adm-loading">Loading…</div>

        <div v-else class="adm-home-editor">

            <!-- ── Hero Poster ─────────────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">Hero Poster</h2>
                <div class="adm-form-grid">
                    <div class="adm-field adm-field--full">
                        <label>Poster Alt Text</label>
                        <input v-model="f.hero_poster_alt" type="text" placeholder="IPAG 49th Theater Season poster">
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Poster Image</label>
                        <div class="adm-img-upload-row">
                            <div v-if="f.hero_poster_image" class="adm-img-preview adm-img-preview--hero">
                                <img :src="f.hero_poster_image" alt="Hero poster preview">
                                <button class="adm-img-preview__remove" type="button" @click="removeHeroPoster">✕</button>
                            </div>
                            <label class="adm-upload-zone adm-upload-zone--inline" :class="{ 'is-dragging': dragging.hero }">
                                <span>{{ uploading.hero ? 'Uploading…' : '+ Upload poster' }}</span>
                                <input type="file" accept="image/*" class="adm-upload-zone__input"
                                    :disabled="uploading.hero"
                                    @change="e => uploadImage(e, 'hero_poster_image', 'hero')">
                            </label>
                        </div>
                        <span class="adm-field__hint">Displays as the full-width banner at the top of the home page.</span>
                    </div>
                </div>
            </section>

            <!-- ── Intro ──────────────────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">Intro Section</h2>
                <div class="adm-form-grid">
                    <div class="adm-field">
                        <label>Kicker</label>
                        <input v-model="f.intro_kicker" type="text" placeholder="The IPAG">
                    </div>
                    <div class="adm-field">
                        <label>Heading</label>
                        <input v-model="f.intro_title" type="text" placeholder="Stories from the South.">
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Body text</label>
                        <textarea v-model="f.intro_body" rows="3"></textarea>
                    </div>
                </div>
            </section>

            <!-- ── Season Panel ───────────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">Season Panel</h2>
                <div class="adm-form-grid">
                    <div class="adm-field">
                        <label>Kicker (date range)</label>
                        <input v-model="f.season_kicker" type="text" placeholder="August 2026 – May 2027">
                    </div>
                    <div class="adm-field">
                        <label>Season Title</label>
                        <input v-model="f.season_title" type="text">
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Season Description</label>
                        <textarea v-model="f.season_body" rows="2"></textarea>
                    </div>
                    <div class="adm-field">
                        <label>Number of productions to show</label>
                        <input v-model.number="f.season_count" type="number" min="1" max="12">
                        <span class="adm-field__hint">Shows the top N productions by sort order.</span>
                    </div>
                </div>
            </section>

            <!-- ── Story Column 1 ─────────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">Story Column 1 (light)</h2>
                <div class="adm-form-grid">
                    <div class="adm-field">
                        <label>Kicker</label>
                        <input v-model="f.story1_kicker" type="text">
                    </div>
                    <div class="adm-field">
                        <label>Heading</label>
                        <input v-model="f.story1_heading" type="text">
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Paragraph 1</label>
                        <textarea v-model="f.story1_para1" rows="3"></textarea>
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Paragraph 2</label>
                        <textarea v-model="f.story1_para2" rows="3"></textarea>
                    </div>
                </div>
            </section>

            <!-- ── Story Column 2 ─────────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">Story Column 2 (dark)</h2>
                <div class="adm-form-grid">
                    <div class="adm-field">
                        <label>Kicker</label>
                        <input v-model="f.story2_kicker" type="text">
                    </div>
                    <div class="adm-field">
                        <label>Heading</label>
                        <input v-model="f.story2_heading" type="text">
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Paragraph</label>
                        <textarea v-model="f.story2_para1" rows="3"></textarea>
                    </div>
                </div>
            </section>

            <!-- ── About Us Slideshow ─────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">About Us — Slideshow</h2>
                <p class="adm-home-section__desc">
                    These images appear in the "About us" slideshow on the home page.
                    Drag to reorder. Click ✕ to remove.
                </p>

                <!-- Current slides -->
                <div v-if="slideImages.length" class="adm-slide-list">
                    <div
                        v-for="(url, i) in slideImages"
                        :key="url"
                        class="adm-slide-item"
                        draggable="true"
                        @dragstart="dragStart(i)"
                        @dragover.prevent="dragOver(i)"
                        @drop.prevent="dragDrop(i)"
                    >
                        <span class="adm-slide-item__handle">⠿</span>
                        <div class="adm-slide-item__thumb">
                            <img :src="url" alt="Slide preview">
                        </div>
                        <span class="adm-slide-item__num">{{ i + 1 }}</span>
                        <button class="adm-slide-item__remove" type="button" @click="removeSlide(i)">✕</button>
                    </div>
                </div>
                <p v-else class="adm-empty" style="margin: 8px 0 12px;">No slideshow images yet.</p>

                <!-- Upload new slides -->
                <label class="adm-upload-zone adm-upload-zone--inline" :class="{ 'is-dragging': dragging.slides }">
                    <span>{{ uploading.slides ? 'Uploading…' : '+ Add slideshow images' }}</span>
                    <span class="adm-field__hint">PNG, JPG, WebP — select multiple</span>
                    <input type="file" accept="image/*" multiple class="adm-upload-zone__input"
                        :disabled="uploading.slides"
                        @change="e => uploadSlides(e.target.files)">
                </label>

                <!-- Upload progress -->
                <div v-if="slideUploadProgress.length" class="adm-upload-progress" style="margin-top:10px;">
                    <div v-for="p in slideUploadProgress" :key="p.name" class="adm-upload-progress__item">
                        <span>{{ p.name }}</span>
                        <span class="adm-upload-progress__status" :class="p.status">{{ p.status }}</span>
                    </div>
                </div>
            </section>

            <!-- ── About Us Text ──────────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">About Us — Text</h2>
                <div class="adm-form-grid">
                    <div class="adm-field adm-field--full">
                        <label>Heading</label>
                        <input v-model="f.about_heading" type="text" placeholder="GLOBAL WORKS">
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Paragraph 1</label>
                        <textarea v-model="f.about_para1" rows="3"></textarea>
                    </div>
                    <div class="adm-field adm-field--full">
                        <label>Paragraph 2</label>
                        <textarea v-model="f.about_para2" rows="3"></textarea>
                    </div>
                    <div class="adm-field">
                        <label>Stat 1 — Number</label>
                        <input v-model="f.about_stat1_num" type="text" placeholder="50">
                    </div>
                    <div class="adm-field">
                        <label>Stat 1 — Label</label>
                        <input v-model="f.about_stat1_label" type="text" placeholder="Full-length productions">
                    </div>
                    <div class="adm-field">
                        <label>Stat 2 — Number</label>
                        <input v-model="f.about_stat2_num" type="text" placeholder="100+">
                    </div>
                    <div class="adm-field">
                        <label>Stat 2 — Label</label>
                        <input v-model="f.about_stat2_label" type="text" placeholder="Cities worldwide">
                    </div>
                </div>
            </section>

            <!-- ── Contact Band ───────────────────────────── -->
            <section class="adm-home-section">
                <h2 class="adm-home-section__title">Contact Band</h2>
                <div class="adm-form-grid">
                    <div class="adm-field">
                        <label>Kicker</label>
                        <input v-model="f.contact_kicker" type="text" placeholder="Bring IPAG to your venue">
                    </div>
                    <div class="adm-field">
                        <label>Heading</label>
                        <input v-model="f.contact_heading" type="text">
                    </div>
                    <div class="adm-field">
                        <label>Address</label>
                        <input v-model="f.contact_address" type="text">
                    </div>
                    <div class="adm-field">
                        <label>Email</label>
                        <input v-model="f.contact_email" type="text">
                    </div>
                    <div class="adm-field">
                        <label>Phone</label>
                        <input v-model="f.contact_phone" type="text">
                    </div>
                </div>
            </section>

            <!-- ── Save ───────────────────────────────────── -->
            <div v-if="uploadError" class="adm-error">{{ uploadError }}</div>
            <div v-if="saveError" class="adm-error">{{ saveError }}</div>
            <div v-if="saveSuccess" class="adm-success">Home page saved successfully.</div>

            <div class="adm-form-actions">
                <button class="adm-btn adm-btn--primary" :disabled="saving" @click="save">
                    {{ saving ? 'Saving…' : 'Save Home Page' }}
                </button>
            </div>

        </div>
    </div>
</template>

<script setup>
import { onMounted, reactive, ref } from 'vue';
import { supabase } from '../../supabase';
import { deleteFromStorage, deleteManyFromStorage } from '../storageUtils';

const BUCKET = 'ipag-images';

const loading     = ref(true);
const saving      = ref(false);
const saveError   = ref('');
const saveSuccess = ref(false);
const uploadError = ref('');

// Slideshow image URLs (stored as JSON in page_content key 'about_slides')
const slideImages = ref([]);
const slideUploadProgress = ref([]);

// Drag-to-reorder state
let dragFromIndex = null;
function dragStart(i) { dragFromIndex = i; }
function dragOver(i)  { /* needed for drop to fire */ }
function dragDrop(i) {
    if (dragFromIndex === null || dragFromIndex === i) return;
    const arr = [...slideImages.value];
    const [moved] = arr.splice(dragFromIndex, 1);
    arr.splice(i, 0, moved);
    slideImages.value = arr;
    dragFromIndex = null;
}
async function removeSlide(i) {
    await deleteFromStorage(slideImages.value[i]);
    slideImages.value = slideImages.value.filter((_, idx) => idx !== i);
}

// Per-field upload state
const uploading = reactive({ hero: false, slides: false });
const dragging  = reactive({ hero: false, slides: false });

// ── All text content fields ───────────────────────────────
const f = reactive({
    hero_poster_image:  '',
    hero_poster_alt:    'IPAG 49th Theater Season poster',
    intro_kicker:       'The IPAG',
    intro_title:        'Stories from the South. Shared with the world.',
    intro_body:         '',
    season_kicker:      'August 2026 – May 2027',
    season_title:       '49th Season: On the road to Gold',
    season_body:        '',
    season_count:       '4',
    story1_kicker:      'Performance and practice',
    story1_heading:     'Hagup sa Kasinatian',
    story1_para1:       '',
    story1_para2:       '',
    story2_kicker:      'Recognition',
    story2_heading:     'A company built beyond the center',
    story2_para1:       '',
    about_heading:      'GLOBAL WORKS',
    about_para1:        '',
    about_para2:        '',
    about_stat1_num:    '50',
    about_stat1_label:  'Full-length productions',
    about_stat2_num:    '100+',
    about_stat2_label:  'Cities worldwide',
    contact_kicker:     'Bring IPAG to your venue',
    contact_heading:    'Plan a performance, road show, or workshop.',
    contact_address:    'IPAG Center, Ramiro St., Ilaya, Poblacion, Iligan City',
    contact_email:      'ipagarts@gmail.com',
    contact_phone:      '(+63) 917 136 2275',
});

// ── Load ─────────────────────────────────────────────────
async function load() {
    loading.value = true;
    const { data } = await supabase
        .from('page_content')
        .select('key, value')
        .eq('page', 'home');

    if (data) {
        data.forEach(row => {
            if (row.key === 'about_slides') {
                try { slideImages.value = JSON.parse(row.value) || []; } catch { slideImages.value = []; }
            } else if (row.key in f) {
                f[row.key] = row.value;
            }
        });
    }
    loading.value = false;
}

// ── Upload a single image (hero poster) ──────────────────
// Sanitise filename: strip spaces/special chars, keep only alphanumeric, dash, dot, underscore
function sanitiseName(name) {
    return name
        .replace(/\s+/g, '-')
        .replace(/[^a-zA-Z0-9._-]/g, '')
        .toLowerCase();
}

async function removeHeroPoster() {
    await deleteFromStorage(f.hero_poster_image);
    f.hero_poster_image = '';
}

async function uploadImage(e, fieldKey, uploadingKey) {
    const file = e.target.files?.[0];
    if (!file) return;
    uploading[uploadingKey] = true;
    uploadError.value = '';
    // Delete old image from storage before replacing
    if (f[fieldKey]) await deleteFromStorage(f[fieldKey]);
    const safe = sanitiseName(file.name);
    const path = `home/${Date.now()}-${safe}`;
    const { error } = await supabase.storage.from(BUCKET).upload(path, file, { upsert: true });
    if (error) {
        console.error('[upload hero]', error);
        uploadError.value = `Upload failed: ${error.message}`;
    } else {
        const { data: urlData } = supabase.storage.from(BUCKET).getPublicUrl(path);
        f[fieldKey] = urlData.publicUrl;
    }
    uploading[uploadingKey] = false;
    e.target.value = '';
}

// ── Upload multiple slideshow images ─────────────────────
async function uploadSlides(files) {
    if (!files?.length) return;
    uploading.slides = true;
    uploadError.value = '';
    slideUploadProgress.value = Array.from(files).map(f => ({ name: f.name, status: 'uploading' }));

    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const safe = sanitiseName(file.name);
        const path = `home/slides/${Date.now()}-${safe}`;
        const { error } = await supabase.storage.from(BUCKET).upload(path, file, { upsert: true });
        if (error) {
            console.error('[upload slide]', error);
            slideUploadProgress.value[i].status = 'error';
            slideUploadProgress.value[i].error = error.message;
        } else {
            const { data: urlData } = supabase.storage.from(BUCKET).getPublicUrl(path);
            slideImages.value.push(urlData.publicUrl);
            slideUploadProgress.value[i].status = 'done';
        }
    }

    uploading.slides = false;
    setTimeout(() => { slideUploadProgress.value = []; }, 4000);
}

// ── Save all fields + slide list ─────────────────────────
async function save() {
    saving.value = true;
    saveError.value = '';
    saveSuccess.value = false;

    const rows = [
        // all text fields
        ...Object.entries(f).map(([key, value]) => ({
            page: 'home', key, value: String(value),
        })),
        // slide images as JSON array
        { page: 'home', key: 'about_slides', value: JSON.stringify(slideImages.value) },
    ];

    const { error } = await supabase
        .from('page_content')
        .upsert(rows, { onConflict: 'page,key' });

    if (error) {
        saveError.value = error.message;
    } else {
        saveSuccess.value = true;
        setTimeout(() => saveSuccess.value = false, 3000);
    }
    saving.value = false;
}

onMounted(load);
</script>
