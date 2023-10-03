class Card
  def calc_relative_value(num)
    if(num != 1)
      relative_value = num - 1
      return relative_value
    else
      relative_value = 13
      return relative_value
    end
  end

  def initialize(card_name_str)
    n = card_name_str.length
    str = card_name_str.slice(0)
    num = card_name_str.slice(1, n).to_i
    # 引数のバリデーション
    if !(str == "H" || str == "C" || str == "D" || str == "S")
      raise ArgumentError
    elsif (num > 13 || num < 1)
      raise ArgumentError
    end

    # 文字列をsuitとnumに分割する
    @suit = str
    @num = num
    # ポーカー内でのnumの実質的な数字の強さ
    @relative_value = calc_relative_value(@num)
  end

  def to_s
    @suit + @num.to_s
  end

  def get_suit
    @suit
  end

  def get_num
    @num
  end

  def get_relative_value
    @relative_value
  end
end
