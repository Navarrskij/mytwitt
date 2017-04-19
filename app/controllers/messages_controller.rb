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
      redirect_to action: :index, notice: "Twitt successfully created"
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
    params.require(:message).permit(:body, :picture)
  end
end
