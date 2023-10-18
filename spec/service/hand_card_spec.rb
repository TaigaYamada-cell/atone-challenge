require_relative "../../app/service/hand"
require_relative "../../app/service/card"
require_relative "../../app/service/hand_card"
require "./config/initializers/constants.rb"
require 'pry-byebug'

# 前提：HandCardクラスによってHandクラスがインスタンス化される
# その際、Cardインスタンスが５つ、昇順に並べ替えられ@cardsに格納される
describe HandCard do
  context "期待する引数でインスタンス化した時" do
    before do
      @hand_card1 = HandCard.new("C3 C4 C5 C6 C7")
      @hand_card2 = HandCard.new("C4 C3 C5 C6 C7")
      @hand_card3 = HandCard.new("C2 S2 C3 D2 D9")
    end

    it "エラーなくインスタンス化が実行される" do
      expect(@hand_card1.get_hand).to eq Constants::STRAIGHT_FLUSH
      expect(@hand_card2.get_hand).to eq Constants::STRAIGHT_FLUSH
      expect(@hand_card3.get_hand).to eq Constants::THREE_OF_A_KIND
    end
  end

  # カード並べ替えメソッドのテスト
  context "#sort_cards" do
    before do
      @hand_card1 = HandCard.new("H2 C3 H4 C5 H3")
    end
    
    it "@cardsが昇順で並べ替えられる" do
      expect(@hand_card1.get_cards_str).to eq ["H2", "C3", "H3", "H4", "C5"]
    end
  end

  # context "期待しない引数でインスタンス化した時" do
  #   it "例外処理が出されること" do
  #     # 接頭時がスートを表さない
  #     expect { HandCard.new("f1 F2 F3 F3 F4") }.to raise_error(ArgumentError)
  #     expect { HandCard.new("O2 H1 H3 C5 D6") }.to raise_error(ArgumentError)
  #     expect { Card.new("h1 h3 h4 h5 h6") }.to raise_error(ArgumentError)
  #     # 数字が1〜１３の間でない
  #     expect { Card.new("C0 C11 C14 C87 H32") }.to raise_error(ArgumentError)
  #     expect { Card.new("H134 C22 C12 C87 C2777") }.to raise_error(ArgumentError)
  #   end
  # end
  
  context "期待しない引数でインスタンス化した時" do
    context "スートが不正な時" do
      # 不正なスートが含まれている引数でHandCardクラスをインスタンス化した時
      it "例外処理が出されること" do
        expect { HandCard.new("f1 S2 S3 C4 D4") }.to raise_error("1番目のカード指定文字が不正です。（f1）")
        expect { HandCard.new("S1 O2 S3 C5 D6") }.to raise_error("2番目のカード指定文字が不正です。（O2）")
        expect { HandCard.new("S1 S2 O3 C5 D6") }.to raise_error("3番目のカード指定文字が不正です。（O3）")
      end
    end
    context "数字が不正（1~13以外）の場合" do
      it "例外処理が出されること" do
        expect { HandCard.new("S0 S2 S3 C5 D6") }.to raise_error("1番目のカード指定文字が不正です。（S0）")
        expect { HandCard.new("S1 S2 S3 C15 D6") }.to raise_error("4番目のカード指定文字が不正です。（C15）")
        expect { HandCard.new("S1 S2 S3 C5 D16") }.to raise_error("5番目のカード指定文字が不正です。（D16）")
      end
    end
    context "引数が文字列でない場合" do
      it "例外処理が出されること" do
        expect { HandCard.new(12345) }.to raise_error("引数が文字列ではありません")
        expect { HandCard.new(25567) }.to raise_error("引数が文字列ではありません")
      end
    end
    context "引数に全角スペースが含まれている場合" do
      it "例外処理が出されること" do
        expect { HandCard.new("H10　H11 H12 H13 H1") }.to raise_error("全角スペースが含まれています")
        expect { HandCard.new("H10 H11 H12 H13 H1　") }.to raise_error("全角スペースが含まれています")
        expect { HandCard.new("H10　H11 H12 H13 H1　") }.to raise_error("全角スペースが含まれています")
      end
    end
    context "引数が５つの要素を持たない場合" do
      it "例外処理が出されること" do
        expect { HandCard.new("H10 H11 H12 H13") }.to raise_error("引数の要素数が不正です")
        expect { HandCard.new("H10 H11 H12 H13 H1 H2") }.to raise_error("引数の要素数が不正です")
        expect { HandCard.new("H10 H11 H12 H13 H1 H2 H3") }.to raise_error("引数の要素数が不正です")
      end
    end
    context "引数に重複したカードが含まれている場合" do
      it "例外処理が出されること" do
        expect { HandCard.new("H10 H11 H12 H13 H13") }.to raise_error("カードが重複しています")
        expect { HandCard.new("H10 H10 H11 H12 H13") }.to raise_error("カードが重複しています")
        expect { HandCard.new("H10 H11 H11 H12 H13") }.to raise_error("カードが重複しています")
      end
    end
  end


end