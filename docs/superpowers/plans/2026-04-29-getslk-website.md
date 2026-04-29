# getslk.sh Website Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the three-page synthwave-themed marketing-and-light-docs site for slk at https://getslk.sh.

**Architecture:** Hand-written static HTML + CSS, two tiny vanilla JS files, no build step. Three pages: `/` (landing), `/themes`, `/install`. Deployed via GitHub Pages with `getslk.sh` custom domain.

**Tech Stack:** HTML5, CSS3 (custom properties + grid + flexbox), vanilla JS (only for click-to-copy and OS install tabs), system fonts.

**Reference assets:**
- Spec: `docs/superpowers/specs/2026-04-29-getslk-website-design.md`
- Hero v6 mockup (locked aesthetic): `docs/superpowers/specs/hero-reference.html`

**Verification approach:** Static sites have no unit-test runner. Most tasks end with "open `index.html` in a browser, confirm X." For the two JS modules (`copy.js`, `tabs.js`) we use real unit tests via a minimal `<script type="module">` test harness in `tests/test.html` — run by opening `tests/test.html` in a browser.

**Commit cadence:** Every task ends with a commit.

---

## File Structure

```
/
├── index.html              # Task 4-10: landing page
├── themes/
│   └── index.html          # Task 13: themes gallery
├── install/
│   └── index.html          # Task 14: setup walkthrough
├── styles.css              # Tasks 2,3,4-10,13,14: all shared styles
├── js/
│   ├── copy.js             # Task 11: click-to-copy
│   └── tabs.js             # Task 12: OS install tabs
├── assets/
│   ├── favicon.svg         # Task 15
│   ├── og-image.png        # Task 15
│   └── themes/             # Task 13: theme preview images (later, when user provides)
├── tests/
│   └── test.html           # Tasks 11,12: vanilla JS test harness
├── CNAME                   # Task 1: contains "getslk.sh"
├── .nojekyll               # Task 1: disable Jekyll on GitHub Pages
└── README.md               # Task 1: site repo readme
```

---

## Task 1: Repo scaffolding

**Files:**
- Create: `CNAME`
- Create: `.nojekyll`
- Create: `README.md`
- Create: `index.html` (placeholder)
- Create: `styles.css` (empty)

- [ ] **Step 1: Create CNAME**

Write `CNAME` with exactly this content (no trailing newline matters but a trailing newline is fine):

```
getslk.sh
```

- [ ] **Step 2: Create .nojekyll**

Write empty file `.nojekyll` (prevents GitHub Pages from running Jekyll, which strips files starting with `_`).

- [ ] **Step 3: Create README.md**

```markdown
# getslk.sh

Source for the [slk](https://github.com/gammons/slk) project website.

Plain static HTML/CSS, served via GitHub Pages at https://getslk.sh.

## Local preview

```bash
python3 -m http.server 8000
# open http://localhost:8000
```

## Deploy

Push to `main`. GitHub Pages serves from the repo root.
```

- [ ] **Step 4: Create placeholder index.html**

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>slk — a blazingly fast slack tui</title>
  <link rel="stylesheet" href="/styles.css">
</head>
<body>
  <h1>slk</h1>
</body>
</html>
```

- [ ] **Step 5: Create empty styles.css**

```css
/* getslk.sh — design tokens and components live here. Filled out in Task 2. */
```

- [ ] **Step 6: Verify locally**

Run: `python3 -m http.server 8000` in repo root.
Open `http://localhost:8000`. Expected: page loads, shows "slk" heading, no console errors.

- [ ] **Step 7: Commit**

```bash
git add CNAME .nojekyll README.md index.html styles.css
git commit -m "Scaffold site: CNAME, placeholder index, empty styles"
```

---

## Task 2: Design tokens in styles.css

Establishes the palette, type stack, spacing scale, and base resets that every later task uses.

**Files:**
- Modify: `styles.css`

- [ ] **Step 1: Write the tokens**

Replace the contents of `styles.css` with:

```css
/* ============================================================
   getslk.sh — design tokens
   ============================================================ */
:root {
  /* sky / scene */
  --sky-top:        #07051a;
  --sky-mid:        #14093a;
  --sky-horizon-1:  #4a1668;
  --sky-horizon-2:  #6b1a7a;

  /* sun */
  --sun-cream:      #fff7c2;
  --sun-gold:       #ffd166;
  --sun-orange:     #ff8a3d;

  /* neon accents */
  --magenta:        #ff2bd6;
  --magenta-deep:   #b026ff;
  --cyan:           #22d3ee;
  --cyan-deep:      #00b4d8;

  /* silhouettes */
  --mountain:       #1a0535;
  --palm:           #0a0418;

  /* surfaces (non-hero sections) */
  --bg:             #07051a;
  --surface:        #0e0a22;
  --border:         #2a1f4a;

  /* text */
  --text:           #e6e0ff;
  --text-muted:     #a89cc8;

  /* type */
  --font-sans:      -apple-system, BlinkMacSystemFont, "Segoe UI", system-ui,
                    "Helvetica Neue", Arial, sans-serif;
  --font-mono:      ui-monospace, "SF Mono", Menlo, Consolas, monospace;

  /* spacing scale */
  --s-1:  4px;
  --s-2:  8px;
  --s-3:  12px;
  --s-4:  16px;
  --s-5:  24px;
  --s-6:  32px;
  --s-7:  48px;
  --s-8:  64px;
  --s-9:  96px;

  /* layout */
  --content-max:    1100px;
  --radius:         8px;
  --radius-lg:      12px;
}

/* ============================================================
   reset / base
   ============================================================ */
*, *::before, *::after { box-sizing: border-box; }
html, body { margin: 0; padding: 0; }
body {
  background: var(--bg);
  color: var(--text);
  font-family: var(--font-sans);
  font-size: 16px;
  line-height: 1.55;
  -webkit-font-smoothing: antialiased;
  text-rendering: optimizeLegibility;
}
img, svg { display: block; max-width: 100%; }
a { color: var(--cyan); text-decoration: none; }
a:hover { text-decoration: underline; }
code, kbd, pre { font-family: var(--font-mono); }

/* layout primitive */
.container {
  width: 100%;
  max-width: var(--content-max);
  margin-inline: auto;
  padding-inline: var(--s-5);
}

/* respect reduced motion */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.001ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.001ms !important;
  }
}
```

- [ ] **Step 2: Verify**

Reload `http://localhost:8000`. Expected: background is now near-black (`#07051a`), "slk" heading renders in light text. No console errors.

- [ ] **Step 3: Commit**

```bash
git add styles.css
git commit -m "Add design tokens, reset, and base styles"
```

---

## Task 3: Hero section CSS + markup

Port the locked v6 mockup into production CSS with semantic class names. The reference is committed at `docs/superpowers/specs/hero-reference.html` — that file is the source of truth for the visual.

**Files:**
- Modify: `styles.css` (append hero styles)
- Modify: `index.html` (replace placeholder body with hero markup)

- [ ] **Step 1: Read the reference**

