# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Setup
bin/setup                  # Full automated setup
bundle install             # Install gems

# Database
bin/rails db:prepare       # Create + migrate
bin/rails db:migrate       # Run pending migrations
bin/rails db:seed          # Load seed data

# Run
bin/rails server           # Start server on port 3005

# Test
bin/rails test             # Run all tests (Minitest)
bin/rails test:system      # Run system tests (Capybara + Selenium)
bin/rails test test/models/earring_test.rb  # Run a single test file
```

## Architecture

**EarTrack** (internally "AppAretes") is a Rails 7 inventory management app for earrings, using PostgreSQL and Hotwire (Turbo + Stimulus). Default locale is Spanish (`es`).

### Core Domain

- **Key** — organizational grouping (has many earrings). Fields: `num_key`, `upp`.
- **Earring** — individual item belonging to a Key. Fields: `earring` (4-digit code), `status` (live/dead/sold), `age`, `gender`, and one attached photo via Active Storage.
- **Setting** — singleton-style app config. Fields: `upp_key`, `producer_full_name`, `produced_address`.

### Routes

```
root → dashboard#index
resources :earrings
resources :keys
resources :settings, only: [:index, :update, :create]
get 'reports/index' → reports#index
```

### Frontend

- Bootstrap 5.2 + Font Awesome 6.4 via Sprockets (no npm/yarn)
- Stimulus controllers in `app/javascript/controllers/`
- Turbo for SPA-like navigation
- WickedPDF for PDF generation in reports

### Internationalization

All user-facing strings go through i18n. Locale files are in `config/locales/` — `en.yml`, `es.yml`, and model-specific files under `config/locales/models/`. Always add keys to both `en` and `es` when adding new UI text.

### Environment

Development database credentials are in `.env` (PostgreSQL user `develop`, password `dev12345`). The server runs on port **3005** (set in `config/puma.rb`).
