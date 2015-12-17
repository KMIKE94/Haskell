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
f :: Int -> [Int] -> [Int]
f n arr = concat $ replicate n arr

-- This part handles the Input and Output and can be used as it is.
-- Do not modify this part.
main :: IO ()
main = getContents >>=
       mapM_ print. (\(n:arr) -> f n arr). map read. words