Open `docs/superpowers/specs/hero-reference.html` to see exactly what the hero must look like. The CSS in that file is the canonical source — copy its declarations into `styles.css` under a `/* hero */` section, but rename the inline class names to a consistent `hero__*` BEM-ish convention:

| Reference class | Production class |
|---|---|
| `.hero-frame`   | `.hero`             |
| `.stars`        | `.hero__stars`      |
| `.stars i`      | `.hero__star`       |
| `.sun`          | `.hero__sun`        |
| `.horizon`      | `.hero__horizon`    |
| `.grid-floor`   | `.hero__grid`       |
| `.mountains`    | `.hero__mountains`  |
| `.palm`         | `.hero__palm`       |
| `.palm.left`    | `.hero__palm--left`  |
| `.palm.right`   | `.hero__palm--right` |
| `.hero-text`    | `.hero__copy`       |
| `.hero-text .logo` | `.hero__logo`    |
| `.hero-text .tag`  | `.hero__tagline` |
| `.hero-cta`     | `.hero__cta`        |
| `.hero-cta .install` | `.hero__install` |
| `.hero-cta .install .prompt` | `.hero__prompt` |

Replace the hardcoded color values in the hero CSS with `var(--token)` references everywhere a token exists in Task 2 (e.g. `#07051a` → `var(--sky-top)`, `#ff2bd6` → `var(--magenta)`, etc.). The two exceptions are the gradient stops inside `.hero__sun` (cream/gold/orange/magenta — keep token references) and the `.hero__sun::after` slice-line color (`#1a0535` → `var(--mountain)`).

The hero must also fill the viewport on desktop. Replace the `aspect-ratio: 16 / 9; border-radius: 12px;` rules with:

```css
.hero {
  position: relative;
  width: 100%;
  min-height: 100vh;
  overflow: hidden;
  /* (background gradients identical to reference) */
  font-family: var(--font-mono);
  isolation: isolate;
}
```

- [ ] **Step 2: Stars rendered semantically**

Instead of 25 hand-positioned `<i>` elements with inline styles, generate 25 stars in HTML with class names and percentage positions stored in inline `style="--x:..; --y:.."` custom properties, then position them in CSS:

```css
.hero__star {
  position: absolute;
  left: var(--x);
  top: var(--y);
  width: 2px; height: 2px;
  background: #fff;
  border-radius: 50%;
  box-shadow: 0 0 4px #fff;
  opacity: 0.85;
  animation: hero-twinkle 3s ease-in-out infinite;
}
.hero__star:nth-child(odd) { animation-duration: 4.2s; }
.hero__star:nth-child(3n) { width: 1px; height: 1px; opacity: 0.6; }
.hero__star:nth-child(7n) { width: 3px; height: 3px; box-shadow: 0 0 8px #fff, 0 0 14px #b8e6ff; }
@keyframes hero-twinkle { 0%,100%{opacity:.3} 50%{opacity:1} }
```

Use the same 25 star coordinates from the reference file.

- [ ] **Step 3: Replace `index.html` body**

Use this skeleton (palms and stars omitted here for brevity — copy them verbatim from the reference but rename class names per the table above):

```html
<body>
  <section class="hero">
    <div class="hero__stars">
      <i class="hero__star" style="--x:4%;  --y:8%"></i>
      <!-- ... all 25 stars from reference, with class hero__star ... -->
    </div>

    <div class="hero__sun"></div>

    <svg class="hero__mountains" viewBox="0 0 1200 72" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 72 L60 38 L130 58 L210 22 L300 50 L380 14 L470 46 L560 30 L640 6 L720 36 L810 18 L900 48 L990 26 L1080 54 L1150 34 L1200 50 L1200 72 Z" fill="var(--mountain)" opacity=".95"/>
    </svg>

    <div class="hero__horizon"></div>
    <div class="hero__grid"></div>

    <svg class="hero__palm hero__palm--left" viewBox="0 0 100 200" preserveAspectRatio="none" aria-hidden="true">
      <!-- copy palm trunk + coconuts + 7 fronds verbatim from reference, fill="var(--palm)" -->
    </svg>
    <svg class="hero__palm hero__palm--right" viewBox="0 0 100 200" preserveAspectRatio="none" aria-hidden="true">
      <!-- same as left -->
    </svg>

    <div class="hero__copy">
      <h1 class="hero__logo">slk</h1>
      <p class="hero__tagline">a blazingly fast slack tui</p>
    </div>

    <div class="hero__cta">
      <code class="hero__install"><span class="hero__prompt">$</span>brew install gammons/tap/slk</code>
    </div>
  </section>
</body>
```

Note: SVG `fill="var(--mountain)"` and `fill="var(--palm)"` work because we're using CSS custom properties; if you find they don't render in some browsers, fall back to setting `fill: var(--mountain)` via CSS class selectors.

- [ ] **Step 4: Verify in browser**

Reload `http://localhost:8000`. Expected:
- Full-viewport hero scene matches `hero-reference.html` exactly: stars twinkle, sun sits on horizon with slice lines, mountains span full width, palms flank both sides, "slk" logo glows, tagline reads "a blazingly fast slack tui" in deep cyan with readable shadow, install pill sits near the bottom.
- No horizontal scroll.
- No console errors.

Open the reference file in a second tab and visually diff. The two should be indistinguishable apart from the reference's fixed 16:9 aspect ratio frame.

- [ ] **Step 5: Verify reduced motion**

In DevTools, enable "Emulate CSS prefers-reduced-motion: reduce" (Rendering tab). Reload. Expected: stars stop twinkling.

- [ ] **Step 6: Commit**

```bash
git add styles.css index.html
git commit -m "Implement hero section from v6 reference"
```

---

## Task 4: Site nav (overlaid on hero)

A minimal top nav that floats over the hero on the landing page and sits as a thin solid bar on `/themes` and `/install`.

**Files:**
- Modify: `styles.css` (append nav styles)
- Modify: `index.html` (insert nav above hero markup)

- [ ] **Step 1: Append nav styles**

Append to `styles.css`:

```css
/* ============================================================
   site nav
   ============================================================ */
.nav {
  position: absolute;       /* overlay variant — used on landing */
  top: 0; left: 0; right: 0;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--s-4) var(--s-5);
  font-family: var(--font-mono);
  font-size: 14px;
}
.nav--solid {                /* used on /themes and /install */
  position: static;
  background: var(--surface);
  border-bottom: 1px solid var(--border);
}
.nav__brand {
  color: var(--text);
  font-weight: 800;
  letter-spacing: -0.5px;
  font-size: 18px;
}
.nav__brand:hover { text-decoration: none; }
.nav__links {
  display: flex;
  gap: var(--s-5);
}
.nav__links a {
  color: var(--text-muted);
}
.nav__links a:hover {
  color: var(--cyan);
  text-decoration: none;
}
```

- [ ] **Step 2: Insert nav in index.html**

Inside `<section class="hero">`, as the first child (before `.hero__stars`):

