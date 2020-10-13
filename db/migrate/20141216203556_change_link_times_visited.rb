# frozen_string_literal: true

class ChangeLinkTimesVisited < ActiveRecord::Migration[5.2]
  def change
    change_column :links, :times_visited, :integer, default: 0
  end
end
