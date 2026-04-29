# getslk.sh website — design

## Purpose

A small marketing-and-light-docs website for `slk`, the Slack TUI client.
Lives at https://getslk.sh. Goals, in priority order:

1. Make a strong first impression that matches slk's personality (fast,
   keyboard-first, beautifully themed).
2. Get a visitor from "I just heard about this" to "I have it installed
   and connected" with as little friction as possible.
3. Show off the themes — visually, the strongest selling point that a
   GitHub README can't do justice to.

The README on the GitHub repo remains the canonical reference docs.
The website does not duplicate it.

## Aesthetic

Locked direction: **classic synthwave** — deep purple sky fading to a
muted-magenta horizon, big horizon-bisected sun with horizontal slice
lines, perspective magenta grid floor, twinkling stars, palm-tree
silhouettes flanking the hero, jagged mountain silhouette behind the
sun.

Reference mockup: `.superpowers/brainstorm/<session>/content/hero-classic-v6.html`
(approved by user as the visual north star).

**Palette (locked):**

| Role                   | Color       | Usage                              |
|------------------------|-------------|------------------------------------|
| Sky top                | `#07051a`   | Page background top                |
| Sky mid                | `#14093a`   | Mid-sky                            |
| Sky horizon (purple)   | `#4a1668`   | Just above horizon                 |
| Sky horizon (magenta)  | `#6b1a7a`   | Right at horizon                   |
| Magenta accent         | `#ff2bd6`   | Sun gradient end, grid, horizon line, prompt char |
| Sun mid (orange)       | `#ff8a3d`   | Sun gradient                       |
| Sun mid (gold)         | `#ffd166`   | Sun gradient                       |
| Sun top (cream)        | `#fff7c2`   | Sun gradient start                 |
| Cyan accent            | `#22d3ee`   | Tagline, install border, links     |
| Cyan deep              | `#00b4d8`   | Cyan glow shadow                   |
| Purple deep (silhouette) | `#1a0535` | Mountain silhouette                |
| Palm silhouette        | `#0a0418`   | Palm trees                         |
| Body text              | `#e6e0ff`   | Default body copy on dark sections |
| Body text muted        | `#a89cc8`   | Secondary copy                     |
| Surface (card)         | `#0e0a22`   | Card backgrounds below the fold    |
| Border                 | `#2a1f4a`   | Subtle dividers / card borders     |

**Type:**

- **Display / logo:** system sans-serif stack, very heavy weight (900),
  tight letter-spacing, layered neon text-shadow (already proven on the
  hero "slk" treatment).
- **Body:** system sans-serif stack (`-apple-system`, etc.), comfortable
  reading sizes.
- **Code / monospace accents:** `ui-monospace, "SF Mono", Menlo,
  monospace` — used for taglines, install commands, keyboard hints,
  config blocks. Reinforces the terminal-tool identity.
- **Tagline shadow rule:** any small monospace text placed *over* the
  synthwave hero (or any magenta-heavy region) gets a layered dark
  drop-shadow underneath the cyan glow for legibility — pattern proven
  in v6.

**Movement:** stars twinkle (CSS keyframe). No other animation in v1 —
no scroll-jacking, no parallax, no auto-playing demos. Reduced-motion
preference is respected (twinkle is disabled if the user has
`prefers-reduced-motion: reduce`).

## Pages

Three pages, each its own hand-written `.html` file. No client-side
routing.

### 1. `/` — landing (`index.html`)

Sections, in order:

1. **Hero** — full synthwave scene from v6 (sun, grid, stars, palms,
   mountains). "slk" logo + "a blazingly fast slack tui" tagline + a
   single install command pill (`brew install gammons/tap/slk`) with a
   click-to-copy affordance. A small "View on GitHub" link below the
   pill.
