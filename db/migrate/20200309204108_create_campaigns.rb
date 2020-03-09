# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :campaigns do
      primary_key :id
      column :job_id, Integer
      column :status, String
      column :external_reference, String
      column :ad_description, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
