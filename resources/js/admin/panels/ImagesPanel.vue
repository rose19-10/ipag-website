<template>
    <div class="adm-panel">

        <div class="adm-panel-intro">
            <p class="adm-panel-intro__text">
                Upload images here to use them anywhere on the website — in productions, artist profiles, the home page, and more.
                After uploading, copy an image's link and paste it wherever you need it.
            </p>
        </div>

        <!-- Upload zone -->
        <div class="adm-images-upload">
            <label
                class="adm-upload-zone adm-upload-zone--large"
                :class="{ 'is-dragging': dragging }"
                @dragover.prevent="dragging = true"
                @dragleave="dragging = false"
                @drop.prevent="onDrop"
            >
                <span class="adm-upload-zone__icon">🖼️</span>
                <span class="adm-upload-zone__text">
                    {{ dragging ? 'Drop your images here!' : 'Drag images here, or click to browse your files' }}
                </span>
                <span class="adm-upload-zone__hint">Supports PNG, JPG, WebP — max 5MB per image. You can select multiple at once.</span>
                <input type="file" accept="image/*" multiple class="adm-upload-zone__input" @change="onFileSelect">
            </label>

            <!-- Upload progress -->
            <div v-if="uploadProgress.length" class="adm-upload-progress" style="margin-top:12px;">
                <div v-for="p in uploadProgress" :key="p.name" class="adm-upload-progress__item">
                    <span class="adm-upload-progress__name">{{ p.name }}</span>
                    <span class="adm-upload-progress__status" :class="p.status">
                        {{ p.status === 'uploading' ? '⏳ Uploading…' : p.status === 'done' ? '✅ Done' : '❌ Failed' }}
                    </span>
                </div>
            </div>
        </div>

        <!-- Library header -->
        <div class="adm-images-header">
            <h3>Your Image Library</h3>
            <button class="adm-btn adm-btn--sm" @click="load">↻ Refresh</button>
        </div>

        <div v-if="loading" class="adm-loading">
            <span class="adm-loading__spinner"></span> Loading images…
        </div>

        <div v-else-if="!images.length" class="adm-empty-state">
            <span class="adm-empty-state__icon">🖼️</span>
            <p>No images uploaded yet. Use the area above to upload your first image.</p>
        </div>

        <div v-else class="adm-image-grid">
            <div v-for="img in images" :key="img.id" class="adm-image-tile">
                <div class="adm-image-tile__img">
                    <img :src="img.public_url" :alt="img.alt_text || img.filename" loading="lazy">
                </div>
                <div class="adm-image-tile__info">
                    <span class="adm-image-tile__name" :title="img.filename">{{ img.filename }}</span>
                    <div class="adm-image-tile__actions">
                        <button class="adm-btn adm-btn--sm" @click="copyUrl(img)">
                            {{ copied === img.id ? '✅ Link copied!' : '🔗 Copy link' }}
                        </button>
                        <button class="adm-btn adm-btn--sm adm-btn--danger" @click="confirmDelete(img)">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Delete confirm -->
        <div v-if="deleting" class="adm-confirm-overlay" @click.self="deleting = null">
            <div class="adm-confirm">
                <div class="adm-confirm__icon">🗑️</div>
                <h3>Delete this image?</h3>
                <p>
                    <strong>{{ deleting.filename }}</strong> will be permanently removed from your image library.
                    Any page still using this image will show a broken image until you replace it.
                </p>
                <div class="adm-confirm__actions">
                    <button class="adm-btn adm-btn--danger" @click="doDelete">Yes, delete it</button>
                    <button class="adm-btn" @click="deleting = null">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { supabase } from '../../supabase';

const BUCKET = 'ipag-images';

const images         = ref([]);
const loading        = ref(true);
const dragging       = ref(false);
const uploadProgress = ref([]);
const deleting       = ref(null);
const copied         = ref(null);

function sanitise(name) {
    return name.replace(/\s+/g, '-').replace(/[^a-zA-Z0-9._-]/g, '').toLowerCase();
}

async function load() {
    loading.value = true;
    const { data } = await supabase
        .from('site_images')
        .select('*')
        .order('uploaded_at', { ascending: false });
    images.value = data || [];
    loading.value = false;
}

async function uploadFiles(files) {
    uploadProgress.value = Array.from(files).map(f => ({ name: f.name, status: 'uploading' }));
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const safe = sanitise(file.name);
        const path = `library/${Date.now()}-${safe}`;
        const { error } = await supabase.storage.from(BUCKET).upload(path, file, { upsert: true });
        if (error) { uploadProgress.value[i].status = 'error'; continue; }
        const { data: urlData } = supabase.storage.from(BUCKET).getPublicUrl(path);
        await supabase.from('site_images').insert({
            filename: file.name,
            storage_path: path,
            public_url: urlData.publicUrl,
        });
        uploadProgress.value[i].status = 'done';
    }
    await load();
    setTimeout(() => { uploadProgress.value = []; }, 4000);
}

function onFileSelect(e) { uploadFiles(e.target.files); }
function onDrop(e) { dragging.value = false; uploadFiles(e.dataTransfer.files); }

function confirmDelete(img) { deleting.value = img; }

async function doDelete() {
    await supabase.storage.from(BUCKET).remove([deleting.value.storage_path]);
    await supabase.from('site_images').delete().eq('id', deleting.value.id);
    deleting.value = null;
    await load();
}

async function copyUrl(img) {
    await navigator.clipboard.writeText(img.public_url);
    copied.value = img.id;
    setTimeout(() => { copied.value = null; }, 2500);
}

onMounted(load);
</script>
