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
