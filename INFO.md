# Haskell

```Haskell
:set prompt "ghci> "
```

#### Examples
```Haskell
ghci> 2 + 2
4
ghci> 2 * 3
6
ghci> 2 - 2
0
ghci> 2 / 2
1
ghci> 2 * (1 + 2)
6
```

## Boolean Operators
```Haskell
ghci> True && False
False
ghci> True || False
True
ghci> not False
True
```

### Equality
```Haskell
ghci> 5 == 5
True
```

### Functions
```Haskell
ghci> suuc 8
9
ghci> min 9 10
9
ghci> succ 9 * 10
100
ghci> succ (9 * 10)
90
ghci> div 92 10
9
```

### Infix Function
```Haskell
ghci> 92 `div` 10
9
```

### Simple Functions
```Haskell
doubleMe x = x + x

ghci> doubleMe 2
4
ghci> doubleMe (doubleMe 2)
8
ghci> doubleMe 8.2
16.4
```
```Haskell
doubleUs x y = x*2 + y*2

ghci> doubleUs 1 2
6
ghci> doubleUs 1.5 2.3
7.6
```

We can even redefine `doubleUs x y = doubleMe x + doubleMe y`

## `if`, `else` and `then`
The `else` part is __mandatory__ in __Haskell__.

example: `doubleSmallNumber x = if x > 100
                        then x
                        else x * 2`

Functions also cannot being with a __capital__ letter.

## Lists
```
ghci> let list = [1, 2, 3, 4]
ghci> list
[1, 2, 3, 4]
ghci> let concat = list ++ list
ghci> concat
[1, 2, 3, 4, 1, 2, 3, 4]
ghci> "hello" ++ " " ++ "world"
"hello world"
ghci> 'A':" COOL CONS"
"A COOL CONS"
```
* Strings are represents as lists, for example `"hello"` is represented as `['h', 'e', 'l', 'l', '0']`.

* The colon operator works as a `cons`. Therefore `'A':" COOL CONS"` is equivalent to `"A" ++ " " + "COOL CONS"`. The benefit of using this instead of the `++` operator is that `:` just prepend something to the top of a list. For example, `[1, 2, 3]` is equivalent to `1:2:3:[]`.

* An element in a list can be returned by `"Hello World" !! 3` -> `'l'`.


- `head [1, 2, 3]` returns `1`.
- `tail [1, 2, 3]` returns `[2, 3]`.
- `last [1, 2, 3]` returns `3`.
- `init [1, 2, 3]` returns `[1, 2]`.
- `length [1, 2, 3]` returns `5`.
- `null [1, 2, 3]` returns `False`.
- `reverse [1, 2, 3]` returns `[3, 2, 1]`.
- `take 2 [1, 2, 3]` returns `[1, 2]`.
- `drop 2 [1, 2, 3]` returns `[3]`.
- `maximum [1, 2, 3]` returns `3`.
- `minimum [1, 2, 3]` returns `1`.
- `sum [1, 2, 3]` returns `6`.
- `product [1, 2, 3]` returns `6`.
- `2 'elem' [1, 2, 3]` returns `True`.

__texas range__ -> `[1..20]` returns `[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]`
- `[2, 4..20]` returns `[2,4,6,8,10,12,14,16,18,20]`
- `[a..z]` returns `"abcdefghijklmnopqrstuvwxyz"`
- `[K..Z]` returns `"KLMNOPQRSTUVWXYZ"`

## Benefits of Texas range
* __Infinite Lists__ `take 24 [13, 26..]`
* `take 10 (cycle [1,2,3])` -> need to take a slice because the result would print forever
* `take 10 (repeat 5)`

Replicate function may be more useful -> `replicate 3 10` returns `[10, 10, 10]`

## List Comprehensions
```Haskell
evenNums = [x*2 | x <- [1..10]]
-- Adding a predicate that the results should be greater than or
-- equal to 12

-- evenNums' = [x*2 | x <- [1..10], x*2 >= 12]
evenNums' = [x | x <- [50..100], x `mod` 7 == 3]

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
-- Run by:
--    ghci> boomBangs [3..20]
--    ["BOOM!","BOOM!","BOOM!","BOOM!","BANG!","BANG!","BANG!","BANG!","BANG!"]

ghci> let nouns = ["hobo","frog","pope"]  
ghci> let adjectives = ["lazy","grouchy","scheming"]  
ghci> [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns]  
["lazy hobo","lazy frog","lazy pope","grouchy hobo","grouchy frog",  
"grouchy pope","scheming hobo","scheming frog","scheming pope"]
```
