# SEO Plan for Daily Menu Site

## Overview

This document outlines the SEO strategy for the **Daily Menu** site — a Defold WebAssembly game that helps users find recipes based on ingredients they already have in their fridge. The site is currently a bare HTML5 game loader with no SEO metadata.

**Target theme:** "Как приготовить вкусное блюдо из того, что есть в холодильнике" (How to cook a delicious meal from what's in the fridge)

**Target audience:** Russian-speaking users in Russia and CIS countries

---

## 1. SEO Meta Tags (for 5 Search Engines)

The following search engines are popular in Russia and Russian-speaking countries:

| # | Search Engine | Market Share (RF) | Key Features |
|---|--------------|-------------------|--------------|
| 1 | **Yandex** | ~60% | Dominant in Russia; supports `yandex` robots tag, `yandex-verification` |
| 2 | **Google** | ~38% | Global standard; Open Graph, Twitter Cards, JSON-LD |
| 3 | **Mail.ru** | ~1.5% | Uses Google-like indexing; supports Open Graph |
| 4 | **Rambler** | <1% | Legacy; supports basic meta tags |
| 5 | **Sputnik** (Ростелеком) | <1% | State search engine; supports basic meta tags |

### Required Meta Tags

All tags will be placed in a separate include file `seo-meta.html` and referenced from `index.html`.

#### Basic Meta Tags (all search engines)

```html
<!-- Character encoding -->
<meta charset="utf-8">

<!-- Viewport (already exists) -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Title (most important SEO element) -->
<title>Ежедневное меню — рецепты из того, что есть в холодильнике | Daily Menu</title>

<!-- Description -->
<meta name="description" content="Ежедневное меню — найди рецепт из продуктов, которые уже есть в холодильнике. Простые и вкусные блюда: завтрак, обед и ужин за 10-30 минут. Калькулятор калорий и стоимости блюда.">

<!-- Keywords -->
<meta name="keywords" content="рецепты, что приготовить, из того что есть в холодильнике, простые рецепты, быстрые блюда, ежедневное меню, завтрак обед ужин, рецепты из остатков, кулинария, готовка">

<!-- Author -->
<meta name="author" content="Daily Menu">

<!-- Robots (all search engines) -->
<meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large">

<!-- Yandex-specific -->
<meta name="yandex" content="index, follow">
<meta name="yandex-verification" content="[PLACE_YANDEX_VERIFICATION_CODE]">

<!-- Google-specific -->
<meta name="googlebot" content="index, follow, max-snippet:-1, max-image-preview:large">
<meta name="google-site-verification" content="[PLACE_GOOGLE_VERIFICATION_CODE]">

<!-- Mail.ru-specific -->
<meta name="mailru-verification" content="[PLACE_MAILRU_VERIFICATION_CODE]">
```

#### Open Graph (Facebook, VK, Telegram, messengers)

```html
<meta property="og:title" content="Ежедневное меню — рецепты из того, что есть в холодильнике">
<meta property="og:description" content="Найди рецепт из продуктов, которые уже есть в холодильнике. Простые и вкусные блюда за 10-30 минут.">
<meta property="og:type" content="website">
<meta property="og:url" content="https://[YOUR-DOMAIN].github.io/daily_menu/">
<meta property="og:image" content="https://[YOUR-DOMAIN].github.io/daily_menu/web_icon.png">
<meta property="og:image:width" content="512">
<meta property="og:image:height" content="512">
<meta property="og:locale" content="ru_RU">
<meta property="og:site_name" content="Daily Menu — Ежедневное меню">
```

#### Twitter Cards

```html
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Ежедневное меню — рецепты из того, что есть в холодильнике">
<meta name="twitter:description" content="Найди рецепт из продуктов, которые уже есть в холодильнике. Простые и вкусные блюда за 10-30 минут.">
<meta name="twitter:image" content="https://[YOUR-DOMAIN].github.io/daily_menu/web_icon.png">
```

#### VK (Vkontakte) specific

```html
<meta property="vk:title" content="Ежедневное меню — рецепты из того, что есть в холодильнике">
<meta property="vk:description" content="Найди рецепт из продуктов, которые уже есть в холодильнике. Простые и вкусные блюда за 10-30 минут.">
<meta property="vk:image" content="https://[YOUR-DOMAIN].github.io/daily_menu/web_icon.png">
```

---

## 2. JSON-LD Structured Data

Structured data helps search engines understand the content and enables rich snippets in search results.

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebApplication",
  "name": "Daily Menu — Ежедневное меню",
  "description": "Найди рецепт из продуктов, которые уже есть в холодильнике. Простые и вкусные блюда: завтрак, обед и ужин за 10-30 минут.",
  "applicationCategory": "LifestyleApplication",
  "operatingSystem": "Web",
  "browserRequirements": "Requires WebGL",
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "RUB"
  },
  "author": {
    "@type": "Organization",
    "name": "Daily Menu"
  }
}
</script>
```

---

## 3. Favicon & Web Icon Configuration

The file `web_icon.png` already exists. We need to add proper `<link>` tags to make it appear in search results as the site icon.

```html
<!-- Standard favicon -->
<link rel="icon" type="image/png" sizes="32x32" href="web_icon.png">
<link rel="icon" type="image/png" sizes="16x16" href="web_icon.png">