```html
<nav class="nav" aria-label="Primary">
  <a class="nav__brand" href="/">slk</a>
  <div class="nav__links">
    <a href="/themes/">themes</a>
    <a href="/install/">install</a>
    <a href="https://github.com/gammons/slk">github</a>
  </div>
</nav>
```

- [ ] **Step 3: Verify**

Reload landing page. Expected:
- "slk" wordmark top-left, three links top-right, all overlaying the hero with no background.
- Hovering a link turns it cyan.
- Nav doesn't push the hero down (it's absolutely positioned).

- [ ] **Step 4: Commit**

```bash
git add styles.css index.html
git commit -m "Add overlay nav on landing hero"
```

---

## Task 5: "Why slk" section

The pitch + 4 stats (cold-start, RSS, binary size, render approach).

**Files:**
- Modify: `styles.css`
- Modify: `index.html`

- [ ] **Step 1: Append section styles**

```css
/* ============================================================
   sections (post-hero)
   ============================================================ */
.section {
  padding-block: var(--s-9);
  border-top: 1px solid var(--border);
}
.section__eyebrow {
  font-family: var(--font-mono);
  font-size: 12px;
  letter-spacing: 4px;
  text-transform: uppercase;
  color: var(--magenta);
  margin: 0 0 var(--s-3);
}
.section__title {
  font-size: clamp(28px, 4vw, 44px);
  line-height: 1.15;
  margin: 0 0 var(--s-4);
  letter-spacing: -0.5px;
  font-weight: 800;
}
.section__lede {
  font-size: 18px;
  color: var(--text-muted);
  max-width: 56ch;
  margin: 0 0 var(--s-7);
}

/* stats row */
.stats {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--s-5);
}
@media (max-width: 720px) {
  .stats { grid-template-columns: repeat(2, 1fr); }
}
.stat {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: var(--s-5);
}
.stat__value {
  font-family: var(--font-mono);
  font-size: 28px;
  font-weight: 700;
  color: var(--cyan);
  line-height: 1.1;
  margin: 0 0 var(--s-2);
}
.stat__label {
  font-size: 14px;
  color: var(--text-muted);
  margin: 0;
}
```

- [ ] **Step 2: Append section markup to index.html**

After the closing `</section>` of the hero, add:

```html
<section class="section" id="why">
  <div class="container">
    <p class="section__eyebrow">why slk</p>
    <h2 class="section__title">The Slack desktop client, minus the 1.5GB of Chromium.</h2>
    <p class="section__lede">
      slk is a daily-driver replacement built in Go. One static binary,
      no Electron, no node_modules. It cold-starts in milliseconds and
      keeps every workspace connected in parallel.
    </p>
    <div class="stats">
      <div class="stat">
        <p class="stat__value">~ms</p>
        <p class="stat__label">cold start</p>
      </div>
      <div class="stat">
        <p class="stat__value">~60 MB</p>
        <p class="stat__label">resident memory</p>
      </div>
      <div class="stat">
        <p class="stat__value">~19 MB</p>
        <p class="stat__label">binary on disk</p>
      </div>
      <div class="stat">
        <p class="stat__value">100%</p>
        <p class="stat__label">keyboard-driven</p>
      </div>
    </div>
  </div>
</section>
```

- [ ] **Step 3: Verify**

Reload. Expected: scrolling past the hero reveals the "Why slk" section with a magenta eyebrow, big white headline, muted lede, and a 4-column stats row. On mobile (<720px), stats become 2×2.

- [ ] **Step 4: Commit**

```bash
git add styles.css index.html
git commit -m "Add 'Why slk' section with stats row"
```

---

## Task 6: Features grid

Six feature cards: real-time messaging, threads, reactions, multi-workspace, themes, keyboard-first.

**Files:**
- Modify: `styles.css`
- Modify: `index.html`

- [ ] **Step 1: Append styles**

```css
.features {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--s-5);
}
@media (max-width: 900px) { .features { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 600px) { .features { grid-template-columns: 1fr; } }
.feature {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: var(--s-5);
}
.feature__label {
  font-family: var(--font-mono);
  font-size: 12px;
  letter-spacing: 2px;
  text-transform: uppercase;
  color: var(--magenta);
  margin: 0 0 var(--s-3);
}
.feature__title {
  font-size: 20px;
  font-weight: 700;
  margin: 0 0 var(--s-2);
}
.feature__body {
  font-size: 15px;
  color: var(--text-muted);
  margin: 0;
}
.kbd {
  display: inline-block;
  font-family: var(--font-mono);
  font-size: 12px;
  padding: 2px 6px;
  border: 1px solid var(--border);
  border-bottom-width: 2px;
  border-radius: 4px;
  background: var(--bg);
  color: var(--cyan);
}
```

- [ ] **Step 2: Append markup**

```html
<section class="section" id="features">
  <div class="container">
    <p class="section__eyebrow">what you get</p>
    <h2 class="section__title">All the Slack you need, none of the bloat.</h2>
    <div class="features">

      <div class="feature">
        <p class="feature__label">/// realtime</p>
        <h3 class="feature__title">Live messages over WebSocket</h3>
        <p class="feature__body">Edits, deletes, reactions, typing indicators — all in real time, with optimistic UI and SQLite-backed scrollback.</p>
      </div>

      <div class="feature">
        <p class="feature__label">/// threads</p>
        <h3 class="feature__title">A real thread panel</h3>
        <p class="feature__body">Side-panel threads on <span class="kbd">Enter</span>, plus a dedicated Threads view that re-ranks live as new replies arrive.</p>
      </div>

      <div class="feature">
        <p class="feature__label">/// reactions</p>
        <h3 class="feature__title">Search-first reaction picker</h3>
        <p class="feature__body">Hit <span class="kbd">r</span> to search, <span class="kbd">R</span> to toggle existing reactions. Pill-style display, optimistic and deduped.</p>
      </div>

      <div class="feature">
        <p class="feature__label">/// workspaces</p>
        <h3 class="feature__title">All workspaces, in parallel</h3>
        <p class="feature__body">Every workspace stays connected. Press <span class="kbd">1</span>–<span class="kbd">9</span> to jump between them with live unread badges.</p>
      </div>

      <div class="feature">
        <p class="feature__label">/// themes</p>
        <h3 class="feature__title">12 built-in themes</h3>
        <p class="feature__body">Live-switch with <span class="kbd">Ctrl+y</span>. Drop your own TOML in <code>~/.config/slk/themes/</code> to add more.</p>
      </div>

      <div class="feature">
        <p class="feature__label">/// keyboard</p>
        <h3 class="feature__title">Vim-modal, all the way</h3>
        <p class="feature__body"><span class="kbd">j</span>/<span class="kbd">k</span> to move, <span class="kbd">i</span> to insert, <span class="kbd">Esc</span> to leave. Bracketed paste, OSC 52 clipboard, no mouse required.</p>
      </div>

    </div>
  </div>
</section>
```

- [ ] **Step 3: Verify**

