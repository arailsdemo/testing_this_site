class Post < ActiveRecord::Base
  STATUSES = ['pending', 'published'].freeze

  has_many :sections
  accepts_nested_attributes_for :sections

  def pending?
    status == 'pending'
  end
end
