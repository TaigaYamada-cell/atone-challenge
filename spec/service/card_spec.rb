require_relative "../../app/service/card"
  
describe Card do
  it "1以外のときrelative_valueを正しく返すこと" do
    card = Card.new("S2")
    expect(card.calc_relative_value(2)).to eq 1
    expect(card.calc_relative_value(3)).to eq 2
    expect(card.calc_relative_value(4)).to eq 3
    expect(card.calc_relative_value(5)).to eq 4
    expect(card.calc_relative_value(6)).to eq 5
  end

  it "1のときrelative_valueを正しく返すこと" do
    card = Card.new("S2")
    expect(card.calc_relative_value(1)).to eq 13
  end

  context "期待する引数インスタンス化した時" do
    before do
      @s4 = Card.new("S4")
      @c11 = Card.new("C11")
      @h1 = Card.new("H1")
    end

    it "インスタンス変数がただしく設定されていること" do
      expect(@s4.to_s).to eq "S4"
      expect(@c11.to_s).to eq "C11"
      expect(@h1.to_s).to eq "H1"
    end
  end

  context "期待しない引数でインスタンス化した時" do
    it "例外処理が出されること" do
      # 窃盗時がスートを表さない
      expect { Card.new("f1") }.to raise_error(ArgumentError)
      expect { Card.new("F2") }.to raise_error(ArgumentError)
      expect { Card.new("G1") }.to raise_error(ArgumentError)
      # 数字が1〜１３の間でない
      expect { Card.new("F0") }.to raise_error(ArgumentError)
      expect { Card.new("H134") }.to raise_error(ArgumentError)
      expect { Card.new("G56") }.to raise_error(ArgumentError)
      expect { Card.new("14") }.to raise_error(ArgumentError)
    end
  end
end