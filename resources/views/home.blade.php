@extends('layouts.app')

@section('title', 'IPAG Philippines')

@section('content')

<nav>
    <div class="brand">
        <img src="{{ asset('images/ipag-logo.png') }}" alt="IPAG logo">
        <strong>Integrated Performing Arts Guild</strong>
    </div>
    <ul>
        <li><a href="/">Home</a></li>
        <li class="dropdown">
            <a href="#">Productions</a>
            <div class="dropdown-content">
                <a href="#">Tales from Mindanao</a>
                <a href="#">SITA: The Ramayana Revisited</a>
                <a href="#">Sarimanok</a>
                <a href="#">MarLen</a>
                <a href="#">Hapoy Daw Waig</a>
                <a href="#">Datu Matu</a>
                <a href="#">Suhi</a>
                <a href="#">Uwahig</a>
            </div>
        </li>
        <li><a href="#">Milestones</a></li>
        <li><a href="#">Bookings</a></li>
        <li><a href="#">Contact</a></li>
    </ul>
</nav>

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
            <img src="/images/tatlo.png">
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

<footer>
    © Integrated Performing Arts Guild (IPAG) Philippines
</footer>

@endsection