import Dist
import Die

-- dreidelDreidelDreidel :: Double -> Double -> Int -> Dist Double
-- dreidelDreidelDreidel y0 p n = ...

n = Dist [('a', 0.3666666), ('b', 0.2333333), ('c', 0.4)]
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
