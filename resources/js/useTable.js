import { onMounted, ref } from 'vue';
import { supabase } from './supabase';

/**
 * useTable — fetch all rows from a Supabase table, ordered by sort_order.
 *
 * @param {string} table  - Supabase table name
 * @param {object} [opts]
 * @param {string} [opts.orderBy='sort_order']  - column to order by
 * @param {boolean} [opts.ascending=true]
 * @param {string} [opts.select='*']
 */
export function useTable(table, opts = {}) {
    const {
        orderBy = 'sort_order',
        ascending = true,
        select = '*',
    } = opts;

    const rows = ref([]);
    const loading = ref(true);
    const error = ref(null);

    async function load() {
        loading.value = true;
        error.value = null;
        const { data, error: err } = await supabase
            .from(table)
            .select(select)
            .order(orderBy, { ascending });
        if (err) {
            error.value = err.message;
            console.error(`[useTable] ${table}:`, err);
        }
        rows.value = data ?? [];
        loading.value = false;
    }

    onMounted(load);

    return { rows, loading, error, load };
}

/**
 * useSingle — fetch a single row from a Supabase table.
 *
 * @param {string} table
 * @param {object} [opts]
 * @param {string} [opts.select='*']
 */
export function useSingle(table, opts = {}) {
    const { select = '*' } = opts;

    const row = ref(null);
    const loading = ref(true);
    const error = ref(null);

    async function load() {
        loading.value = true;
        error.value = null;
        const { data, error: err } = await supabase
            .from(table)
            .select(select)
            .limit(1)
            .single();
        if (err && err.code !== 'PGRST116') {
            error.value = err.message;
            console.error(`[useSingle] ${table}:`, err);
        }
        row.value = data ?? null;
        loading.value = false;
    }

    onMounted(load);

    return { row, loading, error, load };
}
