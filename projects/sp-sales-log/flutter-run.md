---
name: flutter-run
description: Run or build the Flutter app with the correct dart-define values. Use when the user says "run the app", "launch on my phone", "build APK / AAB", or anything that needs Flutter with Supabase env baked in.
---

# Run / build the Flutter app

The Flutter app needs two compile-time defines: `SUPABASE_URL` and `SUPABASE_ANON_KEY`. There are three convenient ways to provide them.

## Run locally

**Preferred — VS Code F5:** `.vscode/launch.json` already has the dart-define values committed. Just press F5.

**CLI via helper script** (reads `.env.local`):
```bash
./scripts/flutter-run.sh                 # default device
./scripts/flutter-run.sh -d chrome
./scripts/flutter-run.sh -d <sim-uuid>
```

If `.env.local` doesn't exist, copy `.env.example` and fill in `SUPABASE_URL` + `SUPABASE_ANON_KEY` from the launch.json or the team password manager.

**CLI without script** (for one-offs):
```bash
flutter run \
  --dart-define=SUPABASE_URL=https://supabase.srv1615879.hstgr.cloud \
  --dart-define=SUPABASE_ANON_KEY=<anon>
```

## Build a release APK

```bash
flutter build apk --release \
  --dart-define=SUPABASE_URL=https://supabase.srv1615879.hstgr.cloud \
  --dart-define=SUPABASE_ANON_KEY=<anon>
# → build/app/outputs/flutter-apk/app-release.apk
```

APK is fine for sharing with the testing team via WhatsApp / Drive.

## Build a Play Store AAB

Requires `android/key.properties` (gitignored — on Murthy's machine + a backup). Without it the build silently falls back to debug-signing and Play Console will reject it.

```bash
flutter clean
flutter build appbundle --release \
  --dart-define=SUPABASE_URL=https://supabase.srv1615879.hstgr.cloud \
  --dart-define=SUPABASE_ANON_KEY=<anon>
# → build/app/outputs/bundle/release/app-release.aab
```

Or use the helper:
```bash
npm run android:package
```

## Gotchas

- **Don't** run `flutter clean` casually — it wipes generated launcher icons. After cleaning, regenerate:
  ```bash
  dart run flutter_launcher_icons
  ```
- The anon key in the bundle is **public** — committing it to `launch.json` is by design. The service role key must never enter the Flutter app.
- If you change the `SUPABASE_URL` host, also update `frontend/.env.local` and the n8n credentials so the three layers stay aligned.
- `image_picker` permissions: Android manifest changes need a full rebuild, not hot-reload.
