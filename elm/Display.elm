module Display (display) where
import Model (..)
import Util (pointRadius, normalize)

display : (Int, Int) -> (Int, Int) -> State -> Element
display (mx, my) (w, h) {points} =
  let mouse' = normalize w h (toFloat mx, toFloat my)
      points' = map (normalize w h) points
      img = croppedImage (0,0) w h imgUrl
      bg = toForm img
      colors = [red, blue, yellow, green]
      lines = traced (solid black) (makePath mouse' points')
      dots = zipWith toCircle colors points'
  in collage w h <| bg::lines::dots

makePath : (Float, Float) -> [(Float, Float)] -> Path
makePath (x,y) pts = path <|
                       if length pts > 0 && length pts < 4
                       then pts ++ [(x, y)]
                       else pts

toCircle : Color -> (Float, Float) -> Form
toCircle c (x,y) =
  circle pointRadius |> filled c |> move (x, y)

imgUrl = "./image.jpg"
