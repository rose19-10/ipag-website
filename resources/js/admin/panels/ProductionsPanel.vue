<template>
    <div class="adm-panel">
        <!-- List -->
        <div v-if="!editing" class="adm-panel__list">
            <div class="adm-panel__toolbar">
                <button class="adm-btn adm-btn--primary" @click="startNew">+ New Production</button>
            </div>
            <div v-if="loading" class="adm-loading">Loading…</div>
            <div v-else-if="!rows.length" class="adm-empty">No productions yet.</div>
            <div v-else class="adm-table-wrap">
                <table class="adm-table">
                    <thead><tr><th>Image</th><th>Title</th><th>Path</th><th></th></tr></thead>
                    <tbody>
                        <tr v-for="row in rows" :key="row.id">
                            <td>
                                <div class="adm-table-thumb">
                                    <img v-if="row.image" :src="row.image" :alt="row.title">
                                    <span v-else class="adm-table-thumb__empty">—</span>
                                </div>
                            </td>
                            <td class="adm-table__title">{{ row.title }}</td>
                            <td><code>{{ row.path }}</code></td>
                            <td class="adm-table__actions">
                                <button class="adm-btn adm-btn--sm" @click="startEdit(row)">Edit</button>
                                <button class="adm-btn adm-btn--sm adm-btn--danger" @click="confirmDelete(row)">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Edit / New form -->
        <div v-else class="adm-panel__form">
            <div class="adm-panel__form-header">
                <button class="adm-back-btn" @click="editing = null">← Back</button>
                <h2>{{ editing.id ? 'Edit Production' : 'New Production' }}</h2>
            </div>

            <div class="adm-form-grid">
                <div class="adm-field adm-field--full">
                    <label>Title</label>
                    <input v-model="editing.title" type="text" placeholder="Production title">
                </div>
                <div class="adm-field">
                    <label>URL Path</label>
                    <input v-model="editing.path" type="text" placeholder="/production-slug">
                </div>
                <div class="adm-field">
                    <label>Sort Order</label>
                    <input v-model.number="editing.sort_order" type="number" min="0">
                </div>
                <div class="adm-field adm-field--full">
                    <label>Description (short)</label>
                    <input v-model="editing.description" type="text">
                </div>
                <div class="adm-field adm-field--full">
                    <label>About</label>
                    <textarea v-model="editing.about" rows="4"></textarea>
                </div>
                <div class="adm-field adm-field--full">
                    <label>History</label>
                    <textarea v-model="editing.history" rows="4"></textarea>
                </div>

                <!-- Main production image -->
                <div class="adm-field adm-field--full">
                    <label>Main Image</label>
                    <div class="adm-img-upload-row">
                        <div v-if="editing.image" class="adm-img-preview adm-img-preview--wide">
                            <img :src="editing.image" :alt="editing.title">
                            <button class="adm-img-preview__remove" type="button" @click="removeMainImage">✕</button>
                        </div>
                        <div v-else class="adm-img-preview adm-img-preview--wide adm-img-preview--empty">
                            <span>No image</span>
                        </div>
                        <label class="adm-upload-zone adm-upload-zone--inline" :class="{ 'is-uploading': mainImgUploading }">
                            <span>{{ mainImgUploading ? 'Uploading…' : editing.image ? '↻ Replace' : '+ Upload image' }}</span>
                            <span class="adm-field__hint">PNG, JPG, WebP</span>
                            <input type="file" accept="image/*" class="adm-upload-zone__input"
                                :disabled="mainImgUploading"
                                @change="uploadMainImage">
                        </label>
                    </div>
                    <div v-if="mainImgError" class="adm-error" style="margin-top:8px;">{{ mainImgError }}</div>
                </div>

                <!-- Facts -->
                <div class="adm-field adm-field--full">
                    <label>Facts <span class="adm-field__hint">(label / value pairs)</span></label>
                    <div v-for="(fact, i) in editing.facts" :key="i" class="adm-pair-row">
                        <input v-model="fact.label" placeholder="Label" type="text">
                        <input v-model="fact.value" placeholder="Value" type="text">
                        <button class="adm-remove-btn" type="button" @click="editing.facts.splice(i,1)">✕</button>
                    </div>
                    <button class="adm-add-btn" type="button" @click="editing.facts.push({ label:'', value:'' })">+ Add Fact</button>
                </div>

                <!-- Credits -->
                <div class="adm-field adm-field--full">
                    <label>Credits <span class="adm-field__hint">(role / name pairs)</span></label>
                    <div v-for="(credit, i) in editing.credits" :key="i" class="adm-pair-row">
                        <input v-model="credit.role" placeholder="Role" type="text">
                        <input v-model="credit.name" placeholder="Name" type="text">
                        <button class="adm-remove-btn" type="button" @click="editing.credits.splice(i,1)">✕</button>
                    </div>
                    <button class="adm-add-btn" type="button" @click="editing.credits.push({ role:'', name:'' })">+ Add Credit</button>
                </div>

                <!-- Videos -->
                <div class="adm-field adm-field--full">
                    <label>YouTube Videos <span class="adm-field__hint">(ID / title pairs)</span></label>
                    <div v-for="(video, i) in editing.videos" :key="i" class="adm-pair-row">
                        <input v-model="video.id" placeholder="YouTube ID (e.g. dQw4w9WgXcQ)" type="text">
                        <input v-model="video.title" placeholder="Title" type="text">
                        <button class="adm-remove-btn" type="button" @click="editing.videos.splice(i,1)">✕</button>
                    </div>
                    <button class="adm-add-btn" type="button" @click="editing.videos.push({ id:'', title:'' })">+ Add Video</button>
                </div>

                <!-- Reviews -->
                <div class="adm-field adm-field--full">
                    <label>Reviews</label>
                    <div v-for="(review, i) in editing.reviews" :key="i" class="adm-review-row">
                        <textarea v-model="review.quote" placeholder="Quote" rows="2"></textarea>
                        <input v-model="review.source" placeholder="Source / attribution" type="text">
                        <button class="adm-remove-btn" type="button" @click="editing.reviews.splice(i,1)">✕</button>
                    </div>
                    <button class="adm-add-btn" type="button" @click="editing.reviews.push({ quote:'', source:'' })">+ Add Review</button>
                </div>

                <!-- Gallery -->
                <div class="adm-field adm-field--full">
                    <label>Gallery Images</label>

                    <!-- Existing gallery thumbnails -->
                    <div v-if="editing.gallery && editing.gallery.length" class="adm-gallery-grid">
                        <div
                            v-for="(url, i) in editing.gallery"
                            :key="url"
                            class="adm-gallery-item"
                            draggable="true"
                            @dragstart="galleryDragStart(i)"
                            @dragover.prevent
                            @drop.prevent="galleryDrop(i)"
                        >
                            <img :src="url" :alt="`Gallery ${i+1}`">
                            <span class="adm-gallery-item__num">{{ i + 1 }}</span>
                            <button class="adm-img-preview__remove" type="button" @click="removeGalleryImage(i)">✕</button>
                        </div>
                    </div>
                    <p v-else class="adm-empty" style="margin:4px 0 10px;font-size:.82rem;">No gallery images yet.</p>

                    <!-- Upload more gallery images -->
                    <label class="adm-upload-zone adm-upload-zone--inline" :class="{ 'is-uploading': galleryUploading }">
                        <span>{{ galleryUploading ? 'Uploading…' : '+ Add gallery images' }}</span>
                        <span class="adm-field__hint">Select multiple — PNG, JPG, WebP</span>
                        <input type="file" accept="image/*" multiple class="adm-upload-zone__input"
                            :disabled="galleryUploading"
                            @change="uploadGalleryImages">
                    </label>

                    <!-- Gallery upload progress -->
                    <div v-if="galleryProgress.length" class="adm-upload-progress" style="margin-top:8px;">
                        <div v-for="p in galleryProgress" :key="p.name" class="adm-upload-progress__item">
                            <span>{{ p.name }}</span>
                            <span class="adm-upload-progress__status" :class="p.status">{{ p.status }}</span>
                        </div>
                    </div>
                    <div v-if="galleryError" class="adm-error" style="margin-top:8px;">{{ galleryError }}</div>
                </div>
            </div>

            <div v-if="saveError" class="adm-error">{{ saveError }}</div>
            <div class="adm-form-actions">
                <button class="adm-btn adm-btn--primary" :disabled="saving || mainImgUploading || galleryUploading" @click="save">
                    {{ saving ? 'Saving…' : 'Save Production' }}
                </button>
                <button class="adm-btn" @click="editing = null">Cancel</button>
            </div>
        </div>

        <!-- Delete confirm -->
        <div v-if="deleting" class="adm-confirm-overlay" @click.self="deleting = null">
            <div class="adm-confirm">
                <p>Delete <strong>{{ deleting.title }}</strong>? This cannot be undone.</p>
                <div class="adm-confirm__actions">
                    <button class="adm-btn adm-btn--danger" @click="doDelete">Delete</button>
                    <button class="adm-btn" @click="deleting = null">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { supabase } from '../../supabase';
