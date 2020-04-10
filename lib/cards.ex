defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @values ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  @suits ["Spades", "Clubs", "Hearts", "Diamonds"]

  @doc """
  Returns an ordered deck of cards

  ## Examples

      iex> Cards.create_deck()
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades",
       "Six of Spades", "Seven of Spades", "Eight of Spades", "Nine of Spades", "Ten of Spades", 
       "Jack of Spades", "Queen of Spades", "King of Spades", "Ace of Clubs", "Two of Clubs",
       "Three of Clubs", "Four of Clubs", "Five of Clubs", "Six of Clubs", "Seven of Clubs", 
       "Eight of Clubs", "Nine of Clubs", "Ten of Clubs", "Jack of Clubs", "Queen of Clubs", 
       "King of Clubs", "Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts",
       "Five of Hearts", "Six of Hearts", "Seven of Hearts", "Eight of Hearts", "Nine of Hearts", 
       "Ten of Hearts", "Jack of Hearts", "Queen of Hearts", "King of Hearts", "Ace of Diamonds", 
       "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds", 
       "Six of Diamonds", "Seven of Diamonds", "Eight of Diamonds", "Nine of Diamonds", 
       "Ten of Diamonds", "Jack of Diamonds", "Queen of Diamonds", "King of Diamonds"]
  """
  def create_deck do
    for suit <- @suits, value <- @values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Returns a shuffled `deck`

  ## Examples

      iex> deck = Cards.create_deck()
      iex> shuffled_deck = Cards.shuffle(deck)
      iex> deck == shuffled_deck
      false
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Returns whether the `deck` contains the `card`

  ## Examples

      iex> deck = Cards.create_deck()
      iex> card = "Ace of Spades"
      iex> Cards.contains?(deck, card)
      true
  """
  def contains?(deck, card) do 
    Enum.member?(deck, card)
  end

  @doc """
  Returns a from the `deck` a `hand_size` of cards

  ## Examples
      iex> deck = Cards.create_deck()
      iex> hand_size = 5
      iex> {hand, remainder} = Cards.deal(deck, hand_size)
      iex> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    File.write(filename, :erlang.term_to_binary(deck))
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "Could not read file: #{reason}"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