<!-- Apple Touch Icon (iOS, Safari) -->
<link rel="apple-touch-icon" sizes="180x180" href="web_icon.png">
<link rel="apple-touch-icon" sizes="152x152" href="web_icon.png">
<link rel="apple-touch-icon" sizes="120x120" href="web_icon.png">

<!-- Android Chrome -->
<link rel="icon" type="image/png" sizes="192x192" href="web_icon.png">
<link rel="icon" type="image/png" sizes="512x512" href="web_icon.png">

<!-- Microsoft Tiles -->
<meta name="msapplication-TileImage" content="web_icon.png">
<meta name="msapplication-TileColor" content="#ffffff">
```

**Important:** The `web_icon.png` should ideally be a square PNG at least 512x512px. If it's smaller, search engines may not display it. Consider creating a proper favicon.ico (multi-size) for maximum compatibility.

---

## 4. robots.txt

```txt
User-agent: *
Allow: /
Sitemap: https://[YOUR-DOMAIN].github.io/daily_menu/sitemap.xml

# Yandex-specific
User-agent: Yandex
Allow: /
Host: https://[YOUR-DOMAIN].github.io/daily_menu
Clean-param: utm_source&utm_medium&utm_campaign
```

---

## 5. sitemap.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://[YOUR-DOMAIN].github.io/daily_menu/</loc>
    <lastmod>2025-01-01</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
```

---

## 6. Answer: Domain vs GitHub Pages (Question 2)

**You do NOT need a custom domain to set up SEO.** You can start with GitHub Pages and add a custom domain later.

### GitHub Pages approach (recommended for start):

1. Push the site to a GitHub repository
2. Enable GitHub Pages in repo Settings → Pages → deploy from `main` branch
3. Your site will be at: `https://[USERNAME].github.io/daily_menu/`
4. Add all SEO meta tags, robots.txt, sitemap.xml with the GitHub Pages URL
5. Submit the URL to Yandex.Webmaster and Google Search Console

### Adding a custom domain later:

1. Buy a domain (e.g., `dailymenu.ru` or `dailymenu.recipes`)
2. Add CNAME record pointing to `[USERNAME].github.io`
3. Configure GitHub Pages to use the custom domain
4. Update all SEO URLs (og:url, sitemap.xml, canonical) to the new domain
5. Re-submit to search engines

**Recommendation:** Start with GitHub Pages, set up SEO, get indexed, then add a domain later. SEO meta tags work identically on GitHub Pages and custom domains.

---

## 7. Answer: How to Set Up Yandex Advertising Network (РСЯ) (Question 4)

### Yandex Advertising Network (РСЯ — Рекламная Сеть Яндекса) Setup Guide:

#### Step 1: Prerequisites
- Site must be indexed by Yandex (submit to Yandex.Webmaster first)
- Site must have unique content (the game/recipes qualify)
- Site must comply with Yandex's content policies

#### Step 2: Register in Yandex.Webmaster
1. Go to https://webmaster.yandex.ru/
2. Add your site and verify ownership (meta tag, DNS record, or file upload)
3. Submit sitemap.xml
4. Wait for indexing (1-7 days)

#### Step 3: Apply to Yandex Advertising Network (РСЯ)
1. Go to https://partner.yandex.ru/
2. Register as a publisher
3. Add your site for moderation
4. Wait for approval (usually 1-14 days)