Reload. Expected: 6 feature cards in a 3-column grid (2-col at <900px, 1-col at <600px). Magenta eyebrows, white titles, muted bodies, cyan keycap pills.

- [ ] **Step 4: Commit**

```bash
git add styles.css index.html
git commit -m "Add features grid section"
```

---

## Task 7: Themes preview strip (placeholder)

A horizontal strip of 12 theme cards. Real theme screenshots will be supplied later by the user; for now use styled placeholder cards that show the theme name and a swatch row.

**Files:**
- Modify: `styles.css`
- Modify: `index.html`

- [ ] **Step 1: Append styles**

```css
.themes-strip {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: var(--s-4);
}
.theme-card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  overflow: hidden;
  text-decoration: none;
  color: inherit;
  display: block;
  transition: transform .15s ease, border-color .15s ease;
}
.theme-card:hover {
  border-color: var(--cyan);
  transform: translateY(-2px);
  text-decoration: none;
}
.theme-card__preview {
  /* placeholder: filled with theme bg color via inline style */
  height: 120px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-mono);
  font-size: 13px;
}
.theme-card__body {
  padding: var(--s-3) var(--s-4);
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.theme-card__name {
  font-family: var(--font-mono);
  font-size: 14px;
  margin: 0;
}
.theme-card__swatches {
  display: flex;
  gap: 4px;
}
.theme-card__swatches i {
  width: 12px; height: 12px;
  border-radius: 3px;
  border: 1px solid rgba(255,255,255,0.1);
}
```

- [ ] **Step 2: Append markup**

```html
<section class="section" id="themes">
  <div class="container">
    <p class="section__eyebrow">themes</p>
    <h2 class="section__title">Twelve themes ship in the box.</h2>
    <p class="section__lede">Live-switch with <span class="kbd">Ctrl+y</span>. Drop your own TOML files in <code>~/.config/slk/themes/</code> to add more.</p>
    <div class="themes-strip">
      <!-- 12 placeholder cards. Real preview images go in once user provides them. -->
      <a class="theme-card" href="/themes/#dracula">
        <div class="theme-card__preview" style="background:#282a36; color:#f8f8f2;">dracula</div>
        <div class="theme-card__body">
          <p class="theme-card__name">Dracula</p>
          <div class="theme-card__swatches">
            <i style="background:#bd93f9"></i><i style="background:#50fa7b"></i><i style="background:#ff79c6"></i><i style="background:#8be9fd"></i>
          </div>
        </div>
      </a>
      <!-- Repeat the same pattern for the other 11 themes. Use these as
           placeholders; the executing engineer should pick reasonable
           bg/fg/accent colors per theme name. The themes are:
             dracula, nord, gruvbox, tokyo-night, catppuccin, monokai,
             solarized-dark, solarized-light, one-dark, kanagawa,
             rose-pine, ayu-dark
           Each card links to /themes/#<slug>. -->
    </div>
    <p style="margin-top: var(--s-6);"><a href="/themes/">See all themes →</a></p>
  </div>
</section>
```

The executing engineer fills in the remaining 11 cards by hand using each theme's known color palette. If unsure of exact colors, use a reasonable approximation — the cards will be replaced with real screenshots later.

- [ ] **Step 3: Verify**

Reload. Expected: themes-strip section appears with at least the Dracula card visible; after the engineer adds the remaining 11 they fill the grid. Hover lifts the card and turns its border cyan.

- [ ] **Step 4: Commit**

```bash
git add styles.css index.html
git commit -m "Add themes preview strip with placeholder cards"
```

---

## Task 8: Install section with OS tabs (markup + styling only)

JavaScript to make the tabs interactive comes in Task 12. For now build the markup with all panels visible and styled — the tabs will hide the inactive panels later.

**Files:**
- Modify: `styles.css`
- Modify: `index.html`

- [ ] **Step 1: Append styles**

```css
.install {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  overflow: hidden;
}
.install__tabs {
  display: flex;
  flex-wrap: wrap;
  gap: 0;
  border-bottom: 1px solid var(--border);
  background: var(--bg);
}
.install__tab {
  background: transparent;
  border: none;
  color: var(--text-muted);
  font-family: var(--font-mono);
  font-size: 13px;
  padding: var(--s-3) var(--s-4);
  cursor: pointer;
  border-bottom: 2px solid transparent;
}
.install__tab[aria-selected="true"] {
  color: var(--cyan);
  border-bottom-color: var(--cyan);
}
.install__tab:hover { color: var(--text); }
.install__panel { padding: var(--s-5); }
.install__panel[hidden] { display: none; }
.install__code {
  display: block;
  position: relative;
  background: #000;
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: var(--s-4);
  padding-right: var(--s-8);
  font-family: var(--font-mono);
  font-size: 13px;
  color: #d6f5f8;
  overflow-x: auto;
  white-space: pre;
}
.copy-btn {
  position: absolute;
  top: var(--s-2);
  right: var(--s-2);
  background: var(--surface);
  border: 1px solid var(--border);
  color: var(--text-muted);
  font-family: var(--font-mono);
  font-size: 11px;
  padding: 4px 8px;
  border-radius: 4px;
  cursor: pointer;
}
.copy-btn:hover { color: var(--cyan); border-color: var(--cyan); }
.copy-btn.is-copied { color: var(--magenta); border-color: var(--magenta); }
```

- [ ] **Step 2: Append markup**

```html
<section class="section" id="install">
  <div class="container">
    <p class="section__eyebrow">install</p>
    <h2 class="section__title">Get it now.</h2>
    <p class="section__lede">One static binary. Pick your platform.</p>

    <div class="install" data-tabs>
      <div class="install__tabs" role="tablist">
        <button class="install__tab" role="tab" aria-selected="true"  data-tab="macos">macOS</button>
        <button class="install__tab" role="tab" aria-selected="false" data-tab="deb">Debian / Ubuntu</button>
        <button class="install__tab" role="tab" aria-selected="false" data-tab="rpm">Fedora / RHEL</button>
        <button class="install__tab" role="tab" aria-selected="false" data-tab="apk">Alpine</button>
        <button class="install__tab" role="tab" aria-selected="false" data-tab="tar">Tarball</button>
        <button class="install__tab" role="tab" aria-selected="false" data-tab="windows">Windows</button>
        <button class="install__tab" role="tab" aria-selected="false" data-tab="go">Go</button>
      </div>

      <div class="install__panel" role="tabpanel" data-panel="macos">
        <pre class="install__code"><button class="copy-btn" data-copy>copy</button>VERSION=$(curl -fsSL https://api.github.com/repos/gammons/slk/releases/latest | grep -oE '"tag_name": *"v[^"]+"' | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | sed 's/^v//')
# Apple Silicon
curl -fsSL "https://github.com/gammons/slk/releases/latest/download/slk_${VERSION}_darwin_arm64.tar.gz" | tar xz
sudo mv slk /usr/local/bin/</pre>
      </div>

      <div class="install__panel" role="tabpanel" data-panel="deb" hidden>
        <pre class="install__code"><button class="copy-btn" data-copy>copy</button>VERSION=$(curl -fsSL https://api.github.com/repos/gammons/slk/releases/latest | grep -oE '"tag_name": *"v[^"]+"' | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | sed 's/^v//')
curl -fsSLO "https://github.com/gammons/slk/releases/latest/download/slk_${VERSION}_linux_amd64.deb"
sudo dpkg -i "slk_${VERSION}_linux_amd64.deb"</pre>
      </div>

      <!-- Repeat for rpm, apk, tar, windows, go panels. Pull commands
           verbatim from the README install section. -->
    </div>

    <p style="margin-top: var(--s-5);">
      Need help authenticating? <a href="/install/">See the setup guide →</a>
    </p>
  </div>
</section>
```

