class Api::V1::MessagesController < ApplicationController
  before_action :authenticate, only: [:index]
  before_action :find_message, only: [:update]

  def index
    @messages = Message.all
    render json: @messages
  end

  def create
  	@message = Message.create(message_params)
  	if @message.valid?
      render json: { message: MessageSerializer.new(@message) }, status: :created
      LunetribeMailer.lunetribe_email(@message.user).deliver_now
  	else
  	  render json: { errors: @message.errors.full_messages }, status: :unprocessible_entity
  	end
  end
 
  def update
    @message.update(message_params)
    if @message.save
      render json: @message, status: :accepted
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessible_entity
    end
  end
 
  private
 
  def message_params
    params.permit(:content, :user_id)
  end
 
  def find_message
    @message = Message.find(params[:id])
  end
end
