#!/usr/bin/env python

import time
import itertools as it
import operator as op

class Poker:
    class Rank:
        HIGH_CARD       = 0
        ONE_PAIR        = 1
        TWO_PAIRS       = 2
        THREE_OF_KIND   = 3
        STRAIGHT        = 4
        FLUSH           = 5
        FULL_HOUSE      = 6
        FOUR_OF_KIND    = 7
        STRAIGHT_FLUSH  = 8
        ROYAL_FLUSH     = 9

    # in order of small to large
    ROYAL = "TJQKA"
    SUIT = "DCHS"
    VALUE = "23456789TJQKA"

    @staticmethod
    def format(hand):
        """
        Format Poker hand, e.g. from ("5D", "2S", "3H", "AS", "TH") into
        val = "235TA" and suit = "SHDHS".
        
        Args:
            hand (list of str): List of 5 cards, where each card is represented by
                two-character string. First char = card value, second char = card suit.

        Returns:
            (val, suit): 
                val (str): String containing card value in increasing order
                suit (str): String containing card suit corresponding to val
        """
        hand_s = list(hand)
        hand_s.sort(key=lambda val: Poker.VALUE.index(val[0]))

        h = list(it.chain.from_iterable(hand_s))
        val = "".join(h[::2])
        suit = "".join(h[1::2])

        return val, suit

    @staticmethod
    def get_score(val, suit):
        """
        Get the score for current Poker hand. Inputs are outputs from Poker.format().

        Args:
            val (str): String containing card value in increasing order.
            suit (str): String containing card suit corresponding to val.

        Returns:
            (rank, rank_val):
                rank (int): Rank of cards at hand. See Rank.
                rank_val (list of int): List of descending score based on rank and
                    remaining cards to determine a winner in case of rank tie.
        """
        val_score = [Poker.VALUE.index(v) for v in val]
        suit_score = [Poker.SUIT.index(s) for s in suit]

        is_straight = val in Poker.VALUE
        if is_straight:
            # is straight
            rank = Poker.Rank.STRAIGHT
            rank_val = val_score[::-1]

        is_flush = len(set(suit)) == 1
        if is_flush:
            is_royal_flush = is_flush and val == Poker.ROYAL
            if is_royal_flush:
                rank = Poker.Rank.ROYAL_FLUSH
                rank_val = [suit_score[0]]
            elif is_straight:
                rank = Poker.Rank.STRAIGHT_FLUSH
                rank_val = [val_score[-1], suit_score[0]]
            else:
                # is flush only
                rank = Poker.Rank.FLUSH
                rank_val = val_score[::-1]
                rank_val.append(suit_score[0])

        elif not is_straight:
            # group same cards into (card_val, frequency)
            val_s = [(key, len(list(group))) for key, group in it.groupby(val)]
            # sort based on frequency. If frequency is same, based on card value.
            # For a given pair of (card value, card frequency), the ordering criteria
            # is (frequency) * 100 + card value
            val_s.sort(key=lambda val: val[1] * 100 + Poker.VALUE.index(val[0]), reverse=True)

            val_score_s = [Poker.VALUE.index(v) for v, _ in val_s]

            rank_val = list(val_score_s)
            if val_s[0][1] == 4:
                # four of a kind
                rank = Poker.Rank.FOUR_OF_KIND
            elif val_s[0][1] == 3:
                rank = Poker.Rank.FULL_HOUSE if val_s[1][1] == 2 else Poker.Rank.THREE_OF_KIND
            elif val_s[0][1] == 2:
                rank = Poker.Rank.TWO_PAIRS if val_s[1][1] == 2 else Poker.Rank.ONE_PAIR
            else:
                rank = Poker.Rank.HIGH_CARD
                rank_val = [v for pair in zip(val_score[::-1], suit_score[::-1]) for v in pair]

        return rank, rank_val

    @staticmethod
    def compare(hand_1, hand_2):
        """
        Compare Poker hands between two players.

        Args:
            hand_1 (list of str): Player one's hand.
            hand_2 (list of str): Player two's hand.

        Returns:
            (int): > 0 if score of hand_1 > hand_2, < 0 if hand_1 < hand_2
        """
        v1, s1 = Poker.format(hand_1)
        r1, rv1 = Poker.get_score(v1, s1)

        v2, s2 = Poker.format(hand_2)
        r2, rv2 = Poker.get_score(v2, s2)

        rv1.insert(0, r1)
        rv2.insert(0, r2)

        comp = it.imap(op.sub, rv1, rv2)
        comp = list(it.dropwhile(lambda x: x == 0, comp))
        return comp[0]


def read_data(file_name):
    """
    Read data from file for q054.

    Args:
        file_name (str): File name

    Returns:
        (tuple): Each element in tuple represents the cards for each player. It is a list of tuples.
    """
    with open(file_name, "rb") as f:
        data = f.read()

        data = data.split()

        all_player = zip(*[iter(data)] * 5)

        player_one = all_player[::2]
        player_two = all_player[1::2]

    return player_one, player_two


p_one, p_two = read_data("q054_data.txt")

assert len(p_one) == len(p_two), "Both players must have same number of games."

tic = time.time()

p_win_one = [i for i, hand_1 in enumerate(p_one) if Poker.compare(hand_1, p_two[i]) > 0]

toc = time.time()

# game in which player two wins
p_win_two = list(set(range(len(p_one))) - set(p_win_one))

print "Result = %d, in %f s" % (len(p_win_one), toc - tic)
