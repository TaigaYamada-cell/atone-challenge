require_relative "../../app/service/hand"
require_relative "../../app/service/card"
require 'pry-byebug'

describe Hand do
  context "期待する引数でインスタンス化した時" do
    before do
      card1 = Card.new("C7")
      card2 = Card.new("C6")
      card3 = Card.new("C5")
      card4 = Card.new("C4")
      card5 = Card.new("C3")
      @cards = [card1, card2, card3, card4, card5]
      @hand = Hand.new(@cards)
    end

    it "エラーなくインスタンス化を実行される" do
      expect(@hand.get_cards).to eq @cards
    end
  end

  context "#judge" do
    context "ストレートフラッシュが成立している手札" do
      before do
        card1 = Card.new("C3")
        card2 = Card.new("C4")
        card3 = Card.new("C5")
        card4 = Card.new("C6")
        card5 = Card.new("C7")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S2")
        card2 = Card.new("S3")
        card3 = Card.new("S4")
        card4 = Card.new("S5")
        card5 = Card.new("S6")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "ストレートフラッシュと判定" do
        expect(@hand1.judge(@cards1)).to eq Constants::STRAIGHT_FLUSH
        expect(@hand2.judge(@cards2)).to eq Constants::STRAIGHT_FLUSH
      end
    end
    
    context "フラッシュが成立している手札" do
      before do
        card1 = Card.new("C2")
        card2 = Card.new("C4")
        card3 = Card.new("C6")
        card4 = Card.new("C7")
        card5 = Card.new("C9")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S3")
        card2 = Card.new("S5")
        card3 = Card.new("S6")
        card4 = Card.new("S10")
        card5 = Card.new("S11")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "フラッシュと判定" do 
        expect(@hand1.judge(@cards1)).to eq Constants::FLUSH
        expect(@hand2.judge(@cards2)).to eq Constants::FLUSH
      end
    end

    context "フォーオブアカインドが成立している手札" do
      before do
        card1 = Card.new("C2")
        card2 = Card.new("S2")
        card3 = Card.new("S2")
        card4 = Card.new("D2")
        card5 = Card.new("C9")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S3")
        card2 = Card.new("H5")
        card3 = Card.new("S5")
        card4 = Card.new("C5")
        card5 = Card.new("S5")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "フォーオブアカインドと判定" do 
        expect(@hand1.judge(@cards1)).to eq Constants::FOUR_OF_A_KIND
        expect(@hand2.judge(@cards2)).to eq Constants::FOUR_OF_A_KIND
      end
    end

    context "フルハウスが成立している手札" do
      before do
        card1 = Card.new("C2")
        card2 = Card.new("S2")
        card3 = Card.new("S2")
        card4 = Card.new("D3")
        card5 = Card.new("C3")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S2")
        card2 = Card.new("H2")
        card3 = Card.new("S5")
        card4 = Card.new("C5")
        card5 = Card.new("S5")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "フルハウスと判定" do 
        expect(@hand1.judge(@cards1)).to eq Constants::FULL_HOUSE
        expect(@hand2.judge(@cards2)).to eq Constants::FULL_HOUSE
      end
    end

    context "スリーオブアカインドが成立している手札" do
      before do
        card1 = Card.new("C2")
        card2 = Card.new("S2")
        card3 = Card.new("S2")
        card4 = Card.new("D4")
        card5 = Card.new("C3")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S2")
        card2 = Card.new("H1")
        card3 = Card.new("S5")
        card4 = Card.new("C5")
        card5 = Card.new("S5")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "スリーオブアカインドと判定" do 
        expect(@hand1.judge(@cards1)).to eq Constants::THREE_OF_A_KIND
        expect(@hand2.judge(@cards2)).to eq Constants::THREE_OF_A_KIND
      end
    end

    context "ツーペアが成立している手札" do
      before do
        card1 = Card.new("C2")
        card2 = Card.new("S2")
        card3 = Card.new("S4")
        card4 = Card.new("D4")
        card5 = Card.new("C3")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S1")
        card2 = Card.new("H2")
        card3 = Card.new("S2")
        card4 = Card.new("C5")
        card5 = Card.new("S5")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "スリーオブアカインドと判定" do 
        expect(@hand1.judge(@cards1)).to eq Constants::TWO_PAIR
        expect(@hand2.judge(@cards2)).to eq Constants::TWO_PAIR
      end
    end

    context "ワンペアが成立している手札" do
      before do
        card1 = Card.new("C2")
        card2 = Card.new("S2")
        card3 = Card.new("S3")
        card4 = Card.new("D4")
        card5 = Card.new("C6")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S1")
        card2 = Card.new("H2")
        card3 = Card.new("S2")
        card4 = Card.new("C5")
        card5 = Card.new("S7")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "ワンペアと判定" do 
        expect(@hand1.judge(@cards1)).to eq Constants::ONE_PAIR
        expect(@hand2.judge(@cards2)).to eq Constants::ONE_PAIR
      end
    end

    context "ハイカードが成立している手札" do
      before do
        card1 = Card.new("C1")
        card2 = Card.new("S2")
        card3 = Card.new("S3")
        card4 = Card.new("D4")
        card5 = Card.new("C6")
        @cards1 = [card1, card2, card3, card4, card5]
        @hand1 = Hand.new(@cards1)

        card1 = Card.new("S1")
        card2 = Card.new("H2")
        card3 = Card.new("S3")
        card4 = Card.new("C5")
        card5 = Card.new("S7")
        @cards2 = [card1, card2, card3, card4, card5]
        @hand2 = Hand.new(@cards2)
      end

      it "ハイカードと判定" do 
        expect(@hand1.judge(@cards1)).to eq Constants::HIGH_CARD
        expect(@hand2.judge(@cards2)).to eq Constants::HIGH_CARD
      end
    end
  end
end