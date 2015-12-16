import Data.List

numUniques :: (Eq a) => [a] -> Int
-- nub is defined in Data.List and removes duplicates
numUniques = length . nub


-------------------------------------------------------------------------
-------------------------------------------------------------------------
doubleMe x = x + x

-- doubleUs x y = x*2 + y*2
doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                        then x
                        else x * 2

doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

-- List Comprehensions
evenNums = [x*2 | x <- [1..10]]
-- Adding a predicate that the results should be greater than or
-- equal to 12

-- evenNums' = [x*2 | x <- [1..10], x*2 >= 12]
evenNums' = [x | x <- [50..100], x `mod` 7 == 3]

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
-- Run by:
--    ghci> boomBangs [3..20]
--    ["BOOM!","BOOM!","BOOM!","BOOM!","BANG!","BANG!","BANG!","BANG!","BANG!"]

-- ghci> let nouns = ["hobo","frog","pope"]
-- ghci> let adjectives = ["lazy","grouchy","scheming"]
-- ghci> [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]
-- ["lazy hobo","lazy frog","lazy pope","grouchy hobo","grouchy frog",
-- "grouchy pope","scheming hobo","scheming frog","scheming pope"]

length' x = sum [1 | _ <- x]
-- ghci> length' [1, 2, 3, 4]
-- 4

removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]
-- ghci> removeNonUppercase "Hello World"
-- "HW"
removeNonLowerCase word = [c | c <- word, c `elem` ['a'..'z']]
-- ghci> removeNonLowerCase "Hello WorLD"
-- "elloor"

-- Collatz
-- colatz n = if isEven n
--   then (n / 2)
--   else (3 * n) / 2

collatz 1 = [1]
collatz x
    | even x = x : collatz (x `div` 2)
    | odd x = x : collatz ((x * 3) + 1)

-- isEven x = 0 == (mod x 2) -> could use just even or odd

add :: Num a => a -> a -> a -> a
add x y z = x + y + z


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

-- Haskell Jack
{-
let f x y = x + y -> f 1 2 = 3
even 2 -> True

map (+1) [1..3] -> [2, 3, 4]

[1..10]

take 10 [1..10] -> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

map f [1..10]
map even [1..10] !! eval

:: Int -> Int -> Int
            takes in two Ints and returns an Int

            *Main> :t (+)
            (+) :: Num a => a -> a -> a
                takes in two numbers and returns a number (general case)
                can make Num into anything (Type inference)!!!!

:i -> info about type class

sum' :: Num a => [a] -> a
sum' [] = 0
sum' xs = head xs + sum' (tail xs)

sum'' :: Num a => [a] -> a
sum '' [] = 0
sum'' (x:xs) = x + sum'' xs

sum''' :: Num a => [a] -> a
sum''' xs = foldl (+) 0 xs

foldl -> fold left
foldr -> fold right

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f n [] = n
foldl f n (x:xs) = foldl f (f n x) xs

                sum = foldl (+) 0 [1, 2, 3]
                                (0 + 1)
                foldl (+) 1 [2, 3]
                          (1 + 2)
                foldl (+) 3 [3]
                        (3 + 3)
                foldl (+) 6 []
                          6

import debug simple reflect library just shows the evaluated result

foldl (+) 0 [1..5] :: Expr
0 + 1 + 2 + 3 + 4 + 5
foldr (+) 0 [1..5] :: Expr
1 + (2 + (3 + (4 + (5 + 0))))



foldr :: (b -> a -> b) -> b -> [a] -> b
foldr f n [] = n
foldr f n (x:xs) = foldr f (f n x) xs

                foldr (+) 0 [1, 2, 3]
                          1 + (2 + (3 + (0)))

lambda
x and a are two variables
foldl (\x a -> x * 10 + a) 0 [1,2,3,4]
1234
foldl (\x a -> x * 10 + a) 0 [1,2,3,4] :: Expr
(((0 * 10 + 1) * 10 + 2) * 10 + 3) * 10 + 4

sum'''' :: Num a => [a] -> a
sum'''' = foldl (+) 0
defining functions in terms of other functions -> Currying!!!

sum :: (Foldable t, Num a) => t a -> a
sum = foldl (+) 0
-}

{-
map even [1..4]
map odd [1..4]

map f [] = []
-- prepended to -> : like cons
1 : []
[1]

1 : (2 : [])
[1,2]

1 : (2 : (3 : []))
[1,2,3]

or-
1 : 2 : 3 : []
map f (x:xs) = f x : map f xs

data [] a = []
            | a : [a]
data Tre a = Empty
            | Tree a (Tree a) (Tree a)
            deriving (Eq, Show, Read)
-- Tree 1 Empty Empty
-- Tree 1 Empty (Tree 2 Empty Empty)

map (+1) [1..10]
-Functor
fmap (+1) [1..10]


-Check Mebe.hs from mu-f2015-cs424
data Maybe a = Nothing | Just a

mebeRecip 1
gotta 1
mebeRecip 2
gotta 0.5
mebeRecip 0
Nada

error
1 + (Just 1)

fmap (+1) (Just 1)

let v = V.fromList [1..10]
fmap (+1) v

map on list - fmap functions on anything

instance Functor Maybe where
  fmap f Nothing = Nothing
  fmap f (Just x) = (Just x)

instance Applicative Maybe where
  pure = Just
  Nothing <*> = Nothing
  Just f <*> Nothing = Nothing
  Just f <*> (Just x) = Just (f x)

instance Monad Maybe where
  return x = Just x
  Nothing >>= _ = Nothing
  -- (Just x) >>= f = Nothing
  (Just x) >>= f = f x

-- [even, odd] <*> [1,2]
  [False, True, True, False]
-- [(+1),(*2)] <*> [1,2]

return 1
1

return :: [Int]
[1]

return 1 :: Maybe Double
1
return :: IO Int
1

return "hello":: IO String
"hello"

Nothing >>= return
Nothing

Just 1 >>= return . (+1)
Just 2





Die has dd
dd >>= return . (+1)
adds 1 to the left side of the dist






-}
