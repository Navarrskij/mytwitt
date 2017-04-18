class MessagesController < ApplicationController

  before_action :load_message, only: [:show, :edit, :update]

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(messages_params)
    if @message.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def update
  end

  private

  def load_message
     @message = Message.find(params[:id])
  end

  def messages_params
    params.require(:message).permit(:body)
  end
end
