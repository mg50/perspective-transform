module Points where
import Mouse
import Window

type State = { points: [(Float, Float)] }

initialState : State
initialState = { points = [] }

port points : Signal [(Float, Float)]
port points = lift .points state

main = display <~ Mouse.position ~ Window.dimensions ~ state

state : Signal State
state = foldp update initialState clickLocs

clickLocs : Signal (Float, Float)
clickLocs = let convert (x, y) = (toFloat x, toFloat y)
            in convert <~ sampleOn Mouse.clicks Mouse.position

update : (Float, Float) -> State -> State
update (x,y) st =
  if (length st.points) >= 4
  then st
  else { st | points <- st.points ++ [(x, y)] }

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
  circle 6 |> filled c |> move (x, y)

normalize : Int -> Int -> (Float, Float) -> (Float, Float)
normalize w h (x, y) =
  let x' = x - toFloat w / 2
      y' = toFloat h / 2 - y
  in (x', y')

imgUrl = "./image.jpg"
