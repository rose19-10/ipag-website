<template>
    <div class="adm-panel">

        <!-- List view -->
        <div v-if="!editing" class="adm-panel__list">
            <div class="adm-panel__toolbar">
                <button class="adm-btn adm-btn--primary" @click="startNew">
                    + Add {{ entryLabel }}
                </button>
            </div>

            <div v-if="loading" class="adm-loading">
                <span class="adm-loading__spinner"></span> Loading…
            </div>
            <div v-else-if="!rows.length" class="adm-empty-state">
                <span class="adm-empty-state__icon">📋</span>
                <p>No entries yet. Click <strong>"+ Add {{ entryLabel }}"</strong> to get started.</p>
            </div>
            <div v-else class="adm-list-cards">
                <div v-for="row in rows" :key="row.id" class="adm-list-card">
                    <div class="adm-list-card__content">
                        <span v-if="row[cols[0]]" class="adm-list-card__tag">{{ row[cols[0]] }}</span>
                        <span class="adm-list-card__title">{{ row[cols[1]] || row[cols[0]] }}</span>
                        <span v-if="cols[2] && row[cols[2]]" class="adm-list-card__sub">{{ row[cols[2]] }}</span>
                    </div>
                    <div class="adm-list-card__actions">
                        <button class="adm-btn adm-btn--sm" @click="startEdit(row)">Edit</button>
                        <button class="adm-btn adm-btn--sm adm-btn--danger" @click="confirmDelete(row)">Remove</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit / New form -->
        <div v-else class="adm-panel__form">
            <div class="adm-panel__form-header">
                <button class="adm-back-btn" @click="editing = null">← Back to list</button>
                <h2>{{ editing.id ? `Edit ${entryLabel}` : `New ${entryLabel}` }}</h2>
            </div>

            <div class="adm-info-card">
                <div class="adm-form-grid">
                    <div
                        v-for="field in fields"
                        :key="field.key"
                        class="adm-field"
                        :class="{ 'adm-field--full': field.full }"
                    >
                        <label>{{ field.label }}</label>
                        <span v-if="field.hint" class="adm-field__hint">{{ field.hint }}</span>
                        <textarea
                            v-if="field.type === 'textarea'"
                            v-model="editing[field.key]"
                            :rows="field.rows || 3"
                            :placeholder="field.placeholder || ''"
                        ></textarea>
                        <input
                            v-else
                            v-model="editing[field.key]"
                            :type="field.type || 'text'"
                            :placeholder="field.placeholder || ''"
                        >
                    </div>
                </div>
            </div>

            <div v-if="saveError" class="adm-error">{{ saveError }}</div>
            <div class="adm-form-actions">
                <button class="adm-btn adm-btn--primary" :disabled="saving" @click="save">
                    {{ saving ? 'Saving…' : `Save ${entryLabel}` }}
                </button>
                <button class="adm-btn" @click="editing = null">Cancel</button>
            </div>
        </div>

        <!-- Delete confirm -->
        <div v-if="deleting" class="adm-confirm-overlay" @click.self="deleting = null">
            <div class="adm-confirm">
                <div class="adm-confirm__icon">🗑️</div>
                <h3>Remove this entry?</h3>
                <p>This will permanently delete the entry. This action cannot be undone.</p>
                <div class="adm-confirm__actions">
                    <button class="adm-btn adm-btn--danger" @click="doDelete">Yes, remove it</button>
                    <button class="adm-btn" @click="deleting = null">Keep it</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { supabase } from '../../supabase';

const props = defineProps({
    table:      { type: String, required: true },
    fields:     { type: Array,  required: true },
    cols:       { type: Array,  required: true },
    entryLabel: { type: String, default: 'Entry' },
    orderBy:    { type: String, default: 'sort_order' },
    orderDesc:  { type: Boolean, default: false },
});

const rows     = ref([]);
const loading  = ref(true);
const editing  = ref(null);
const deleting = ref(null);
const saving   = ref(false);
const saveError = ref('');

async function load() {
    loading.value = true;
    const { data } = await supabase
        .from(props.table)
        .select('*')
        .order(props.orderBy, { ascending: !props.orderDesc });

    let result = data || [];

    // If ordering by year, sort client-side so numeric years sort correctly
    // (years are stored as text, e.g. "1992", "2012–2018", "—")
    if (props.orderBy === 'year') {
        result = [...result].sort((a, b) => {
            const ya = parseYear(a.year);
            const yb = parseYear(b.year);
            return props.orderDesc ? yb - ya : ya - yb;
        });
    }

    rows.value = result;
    loading.value = false;
}

// Extract a sortable number from year strings like "1992", "2012–2018", "—"
function parseYear(val) {
    if (!val) return props.orderDesc ? -Infinity : Infinity;
    const match = String(val).match(/\d{4}/);
    return match ? parseInt(match[0], 10) : (props.orderDesc ? -Infinity : Infinity);
}

function startNew() {
    const blank = { sort_order: rows.value.length };
    props.fields.forEach(f => { blank[f.key] = ''; });
    editing.value = blank;
}

function startEdit(row) { editing.value = JSON.parse(JSON.stringify(row)); }
function confirmDelete(row) { deleting.value = row; }

async function doDelete() {
    await supabase.from(props.table).delete().eq('id', deleting.value.id);
    deleting.value = null;
    await load();
}

async function save() {
    saving.value = true;
    saveError.value = '';
    const payload = { ...editing.value };
    const { error } = editing.value.id
        ? await supabase.from(props.table).update(payload).eq('id', payload.id)
        : await supabase.from(props.table).insert(payload);
    if (error) { saveError.value = error.message; }
    else { editing.value = null; await load(); }
    saving.value = false;
}

onMounted(load);
</script>
