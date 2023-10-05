require "net/http"
require "json"
require "uri"

class JudgeService < ApplicationController
  def judge(data)
    hand_card = HandCard.new(data)
    hand = hand_card.get_hand
    cards = hand_card.get_cards_str
    output = [hand, cards]
    return output
  end
end
