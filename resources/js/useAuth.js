import { ref, readonly } from 'vue';
import { supabase } from './supabase';

const user = ref(null);
const loading = ref(true);

// Initialise — restore session from localStorage if one exists
supabase.auth.getSession().then(({ data }) => {
    user.value = data.session?.user ?? null;
    loading.value = false;
});

// Keep user in sync with Supabase auth state changes
supabase.auth.onAuthStateChange((_event, session) => {
    user.value = session?.user ?? null;
});

export function useAuth() {
    async function signIn(email, password) {
        const { data, error } = await supabase.auth.signInWithPassword({ email, password });
        if (error) throw error;
        return data;
    }

    async function signOut() {
        const { error } = await supabase.auth.signOut();
        if (error) throw error;
    }

    return {
        user: readonly(user),
        loading: readonly(loading),
        signIn,
        signOut,
    };
}
