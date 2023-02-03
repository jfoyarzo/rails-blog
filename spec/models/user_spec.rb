require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Test User', photo: 'www.testimage.com', bio: 'Just a user generated for the purposes of testing')
  end
  before { subject.save }

  describe 'Validations' do
    it 'should have a name to be valid' do
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'should have an integer greater or equal to 0 as posts_counter to be valid' do
      subject.posts_counter = -1
      expect(subject).to be_invalid
    end
  end

  describe '#recent_posts' do
    it 'should return only the last 3 posts' do
      4.times { Post.create(title: 'Title1', text: 'text1', author_id: subject.id) }
      expect(User.recent_posts(subject.id)).to eq(subject.posts.last(3))
    end
  end
end
