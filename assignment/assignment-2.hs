import Dist
import Die
import Debug.SimpleReflect.Expr

-- I have a dice with the probability 'dd'
-- y0 is the pot
-- p is the probability
-- n is the number of rounds

-- each round you bet p*y0
-- idea -> create a distribution with 'n' different Variables
--         name each of the variables with 1-n
--         the first round p*y0

-- Think 1/2 for first
-- Then 1/2 * 1/2 for second .....
-- y0 -> Double, p -> Double, n -> Int
-- dreidelDreidelDreidel y0 p n = Dist [(x, y) | x <- [1..n], y <- [1..n]]
-- predicate -> probability is a list [1/p, 1/p * 1/p..] where sum probability == 1
-- [x | x <- [1/i, 1/i * 1/i..], sum x == 1]

-- Problem is x[0] -> y[1-x]

-- fromIntegral :: (Integer a, Num b) => a -> b
-- dreidelDreidelDreidel :: Double -> Double -> Int -> Dist Double
-- dreidelDreidelDreidel y0 p n = Dist [(x, p) | x <- [1.0, 2.0..fromIntegral n]]
-- n = 3
-- p = 1/2
-- dreidelDreidelDreidel y0 p n = Dist [(1.0, (p * y0) * (1 / 2)), (2.0, (p * y0) * ((1 / 2) * (1 / 2))),
--                                         (3.0, (p * y0) * ((1 / 2) * (1 / 2) * (1 / 2)))]
-- Dist [(((y * p) * (1 + (1 + (1/4)^x)) + y),(1/4)^x) | x <- [1,2..n]]

-- fmap (+ y0)
-- dreidelDreidelDreidel y0 p n = Dist [((y0 * p) * (1 + (1 + (1/4)^x)) + k + y0, ((1/4)^x)) | x <- [1,2..n]]
--                               where x = 1
--                                     k = (y0 * p) * (1 + (1 + (1/4)^x))
-- (y0 * p) * (1 + (1 + (1/4)^x)) + y0
-- dreidelDreidelDreidel y0 p n =
--                               let x1 = Dist [((y0 + (y0 * p) * (((1/4) ^ x) * 10)), (1/4) ^ x) | x <- [1..n]] >>=
--                                             \y -> Dist [(y, 1)] >>= return . (+y0)
--                                   x2 = x1 >>= \y -> Dist [(y, 1)]
--                               in x2



-- dreidelDreidelDreidel y0 p n =
--                               let x1 = y0
--                                   x2 = (1/4) ^ 1
--                                   x3 = (y0 * p) * (x2 * 10) + x1
--                                   x4 = Dist [(x3, x2)] >>= return .(+x1)
--                                   x5 = dreidelDreidelDreidel x3 p
--                               in x4

dreidelDreidelDreidel' :: Double -> Double -> Int -> Dist Double
dreidelDreidelDreidel' y0 p n = Dist [(y0, (1/4 ^ x)) | x <- [1..n]] >>= \x1
                                -> Dist [(x1*p * 2.5 + y0, 1)]
  -- Dist [((y0*p) * (2.5) + y0, (1/4) ^ x) | x <- [1..n]]

-- addStuff :: Int -> Int
-- addStuff = do
--     a <- (*2)
--     b <- (+10)
--     return (a+b)

-- >>= \y -> Dist[((y0 * p) * (1 + (1 + (1/4)^x)) + y0,(1/4)^x) | x <- [1,2..n]]


-- dreidelDreidelDreidel y0 p n = if p < 0
--                               then error "Probability less than 0"
--                               else if p > 1
--                                 then error "Probability greater than 1"
--                                 else if p == 0
--                                   then Dist [(1.0, y0)]
--                                   else (\(x, y) -> Dist [(x, y)]) lcomp (p*y0) n

-- lcomp py0 n= zip [1.0..fromIntegral n] [py0*x | x <- [1.0,2.0..]]

-- mean :: Dist Double -> Double
-- mean d = Dist [()]


-- n = Dist [('a', 0.3666666), ('b', 0.2333333), ('c', 0.4)]
-- *Main> checkProper n
-- False || True

-- *Main> fmap (const 'a') n
-- Dist [('a',0.3),('a',0.2),('a',0.5)]
--
-- *Main> fmap (const 'a') n
-- Dist [('a',0.3),('a',0.2),('a',0.5)]

-- *Main> dd
-- Dist [(0,0.25),(1,0.25),(2,0.25),(3,0.25)]
-- *Main> let d = Dist [(0, 1/5), (1, 1/5), (2,1/5),(3,1/5)]
-- *Main> d
-- Dist [(0,0.2),(1,0.2),(2,0.2),(3,0.2)]
-- *Main> normalize d
-- Dist [(0,0.25),(1,0.25),(2,0.25),(3,0.25)]
-- *Main> checkProper d
-- False
-- *Main> d
-- Dist [(0,0.2),(1,0.2),(2,0.2),(3,0.2)]
-- *Main> let x = normalize d
-- *Main> checkProper x
-- True

{-
Dist a = Dist [(a ,Double)]
Coin = Head | Tail deriving (Eq, Show)
Coin = Dist [(Head, 1/2), (Tail, 1/2)]

data Coin = Head | Tail deriving (Eq, Show)

let cointoss = Dist [(Head, 1/2), (Tail, 1/2)]
cointoss
Dist [(Head , 0.5), (Tail, 0.5)]

let cointoss2 = Dist [(Head, 1/4), (Tail, 3/4)]

let cointoss money= Dist [(money * 2, 1/4), (money / 2, 3/4)]
cointoss 10
Dist [(20, 0.5), (5, 0.5)] -}


-- lift ::  ([(a, Double)] -> [(b, Double)]) -> Dist a -> Dist b
-- lift f (Dist a) = Dist (f a)

unwrap ::  Dist a -> [(a, Double)]
unwrap (Dist x) = x

-- chose :: Integral a => a -> a -> a
-- chose n r = factorial n `div` (factorial r * factorial (n - r))
--
-- factorial ::  (Enum a, Num a) => a -> a
-- factorial n = product [1..n]

dreidelDreidelDreidel :: Double -> Double -> Int -> Dist Double
dreidelDreidelDreidel y0 p n = Dist . last . take n $ iterate (concatMap (dr p)) [(y0, 1)]
  where dr p (y0,prob) = [(win  p y0, prob * 1/4),
                           (loss p y0, prob * 3/4)]

win  p y0  = y0 - x + (10 * x)
  where x = p * y0

loss p y0  = y0 - x
  where x = p * y0

-- map' f  = foldr (\x xs -> f x : xs) []

mean ::  Dist Double -> Double
mean = sum . map (\(x,p) -> x * p) . unwrap

prExceeds :: Double -> Dist Double -> Double
prExceeds target dist = mean $ fmap (fromIntegral . fromEnum . (>= target)) dist
