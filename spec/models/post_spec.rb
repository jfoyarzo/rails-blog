require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(title: 'Title1', text: 'text1', author_id: 1)
  end
  before { subject.save }

  describe 'Validations' do
    it 'should have a title to be valid' do
      subject.title = nil
      expect(subject).to be_invalid
    end

    it 'should have a title that doesn\'t exceeds 250 characters to be valid' do
      subject.title = '0' * 255
      expect(subject).to be_invalid
    end

    it 'should have an integer greater or equal to 0 as comments_counter to be valid' do
      subject.comments_counter = -1
      expect(subject).to be_invalid
    end

    it 'should have an integer greater or equal to 0 as likes_counter to be valid' do
      subject.likes_counter = -1
      expect(subject).to be_invalid
    end
  end

  describe '#recent_comments' do
    it 'should return only the last 5 comments' do
      6.times { Comment.create(text: 'text1', author_id: 1, post_id: subject.id) }
      expect(Post.recent_comments(subject.id)).to eq(subject.comments.last(5))
    end
  end
end
