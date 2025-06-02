# frozen_string_literal: true

json.array! @keys, partial: 'keys/key', as: :key
