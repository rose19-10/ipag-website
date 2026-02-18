@extends('layouts.app')

@section('title', 'Tales from Mindanao — IPAG')

@section('content')
<div class="tfm-root">

    {{-- ═══════════ HERO ═══════════ --}}
    <header
        class="tfm-hero"
        style="background-image: url('{{ asset('images/productions/tfm/hero.jpg') }}');"
    >
        <div class="tfm-hero__inner">
            <p class="tfm-hero__kicker">IPAG — Integrated Performing Arts Guild · Philippines</p>
            <span class="tfm-hero__rule"></span>
            <h1 class="tfm-hero__title">Tales from<br><em>Mindanao</em></h1>
            <p class="tfm-hero__subtitle">
                A highly-acclaimed international touring repertoire of dance-music stories
                about Mindanao and its people.
            </p>
            <div class="tfm-hero__actions">
                <a href="#gallery" class="tfm-btn tfm-btn--primary">View Gallery</a>
                <a href="#watch"   class="tfm-btn tfm-btn--ghost">Watch Video</a>
            </div>
        </div>
    </header>

    {{-- ═══════════ INFO STRIP ═══════════ --}}
    <div class="tfm-strip">
        <div class="tfm-strip__item">
            <span class="tfm-strip__label">Type</span>
            <span class="tfm-strip__value">Dance-Music Stories / Vignettes</span>
        </div>
        <div class="tfm-strip__item">
            <span class="tfm-strip__label">Origin</span>
            <span class="tfm-strip__value">Mindanao, Philippines</span>
        </div>
        <div class="tfm-strip__item">
            <span class="tfm-strip__label">Premiered</span>
            <span class="tfm-strip__value">1992 — CCP National Theatre Festival</span>
        </div>
        <div class="tfm-strip__item">
            <span class="tfm-strip__label">International Premiere</span>
            <span class="tfm-strip__value">1994 — Singapore Festival of the Arts</span>
        </div>
    </div>

    {{-- ═══════════ MAIN BODY ═══════════ --}}
    <main class="tfm-main">

        {{-- ── 01 OVERVIEW ── --}}
        <section aria-labelledby="overview-title" data-reveal>
            <div class="tfm-section-head">
                <span class="tfm-section-head__num">01</span>
                <h2 id="overview-title">About the Production</h2>
                <span class="tfm-section-head__line"></span>
            </div>

            <div class="tfm-overview">
                <div>
                    <p class="tfm-lead">
                        <strong>Tales from Mindanao</strong> is a celebrated international touring repertoire of
                        dance-music stories about Mindanao and its people — performed in extensive road shows
                        representing the Philippines in world festivals since its premiere at the Cultural Center
                        of the Philippines.
                    </p>
                    <p class="tfm-lead">
                        A series of dance-music vignettes pooled from the rich indigenous and folk cultural
                        resources of the Philippines' southernmost island, this suite is perhaps the Philippines'
                        most-traveled repertory production.
                    </p>
                </div>
                <aside class="tfm-sidebar">
                    <div class="tfm-box">
                        <h3>Programming Note</h3>
                        <p>Ideal for cultural festivals, touring circuits, educational showcases, and community events.</p>
                    </div>
                    <div class="tfm-box">
                        <h3>Audience Experience</h3>
                        <p>Storytelling through dance and live folk-inspired music — visceral, athletic, poetic.</p>
                    </div>
                </aside>
            </div>
        </section>

        {{-- ── 02 HISTORY ── --}}
        <section class="tfm-history" aria-labelledby="history-title" data-reveal>
            <div class="tfm-section-head">
                <span class="tfm-section-head__num">02</span>
                <h2 id="history-title">History</h2>
                <span class="tfm-section-head__line"></span>
            </div>

            <p class="tfm-lead">
                It premiered as <em>Life, Love and Death: Tales From Mindanao</em> at the 1992 1st CCP National
                Theatre Festival. Since its first appearance and subsequent international premiere at the 1994
                Singapore Festival of the Arts, <strong>Tales</strong> has enthralled thousands worldwide across
                countless stages and cultures.
            </p>
        </section>

        {{-- ── 03 CREDITS ── --}}
        <section aria-labelledby="credits-title" data-reveal>
            <div class="tfm-section-head">
                <span class="tfm-section-head__num">03</span>
                <h2 id="credits-title">Credits</h2>
                <span class="tfm-section-head__line"></span>
            </div>

            <div class="tfm-credits-grid">
                <div class="tfm-credit">
                    <span class="tfm-credit__role">Choreography</span>
                    <span class="tfm-credit__name">Nolly Ceballos &amp; the IPAG Creative Collective</span>
                    <span class="tfm-credit__detail">Associates: Melvin Pascubillo, Leilani Monterola</span>
                </div>
                <div class="tfm-credit">
                    <span class="tfm-credit__role">Music</span>
                    <span class="tfm-credit__name">Steven P.C. Fernandez</span>
                    <span class="tfm-credit__detail">Also adapted from indigenous and folk sources</span>
                </div>
                <div class="tfm-credit">
                    <span class="tfm-credit__role">Designs</span>
                    <span class="tfm-credit__name">Vicmar Paloma, Hermi Dico</span>
                </div>
                <div class="tfm-credit">
                    <span class="tfm-credit__role">Production Management &amp; Marketing</span>
                    <span class="tfm-credit__name">Arlem Abanes</span>
                </div>
                <div class="tfm-credit">
                    <span class="tfm-credit__role">Technical Director</span>
                    <span class="tfm-credit__name">Andrew Salazar</span>
                </div>
                <div class="tfm-credit">
                    <span class="tfm-credit__role">Mise-en-Scène</span>
                    <span class="tfm-credit__name">Steven P.C. Fernandez</span>
                </div>
            </div>
        </section>

        {{-- ── 04 PRESS ── --}}
        <section aria-labelledby="press-title" data-reveal>
            <div class="tfm-section-head">
                <span class="tfm-section-head__num">04</span>
                <h2 id="press-title">Press &amp; Testimonials</h2>
                <span class="tfm-section-head__line"></span>
            </div>

            <div class="tfm-quotes">
                <figure class="tfm-quote">
                    <blockquote>
                        "…grab(s) me fully from their opening seconds: dark stage, figures in shadow, kulintang music…
                        The experience is visceral and exhilarating…"
                    </blockquote>
                    <figcaption>Tim Tomlinson — President, New York Writers Workshop, New York City</figcaption>
                </figure>

                <figure class="tfm-quote">
                    <blockquote>
                        "…skillful storytelling via dance…fascinating… not for an instant did audience attention falter…"
                    </blockquote>
                    <figcaption>Leonor Orosa Goquingco — National Artist for Dance</figcaption>
                </figure>

                <figure class="tfm-quote">
                    <blockquote>
                        "…heir(s) of…pioneers [of Southern culture]…. versatility…in conception, direction, and musical writing and leadership."
                    </blockquote>
                    <figcaption>Basilio Esteban S. Villaruz — The Manila Chronicle</figcaption>
                </figure>

                <figure class="tfm-quote">
                    <blockquote>
                        "…I watched with pleasure… eloquent inspite of the minimal use of dialogue…"
                    </blockquote>
                    <figcaption>Doreen G. Fernandez, Ph.D — Theater historian and critic</figcaption>
                </figure>

                <figure class="tfm-quote">
                    <blockquote>
                        "How exquisitely delightful to watch IPAG steadily increase in stature thru the years!
                        …vivid storytelling… that mesmerizes and thrills…"
                    </blockquote>
                    <figcaption>Julie Lluch — Philippine Artist</figcaption>
                </figure>
            </div>
        </section>

        {{-- ── 05 GALLERY ── --}}
        <section id="gallery" aria-labelledby="gallery-title" data-reveal>
            <div class="tfm-section-head">
                <span class="tfm-section-head__num">05</span>
                <h2 id="gallery-title">Gallery</h2>
                <span class="tfm-section-head__line"></span>
            </div>

            <div class="tfm-gallery__slideshow" data-tfm-slideshow data-interval="7000">
                <button class="tfm-slide-btn tfm-slide-btn--left"  type="button" aria-label="Previous image" data-prev>&#8249;</button>

                <img class="tfm-slide is-active" src="{{ asset('images/productions/tfm/01.jpg') }}" alt="Tales from Mindanao — production photo 1">
                <img class="tfm-slide"           src="{{ asset('images/productions/tfm/02.jpg') }}" alt="Tales from Mindanao — production photo 2">
                <img class="tfm-slide"           src="{{ asset('images/productions/tfm/03.jpg') }}" alt="Tales from Mindanao — production photo 3">
                <img class="tfm-slide"           src="{{ asset('images/productions/tfm/04.jpg') }}" alt="Tales from Mindanao — production photo 4">

                <button class="tfm-slide-btn tfm-slide-btn--right" type="button" aria-label="Next image"      data-next>&#8250;</button>

                <div class="tfm-dots" data-dots aria-label="Slideshow navigation"></div>
            </div>
        </section>

        {{-- ── 06 WATCH ── --}}
        <section id="watch" aria-labelledby="watch-title" data-reveal>
            <div class="tfm-section-head">
                <span class="tfm-section-head__num">06</span>
                <h2 id="watch-title">Watch</h2>
                <span class="tfm-section-head__line"></span>
            </div>

            <div class="tfm-video-wrap">
                {{-- Replace VIDEO_ID with your actual YouTube video ID --}}
                <iframe
                    src="https://www.youtube.com/embed/VIDEO_ID"
                    title="Tales from Mindanao — IPAG"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                    allowfullscreen
                ></iframe>
            </div>

            <p class="tfm-hint">
                Tip: The video ID is the string after <code>v=</code> in a YouTube URL, e.g.
                <code>youtube.com/watch?v=<strong>VIDEO_ID</strong></code>
            </p>
        </section>

    </main>

    {{-- ═══════════ CTA BAND ═══════════ --}}
    <div class="tfm-cta" data-reveal>
        <p class="tfm-cta__eyebrow">Book a Performance</p>
        <h2>Bring <span>Tales from Mindanao</span><br>to your venue</h2>
        <p>Interested in hosting IPAG? Send us your event details and we'll get back to you.</p>
        <div class="tfm-cta__actions">
            <a class="tfm-btn tfm-btn--primary" href="{{ url('/bookings') }}">Book a Performance</a>
            <a class="tfm-btn tfm-btn--ghost"   href="{{ url('/contact') }}">Contact IPAG</a>
        </div>
    </div>

</div>
@endsection
