<template>
    <div class="adm-panel">
        <!-- List -->
        <div v-if="!editing" class="adm-panel__list">
            <div class="adm-panel__toolbar">
                <div class="adm-tab-group">
                    <button class="adm-tab" :class="{ 'is-active': tab === 'resident' }" @click="tab = 'resident'">Resident Artists</button>
                    <button class="adm-tab" :class="{ 'is-active': tab === 'apprentice' }" @click="tab = 'apprentice'">Apprentices</button>
                </div>
                <button class="adm-btn adm-btn--primary" @click="startNew">+ New Artist</button>
            </div>

            <div v-if="loading" class="adm-loading">Loading…</div>
            <div v-else-if="!filtered.length" class="adm-empty">No {{ tab === 'resident' ? 'resident artists' : 'apprentices' }} yet.</div>
            <div v-else class="adm-cards-grid">
                <div v-for="row in filtered" :key="row.id" class="adm-artist-card">
                    <div class="adm-artist-card__photo">
                        <img v-if="row.photo" :src="row.photo" :alt="row.name">
                        <div v-else class="adm-artist-card__placeholder">{{ initials(row.name) }}</div>
                    </div>
                    <div class="adm-artist-card__body">
                        <span class="adm-artist-card__role">{{ row.role }}</span>
                        <h3 class="adm-artist-card__name">{{ row.name }}</h3>
                        <p v-if="row.note" class="adm-artist-card__note">{{ row.note }}</p>
                        <div class="adm-artist-card__actions">
                            <button class="adm-btn adm-btn--sm" @click="startEdit(row)">Edit</button>
                            <button class="adm-btn adm-btn--sm adm-btn--danger" @click="confirmDelete(row)">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit / New form -->
        <div v-else class="adm-panel__form">
            <div class="adm-panel__form-header">
                <button class="adm-back-btn" @click="editing = null">← Back</button>
                <h2>{{ editing.id ? 'Edit Artist' : 'New Artist' }}</h2>
            </div>

            <div class="adm-form-grid">
                <div class="adm-field">
                    <label>Full Name</label>
                    <input v-model="editing.name" type="text" placeholder="Artist name">
                </div>
                <div class="adm-field">
                    <label>Role / Specialization</label>
                    <input v-model="editing.role" type="text" placeholder="e.g. Choreographer / Senior Artist">
                </div>
                <div class="adm-field adm-field--full">
                    <label>Bio / Note</label>
                    <textarea v-model="editing.note" rows="3" placeholder="Productions, contributions, etc."></textarea>
                </div>

                <!-- Photo upload -->
                <div class="adm-field adm-field--full">
                    <label>Photo</label>
                    <div class="adm-img-upload-row">
                        <!-- Preview -->
                        <div v-if="editing.photo" class="adm-img-preview adm-img-preview--square">
                            <img :src="editing.photo" :alt="editing.name">
                            <button class="adm-img-preview__remove" type="button" @click="editing.photo = ''">✕</button>
                        </div>
                        <div v-else class="adm-img-preview adm-img-preview--square adm-img-preview--empty">
                            <span>{{ initials(editing.name) || '?' }}</span>
                        </div>
                        <!-- Upload button -->
                        <label class="adm-upload-zone adm-upload-zone--inline" :class="{ 'is-uploading': photoUploading }">
                            <span>{{ photoUploading ? 'Uploading…' : editing.photo ? '↻ Replace photo' : '+ Upload photo' }}</span>
                            <span class="adm-field__hint">PNG, JPG, WebP</span>
                            <input type="file" accept="image/*" class="adm-upload-zone__input"
                                :disabled="photoUploading"
                                @change="uploadPhoto">
                        </label>
                    </div>
                    <!-- separate remove button so it's clear what it does -->
                    <div v-if="editing.photo" style="margin-top:6px;">
                        <button class="adm-btn adm-btn--sm adm-btn--danger" type="button" @click="removePhoto">
                            Remove photo
                        </button>
                    </div>
                    <div v-if="photoError" class="adm-error" style="margin-top:8px;">{{ photoError }}</div>
                </div>

                <div class="adm-field">
                    <label>Type</label>
                    <select v-model="editing.type">
                        <option value="resident">Resident Artist</option>
                        <option value="apprentice">Apprentice</option>
                    </select>
                </div>
                <div class="adm-field">
                    <label>Sort Order</label>
                    <input v-model.number="editing.sort_order" type="number" min="0">
                </div>
            </div>

            <div v-if="saveError" class="adm-error">{{ saveError }}</div>
            <div class="adm-form-actions">
                <button class="adm-btn adm-btn--primary" :disabled="saving || photoUploading" @click="save">
                    {{ saving ? 'Saving…' : 'Save Artist' }}
                </button>
                <button class="adm-btn" @click="editing = null">Cancel</button>
            </div>
        </div>

        <!-- Delete confirm -->
        <div v-if="deleting" class="adm-confirm-overlay" @click.self="deleting = null">
            <div class="adm-confirm">
                <p>Delete <strong>{{ deleting.name }}</strong>? This cannot be undone.</p>
                <div class="adm-confirm__actions">
                    <button class="adm-btn adm-btn--danger" @click="doDelete">Delete</button>
                    <button class="adm-btn" @click="deleting = null">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { supabase } from '../../supabase';
