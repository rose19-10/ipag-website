<template>
    <div class="ct-root">

        <header class="ct-hero">
            <div class="ct-hero__inner">
                <p class="ct-kicker">IPAG — Integrated Performing Arts Guild · Philippines</p>
                <span class="ct-rule"></span>
                <h1 class="ct-hero__title">Contact Us</h1>
                <p class="ct-hero__sub">Reach out for bookings, collaborations, media inquiries, or general information about IPAG.</p>
            </div>
        </header>

        <div class="ct-body">

            <div class="ct-layout">

                <!-- Contact form -->
                <section class="ct-form-wrap">
                    <div class="ct-section-head">
                        <span class="ct-section-head__num">01</span>
                        <h2>Send a Message</h2>
                        <span class="ct-section-head__line"></span>
                    </div>

                    <form class="ct-form" @submit.prevent="sendEmail">
                        <div class="ct-form__row">
                            <div class="ct-field">
                                <label class="ct-field__label" for="ct-name">Your Name</label>
                                <input id="ct-name" v-model="form.name" class="ct-field__input" type="text" placeholder="Juan dela Cruz" required>
                            </div>
                            <div class="ct-field">
                                <label class="ct-field__label" for="ct-email">Email Address</label>
                                <input id="ct-email" v-model="form.email" class="ct-field__input" type="email" placeholder="you@example.com" required>
                            </div>
                        </div>
                        <div class="ct-field">
                            <label class="ct-field__label" for="ct-subject">Subject</label>
                            <select id="ct-subject" v-model="form.subject" class="ct-field__input ct-field__select">
                                <option value="">Select a topic</option>
                                <option>Booking Inquiry</option>
                                <option>International Tour</option>
                                <option>Workshop Request</option>
                                <option>Media / Press</option>
                                <option>General Inquiry</option>
                            </select>
                        </div>
                        <div class="ct-field">
                            <label class="ct-field__label" for="ct-message">Message</label>
                            <textarea id="ct-message" v-model="form.message" class="ct-field__input ct-field__textarea" rows="6" placeholder="Tell us about your event, venue, and dates..." required></textarea>
                        </div>
                        <div v-if="sent" class="ct-form__success">
                            Your message has been sent. We'll get back to you soon.
                        </div>
                        <button class="ct-form__submit tfm-btn tfm-btn--primary" type="submit" :disabled="sending">
                            {{ sending ? 'Sending…' : 'Send Message' }}
                        </button>
                    </form>
                </section>

                <!-- Info sidebar -->
                <aside class="ct-info">
                    <div class="ct-section-head">
                        <span class="ct-section-head__num">02</span>
                        <h2>Contact Info</h2>
                        <span class="ct-section-head__line"></span>
                    </div>

                    <div class="ct-info-cards">
                        <div class="ct-info-card">
                            <span class="ct-info-card__label">Address</span>
                            <p class="ct-info-card__value">IPAG Center, Ramiro St., Ilaya<br>Poblacion, Iligan City<br>Philippines</p>
                        </div>
                        <div class="ct-info-card">
                            <span class="ct-info-card__label">General Inquiries</span>
                            <a class="ct-info-card__value ct-info-card__link" href="mailto:ipagarts@gmail.com">ipagarts@gmail.com</a>
                            <a class="ct-info-card__value ct-info-card__link" href="tel:+639171362275">(+63) 917 136 2275</a>
                        </div>
                        <div class="ct-info-card">
                            <span class="ct-info-card__label">International Bookings</span>
                            <p class="ct-info-card__value">Stanley Perry C. Fernandez</p>
                            <a class="ct-info-card__value ct-info-card__link" href="mailto:fernandezstanleyperry@gmail.com">fernandezstanleyperry@gmail.com</a>
                            <a class="ct-info-card__value ct-info-card__link" href="tel:+639770314669">(+63) 977 031 4669</a>
                        </div>
                        <div class="ct-info-card">
                            <span class="ct-info-card__label">Local Bookings</span>
                            <p class="ct-info-card__value">Arlem M. Abanes</p>
                            <a class="ct-info-card__value ct-info-card__link" href="mailto:ipagarts@gmail.com">ipagarts@gmail.com</a>
                            <a class="ct-info-card__value ct-info-card__link" href="tel:2295178">229-5178</a>
                        </div>
                    </div>
                </aside>

            </div>

        </div>

    </div>
</template>

<script setup>
import { ref } from 'vue';

const form = ref({ name: '', email: '', subject: '', message: '' });
const sending = ref(false);
const sent = ref(false);

function sendEmail() {
    sending.value = true;
    const subject = encodeURIComponent(form.value.subject || 'Message from IPAG Website');
    const body = encodeURIComponent(
        `Name: ${form.value.name}\nEmail: ${form.value.email}\n\n${form.value.message}`
    );
    window.location.href = `mailto:ipagarts@gmail.com?subject=${subject}&body=${body}`;
    setTimeout(() => {
        sending.value = false;
        sent.value = true;
        form.value = { name: '', email: '', subject: '', message: '' };
    }, 1000);
}
</script>
