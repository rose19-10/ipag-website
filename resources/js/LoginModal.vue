<template>
    <Teleport to="body">
        <Transition name="login-fade">
            <div v-if="open" class="login-backdrop" @click.self="$emit('close')"></div>
        </Transition>
        <Transition name="login-slide">
            <div v-if="open" class="login-panel" role="dialog" aria-modal="true" aria-labelledby="login-title">

                <div class="login-panel__top">
                    <div class="login-panel__brand">
                        <img :src="'/images/ipag-logo.png'" alt="IPAG">
                        <div>
                            <span class="login-panel__guild">IPAG</span>
                            <span class="login-panel__guild-sub">Member Portal</span>
                        </div>
                    </div>
                    <button class="login-panel__close" type="button" aria-label="Close" @click="$emit('close')">✕</button>
                </div>

                <!-- Signed out — show form -->
                <template v-if="!user">
                    <div class="login-panel__hero">
                        <h2 id="login-title" class="login-panel__title">Welcome<br>Back</h2>
                        <p class="login-panel__sub">Sign in to access the IPAG admin area.</p>
                    </div>

                    <form class="login-panel__form" @submit.prevent="handleLogin">
                        <div class="login-field">
                            <label class="login-field__label" for="login-email">Email</label>
                            <input
                                id="login-email"
                                v-model="email"
                                class="login-field__input"
                                type="email"
                                placeholder="admin@ipagarts.com"
                                autocomplete="email"
                                required
                            >
                        </div>
                        <div class="login-field">
                            <label class="login-field__label" for="login-password">Password</label>
                            <div class="login-field__row">
                                <input
                                    id="login-password"
                                    v-model="password"
                                    class="login-field__input"
                                    :type="showPassword ? 'text' : 'password'"
                                    placeholder="••••••••"
                                    autocomplete="current-password"
                                    required
                                >
                                <button class="login-field__toggle" type="button" @click="showPassword = !showPassword">
                                    {{ showPassword ? 'Hide' : 'Show' }}
                                </button>
                            </div>
                        </div>

                        <Transition name="login-err">
                            <div v-if="error" class="login-panel__error">{{ error }}</div>
                        </Transition>

                        <button class="login-panel__submit" type="submit" :disabled="loading">
                            <span v-if="loading" class="login-panel__spinner"></span>
                            {{ loading ? 'Signing in…' : 'Sign In' }}
                        </button>
                    </form>
                </template>

                <!-- Signed in — show user info -->
                <template v-else>
                    <div class="login-panel__hero login-panel__hero--signed-in">
                        <div class="login-panel__signed-in-avatar">{{ userInitial }}</div>
                        <h2 class="login-panel__title login-panel__title--sm">Signed in</h2>
                        <p class="login-panel__signed-in-email">{{ user.email }}</p>
                    </div>
                    <div class="login-panel__form">
                        <a class="login-panel__admin-link tfm-btn tfm-btn--primary" href="/admin" @click.prevent="goAdmin">
                            Go to Admin Dashboard
                        </a>
                        <button class="login-panel__signout" type="button" @click="handleSignOut">
                            Sign Out
                        </button>
                    </div>
                </template>

            </div>
        </Transition>
    </Teleport>
</template>

<script setup>
import { computed, ref } from 'vue';
import { useAuth } from './useAuth';

const props = defineProps({ open: { type: Boolean, default: false } });
const emit = defineEmits(['close', 'navigate']);

const { user, signIn, signOut } = useAuth();

const email = ref('');
const password = ref('');
const showPassword = ref(false);
const loading = ref(false);
const error = ref('');

const userInitial = computed(() => user.value?.email?.[0]?.toUpperCase() ?? '?');

async function handleLogin() {
    loading.value = true;
    error.value = '';
    try {
        await signIn(email.value, password.value);
        password.value = '';
        emit('close');
        emit('navigate', '/admin');
    } catch (err) {
        error.value = err.message ?? 'Sign in failed. Please check your credentials.';
    } finally {
        loading.value = false;
    }
}

async function handleSignOut() {
    await signOut();
    emit('close');
}

function goAdmin() {
    emit('close');
    emit('navigate', '/admin');
}
</script>
