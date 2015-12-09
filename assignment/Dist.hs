-- Represent a discrete probability distribution.
-- Probabilities are nonnegative and must sum to one.

module Dist (Dist(Dist), checkProper, normalize) -- Dist(Dist) exports both type and constructor
       where

import Control.Applicative

-- ASIDE, HASKELL CONVENTIONS:
-- Regular Variables -> Lower Case
-- Constructors / Function Names -> Upper Case

-------------------------Probability Section---------------------------

-- Represent a discrete probability distribution.
-- Probabilities are nonnegative and must sum to one.
-- Probability is over a list of finite objects, contains a list of objects + prob of each value.
data Dist a = Dist [(a, Double)]
            deriving (Eq, Show)

-- We use the "a" above to parametrise the object. We originally had this set to char and it's
-- functions only worked on chars. Now works on any data type. Lists are syntactic sugar for parametrised types.

-- Giving 'Dist' an instance for Functor, Applicative and Monad, based on the
-- types of the functions defined in this module.

instance Functor Dist where
  -- Takes some function and a probability distribution and maps f onto Dist.
  fmap f (Dist cProbPairs) = Dist (map (\(c,p)->(f c,p)) cProbPairs)

instance Applicative Dist where
  pure = return
  pf <*> px = pf >>= (\f -> px >>= (pure . f))

instance Monad Dist where
  Dist xps >>= f = Dist (concat (map g xps))
    where
      g (x,p) = scale p (f x)
      -- Scales up/down the distribution, returns list (since not proper distribution)
      scale :: Double -> Dist a -> [(a,Double)]
      scale s (Dist yps) = map (\(y,p) -> (y,s*p)) yps
  return x = Dist [(x,1)]

-- Checks if the probabilities in a distribution sum to 1.
checkProper :: Dist a -> Bool
checkProper (Dist cProbPairs)
  = sum (map snd cProbPairs) ~= 1
    && all (\(_,p) -> 0<=p && p<=1) cProbPairs

-- About equals function to account for floating point errors
(~=) :: Double -> Double -> Bool
x ~= y = abs (x-y) < 1e-6

-- Scales the probabilities to sum to one, in case they've drifted.
-- (If floating point were exact this would be unnecessary.)
normalize :: Dist a -> Dist a
normalize (Dist xps) = Dist [(x,p/z) | (x,p) <- xps] where z = sum (map snd xps)

-- Creating a Dist in console: "let d = Dist [('a', 0.5), ('b', 0.4), ('c', 0.1)]
-- "checkProper d" => True
-- "fmap (const '2') d" => checkProper will still return true, prob Dist not changed
