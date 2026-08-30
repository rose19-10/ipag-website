<template>
    <div class="adm-panel">
        <div v-if="loading" class="adm-loading">
            <span class="adm-loading__spinner"></span> Loading director profile…
        </div>

        <div v-else class="adm-director-layout">

            <!-- Left: photo -->
            <aside class="adm-director-sidebar">
                <div class="adm-director-photo">
                    <img v-if="form.photo" :src="form.photo" :alt="form.name">
                    <div v-else class="adm-director-photo__placeholder">
                        <span>No photo yet</span>
                    </div>
                    <div class="adm-director-photo__actions">
                        <label class="adm-upload-zone adm-upload-zone--inline" :class="{ 'is-uploading': photoUploading }">
                            <span>{{ photoUploading ? 'Uploading…' : form.photo ? '↻ Replace photo' : '+ Upload photo' }}</span>
                            <input type="file" accept="image/*" class="adm-upload-zone__input"
                                :disabled="photoUploading" @change="uploadPhoto">
                        </label>
                        <button v-if="form.photo" class="adm-btn adm-btn--sm adm-btn--danger" style="margin-top:6px;" @click="removePhoto">Remove photo</button>
                    </div>
                    <div v-if="photoError" class="adm-error" style="margin-top:8px;font-size:.78rem;">{{ photoError }}</div>
                </div>

                <div class="adm-director-stats-card">
                    <p class="adm-director-stats-card__label">Numbers shown on the Director page</p>
                    <div class="adm-stat-row">
                        <div class="adm-stat-input">
                            <span class="adm-stat-input__icon">🎭</span>
                            <div>
                                <label>Total Productions</label>
                                <input v-model="form.stat_productions" type="text" placeholder="50+">
                            </div>
                        </div>
                        <div class="adm-stat-input">
                            <span class="adm-stat-input__icon">📚</span>
                            <div>
                                <label>Books Published</label>
                                <input v-model="form.stat_books" type="text" placeholder="6">
                            </div>
                        </div>
                        <div class="adm-stat-input">
                            <span class="adm-stat-input__icon">📅</span>
                            <div>
                                <label>Years with IPAG</label>
                                <input v-model="form.stat_years" type="text" placeholder="47">
                            </div>
                        </div>
                    </div>
                </div>
            </aside>

            <!-- Right: form -->
            <div class="adm-director-main">

                <div class="adm-info-card">
                    <h3 class="adm-info-card__title">Basic Information</h3>
                    <div class="adm-form-grid">
                        <div class="adm-field">
                            <label>Full Name</label>
                            <input v-model="form.name" type="text" placeholder="e.g. Steven P.C. Fernandez">
                        </div>
                        <div class="adm-field">
                            <label>Credentials / Role</label>
                            <input v-model="form.title" type="text" placeholder="e.g. DFA · Playwright · Composer">
                            <span class="adm-field__hint">Shown beneath the director's name on the page.</span>
                        </div>
                    </div>
                </div>

                <div class="adm-info-card">
                    <h3 class="adm-info-card__title">Biography</h3>
                    <p class="adm-info-card__desc">The biography appears in two columns on the Director page. Split the text however feels natural.</p>
                    <div class="adm-form-grid">
                        <div class="adm-field adm-field--full">
                            <label>First paragraph / column</label>
                            <textarea v-model="form.bio_col1" rows="6" placeholder="Write the first part of the biography here…"></textarea>
                        </div>
                        <div class="adm-field adm-field--full">
                            <label>Second paragraph / column</label>
                            <textarea v-model="form.bio_col2" rows="6" placeholder="Continue the biography here…"></textarea>
                        </div>
                    </div>
                </div>

                <div class="adm-info-card">
                    <h3 class="adm-info-card__title">Featured Quote</h3>
                    <p class="adm-info-card__desc">A highlighted quote from the director, displayed prominently on the page.</p>
                    <div class="adm-form-grid">
                        <div class="adm-field adm-field--full">
                            <label>Quote</label>
                            <textarea v-model="form.quote" rows="3" placeholder="e.g. The traditional is the contemporary…"></textarea>
                        </div>
                    </div>
                </div>

                <div class="adm-info-card">
                    <h3 class="adm-info-card__title">Awards &amp; Distinctions</h3>
                    <p class="adm-info-card__desc">Enter each award or honor on its own line. These appear as chips/badges on the page.</p>
                    <div class="adm-form-grid">
                        <div class="adm-field adm-field--full">
                            <label>List of distinctions <span class="adm-field__hint">— one per line</span></label>
                            <textarea v-model="distinctionsText" rows="10"
                                placeholder="CCP Gawad para sa Sining (2020)&#10;UMPIL Pambansang Alagad ni Balagtas (2014)&#10;Palanca Award — 1st Place, MingMing (2006)"></textarea>
                        </div>
                    </div>
                </div>

                <div v-if="saveError" class="adm-error">{{ saveError }}</div>
                <div v-if="saveSuccess" class="adm-success">Director profile saved successfully.</div>

                <div class="adm-form-actions">
                    <button class="adm-btn adm-btn--primary adm-btn--lg" :disabled="saving || photoUploading" @click="save">
                        {{ saving ? 'Saving…' : 'Save Director Profile' }}
                    </button>
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

const form = ref({
    name: '', title: '', photo: '', bio_col1: '', bio_col2: '',
    quote: '', stat_productions: '50+', stat_books: '6', stat_years: '47',
    distinctions: [],
});
const loading     = ref(true);
const saving      = ref(false);
const saveError   = ref('');
const saveSuccess = ref(false);
const photoUploading = ref(false);
const photoError     = ref('');
let recordId = null;

const distinctionsText = computed({
    get: () => (form.value.distinctions || []).join('\n'),
    set: val => { form.value.distinctions = val.split('\n').map(s => s.trim()).filter(Boolean); },
});

function sanitise(name) {
    return name.replace(/\s+/g, '-').replace(/[^a-zA-Z0-9._-]/g, '').toLowerCase();
}

async function uploadPhoto(e) {
    const file = e.target.files?.[0];
    if (!file) return;
    photoUploading.value = true;
    photoError.value = '';
    if (form.value.photo) await deleteFromStorage(form.value.photo);
    const path = `director/${Date.now()}-${sanitise(file.name)}`;
    const { error } = await supabase.storage.from(BUCKET).upload(path, file, { upsert: true });
    if (error) { photoError.value = `Upload failed: ${error.message}`; }
    else {
        const { data } = supabase.storage.from(BUCKET).getPublicUrl(path);
        form.value.photo = data.publicUrl;
    }
    photoUploading.value = false;
    e.target.value = '';
}

async function removePhoto() {
    await deleteFromStorage(form.value.photo);
    form.value.photo = '';
}

async function load() {
    loading.value = true;
    const { data } = await supabase.from('director').select('*').limit(1).single();
    if (data) { recordId = data.id; form.value = { ...data }; }
    loading.value = false;
}

async function save() {
    saving.value = true;
    saveError.value = '';
    saveSuccess.value = false;
    const payload = { ...form.value };
    const { error } = recordId
        ? await supabase.from('director').update(payload).eq('id', recordId)
        : await supabase.from('director').insert(payload);
    if (error) { saveError.value = error.message; }
    else { saveSuccess.value = true; await load(); setTimeout(() => saveSuccess.value = false, 3000); }
    saving.value = false;
}

onMounted(load);
</script>
