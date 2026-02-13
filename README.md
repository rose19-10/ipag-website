# IPAG Website  
Laravel + Herd Setup Guide (Beginner Friendly)

This guide will walk you step-by-step from installing the required tools to accessing and running the **ipag-website** repository on your computer.

No prior Laravel, Git, or GitHub experience required.

---

# 🧰 PART 1 — Install Required Software

You must install these first before accessing the repository.

---

## ✅ Step 1 — Install Laravel Herd (Windows)

Laravel Herd is a local development environment that runs PHP automatically.

1. Download Laravel Herd.
2. Install it normally.
3. Open Herd after installation.
4. Make sure PHP is running (green status).

Herd automatically creates `.test` domains for projects placed inside its directory.

Default Herd folder:

```
C:\Users\YourName\Herd
```

---

## ✅ Step 2 — Install Visual Studio Code

1. Download Visual Studio Code.
2. Install it.
3. Open VS Code.

Recommended extensions:
- PHP Intelephense
- Laravel Blade Snippets
- GitLens

---

## ✅ Step 3 — Install Git

1. Download Git from https://git-scm.com
2. Install using default settings.
3. Open Command Prompt and test:

```
git --version
```

If you see a version number, Git is installed correctly.

---

# 📥 PART 2 — Clone the GitHub Repository

Now you will download (clone) the project to your computer.

---

## ✅ Step 4 — Copy the Repository Link

1. Go to the GitHub repository page for **ipag-website**.
2. Click the green **Code** button.
3. Copy the HTTPS URL.

```
https://github.com/rose19-10/ipag-website.git
```


---

## ✅ Step 5 — Clone the Repository into Herd

Open Command Prompt.

Go to your Herd folder:

```
cd C:\Users\YourName\Herd
```

Then run:

```
git clone https://github.com/rose19-10/ipag-website.git
```

After cloning, go inside the project:

```
cd ipag-website
```


The project is now on your computer.

---

# 📦 PART 3 — Install Laravel Dependencies

Laravel projects require dependencies to run.

Inside the project folder, run:

```
composer install
```


This may take a few minutes.

---

# ⚙️ PART 4 — Configure the Project

Laravel requires a `.env` file.

---

## ✅ Step 6 — Create Environment File

Run:

```
copy .env.example .env
```


---

## ✅ Step 7 — Generate Application Key

Run:

```
php artisan key:generate
```


This sets up the encryption key required by Laravel.

---

# ▶️ PART 5 — Run the Website

You now have two ways to run the project.

---

## Option A — Using Herd (Recommended)

Make sure the project folder is inside:

```
C:\Users\YourName\Herd\ipag-website
```


Then open your browser and go to:

```
http://ipag-website.test
```


If it loads, setup is complete.

If it does not load:
- Restart Herd
- Make sure the folder name is lowercase
- Make sure it is directly inside the Herd folder

---

## Option B — Using Artisan Server

Inside the project folder run:

```
php artisan serve
```


Then open:

```
http://127.0.0.1:8000
```


---

# 🔄 PART 6 — Pull Latest Updates from GitHub

If the repository gets updated and you want the latest version:

Go inside the project folder:

```
cd C:\Users\YourName\Herd\ipag-website
```


Then run:

```
git pull origin main
```


This updates your local project with the latest changes.

---

# 🧠 Important Notes

## Images Not Showing?

Images must be inside:

```
public/images/
```


And referenced using:

```
<img src="{{ asset('images/filename.png') }}">
```


