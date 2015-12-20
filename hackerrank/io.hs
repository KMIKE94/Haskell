-- IO Haskell

-- add two numbers taken from input
-- run main
solveMeFirst a b = a + b

test_input = do
    val1 <- readLn
    val2 <- readLn
    let sum = solveMeFirst val1 val2
    print sum

--------------------------------------------------------------
-- Print Hello World with out quotes ("")

hello_world = do
               putStrLn "Hello World"

-- This part relates to Input/Output and can be used as it is.
-- Do not modify this section
hello = do
   hello_world

--------------------------------------------------------------
-- print Hello World n times

-- *Main> :t unlines
-- unlines :: [String] -> String

-- *Main> :t replicate
-- replicate :: Int -> a -> [a]

hello_worlds n = putStrLn $ unlines $ replicate n "Hello World"

-- This part is related to the Input/Output and can be used as it is
-- Do not modify it
ntimes = do
   n <- readLn :: IO Int
   hello_worlds n

--------------------------------------------------------------
-- List replication
l :: Int -> [Int] -> [Int]
-- the following will concat the replicated list to the end
-- of the list
l n arr = concat $ replicate n arr
-- This concatMap performs the replicate over each element on the
-- list
l' n arr = concatMap  (replicate n) arr

-- This part handles the Input and Output and can be used as it is.
-- Do not modify this part.
listRep :: IO ()
listRep = getContents >>=
       mapM_ print. (\(n:arr) -> l' n arr). map read. words

--------------------------------------------------------------
f :: Int -> [Int] -> [Int]
-- Elements of a list, with delimiter n
-- use foldr to run through list right and check against predicate
-- which would be the n value
f p xs = foldr (\x xs -> if (<p) x then x : xs else xs) [] xs
-- The Input/Output section. You do not need to change or modify this part
main = do
    n <- readLn :: IO Int
    inputdata <- getContents
    let
        numbers = map read (lines inputdata) :: [Int]
    putStrLn . unlines $ (map show . f n) numbers
