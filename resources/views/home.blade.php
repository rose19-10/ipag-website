@extends('layouts.app')

@section('title', 'IPAG Philippines')

@section('content')

<nav>
    <div class="brand">
        <img src="{{ asset('images/ipag-logo.png') }}" alt="IPAG logo">
        <strong>Integrated Performing Arts Guild</strong>
    </div>
    <ul>
        <li><a href="#" data-tab="home" class="tab-link active">Home</a></li>
        <li class="dropdown">
            <a href="#">Productions</a>
            <div class="dropdown-content">
                <a href="{{ route('TFM') }}">Tales from Mindanao</a>
                <a href="{{ route('SITA') }}">SITA: The Ramayana Revisited</a>
                <a href="{{ route('Sarimanok') }}">Sarimanok</a>
                <a href="{{ route('Marlen') }}">MarLen</a>
                <a href="{{ route('Hapoy') }}">Hapoy Daw Waig</a>
                <a href="{{ route('Datu') }}">Datu Matu</a>
                <a href="{{ route('Suhi') }}">Suhi</a>
                <a href="{{ route('Uwahig') }}">Uwahig</a>
            </div>
        </li>
        <li><a href="#" data-tab="milestones" class="tab-link">Milestones</a></li>
        <li><a href="#" data-tab="bookings" class="tab-link">Bookings</a></li>
        <li><a href="#" data-tab="contact" class="tab-link">Contact</a></li>
    </ul>
</nav>

<!-- HOME TAB -->
<section id="home" class="tab-content active">
    <section class="hero">
        <h1><span>Integrated Performing Arts Guild</span><br/>Philippines</h1>
        <p>World-renowned performing arts company rooted in Mindanao, blending theater, dance, music, and visual storytelling.</p>
    </section>

    <section class="productions">
        <h2>Recent Productions</h2>
        <div class="cards">
            <div class="card">
                <img src="{{ asset('images/TFM2.jpg') }}">
                <p>Tales from Mindanao</p>
            </div>
            <div class="card">
                <img src="{{ asset('images/Sita.jpg') }}">
                <p>Sita: The Ramayana Revisited</p>
            </div>
            <div class="card">
                <img src="{{ asset('images/tatlo.png') }}">
                <p>Tatlo sa Isa</p>
            </div>
            <div class="card">
                <img src="{{ asset('images/isaulog.jpg') }}">
                <p>Isaulog</p>
            </div>
        </div>
    </section>

    <section class="feature">
        <div class="feature-header">
            <h3>About us</h3>
        </div>

        <div class="slideshow-container">
            <button class="nav-button prev-button" onclick="changeSlide(-1)">&#10094;</button>
            <button class="nav-button next-button" onclick="changeSlide(1)">&#10095;</button>

            <div class="slide active">
                <img src="{{ asset('images/ipag1.png') }}">
            </div>
            <div class="slide">
                <img src="{{ asset('images/ipag2.png') }}">
            </div>
            <div class="slide">
                <img src="{{ asset('images/ipag3.png') }}">
            </div>
            <div class="slide">
                <img src="{{ asset('images/ipag4.png') }}">
            </div>
            <div class="slide">
                <img src="{{ asset('images/ipag5.png') }}">
            </div>
            <div class="slide">
                <img src="{{ asset('images/ipag6.png') }}">
            </div>
        </div>
    </section>
</section>

<!-- MILESTONES TAB -->
<section id="milestones" class="tab-content">
    <section class="productions">
        <h2>Milestones</h2>
        <p>All the important achievements and history of IPAG go here.</p>
    </section>
</section>

<!-- BOOKINGS TAB -->
<section id="bookings" class="tab-content">
    <section class="productions">
        <h2>Bookings</h2>
        <p>Booking form or booking information goes here.</p>
    </section>
</section>

<!-- CONTACT TAB -->
<section id="contact" class="tab-content">
    <section class="productions">
        <h2>Contact</h2>
        <p>Contact form or contact details go here.</p>
    </section>
</section>

<footer>
    © Integrated Performing Arts Guild (IPAG) Philippines
</footer>

@endsection
