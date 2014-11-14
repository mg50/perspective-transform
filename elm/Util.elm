module Util where

closest : Float -> Float -> [(Float, Float)] -> Maybe Int
closest x y points =
  let go x y points n = case points of
                          [] -> Nothing
                          (p::ps) -> if sqDist (x,y) p <= pointRadius^2
                                     then Just n
                                     else go x y ps (n+1)
  in go x y points 0

pointRadius = 6

sqDist (x1,y1) (x2,y2) = (x1-x2)^2 + (y1-y2)^2

set : Int -> a -> [a] -> [a]
set n x xs =
  case xs of
    [] -> []
    (x'::xs') -> if n == 0
                 then x::xs'
                 else x' :: set (n-1) x xs'


normalize : Int -> Int -> (Float, Float) -> (Float, Float)
normalize w h (x, y) =
  let x' = x - toFloat w / 2
      y' = toFloat h / 2 - y
  in (x', y')
