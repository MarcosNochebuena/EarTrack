# ── Stage: desarrollo ─────────────────────────────────────
FROM ruby:3.4.1-slim AS development

RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
  build-essential \
  libpq-dev \
  git \
  curl \
  nodejs \
  libxrender1 libfontconfig1 libxext6 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

# ── Stage: producción ──────────────────────────────────────
FROM development AS production

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

RUN bundle exec rails assets:precompile SECRET_KEY_BASE=placeholder

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
