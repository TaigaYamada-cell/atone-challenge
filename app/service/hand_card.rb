class HandCard
  def initialize(cards)
    @cards = create_cards(cards)
    @hand = judge_hand(@cards)
  end

  def get_cards
    @cards
  end

  def get_hand
    @hand
  end

  def to_s
    "あなたの手札の#{@cards}は#{@hand}の役が成立します"
  end

  private
  # 5つのcardインスタンスが格納された配列を返す
  def create_cards(cards)
    # cardsを配列にする
    cards_str = cards.split
    cards = []
    for card_str in cards_str do
      card = Card.new(card_str)
      cards.push(card)
    end

    sort_cards = sort_cards(cards)
    return sort_cards
  end

  # インスタンスをrealetive_valueで逆引きして取得
  # まずcardsのrelative_valueを配列で取得して、並べ替える。
  # それをkeyにしてcardインスタンスを取得して、配列に格納する
  # memo:あんまりよくない実装になっている気がする。
  # sortのやり方を工夫するか、そもそも並び順に依存する役判定ロジックを改善するか
  def sort_cards(cards)
    relative_values = []
    for card in cards do
      relative_values.push(card.get_relative_value)
    end
    relative_values.sort!

    i = 0
    sort_cards = []
    while i < 6 do
      for card in cards do
        if(relative_values[i] == card.get_relative_value)
          sort_cards.push(card)
        end
      end
      i += 1
    end
    return sort_cards
  end

  def judge_hand(cards)
    # handクラスをインスタンス化
    hand = Hand.new(cards).get_hand
    return hand
  end
end