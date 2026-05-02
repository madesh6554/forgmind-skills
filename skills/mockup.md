---
name: mockup
description: Instantly generate a polished, self-contained HTML preview of whatever is currently being discussed in the conversation. Use when the user runs /mockup and you should auto-detect the best visual format (UI screen, theme comparison, component variants, states, flow, dashboard, etc.).
---

# /mockup — Instant HTML visual preview

When the user runs `/mockup`, immediately generate a self-contained HTML preview page of whatever is currently being discussed or planned. No extra explanation needed from the user.

## Auto-detect what to preview

Look at the current conversation context and decide the best visual format:
- New screen or page → render it as a realistic UI mockup
- Color or theme change → side-by-side comparison cards
- Component or widget → show it standalone with variants
- Error / empty / loading states → each state labeled
- Flow or plan → visual step cards or diagram
- Dashboard or data view → chart/table/stat card layout
- Anything else → use whatever layout best communicates it visually

## Always do this

1. If the project has a theme/color file, read it first and use the real colors
2. If no theme file exists, pick clean neutral colors that suit the context
3. Generate a single self-contained HTML file — inline CSS only, no external dependencies
4. Save it where the project serves static files (e.g. `build/web/mockup.html` for Flutter, `public/mockup.html` for React/Next.js, or just the project root if unsure)
5. Tell the user the path or URL to open it

## HTML style rules

- Clean modern look — white or dark background depending on context
- Use cards, sections, grids, or whatever layout fits the content
- Label each section or variant clearly
- Title + short subtitle at the top
- Must work fully offline (no CDN fonts, no external scripts)
- Make it look polished — not a rough wireframe
