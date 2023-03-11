# frozen_string_literal: true

json.extract! user_name, :id, :created_at, :updated_at
json.url user_name_url(user_name, format: :json)