The executing engineer fills in the remaining 5 panels with the exact commands from the slk README. All panels except `macos` get the `hidden` attribute.

- [ ] **Step 3: Verify**

Reload. Expected: install card visible with all tabs styled (macOS active in cyan), only the macOS panel showing. Copy button visible top-right of the code block but doesn't do anything yet.

- [ ] **Step 4: Commit**

```bash
git add styles.css index.html
git commit -m "Add install section with OS tabs (markup + styles)"
```

---

## Task 9: Footer

**Files:**
- Modify: `styles.css`
- Modify: `index.html`

- [ ] **Step 1: Append styles**

```css
.footer {
  border-top: 1px solid var(--border);
  padding: var(--s-6) 0;
  font-family: var(--font-mono);
  font-size: 13px;
  color: var(--text-muted);
  text-align: center;
}
.footer a { color: var(--text-muted); }
.footer a:hover { color: var(--cyan); }
```

- [ ] **Step 2: Append markup (replace closing </body>)**

```html
<footer class="footer">
  <div class="container">
    // MIT licensed · <a href="https://github.com/gammons/slk">github.com/gammons/slk</a> · grant ammons
  </div>
</footer>
</body>
```

- [ ] **Step 3: Verify**

Reload. Expected: small monospace footer at the bottom, dim with cyan-on-hover GitHub link.

- [ ] **Step 4: Commit**

```bash
git add styles.css index.html
git commit -m "Add site footer"
```

---

## Task 10: Page metadata + OG tags

**Files:**
- Modify: `index.html` (head)

- [ ] **Step 1: Replace head**

```html
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>slk — a blazingly fast slack tui</title>
  <meta name="description" content="A blazingly fast Slack TUI. Keyboard-driven, beautifully themed, under 20MB. One static binary. No Electron required.">
  <link rel="icon" type="image/svg+xml" href="/assets/favicon.svg">

  <!-- Open Graph -->
  <meta property="og:title" content="slk — a blazingly fast slack tui">
  <meta property="og:description" content="A blazingly fast Slack TUI. Keyboard-driven, beautifully themed, under 20MB.">
  <meta property="og:url" content="https://getslk.sh">
  <meta property="og:image" content="https://getslk.sh/assets/og-image.png">
  <meta property="og:type" content="website">

  <!-- Twitter -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="slk — a blazingly fast slack tui">
  <meta name="twitter:description" content="A blazingly fast Slack TUI. Keyboard-driven, beautifully themed, under 20MB.">
  <meta name="twitter:image" content="https://getslk.sh/assets/og-image.png">

  <link rel="stylesheet" href="/styles.css">
</head>
```

- [ ] **Step 2: Verify**

Reload. View page source. Expected: all meta tags present, no broken links to favicon (favicon may 404 — fixed in Task 15, fine for now).

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "Add page metadata, OG, and Twitter tags"
```

---

## Task 11: copy.js with tests

Vanilla JS module that wires up `[data-copy]` buttons to copy the text content of their parent code block.

**Files:**
- Create: `js/copy.js`
- Create: `tests/test.html`
- Modify: `index.html` (load copy.js)

- [ ] **Step 1: Write failing test harness**

Create `tests/test.html`:

```html
<!doctype html>
<html>
<head><meta charset="utf-8"><title>tests</title></head>
<body>
<div id="results"></div>
<script type="module">
const results = document.getElementById('results');
const log = (name, ok, err) => {
  const div = document.createElement('div');
  div.textContent = `${ok ? 'PASS' : 'FAIL'} — ${name}${err ? ': ' + err.message : ''}`;
  div.style.color = ok ? 'green' : 'red';
  div.style.fontFamily = 'monospace';
  results.appendChild(div);
};
const test = async (name, fn) => {
  try { await fn(); log(name, true); } catch (e) { log(name, false, e); console.error(e); }
};
const assert = (cond, msg) => { if (!cond) throw new Error(msg || 'assertion failed'); };
const assertEq = (a, b) => { if (a !== b) throw new Error(`expected ${JSON.stringify(b)}, got ${JSON.stringify(a)}`); };

// --- copy.js tests ---
import { initCopyButtons } from '../js/copy.js';

await test('copy button copies text from parent <pre>', async () => {
  document.body.insertAdjacentHTML('beforeend',
    '<pre id="t1"><button class="copy-btn" data-copy>copy</button>hello world</pre>');
  let copied = '';
  navigator.clipboard = { writeText: t => { copied = t; return Promise.resolve(); } };
  initCopyButtons(document.getElementById('t1'));
  document.querySelector('#t1 [data-copy]').click();
  await new Promise(r => setTimeout(r, 10));
  assertEq(copied, 'hello world');
});

await test('button shows is-copied class briefly after click', async () => {
  document.body.insertAdjacentHTML('beforeend',
    '<pre id="t2"><button class="copy-btn" data-copy>copy</button>x</pre>');
  navigator.clipboard = { writeText: () => Promise.resolve() };
  initCopyButtons(document.getElementById('t2'));
  const btn = document.querySelector('#t2 [data-copy]');
  btn.click();
  await new Promise(r => setTimeout(r, 10));
  assert(btn.classList.contains('is-copied'), 'expected is-copied class');
});
</script>
</body>
</html>
```

- [ ] **Step 2: Run test, verify FAIL**

Open `http://localhost:8000/tests/test.html`. Expected: red "FAIL" lines (file not found / module not found).

- [ ] **Step 3: Implement copy.js**

```js
// js/copy.js
export function initCopyButtons(root = document) {
  root.querySelectorAll('[data-copy]').forEach(btn => {
    btn.addEventListener('click', async () => {
      const block = btn.parentElement;
      // Take the parent's text content minus the button's text.
      const text = Array.from(block.childNodes)
        .filter(n => n !== btn)
        .map(n => n.textContent)
        .join('')
        .trim();
      try {
        await navigator.clipboard.writeText(text);
      } catch { return; }
      const original = btn.textContent;
      btn.textContent = 'copied!';
      btn.classList.add('is-copied');
      setTimeout(() => {
        btn.textContent = original;
        btn.classList.remove('is-copied');
      }, 1200);
    });
  });
}

if (typeof document !== 'undefined' && document.readyState !== 'loading') {
  initCopyButtons();
} else if (typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', () => initCopyButtons());
}
```

