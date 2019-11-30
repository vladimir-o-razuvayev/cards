defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  def values() do
    ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"] 
  end

  def suits() do
    ["Spades", "Clubs", "Hearts", "Diamonds"]
  end

  @doc """
    Returns a list of strings representing a deck of playing cards.
  """
  def create_deck() do
    for suit <- suits(), value <- values() do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a shuffled copy of the deck provided.
  ## Examples
      iex> deck = Cards.create_deck
      iex> shuffled_deck = Cards.shuffle(deck)
      iex> deck == shuffled_deck
      false
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card
  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards to place into the hand.
  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
      iex> Cards.contains?(deck, "Ace of Spades")
      false
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
