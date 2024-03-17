class Book < ApplicationRecord
  belongs_to :author, optional: true

  has_many :book_tags
  has_many :tags, through: :book_tags

  validates :title, presence: true

  scope :filter_by_title, -> (title) { where("title ILIKE ?", "%#{title}%") if title.present? }
  scope :filter_by_year, -> (year) { where(year_of_publication: year) if year.present? }
  scope :filter_by_author_id, -> (author_id) { where(author_id: author_id) if author_id.present? }
  scope :filter_by_tag_id, -> (tag_id) { joins(:tags).where(tags: { id: tag_id }).distinct if tag_id.present? }

  def self.sorted(sort, direction)
    sort_column = %w[title year_of_publication authors.name].include?(sort) ? sort : 'created_at'
    sort_direction = %w[asc desc].include?(direction) ? direction : 'asc'

    if sort_column == 'authors.name'
      joins(:author).order("authors.name #{sort_direction}")
    else
      order("#{sort_column} #{sort_direction}")
    end
  end
end