- [ ] **Step 4: Run test, verify PASS**

Reload `tests/test.html`. Expected: two green "PASS" lines.

- [ ] **Step 5: Wire into index.html**

Before `</body>`:

```html
<script type="module" src="/js/copy.js"></script>
```

- [ ] **Step 6: Verify in browser**

Reload landing page. Click the copy button on the install code block. Expected: button briefly turns magenta, says "copied!"; pasting elsewhere yields the install command.

- [ ] **Step 7: Commit**

```bash
git add js/copy.js tests/test.html index.html
git commit -m "Add click-to-copy with tests"
```

---

## Task 12: tabs.js with tests

**Files:**
- Create: `js/tabs.js`
- Modify: `tests/test.html`
- Modify: `index.html`

- [ ] **Step 1: Append failing tests to tests/test.html**

Add inside the existing `<script type="module">` block, after the copy.js tests:

```js
import { initTabs } from '../js/tabs.js';

await test('clicking a tab selects it and shows its panel', async () => {
  document.body.insertAdjacentHTML('beforeend', `
    <div id="t3" data-tabs>
      <div class="install__tabs">
        <button class="install__tab" aria-selected="true"  data-tab="a">A</button>
        <button class="install__tab" aria-selected="false" data-tab="b">B</button>
      </div>
      <div data-panel="a">PANEL A</div>
      <div data-panel="b" hidden>PANEL B</div>
    </div>`);
  initTabs(document.getElementById('t3'));
  const root = document.getElementById('t3');
  root.querySelector('[data-tab="b"]').click();
  assertEq(root.querySelector('[data-tab="a"]').getAttribute('aria-selected'), 'false');
  assertEq(root.querySelector('[data-tab="b"]').getAttribute('aria-selected'), 'true');
  assert(root.querySelector('[data-panel="a"]').hasAttribute('hidden'));
  assert(!root.querySelector('[data-panel="b"]').hasAttribute('hidden'));
});
```

- [ ] **Step 2: Run, verify FAIL**

Reload `tests/test.html`. Expected: new test fails (module missing).

- [ ] **Step 3: Implement tabs.js**

```js
// js/tabs.js
export function initTabs(root = document) {
  root.querySelectorAll('[data-tabs]').forEach(group => {
    const tabs = group.querySelectorAll('[data-tab]');
    const panels = group.querySelectorAll('[data-panel]');
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        const target = tab.dataset.tab;
        tabs.forEach(t => t.setAttribute('aria-selected', String(t === tab)));
        panels.forEach(p => {
          if (p.dataset.panel === target) p.removeAttribute('hidden');
          else p.setAttribute('hidden', '');
        });
      });
    });
  });
  // If root itself is a [data-tabs] element, also wire it
  if (root instanceof Element && root.matches('[data-tabs]')) {
    const tabs = root.querySelectorAll('[data-tab]');
    const panels = root.querySelectorAll('[data-panel]');
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        const target = tab.dataset.tab;
        tabs.forEach(t => t.setAttribute('aria-selected', String(t === tab)));
        panels.forEach(p => {
          if (p.dataset.panel === target) p.removeAttribute('hidden');
          else p.setAttribute('hidden', '');
        });
      });
    });
  }
}

if (typeof document !== 'undefined' && document.readyState !== 'loading') {
  initTabs();
} else if (typeof document !== 'undefined') {
  document.addEventListener('DOMContentLoaded', () => initTabs());
}
```

- [ ] **Step 4: Run, verify PASS**

Reload `tests/test.html`. Expected: all three tests PASS.

- [ ] **Step 5: Wire into index.html**

Add before `</body>` (after copy.js):

```html
<script type="module" src="/js/tabs.js"></script>
```

- [ ] **Step 6: Verify in browser**

Reload landing page. Click each install OS tab. Expected: clicked tab turns cyan, the matching panel becomes visible, others hide.

- [ ] **Step 7: Commit**

```bash
git add js/tabs.js tests/test.html index.html
git commit -m "Add OS install tabs with tests"
```

---

## Task 13: /themes page

Full themes gallery. Twelve theme cards, each rendering a mini terminal-mockup preview in the theme's actual colors.

**Files:**
- Create: `themes/index.html`

- [ ] **Step 1: Create themes/index.html**

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Themes — slk</title>
  <meta name="description" content="The 12 themes that ship with slk. Drop your own TOML in ~/.config/slk/themes/ to add more.">
  <link rel="icon" type="image/svg+xml" href="/assets/favicon.svg">
  <link rel="stylesheet" href="/styles.css">
</head>
<body>
  <nav class="nav nav--solid" aria-label="Primary">
    <a class="nav__brand" href="/">slk</a>
    <div class="nav__links">
      <a href="/themes/">themes</a>
      <a href="/install/">install</a>
      <a href="https://github.com/gammons/slk">github</a>
    </div>
  </nav>

  <section class="section">
    <div class="container">
      <p class="section__eyebrow">themes</p>
      <h2 class="section__title">Twelve themes ship with slk.</h2>
      <p class="section__lede">
        Live-switch with <span class="kbd">Ctrl+y</span>. Drop your own TOML files
        in <code>~/.config/slk/themes/</code> to add more.
      </p>

      <div class="themes-gallery">
        <!-- Theme: Dracula -->
        <article class="theme-detail" id="dracula">
          <div class="theme-detail__preview" style="--th-bg:#282a36;--th-fg:#f8f8f2;--th-side:#21222c;--th-sel:#44475a;--th-acc:#bd93f9;--th-acc2:#50fa7b;--th-acc3:#ff79c6">
            <!-- mini terminal mockup -->
            <div class="tm">
              <div class="tm__rail" style="background:var(--th-side);color:var(--th-fg)">●</div>
              <div class="tm__sidebar" style="background:var(--th-side);color:var(--th-fg)">
                <div class="tm__section">channels</div>
                <div class="tm__chan" style="color:var(--th-acc)"># general</div>
                <div class="tm__chan">› eng-deploys</div>
                <div class="tm__chan">› random</div>
              </div>
              <div class="tm__main" style="background:var(--th-bg);color:var(--th-fg)">
                <div class="tm__msg"><b style="color:var(--th-acc2)">@grant</b> shipping the new theme today</div>
                <div class="tm__msg"><b style="color:var(--th-acc3)">@dani</b> looks great <span style="color:var(--th-acc)">:rocket:</span></div>
              </div>
            </div>
          </div>
          <div class="theme-detail__meta">
            <h3>Dracula</h3>
            <div class="theme-card__swatches">
              <i style="background:#282a36"></i><i style="background:#bd93f9"></i><i style="background:#50fa7b"></i><i style="background:#ff79c6"></i><i style="background:#8be9fd"></i>
            </div>
          </div>
        </article>

        <!-- Repeat for the remaining 11 themes:
             nord, gruvbox, tokyo-night, catppuccin, monokai,
             solarized-dark, solarized-light, one-dark, kanagawa,
             rose-pine, ayu-dark.
             Each <article id="<slug>"> follows the same structure. The
             executing engineer fills in each theme's bg/fg/sidebar/accent
             colors using their canonical palettes (search the theme's
             official site if uncertain). -->
      </div>

      <p style="margin-top: var(--s-7); color: var(--text-muted); font-size: 14px;">
        Real screenshots will replace these mock previews once available.
      </p>
    </div>
  </section>

  <footer class="footer">
    <div class="container">
      // MIT licensed · <a href="https://github.com/gammons/slk">github.com/gammons/slk</a> · grant ammons
    </div>
  </footer>