2. **Why slk** — one-line punchline ("The Slack desktop client, minus
   the 1.5GB of Chromium"), then a 4-stat row: cold-start time, RSS
   memory, binary size, render approach. Numbers come straight from the
   README's "Why slk?" section.
3. **Features grid** — a 2×3 or 3×2 grid of the headline features:
   real-time messaging, threads, reactions, multi-workspace, themes,
   keyboard-first. Each card: small monospace label, short description,
   one tiny visual touch (mocked terminal snippet, key cap, reaction
   pill, etc).
4. **Themes preview strip** — a horizontal scroller (or grid on mobile)
   showing each of the 12 themes as a small terminal mockup. Each card
   links to the corresponding entry on `/themes`.
5. **Install** — "Get it now" CTA block. Per-OS install commands shown
   in tabs (macOS, Linux deb, Linux rpm, Linux apk, tarball, Windows,
   Go). Each command has click-to-copy. Below the tabs: a single link
   "Need help authenticating? See the setup guide →" pointing to
   `/install`.
6. **Footer** — minimal: project name, MIT license, GitHub link,
   author credit.

### 2. `/themes` (`themes/index.html`)

Twelve theme cards. Each card is a mini terminal mockup that renders a
realistic Slack-like sidebar + message pane in that theme's actual
colors (sourced from the slk repo's bundled theme TOML files). Card
shows the theme name and palette swatches. Clicking a card opens an
expanded preview (could be just an in-page modal/lightbox or a scroll
to a detail row — implementation detail decided in plan, not spec).

A footnote at the top explains: "These ship with slk. Drop your own
TOML in `~/.config/slk/themes/` to add more."

### 3. `/install` (`install/index.html`)

The setup walkthrough. The README's install commands are useful but
the auth section ("grab your `d` cookie and `xoxc` token from
DevTools") is the single fiddliest moment for new users. This page
exists to make that less scary.

Sections:

1. **Step 1: Install the binary** — same per-OS tabs as on the landing
   page, but with a bit more breathing room and the verify-checksums
   step included.
2. **Step 2: Grab your browser tokens** — annotated screenshots:
    - DevTools → Application → Cookies → copy `d` cookie value.
    - DevTools → Console → run the `localConfig_v2` snippet → copy
      `xoxc-…` token.
3. **Step 3: Add your workspace** — the `slk --add-workspace` flow,
   what to expect, how to add additional workspaces later.
4. **Troubleshooting** — short list of the most common gotchas pulled
   from the README (OSC 52 clipboard caveats, token expiry, how to
   re-add a workspace).

## Site-wide elements

- **Header / nav:** ultra-minimal. Top-left: "slk" wordmark (small,
  links to `/`). Top-right: `Themes`, `Install`, `GitHub` — three text
  links. The nav sits *inside* the hero on the landing page (so the
  hero is the first thing you see), and as a thin bar at the top of
  the other two pages.
- **Footer:** identical across all three pages. Small monospace text:
  `// MIT licensed · github.com/gammons/slk · grant ammons`.
- **Background:** the non-hero sections of the landing page, plus the
  full body of `/themes` and `/install`, use a near-solid deep-purple
  background (`#0e0a22` over `#07051a`). Synthwave is *concentrated* in
  the hero; the rest of the site is calm dark-mode with neon accents
  (cyan links, magenta highlights for code/prompts) and the occasional
  glowing divider. This keeps the page readable and prevents
  synthwave-fatigue.
- **Click-to-copy:** any code block representing a command the user
  should run gets a subtle copy button in its top-right corner that
  flashes a brief "copied!" confirmation. Implemented in vanilla JS
  (~30 lines), no library.

## Tech stack

- **Hand-written static HTML + CSS.** No build step, no JS framework,
  no Node toolchain.
- **One shared stylesheet** at `/styles.css` covering tokens, layout
  primitives, components.
- **Hero CSS** lives in the shared stylesheet (the hero scene is the
  visual centerpiece and is the only place the full synthwave treatment
  appears).
- **JavaScript:** vanilla, kept to two small files at most:
    - `copy.js` — click-to-copy buttons.
    - `tabs.js` — install-command OS tabs.
  No bundler, just plain `<script defer>` tags.
- **Images:** SVG inline for the hero (sun, palms, mountains, grid are
  all CSS/SVG), PNG/SVG for theme previews if needed, OG image as a
  PNG export of the hero scene.
- **Fonts:** system fonts only. No web-font network requests.

## Hosting

- GitHub Pages from this repo. A records for `getslk.sh` already point
  at GitHub Pages (per user).
- Repo will contain a `CNAME` file at the publish root with
  `getslk.sh`.
- Deploy on push to `main` via the default GitHub Pages workflow. No
  custom CI needed.

## File / directory layout

```
/
├── index.html             # landing
├── themes/
│   └── index.html
├── install/
│   └── index.html
├── styles.css             # all shared styles
├── js/
│   ├── copy.js
│   └── tabs.js
├── assets/
│   ├── og-image.png       # social card (hero scene exported)
│   ├── favicon.svg
│   └── themes/            # any per-theme assets
├── CNAME                  # contains: getslk.sh
└── README.md              # site repo readme (NOT the project readme)
```

## Out of scope (for v1)

- Search.
- Animated demo videos / asciinema embeds. (Could be added in v2.)
- A blog / changelog page. (Releases live on GitHub.)
- Internationalization.
- Analytics. (Can be added later if desired.)
- Comment system / community page.
- A separate keybindings cheatsheet page — covered well enough by the
  README.

## Success criteria

- Landing page loads in under 200ms on a fresh connection (no fonts,
  no JS framework, ~30KB total page weight target excluding the OG
  image).
- All three pages render correctly with JavaScript disabled (copy
  buttons degrade to plain code blocks the user can manually copy).
- The themes gallery shows all 12 themes in their actual colors.
- Setup walkthrough takes a new user from "binary installed" to
  "connected to a workspace" without reading the README.
- The hero is unmistakably synthwave on first load, with no
  noticeable layout shift.