import { deleteFromStorage } from '../storageUtils';

const BUCKET = 'ipag-images';

const rows    = ref([]);
const loading = ref(true);
const editing = ref(null);
const deleting = ref(null);
const saving  = ref(false);
const saveError = ref('');
const tab = ref('resident');

const photoUploading = ref(false);
const photoError     = ref('');

const filtered = computed(() => rows.value.filter(r => r.type === tab.value));

function initials(name) {
    return (name || '?').split(' ').filter(w => w.length > 1).slice(0, 2).map(w => w[0]).join('');
}

function sanitise(name) {
    return name.replace(/\s+/g, '-').replace(/[^a-zA-Z0-9._-]/g, '').toLowerCase();
}

async function uploadPhoto(e) {
    const file = e.target.files?.[0];
    if (!file) return;
    photoUploading.value = true;
    photoError.value = '';
    // If replacing an existing photo, delete the old one from storage first
    if (editing.value.photo) await deleteFromStorage(editing.value.photo);
    const path = `artists/${Date.now()}-${sanitise(file.name)}`;
    const { error } = await supabase.storage.from(BUCKET).upload(path, file, { upsert: true });
    if (error) {
        photoError.value = `Upload failed: ${error.message}`;
    } else {
        const { data } = supabase.storage.from(BUCKET).getPublicUrl(path);
        editing.value.photo = data.publicUrl;
    }
    photoUploading.value = false;
    e.target.value = '';
}

async function removePhoto() {
    await deleteFromStorage(editing.value.photo);
    editing.value.photo = '';
}

async function load() {
    loading.value = true;
    const { data } = await supabase.from('artists').select('*').order('sort_order');
    rows.value = data || [];
    loading.value = false;
}

function startNew() {
    editing.value = { name: '', role: '', note: '', photo: '', type: tab.value, sort_order: 0, active: true };
}
function startEdit(row) { editing.value = JSON.parse(JSON.stringify(row)); }
function confirmDelete(row) { deleting.value = row; }

async function doDelete() {
    await supabase.from('artists').delete().eq('id', deleting.value.id);
    deleting.value = null;
    await load();
}

async function save() {
    saving.value = true;
    saveError.value = '';
    const payload = { ...editing.value };
    const { error } = editing.value.id
        ? await supabase.from('artists').update(payload).eq('id', payload.id)
        : await supabase.from('artists').insert(payload);
    if (error) { saveError.value = error.message; }
    else { editing.value = null; await load(); }
    saving.value = false;
}

onMounted(load);
</script>
