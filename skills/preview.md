---
name: preview
description: Generate a self-contained HTML mockup page using the project's real theme colors. Use when the user runs /preview to visualize UI ideas, color/theme changes, error states, or before/after comparisons before coding them.
---

# /preview — Visual HTML preview generator

When the user runs `/preview`, generate a self-contained HTML mockup page and save it to an appropriate location in the project (e.g. `build/web/preview.html` for Flutter web, or `public/preview.html` for web projects).

## What to do

Read the project's color/theme system first (e.g. `lib/core/theme.dart`, `tailwind.config.js`, CSS variables, etc.) to extract the **actual colors** used in the app.

Then build an HTML file that visually demonstrates whatever the user describes — using those real colors, not generic placeholders.

## Common use cases

- **Color/theme change**: Show old vs new colors side by side in card/component mockups
- **Error/offline states**: Show phone or card mockups of each error scenario with the real UI (icons, messages, buttons)
- **UI component design**: Show what a new widget, screen, or layout will look like before coding it
- **Before/after comparison**: Two-column layout comparing current vs proposed design

## How to build the HTML

- Pure HTML + inline CSS, no external dependencies (must work offline/file://)
- Use the project's real hex colors extracted from theme files
- Phone shell mockup: `border-radius: 36px`, dark bezel `#1a1a2e`, notch bar at top
- Card/component mockup: rounded cards with shadows on a neutral background
- Grid layout: wrap mockups in a responsive flex/grid so many fit on screen
- Label each mockup clearly below it
- Add a title and subtitle at the top explaining what the preview shows

## Example prompts that trigger this

- `/preview the 3 new onboarding screens using the app colors`
- `/preview all error states as phone mockups`
- `/preview the color theme change — show old vs new`
- `/preview what the new dashboard card will look like`
