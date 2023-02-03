require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Test User', photo: 'www.testimage.com', bio: 'Just a user generated for the purposes of testing')
  end
  before { subject.save }

  it 'should have a name to be valid' do
    subject.name = nil
    expect(subject).to be_invalid
  end
end