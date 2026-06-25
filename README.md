# OctaFit

AI-Powered Fitness Ecosystem — **frontend-only** Flutter mobile app with mock data.

## Features

- Splash, 4 onboarding screens, auth flow (login / sign up / forgot password / profile setup)
- Home dashboard with AI insights, stats, quick actions
- Training hub (Bodybuilding, MMA, Home workouts)
- AI Hub (Coach, Chat, Motion Analyzer, Physio)
- Store (products, cart, checkout UI)
- Community feed & gamification (achievements, challenges, leaderboard)
- Profile & settings with dark/light mode toggle

## Architecture

- **Clean Architecture**: `presentation` / `domain` / `data`
- **State management**: Riverpod
- **Navigation**: go_router with bottom nav shell
- **DI**: get_it
- **Mock data**: `assets/data/mock_data.json`

## Getting Started

```bash
flutter pub get
flutter run
```

Open the project folder in VS Code and run on an emulator or device.

## Project Structure

```
lib/
├── main.dart
├── app.dart
├── injection.dart
├── core/           # theme, router, widgets, animations
├── domain/         # entities, repository interfaces
├── data/           # models, mock data source, repository impls
└── presentation/   # providers, screens
```

## Design

- Dark mode default (#0A0A0F)
- Glassmorphism cards with blur
- Brand colors: Blue #0080FF, Purple #7B2FFF, Cyan #00D4FF
- 300ms ease-in-out page transitions
- Scale press animation (0.96) on buttons
