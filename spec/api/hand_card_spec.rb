require_relative "../../app/service/hand"
require_relative "../../app/service/card"
require_relative "../../app/service/hand_card"
require "./config/initializers/constants.rb"
require 'pry-byebug'

describe HandCard do
  context "期待する引数でインスタンス化した時" do
    before do
      @hand_card1 = HandCard.new("C3 C4 C5 C6 C7")
      @hand_card2 = HandCard.new("C4 C3 C5 C6 C7")
      @hand_card3 = HandCard.new("C2 S2 S2 D2 D9")
    end

    it "エラーなくインスタンス化が実行される" do
      expect(@hand_card1.get_hand).to eq Constants::STRAIGHT_FLUSH
      expect(@hand_card2.get_hand).to eq Constants::STRAIGHT_FLUSH
      expect(@hand_card3.get_hand).to eq Constants::FOUR_OF_A_KIND
    end

  context "期待しない引数でインスタンス化した時" do
    it "例外処理が出されること" do
      # 窃盗時がスートを表さない
      expect { HandCard.new("f1 F2 F3 F3 F4") }.to raise_error(ArgumentError)
      expect { HandCard.new("O2 H1 H3 C5 D6") }.to raise_error(ArgumentError)
      expect { Card.new("h1 h3 h4 h5 h6") }.to raise_error(ArgumentError)
      # 数字が1〜１３の間でない
      expect { Card.new("C0 C11 C14 C87 H32") }.to raise_error(ArgumentError)
      expect { Card.new("H134 C22 C12 C87 C2777") }.to raise_error(ArgumentError)
    end
  end
  end
end