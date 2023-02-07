require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before(:each) { get users_path }

    it 'responds with the correct http status code' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'response body contains the correct placeholder text' do
      expect(response.body).to include('This will display list of users')
    end
  end

  describe 'GET /users/:id' do
    before(:each) { get('/users/1') }

    it 'responds with the correct http status code' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end

    it 'response body contains the correct placeholder text' do
      expect(response.body).to include('This will display a specific user by id')
    end
  end
end
