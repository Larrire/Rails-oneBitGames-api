require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expect.to validate_presence_of(:name) }
end
