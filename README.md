# Stayly — Flutter Hotel Booking App

Flutter assignment: a mobile hotel-booking UI implemented from the provided Figma design (dashboard, hotels, booking calendar, account, and side menu).

The app is branded as **Stayly**, with a custom launcher icon and native splash screen. It is a **mobile-first Flutter / Dart** client with pixel-accurate layout, reusable widgets, responsive sizing, and the interactions shown in the prototype.

Demo catalog: **5 properties** (Toronto, Bali, Santorini, Kyoto, Maldives), each with its own photo gallery.

---

## Requirements

| Tool | Version |
| --- | --- |
| **Flutter** | **3.47.2** (pinned in [`.fvmrc`](.fvmrc)) |
| **Dart** | SDK `^3.11.0` (the SDK that ships with Flutter 3.47.2) |

Also required:

- [FVM](https://fvm.app) **or** a local Flutter SDK matching the version in `.fvmrc`
- Android Studio / Xcode command-line tools if you run on a device or emulator
- A connected Android/iOS device or an emulator/simulator

Do **not** use a different Flutter version. Layout, Gradle plugin compatibility, and Dart language features in this project were developed against **3.47.2**.

---

## Project Setup

Use **either** FVM (recommended) **or** the same Flutter version FVM pins.

### Option A — FVM (recommended)

1. Install [FVM](https://fvm.app/documentation/getting-started/installation) if it is not already installed.
2. From the project root:

```bash
fvm install
fvm flutter pub get
```

`fvm install` reads `.fvmrc` and installs Flutter **3.47.2**.

3. Run on a connected device or emulator:

```bash
fvm flutter devices
fvm flutter run
```

To target a specific device:

```bash
fvm flutter run -d <device_id>
```

### Option B — Without FVM

Install Flutter **3.47.2** yourself (the version in `.fvmrc`) and put that SDK on your `PATH`. Then:

```bash
flutter --version          # confirm it is 3.47.2
flutter pub get
flutter run
```

If `flutter --version` is not 3.47.2, switch SDKs before running. Mixing versions can change layout and Android toolchain warnings.

### Run tests

```bash
fvm flutter test
# or: flutter test
```

---

## Build Instructions

Release APK (Android submission artifact):

```bash
fvm flutter build apk --release
# or: flutter build apk --release
```

Output:

```
build/app/outputs/flutter-apk/app-release.apk
```

Debug APK (optional):

```bash
fvm flutter build apk --debug
```

The first Android build downloads Gradle dependencies and can take several minutes.

---

## Third-Party Packages

Only a small set of packages is used, each for a specific job:

| Package | Purpose |
| --- | --- |
| [`go_router`](https://pub.dev/packages/go_router) | Declarative navigation and a four-tab `StatefulShellRoute` (dashboard, hotels, booking, account) so each tab keeps its own stack. |
| [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) | App state: hotel list from JSON, selected hotel, and async loading. |
| [`flutter_svg`](https://pub.dev/packages/flutter_svg) | Figma SVG icons (nav, search, account rows, calendar arrows, etc.). |
| [`kf_drawer`](https://pub.dev/packages/kf_drawer) | Side-menu drawer with the scale/slide motion from the prototype. |
| [`flutter_lints`](https://pub.dev/packages/flutter_lints) | Dev-only analyzer lints. |
| [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) | Dev-only generator for the Android launcher icon (`assets/images/appLogo.png`). |
| [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) | Dev-only generator for the native splash screen (`assets/images/splashLogo.png` on `#0C0E0D`). |

Hotel data, images, fonts, and icons live in the repo (`assets/`). There is no backend and no extra image CDN.

---

## What’s Implemented

- **Branding** — display name **Stayly**, custom Android app icon, and a dark native splash with the Stayly logo.
- **Dashboard** — time-based greeting, search, property cards for **5 destinations**, skeleton loading, pull-to-refresh, empty search state, tap a card to open Hotels.
- **Hotels / Resort** — per-property hero image carousel, overlapping info panel, rating/reviews, address, description.
- **Booking Hotel** — stay header, cancel-date action, month navigation, custom calendar with date-range selection.
- **Account** — settings rows matching Figma; taps that have no destination screen show a Coming Soon dialog.
- **Side menu** — profile header and menu rows from the hamburger control; options that are UI-only in the design show Coming Soon.
- **Bottom navigation** — four tabs with the Figma pill/selection animation.
- **Back navigation** — system back closes the side menu if it is open; otherwise the first press shows a “Press back again to exit” hint, and a second press within 2 seconds exits the app.
- **Responsive layout** — width-based scale and device tiers (small / medium / large phone, tablet), safe areas, and keyboard-safe scrolling.

Design tokens (colors, type, spacing, icons) live under `lib/app/theme/`. Screens are split by feature under `lib/features/`.

```
lib/
  app/         theme, router, MaterialApp
  core/        shared widgets and utilities
  data/        hotel model, JSON repository, Riverpod providers
  features/    dashboard, hotel, booking, account, side_menu
  l10n/        UI copy
assets/
  fonts/       Nohemi, Inter
  icons/       SVG icons
  images/      app logo, splash logo, avatar, per-city property photos
  data/        hotels.json (5 properties)
```

---

## Assumptions

- **No backend.** Five demo properties are loaded from `assets/data/hotels.json` (Toronto, Bali, Santorini, Kyoto, Maldives). Search filters that local list (location, dates, price, distance).
- **Per-property galleries.** Each listing has its own `imageAssets` array (three WebP photos under `assets/images/<City>/`). The Hotels tab carousel uses that hotel’s images.
- **App name / icon / splash.** The launcher label is **Stayly**. The icon and splash were generated for **Android** from `appLogo.png` and `splashLogo.png` via `flutter_launcher_icons` and `flutter_native_splash` (iOS generation is left off in `pubspec.yaml`).
- **Coming Soon** is used where the Figma UI exists but no further screen or API was specified (microphone, most account rows, most side-menu items, hotel notification bell). The control still responds to tap.
- **Booking calendar** starts on the demo stay in the design (24–26 Oct 2026). Range selection and month paging are fully interactive.
- **Copy and fonts.** UI strings are English. Figma Nohemi is bundled. Labels that specified SF Pro use Inter, which is bundled.
- **Android Gradle / AGP / Kotlin warnings.** `flutter run` / `flutter build` may print that Flutter will *soon* drop support for this project’s Gradle **8.14.0**, Android Gradle Plugin **8.11.1**, and Kotlin **2.2.20**. These are **future-compatibility warnings, not build failures**. The debug and release APKs still assemble and install. They are left as-is for this assignment so the Android toolchain is not changed at submission time. They can be upgraded later (Gradle ≥ 9.1.0, AGP ≥ 9.0.1, Kotlin ≥ 2.3.20) without changing app behavior.
- **First-frame Android size.** Some devices briefly report a `0×0` window before the Flutter surface attaches. Layout math clamps that so cards and the hotel hero do not crash; the next frame uses the real size.
- **Application id** is the Flutter template id `com.example.flutter_hotel_booking_app` (display name remains Stayly).

---

## Running on a device

1. Enable Developer options and USB debugging (Android) or trust the computer (iOS).
2. `fvm flutter devices` (or `flutter devices`) should list the phone.
3. `fvm flutter run -d <device_id>`.

The first launch compiles the Android/iOS engine; later launches are faster. You should see the Stayly splash, then the dashboard with the five property cards.
