import { onMounted, ref } from 'vue';
import { supabase } from './supabase';

// Generic fetch hook
export function useTable(table, options = {}) {
    const data = ref([]);
    const loading = ref(true);
    const error = ref(null);

    async function load() {
        loading.value = true;
        let query = supabase.from(table).select('*');
        if (options.order) query = query.order(options.order, { ascending: options.ascending ?? true });
        if (options.filter) query = query.eq(options.filter.col, options.filter.val);
        const { data: rows, error: err } = await query;
        data.value = rows || [];
        error.value = err;
        loading.value = false;
    }

    onMounted(load);
    return { data, loading, error, reload: load };
}

// Fetch a single row (e.g. director)
export function useSingle(table) {
    const data = ref(null);
    const loading = ref(true);

    async function load() {
        loading.value = true;
        const { data: row } = await supabase.from(table).select('*').limit(1).single();
        data.value = row;
        loading.value = false;
    }

    onMounted(load);
    return { data, loading, reload: load };
}