import { deleteFromStorage, deleteManyFromStorage } from '../storageUtils';

const BUCKET = 'ipag-images';

const rows    = ref([]);
const loading = ref(true);
const editing = ref(null);
const deleting = ref(null);
const saving  = ref(false);
const saveError = ref('');

// Main image upload
const mainImgUploading = ref(false);
const mainImgError     = ref('');

// Gallery upload
const galleryUploading = ref(false);
const galleryProgress  = ref([]);
const galleryError     = ref('');

// Gallery drag-to-reorder
let galleryDragFrom = null;
function galleryDragStart(i) { galleryDragFrom = i; }
function galleryDrop(i) {
    if (galleryDragFrom === null || galleryDragFrom === i) return;
    const arr = [...editing.value.gallery];
    const [moved] = arr.splice(galleryDragFrom, 1);
    arr.splice(i, 0, moved);
    editing.value.gallery = arr;
    galleryDragFrom = null;
}

function sanitise(name) {
    return name.replace(/\s+/g, '-').replace(/[^a-zA-Z0-9._-]/g, '').toLowerCase();
}

// Upload main production image
async function uploadMainImage(e) {
    const file = e.target.files?.[0];
    if (!file) return;
    mainImgUploading.value = true;
    mainImgError.value = '';
    // Delete old image from storage before replacing
    if (editing.value.image) await deleteFromStorage(editing.value.image);
    const path = `productions/${Date.now()}-${sanitise(file.name)}`;
    const { error } = await supabase.storage.from(BUCKET).upload(path, file, { upsert: true });
    if (error) {
        mainImgError.value = `Upload failed: ${error.message}`;
    } else {
        const { data } = supabase.storage.from(BUCKET).getPublicUrl(path);
        editing.value.image = data.publicUrl;
    }
    mainImgUploading.value = false;
    e.target.value = '';
}

