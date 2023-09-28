class Card
  def self.calc_relative_value(num)
    if(num != 1)
      relative_value = num - 1
      return relative_value
    else
      relative_value = 13
      return relative_value
    end
  end

  def initialize(card_name_str)
    # 文字列をsuitとnumに分割する
    @suit = card_name_str.slice(0)
    @num = card_name_str.slice(1, n).to_i
    @relative_value = self.calc_relative_value(@num)
  end

  def to_s
    @suit + @num.to_s
  end
end
