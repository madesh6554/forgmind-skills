---
name: mockup
description: Generate a polished self-contained HTML file visually showing whatever is being discussed. ALWAYS outputs a real .html file — never markdown, never ASCII diagrams, never a .md file.
---

# /mockup — HTML Visual Generator

**CRITICAL RULE: Always output a real `.html` file with inline CSS. Never write markdown. Never write ASCII art. Never write a `.md` file. The output must be a browser-openable HTML page.**

When the user runs `/mockup`, read the current conversation context and generate a single self-contained HTML file that visually represents it.

## What to generate based on context

- Plan or process → visual flowchart or phase cards with arrows
- UI screen or page → realistic phone/browser frame mockup
- Architecture or system → boxes and arrows diagram in HTML/CSS
- Color or theme change → side-by-side comparison cards
- Data or dashboard → stat cards, charts, table layouts
- Before/after → two-column visual comparison
- Timeline → horizontal or vertical step timeline
- Anything else → use the layout that best communicates it visually

## Always do this

1. Read the conversation context — understand what needs to be visualized
2. If the project has a theme/color file, read it and use the real colors
3. If no theme exists, use a clean dark or light neutral palette
4. Generate ONE `.html` file with all CSS inline — no external dependencies
5. Save to the right location:
   - Flutter project → `build/web/mockup.html`
   - React/Next.js → `public/mockup.html`
   - No framework → project root `mockup.html`
   - Server/no frontend → `/tmp/mockup.html`
6. Tell the user the exact path to open in browser

## HTML requirements

- Must open and render fully offline (no CDN, no external fonts, no scripts)
- Use real HTML elements — divs, cards, flexbox, grid — not ASCII characters
- Clean modern look: rounded cards, subtle shadows, clear typography
- Color code phases or categories when showing plans or timelines
- Label every section clearly
- Title and subtitle at the top
- Max width 1200px centered

## For plans and process flows

When the context is a migration plan, architecture, or multi-phase process:
- Each phase = a colored card or step block in HTML
- Arrows between steps using CSS or styled HTML elements
- Summary table showing before/after or phase breakdown
- Timeline bar if there are dates or durations
- Color code: green = done/safe, yellow = in progress, red = risky/cutover

## What NOT to do

- Do NOT write a `.md` file
- Do NOT use ASCII art boxes like `┌──────┐`
- Do NOT output plain text diagrams
- Do NOT explain in markdown — just generate the HTML file and tell the user the path
