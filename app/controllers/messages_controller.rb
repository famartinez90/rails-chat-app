class MessagesController < ApplicationController
  def show
    @from = params["from"]
    @to = params["to"]
    @messages = Message
      .where(from: @from, to: @to)
      .or(Message.where(from: @to, to: @from))
      .order(:created_at)
  end
end
