require 'rails_helper'

RSpec.describe Comment, type: :model do
  # user_id and movie_id can't be blank
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:movie_id) }

  # minimum length for comment is 10 characters.
  it { is_expected.to allow_value("This is valid comment for a movie").for(:body) }
  it { is_expected.to allow_value("So is this").for(:body) }
  it { is_expected.not_to allow_value("ok").for(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(3).on(:create) }

end
