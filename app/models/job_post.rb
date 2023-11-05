class JobPost < ApplicationRecord
    include Elasticsearch::Model

    validates :expiry_date, presence: true
    index_name "job_posts_#{Rails.env}"

    def as_indexed_json(_options = {})
    as_json(only: [:title, :description])
  end
  end
  