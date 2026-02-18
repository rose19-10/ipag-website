<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('home');
}) ->name('home');

Route::get('/tales-from-mindanao', function () {
    return view('TFM');
})->name('TFM');

Route::get('/sita', function () {
    return view('SITA');
})->name('SITA');

Route::get('/sarimanok', function () {
    return view('Sarimanok');
})->name('Sarimanok');

Route::get('/marlen', function () {
    return view('Marlen');
})->name('Marlen');

Route::get('/hapoy', function () {
    return view('Hapoy');
})->name('Hapoy');

Route::get('/datu', function () {
    return view('Datu');
})->name('Datu');

Route::get('/suhi', function () {
    return view('Suhi');
})->name('Suhi');

Route::get('/uwahig', function () {
    return view('Uwahig');
})->name('Uwahig');
