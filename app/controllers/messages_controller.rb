require 'twitter'
class MessagesController < ApplicationController

  before_action :load_message, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @messages = Message.all.order("created_at DESC")
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = current_user.messages.build(messages_params)
    if @message.save
      send_update_twitter
      flash[:notice] = 'Twitt successfully created!'
      redirect_to action: :index
    else
      flash[:notice] = 'Something wrong!'
      redirect_to action: :index
    end
  end

  def update
  end

  def twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.consumer_key
      config.consumer_secret = Rails.application.secrets.consumer_secret
      config.access_token = Rails.application.secrets.access_token
      config.access_token_secret = Rails.application.secrets.access_token_secret
    end
  end

  def send_update_twitter
    if @message.picture.file
      twitter_client.update_with_media(@message.body, File.open(@message.picture.file.file)) unless @message == nil
    else
      twitter_client.update(@message.body) unless @message == nil
    end
  end

  def delete
  end

  private

  def load_message
     @message = Message.find(params[:id])
  end

  def messages_params
    params.require(:message).permit(:body, :picture)
  end
end