</body>
</html>
```

- [ ] **Step 2: Append `.themes-gallery` and `.tm` (terminal mockup) styles to styles.css**

```css
.themes-gallery {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: var(--s-5);
}
@media (max-width: 720px) { .themes-gallery { grid-template-columns: 1fr; } }
.theme-detail {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  overflow: hidden;
}
.theme-detail__preview { padding: 0; }
.theme-detail__meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--s-4);
  border-top: 1px solid var(--border);
}
.theme-detail__meta h3 { margin: 0; font-size: 16px; font-family: var(--font-mono); }

/* mini terminal mockup */
.tm {
  display: grid;
  grid-template-columns: 32px 160px 1fr;
  height: 200px;
  font-family: var(--font-mono);
  font-size: 12px;
}
.tm__rail { display: flex; align-items: flex-start; justify-content: center; padding-top: var(--s-3); }
.tm__sidebar { padding: var(--s-3); }
.tm__section { font-size: 10px; opacity: .6; text-transform: uppercase; letter-spacing: 1px; margin-bottom: var(--s-2); }
.tm__chan { padding: 2px 0; }
.tm__main { padding: var(--s-3); }
.tm__msg { padding: 4px 0; }
```

- [ ] **Step 3: Verify**

Open `http://localhost:8000/themes/`. Expected: page renders, nav is solid, big "Twelve themes ship with slk" heading, gallery shows the Dracula card with a mini terminal-look mockup using Dracula colors. Footer at bottom.

- [ ] **Step 4: Commit**

```bash
git add themes/index.html styles.css
git commit -m "Add /themes page with mini terminal mockups"
```

---

## Task 14: /install page

Setup walkthrough including the auth/cookie steps.

**Files:**
- Create: `install/index.html`

- [ ] **Step 1: Create install/index.html**

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Install & setup — slk</title>
  <meta name="description" content="Install slk and authenticate with your Slack workspace.">
  <link rel="icon" type="image/svg+xml" href="/assets/favicon.svg">
  <link rel="stylesheet" href="/styles.css">
</head>
<body>
  <nav class="nav nav--solid" aria-label="Primary">
    <a class="nav__brand" href="/">slk</a>
    <div class="nav__links">
      <a href="/themes/">themes</a>
      <a href="/install/">install</a>
      <a href="https://github.com/gammons/slk">github</a>
    </div>
  </nav>

  <section class="section">
    <div class="container">
      <p class="section__eyebrow">setup</p>
      <h2 class="section__title">Install slk in three steps.</h2>
      <p class="section__lede">From zero to a connected workspace in about two minutes.</p>

      <h3 class="step-title">1. Install the binary</h3>
      <!-- Reuse the install card markup from index.html (Task 8). Same
           markup, same styles. The executing engineer copies the
           <div class="install" data-tabs>…</div> block here verbatim,
           plus an additional "Verify your download" code block: -->
      <!-- ...full install card... -->

      <details class="verify">
        <summary>Verify your download (optional)</summary>
        <pre class="install__code"><button class="copy-btn" data-copy>copy</button>curl -fsSLO https://github.com/gammons/slk/releases/latest/download/checksums.txt
sha256sum -c checksums.txt --ignore-missing</pre>
      </details>

      <h3 class="step-title">2. Grab your browser tokens</h3>
      <p>slk authenticates by re-using your existing Slack browser session — no Slack App, no OAuth setup. You'll need two values from your browser's DevTools.</p>

      <h4>The <code>d</code> cookie</h4>
      <ol>
        <li>Open <a href="https://app.slack.com">app.slack.com</a> and sign in.</li>
        <li>Open DevTools (<span class="kbd">F12</span> or <span class="kbd">Cmd+Option+I</span>).</li>
        <li>Application tab → Cookies → <code>https://app.slack.com</code>.</li>
        <li>Find the cookie named <code>d</code>. Copy its value.</li>
      </ol>
      <!-- TODO: real annotated screenshots dropped into /assets/install/ later -->
      <div class="placeholder-shot">screenshot: DevTools cookies panel with the <code>d</code> cookie highlighted</div>

      <h4>The <code>xoxc</code> token</h4>
      <p>In the DevTools <strong>Console</strong>, paste this and hit enter:</p>
      <pre class="install__code"><button class="copy-btn" data-copy>copy</button>Object.entries(JSON.parse(localStorage.localConfig_v2).teams).forEach(([id,t]) =&gt; console.log(t.name, t.token))</pre>
      <p>You'll see one line per workspace. Copy the <code>xoxc-…</code> token for the workspace you want.</p>
      <div class="placeholder-shot">screenshot: console output with workspace name and xoxc token</div>

      <h3 class="step-title">3. Add your workspace</h3>
      <pre class="install__code"><button class="copy-btn" data-copy>copy</button>slk --add-workspace</pre>
      <p>You'll be prompted for the <code>d</code> cookie and <code>xoxc</code> token. Paste them in. slk will verify the credentials, fetch your channels, and you're connected.</p>
      <p>To add another workspace later, run <code>slk --add-workspace</code> again. To switch between connected workspaces inside slk, press <span class="kbd">1</span>–<span class="kbd">9</span> or <span class="kbd">Ctrl+w</span>.</p>

      <h3 class="step-title">Troubleshooting</h3>
      <ul class="trouble">
        <li><strong>"Copied N chars" but nothing in clipboard.</strong> Your terminal is dropping OSC 52 writes. tmux: add <code>set -g set-clipboard on</code>. screen: switch to tmux. Older kitty: add <code>clipboard_control write-clipboard</code>.</li>
        <li><strong>Tokens stopped working.</strong> Slack rotated them, or you signed out of the browser. Re-run <code>slk --add-workspace</code> with fresh values.</li>
        <li><strong>Stuck on a step?</strong> Open an issue on <a href="https://github.com/gammons/slk/issues">GitHub</a>.</li>
      </ul>
    </div>
  </section>

  <footer class="footer">
    <div class="container">
      // MIT licensed · <a href="https://github.com/gammons/slk">github.com/gammons/slk</a> · grant ammons
    </div>
  </footer>

  <script type="module" src="/js/copy.js"></script>
  <script type="module" src="/js/tabs.js"></script>
