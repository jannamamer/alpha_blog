# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    message = current_user.messages.build(message_params)
    return unless message.save

    ActionCable.server.broadcast 'chatroom_channel',
                                 content: message_render(message)
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: { messages: [message] })
  end
end
