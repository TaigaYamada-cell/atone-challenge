require "net/http"
require "json"
require "uri"

class JudgeService < ApplicationController
  def judge(data)
    hand_card = HandCard.new(data)
    hand = hand_card.get_hand
    return hand
  end
end
