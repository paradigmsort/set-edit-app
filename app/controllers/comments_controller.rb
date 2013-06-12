class CommentsController < ApplicationController
  def create
    card = Card.find(params[:comment][:card_id])
    comment = current_user.comments.build(content: params[:comment][:content])
    comment.card = card
    comment.save
    redirect_to card
  end
end