</body>
</html>
```

- [ ] **Step 2: Append `.step-title`, `.placeholder-shot`, `.verify`, `.trouble` styles**

```css
.step-title {
  font-family: var(--font-mono);
  font-size: 18px;
  color: var(--cyan);
  margin: var(--s-7) 0 var(--s-4);
}
.placeholder-shot {
  background: #000;
  border: 1px dashed var(--border);
  border-radius: var(--radius);
  padding: var(--s-7);
  text-align: center;
  color: var(--text-muted);
  font-family: var(--font-mono);
  font-size: 13px;
  margin: var(--s-4) 0;
}
.verify {
  margin: var(--s-4) 0 var(--s-6);
  font-size: 14px;
  color: var(--text-muted);
}
.verify summary { cursor: pointer; }
.verify[open] summary { margin-bottom: var(--s-3); }
.trouble {
  list-style: none;
  padding: 0;
  display: grid;
  gap: var(--s-3);
}
.trouble li {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: var(--s-4);
  font-size: 14px;
}
```

- [ ] **Step 3: Verify**

Open `http://localhost:8000/install/`. Expected: page loads, three numbered step headings in cyan monospace, install tabs work, copy buttons work, dashed placeholder boxes where screenshots will go. Troubleshooting list at bottom in styled cards.

- [ ] **Step 4: Commit**

```bash
git add install/index.html styles.css
git commit -m "Add /install setup walkthrough"
```

---

## Task 15: Favicon, OG image, assets

**Files:**
- Create: `assets/favicon.svg`
- Create: `assets/og-image.png` (placeholder, real one generated after deploy or via screenshot tool)

- [ ] **Step 1: Create favicon.svg**

Simple synthwave-styled mark — a magenta sun on dark background:

```xml
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <rect width="64" height="64" fill="#07051a"/>
  <defs>
    <linearGradient id="s" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#fff7c2"/>
      <stop offset="50%" stop-color="#ffd166"/>
      <stop offset="100%" stop-color="#ff2bd6"/>
    </linearGradient>
  </defs>
  <circle cx="32" cy="32" r="20" fill="url(#s)"/>
  <g stroke="#1a0535" stroke-width="2">
    <line x1="14" y1="36" x2="50" y2="36"/>
    <line x1="14" y1="42" x2="50" y2="42"/>
    <line x1="14" y1="48" x2="50" y2="48"/>
  </g>
</svg>
```

- [ ] **Step 2: OG image placeholder**

Create `assets/og-image.png` as a 1200×630 PNG screenshot of the landing page hero. Easiest path: open the landing page locally, set the browser viewport to 1200×630 via DevTools, screenshot the hero. Save to `assets/og-image.png`.

If a programmatic option is preferred, use Playwright/Puppeteer (out of scope of this plan) or simply commit a placeholder image and replace it later.

- [ ] **Step 3: Verify**

Reload landing page. Expected: tab favicon shows the synthwave sun. View source for `og:image` URL → `http://localhost:8000/assets/og-image.png` returns the file (or placeholder).

- [ ] **Step 4: Commit**

```bash
git add assets/favicon.svg assets/og-image.png
git commit -m "Add favicon and OG image"
```

---

## Task 16: Accessibility + reduced-motion + lighthouse pass

A focused QA pass. No code changes unless issues are found.

**Files:** any of the page files, as needed.

- [ ] **Step 1: Keyboard navigation**

Tab through `/`. Expected: focus order is nav → install tabs → copy buttons → footer link. All focusable elements have a visible focus ring (browsers default to a ring on `:focus-visible` — verify it's not removed). If any element is missing a focus ring, add:

```css
:focus-visible {
  outline: 2px solid var(--cyan);
  outline-offset: 2px;
  border-radius: 2px;
}
```

- [ ] **Step 2: Screen reader smoke test**

Run a quick screen reader pass (VoiceOver on macOS: `Cmd+F5`, or NVDA on Windows).
Expected:
- The hero is reachable but the decorative SVGs (palms, mountains) are skipped (`aria-hidden="true"` already set in Task 3).
- The `slk` logo h1 announces as a heading.
- Nav links announce correctly.

If the install tabs aren't announced as a tablist, ensure `role="tablist"` / `role="tab"` / `role="tabpanel"` markup is correct (already in Task 8).

- [ ] **Step 3: Reduced-motion**

DevTools → Rendering → Emulate `prefers-reduced-motion: reduce`. Reload `/`. Expected: stars no longer twinkle (Task 2 base CSS already enforces this).

- [ ] **Step 4: Color contrast**

Run Lighthouse → Accessibility on `/`, `/themes/`, `/install/`. Expected: scores ≥ 95 each. Fix any reported contrast issues by lifting `--text-muted` slightly if needed (current `#a89cc8` on `#0e0a22` should pass AA).

- [ ] **Step 5: Page weight**

DevTools → Network → reload `/` with cache disabled. Expected:
- Total transfer < 100KB (excluding OG image).
- No font requests (system fonts only).
- No third-party requests.

- [ ] **Step 6: Commit any fixes**

```bash
git add -A
git commit -m "Accessibility and reduced-motion polish"
```

If no fixes needed, skip the commit.

---

## Task 17: GitHub Pages deploy

**Files:** none (configuration via the GitHub web UI).

- [ ] **Step 1: Push to GitHub**

```bash
git push origin main
```

- [ ] **Step 2: Enable GitHub Pages**

In the GitHub repo settings → Pages:
- Source: "Deploy from a branch"
- Branch: `main`, folder: `/ (root)`
- Custom domain: `getslk.sh` (already verified by user via A records)
- Enforce HTTPS: on

- [ ] **Step 3: Verify live**

Wait ~1 minute for the build. Then visit https://getslk.sh.
Expected:
- Hero renders identically to local.
- All three pages reachable: `/`, `/themes/`, `/install/`.
- HTTPS lock icon present.
- `view-source:https://getslk.sh` shows the same HTML as local.

- [ ] **Step 4: Smoke test on mobile**

Open https://getslk.sh on a phone. Expected: hero scales sensibly (palms still visible, sun proportional, install pill readable), nav is usable, sections stack to single column.

If the hero looks broken on narrow viewports, add a small responsive tweak — e.g., shrink palm width, sun width — and push.

- [ ] **Step 5: Done**

No commit needed unless step 4 required changes.

---

## Self-review notes

Run before declaring the plan complete:

- **Spec coverage:** every page, section, and visual element from the spec maps to a task. Hero (Task 3), nav (Task 4), Why slk (5), Features (6), Themes strip (7), Install (8), Footer (9), metadata (10), copy.js (11), tabs.js (12), /themes (13), /install (14), favicon/OG (15), accessibility (16), deploy (17). ✓
- **Placeholders:** placeholder content is intentionally limited to (a) the 11 themes the engineer fills in from canonical palettes, (b) the 5 OS install panels copied verbatim from the README, (c) screenshots that the user will provide later. Each is explicitly called out with instructions for the executing engineer.
- **Type consistency:** class names (`hero__*`, `install__*`, etc.) used consistently across CSS and HTML tasks. JS module exports (`initCopyButtons`, `initTabs`) match the imports in `tests/test.html`.

