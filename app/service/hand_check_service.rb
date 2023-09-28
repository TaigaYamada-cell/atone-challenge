class HandCheckService
  # 全てのメソッドをクラスメソッドにする
  class << self

    def straight_flush_check(cards)
      check = nil
      suit = cards[0][0]
      # スートが同じかチェック
      for card in cards do
        if(card[0] != suit)
          check = false
        end
        suit = card[0]
      end
      # 数字が連続するかチェック
      
      num = []
      for card in cards do
        n = card.length
        num.append(card.slice(1, n).to_i)
      end

      # 連続しているかチェック
      # todo:どうやって、プログラムにポーカーの数字の順番を認識させるべきか考える
      num = num.sort()
      binding.pry

      if(check == false)
        return false
      end
      return true
    end

    def four_of_a_kind_check(cards)
      return true
    end

    def full_house_check(cards)
      return true
    end

    def flush_check(cards)
      return true
    end

    def straight_check(cards)
      return true
    end

    def three_of_a_kind_check(cards)
      return true
    end

    def two_pair_check(cards)
      return true
    end

    def one_pair_check(cards)
      return true
    end

    def high_card_check(cards)
      return true
    end
  end
end