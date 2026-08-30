<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('home');
}) ->name('home');

foreach (['tales-from-mindanao' => 'TFM', 'sita' => 'SITA', 'sarimanok' => 'Sarimanok', 'marlen' => 'Marlen', 'tatlo-sa-isa' => 'TatloSaIsa', 'hapoy' => 'Hapoy', 'datu' => 'Datu', 'suhi' => 'Suhi', 'uwahig' => 'Uwahig'] as $path => $name) {
    Route::get('/'.$path, fn () => view('home'))->name($name);
}

foreach (['milestones', 'bookings', 'contact'] as $path) {
    Route::get('/'.$path, fn () => view('home'))->name($path);
}
