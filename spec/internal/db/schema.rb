# frozen_string_literal: true

ActiveRecord::Schema.define(version: 0) do
  create_table :authors do |t|
    t.string :name
  end

  create_table :books do |t|
    t.references :author, foreign_key: { on_delete: :cascade }
    t.string :name
    t.string :tags, array: true
  end

  create_table :chapters do |t|
    t.references :book, foreign_key: { on_delete: :cascade }
    t.text :title
    t.text :content
  end

  create_table :schema_migrations, id: false do |t|
    t.string :version, primary_key: true
  end

  create_view :popular_authors, materialized: true

  create_table :magazines do |t|
    t.string :title
    t.string :from
  end
end
