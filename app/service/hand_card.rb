require "json"

class HandCard
  def initialize(request)
    @errors = []
    validate(request)
    
    @cards = create_cards(request)
    # @errorsがあったらraise ArgumentErrorする
    if @errors.any?
      raise ArgumentError, @errors
    end
    @hand = judge_hand(@cards)
  end

  def get_cards
    @cards
  end

  def get_cards_str
    cards_str = []
    for card in @cards do
      card_num_str = card.get_num.to_s
      card_suit_str = card.get_suit
      card_str = card_suit_str + card_num_str
      cards_str.push(card_str)
    end
    return cards_str
  end

  def get_hand
    @hand
  end

  def to_s
    "あなたの手札は#{@hand}の役が成立します"
  end

  private
  # 引数のバリデーション。以下の条件を満たさない場合はerrorsに格納する
  def validate(request)
    # 1. 引数が文字列かどうか
    if !(request.is_a?(String))
      @errors << "引数が文字列ではありません"
    end
    # 2. 全角スペースが含まれていないかどうか
    if request.include?("　")
      @errors << "全角スペースが含まれています"
    end
    # 3. 引数が5つの要素かどうか
    if !(request.split.length == 5)
      @errors << "引数の要素数が不正です"
    end
    # 4. カードが重複していないかどうか
    if request.split.uniq.length != 5
      @errors << "カードが重複しています"
    end
  end

  # 5つのcardインスタンスが格納された配列を返す
  def create_cards(cards)
    # cardsを配列にする
    cards_str = cards.split
    cards = []
    i = 1
    for card_str in cards_str do
      begin
        card = Card.new(card_str)
      rescue => e
        @errors << "#{i}番目のカード指定文字が不正です。（#{card_str}）"
      end
      cards.push(card)
      i += 1
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
    relative_values = relative_values.uniq

    i = 0
    n = relative_values.length
    sort_cards = []
    while i < n do
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