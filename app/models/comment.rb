# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, :movie_id, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }

  validates :body, presence: true, length: { minimum: 3 }

end
