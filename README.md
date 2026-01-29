# Audio Scrapers for Stash

Audio scrapers for use with [stashcoder42/stash](https://github.com/stashcoder42/stash), a fork of Stash with audio file support.

**Note:** These scrapers require the audio feature which is not available in upstream Stash. You must use the `stashcoder42-main` branch or a release from the fork.

## Available Scrapers

### Soundgasm
Scrapes audio pages from `soundgasm.net/u/{user}/{audio-slug}`

**Extracted fields:**
- Title
- Details (description text)
- Performer (from username)
- Tags (parsed from bracketed items like `[F4M]`, `[Blowjob]`, etc.)

## Installation

### Option 1: Add as Package Source (Recommended)

1. In Stash, go to **Settings → Metadata Providers → Scrapers**
2. Under **Available Scrapers**, click **Add Source**
3. Add:
   - **Name:** Audio Scrapers
   - **Source URL:** `https://stashcoder42.github.io/audio-scrapers/stable/index.yml`
4. Click **Save**, then install scrapers from the list

### Option 2: Manual Installation

1. Download the scraper `.yml` file from the `scrapers/` directory
2. Copy it to your Stash scrapers folder (typically `~/.stash/scrapers/`)
3. Reload scrapers in Stash (Settings → Metadata Providers → Scrapers → Reload)

## Usage

1. Navigate to an audio's detail page in Stash
2. Click the **Scrape** button
3. Enter the soundgasm URL
4. Review and apply the scraped metadata
