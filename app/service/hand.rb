require "./config/initializers/constants.rb"
require "pry"

class Hand
  def initialize(cards)
    @cards = cards
    @hand = judge(cards)
  end

  def get_cards
    @cards
  end

  def get_hand
    @hand
  end

  def to_s 
    @hand
  end

  def judge(cards)
    # cardsの役を定数で返す
    hand = nil
    same_num = nil
    # スートが同じかどうかで処理を分ける
    checker = is_suit_same?
    if(checker) 
      hand = num_straight_check
      return hand
    else
      same_num = count_same_num
    end

    #　大きい順に並べ替える
    same_num = same_num.max(2)

    # 同じ数字が何枚あるかに応じて条件分岐
    if(same_num[0] > 3)
      return Constants::FOUR_OF_A_KIND
    elsif(same_num[0] == 3)   
      if(same_num[1] == 2)
        return Constants::FULL_HOUSE
      else 
        return Constants::THREE_OF_A_KIND
      end
    elsif(same_num[0] == 2) 
      if(same_num[1] == 2)
        return Constants::TWO_PAIR
      else
        return Constants::ONE_PAIR
      end
    else
      return Constants::HIGH_CARD
    end
  end

  private
  # suitが同じかどうかを真偽値で返す
  def is_suit_same?
    first_suit = @cards[0].get_suit
    for card in @cards do
      suit = card.get_suit
      if(suit != first_suit)
        return false
      end
    end
    return true
  end

  # suitが同じ場合の役判定処理
  # numが連続しているか否かで二種類の役のうちどちらかに決定する
  def num_straight_check
    i = 1
    for card in @cards do
      # 5回目のループでは次のカードはもうないので処理をスキップする
      if(i < 5)
        num = card.get_num + 1
        next_num = @cards[i].get_num
        # next_numがAでかつ4回目のループの時はストレートフラッシュが成立するのでループを抜ける
        if(next_num == 1 && i == 4)
          break
        elsif(num != next_num)
          return Constants::FLUSH
        end
        i += 1
      end
    end
    return Constants::STRAIGHT_FLUSH
  end

  # 手札のうち同じ数字が何枚あるかを返す
  def count_same_num
    nums = []
    for card in @cards do
      nums.push(card.get_num)
    end
    values = nil
    # 同じ値の要素をハッシュで取得
    enum = nums.group_by(&:itself).transform_values(&:size).each_value
    same_num = []
    for value in enum do
      same_num << value
    end
    return same_num
  end
end