#### Step 4: Get Ad Code
1. After approval, create an ad unit in Yandex Partner interface
2. Choose ad format (recommended: responsive block for mobile compatibility)
3. Copy the JavaScript ad code

#### Step 5: Integrate Ad Code into the Site
Since this is a Defold WASM game, there are two approaches:

**Option A: Banner above/below the game canvas (recommended)**
Add the ad code in `index.html` as a `<div>` before or after the game container:

```html
<!-- Ad before game -->
<div id="yandex-ad-top" style="text-align:center; margin:10px auto;">
  <!-- Yandex.RTB R-A-XXXXXXXXX-X -->
  <div id="yandex_rtb_R-A-XXXXXXXXX-X"></div>
  <script>window.yaContextCb=window.yaContextCb||[]</script>
  <script src="https://yandex.ru/ads/system/context.js" async></script>
  <script>
    (function(w,d,n,s,t){w[n]=w[n]||[];w[n].push(function(){
      Ya.Context.AdvManager.render({
        renderTo: 'yandex_rtb_R-A-XXXXXXXXX-X',
        blockId: 'R-A-XXXXXXXXX-X'
      })
    });t=d.getElementsByTagName(d.head)[0];
    var x=d.createElement(s);x.src='https://yandex.ru/ads/system/context.js';
    x.async=true;t.parentNode.insertBefore(x,t);
    })(window,document,'yandexContextAsyncCallbacks','script');
  </script>
</div>
```

**Option B: In-game ads via Defold**
If you want ads inside the game itself, you'd need to:
1. Create a Defold extension that loads Yandex ads via JavaScript bridge
2. Use `html5.run()` or `webview.show()` in Defold to display ads
3. This is significantly more complex

**Recommendation:** Start with Option A (banner outside the game canvas) as it's simpler and doesn't require game code changes.

#### Important РСЯ Notes:
- **Mobile-first:** Yandex prioritizes mobile-friendly sites. The current site already has viewport meta tag.
- **Content quality:** The recipes in `recipes.json` are excellent content for Yandex indexing.
- **Traffic requirement:** Yandex typically requires some traffic before approving. Start with SEO first.
- **Ad placement:** Don't cover the game canvas with ads — Yandex prohibits deceptive ad placement.

---

## 8. Implementation Plan

### Files to Create:
1. **`seo-meta.html`** — All SEO meta tags in one file (for easy maintenance)
2. **`robots.txt`** — Search engine crawling rules
3. **`sitemap.xml`** — Site structure for search engines

### Files to Modify:
4. **`index.html`** — Add SEO meta tags, favicon links, JSON-LD, change `<html lang="ru">`, update `<title>`

### Implementation Steps:

| Step | File | Action |
|------|------|--------|
| 1 | `index.html` | Change `<html lang="en">` → `<html lang="ru">` |
| 2 | `index.html` | Update `<title>` from "daily_menu 1.0" to SEO-optimized Russian title |
| 3 | `seo-meta.html` | Create file with all meta tags (basic, OG, Twitter, VK, Yandex) |
| 4 | `index.html` | Include `seo-meta.html` content in `<head>` |
| 5 | `index.html` | Add favicon/apple-touch-icon links pointing to `web_icon.png` |
| 6 | `index.html` | Add JSON-LD structured data script |
| 7 | `robots.txt` | Create with allow rules and sitemap reference |
| 8 | `sitemap.xml` | Create with the single page URL |
| 9 | All | Replace `[PLACEHOLDER]` values with actual verification codes |

---

## 9. SEO Checklist for Launch

- [ ] Change `<html lang="en">` to `<html lang="ru">`
- [ ] Add descriptive Russian `<title>` (max 60 chars)
- [ ] Add `<meta name="description">` (max 160 chars)
- [ ] Add Open Graph tags (og:title, og:description, og:image, og:url)
- [ ] Add Twitter Card tags
- [ ] Add VK meta tags
- [ ] Add favicon and apple-touch-icon links
- [ ] Add JSON-LD structured data
- [ ] Create `robots.txt`
- [ ] Create `sitemap.xml`
- [ ] Submit to Yandex.Webmaster
- [ ] Submit to Google Search Console
- [ ] Verify site ownership in both services
- [ ] Monitor indexing status
- [ ] After indexing, apply to Yandex Advertising Network (РСЯ)