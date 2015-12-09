module Die (dd, dieToDistChar)
       where

import Dist

-- Distribution over fair 4-sided die
dd = Dist [(0,1/4),(1,1/4),(2,1/4),(3,1/4)]

-- Maps the probability across to a char distribution
dieToDistChar :: Integer -> Dist Char
dieToDistChar 0 = return 'a'
dieToDistChar 1 = Dist [('c',1/2),('d',1/2)]
dieToDistChar 2 = return 'b'
dieToDistChar 3 = Dist [('b',1/3),('c',2/3)]

-- P(Dice)
-- P(Coin | Dice)
-- together induce P(Coin) = sum_{Dice} P(Coin | Dice) P(Dice)

-- Console: dd >>= dieToDistChar => Gives probability output of dd
