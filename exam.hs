import Data.List
mylast :: [a] -> a
mylast xs = last xs

mylast' :: [a] -> a
mylast' xs = head $ reverse xs

mybutlast :: [a] -> a
mybutlast xs = head $ reverse $ init xs


elementatk xs n = xs !! (n-1)

myLength :: [a] -> Int
myLength = sum . map (\_->1)

myLength' :: [a] -> Int
myLength' xs = length xs

myreverse :: [a] -> [a]
myreverse xs = reverse xs


isPalindrome xs = xs == (reverse xs)


data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List x) = concatMap flatten x


-- removeDuplicates :: [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : (removeDuplicates $ dropWhile (== x) xs)

pack (x:xs) = let (first, rest) = span (==x) xs in (x:first) : pack rest
pack [] = []

encode :: Eq a => [a] -> [(Int, a)]
encode = map (\x -> (length x, head x)) . group



revCount xs ys = (reverse xs) 
rep xs ys = map (replicate (ys !! (length ys-1))) (head xs)
