class MessagesController < ApplicationController
  def show
    @from = params["from"]
    @to = params["to"]
    @messages = Message
      .where(from: @from, to: @to)
      .or(Message.where(from: @to, to: @from))
      .order(:created_at)
  end

  def list
    @user = session[:user]
    @group = Group.where(:id => params['id_group']).first()
    @messages = Message.where(:id_group => params['id_group']).order(:created_at)
  end
end
