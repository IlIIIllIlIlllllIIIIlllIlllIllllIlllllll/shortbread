# frozen_string_literal: true

class ChangeOriginalLinkToText < ActiveRecord::Migration[5.2]
  def change
    change_column :links, :original_url, :text
  end
end
