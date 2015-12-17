import Dist
import Die

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

{-
Notes for my own understanding
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
Dist [(20, 0.5), (5, 0.5)]

Prelude> :t concatMap
concatMap :: Foldable t => (a -> [b]) -> t a -> [b] -}

unwrap ::  Dist a -> [(a, Double)]
unwrap (Dist x) = x

dreidelDreidelDreidel :: Double -> Double -> Int -> Dist Double
-- $ is a function application with applies to the right
dreidelDreidelDreidel y0 p n = Dist . last . take n $ iterate (concatMap (dr p)) [(y0, 1)]
  where dr p (y0,prob) = [(win  p y0, prob * 1/4),
                           (loss p y0, prob * 3/4)]

                          --  *Main> dreidelDreidelDreidel 100 0.5 3
                          --  Dist [(3600.0,6.25e-2),(300.0,0.1875),(300.0,0.1875),(25.0,0.5625)]
                          {-
                              The result here shows a distribution for 3 rounds
                              After the first run I will bet 50 and the run will be 250 + the original bet
                              of 50 which gives 300
                              Whereas you can lose the the original fifty you bet
                          -}

win  p y0  = y0 + (10 * x)
  where x = p * y0

loss p y0  = y0 - x
  where x = p * y0

mean :: Dist Double -> Double
mean = sum . fmap (\(x, p) -> x * p) . unwrap
                          {-
                              *Main> mean (Dist [(i,1/7) | i <- [0..6]])
                              2.9999999999999996

                              Will use fmap to multiply the two values of the Dist together
                              Once is does and saves the values it will return a Dist with the mean
                              The function unwrap will convert the Distribution to a list of the results and
                              sum these results
                          -}

prExceeds :: Double -> Dist Double -> Double
prExceeds target dist = mean $ fmap (fromIntegral . fromEnum . (>= target)) dist
                          {-
                              *Main> prExceeds 2000 $ dreidelDreidelDreidel 1000 0.5 10
                              0.399322509765625
                          -}
