# frozen_string_literal: true

# Creates an index on the `short_url` column
class CreateShortUrlIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :links, :short_url
  end
end
