class HandCheckService
  # 全てのメソッドをクラスメソッドにする
  class << self

    def straight_flush_check(cards)
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