async function removeMainImage() {
    await deleteFromStorage(editing.value.image);
    editing.value.image = '';
}

// Upload gallery images
async function uploadGalleryImages(e) {
    const files = e.target.files;
    if (!files?.length) return;
    galleryUploading.value = true;
    galleryError.value = '';
    galleryProgress.value = Array.from(files).map(f => ({ name: f.name, status: 'uploading' }));

    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const path = `productions/gallery/${Date.now()}-${sanitise(file.name)}`;
        const { error } = await supabase.storage.from(BUCKET).upload(path, file, { upsert: true });
        if (error) {
            galleryProgress.value[i].status = 'error';
            galleryError.value = `Some uploads failed: ${error.message}`;
        } else {
            const { data } = supabase.storage.from(BUCKET).getPublicUrl(path);
            editing.value.gallery.push(data.publicUrl);
            galleryProgress.value[i].status = 'done';
        }
    }

    galleryUploading.value = false;
    e.target.value = '';
    setTimeout(() => { galleryProgress.value = []; }, 4000);
}

async function removeGalleryImage(i) {
    const url = editing.value.gallery[i];
    await deleteFromStorage(url);
    editing.value.gallery.splice(i, 1);
}

async function load() {
    loading.value = true;
    const { data } = await supabase.from('productions').select('*').order('sort_order');
    rows.value = data || [];
    loading.value = false;
}

function startNew() {
    editing.value = {
        title: '', path: '', image: '', description: '', about: '', history: '',
        facts: [], credits: [], videos: [], reviews: [], gallery: [],
        sort_order: rows.value.length,
    };
}

function startEdit(row) {
    const copy = JSON.parse(JSON.stringify(row));
    // Ensure arrays are always arrays (guard against null from DB)
    copy.facts    = copy.facts    || [];
    copy.credits  = copy.credits  || [];
    copy.videos   = copy.videos   || [];
    copy.reviews  = copy.reviews  || [];
    copy.gallery  = copy.gallery  || [];
    editing.value = copy;
}

function confirmDelete(row) { deleting.value = row; }

async function doDelete() {
    const prod = deleting.value;
    // Delete main image + all gallery images from storage
    const toDelete = [prod.image, ...(prod.gallery || [])].filter(Boolean);
    if (toDelete.length) await deleteManyFromStorage(toDelete);
    await supabase.from('productions').delete().eq('id', prod.id);
    deleting.value = null;
    await load();
}

async function save() {
    saving.value = true;
    saveError.value = '';
    const payload = { ...editing.value };
    const { error } = editing.value.id
        ? await supabase.from('productions').update(payload).eq('id', payload.id)
        : await supabase.from('productions').insert(payload);
    if (error) { saveError.value = error.message; }
    else { editing.value = null; await load(); }
    saving.value = false;
}

onMounted(load);
</script>
