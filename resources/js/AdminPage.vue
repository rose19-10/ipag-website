<template>
    <div>
        <div v-if="!user" class="admin-auth-guard">
            <p>You must be signed in to access the admin area.</p>
            <button class="adm-btn adm-btn--primary" @click="$emit('navigate', '/')">Back to Site</button>
        </div>
        <AdminLayout v-else @navigate="$emit('navigate', $event)" />
    </div>
</template>

<script setup>
import { useAuth } from './useAuth';
import AdminLayout from './admin/AdminLayout.vue';

defineEmits(['navigate']);
const { user } = useAuth();
</script>
