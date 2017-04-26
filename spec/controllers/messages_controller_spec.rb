require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:message) { create(:message) }

  describe 'Get index' do
    let(:messages) { create_list(:message, 2) }
    before {get :index}

    it 'populates an array of all messages' do
      expect(assigns(:messages)).to match_array(messages)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'Get new' do
    before {get :new}

    it 'assigns a new message to @message' do
      expect(assigns(:message)).to be_a_new(Message)
    end 

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do

      it 'save the new message in a database' do
        expect { post :create, message: attributes_for(:message) }.to change(Message, :count).by(1)
      end 

      it 'redirect_to messages' do
        post :create, message: attributes_for(:message)
        expect(response).to redirect_to root_path(assigns(:messages))
      end
    end
    context 'with invalid attributes' do

      it 'doesnt save new message in a database' do
        expect { post :create, message: attributes_for(:invalid_message) }.to_not change(Message, :count)
      end 

      it 're_renders new view' do
        post :create, message: attributes_for(:invalid_message)
        expect(response).to redirect_to root_path(assigns(:messages))
    end
  end
end
