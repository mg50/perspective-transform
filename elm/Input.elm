module Input (actions) where
import Model (..)
import Mouse

actions : Signal Action
actions = merges [ Mousemove << floatize <~ Mouse.position
                 , mouseUp
                 , mouseDown
                 ]

mouseUp = let down = keepIf not False Mouse.isDown
          in Mouseup << floatize <~ sampleOn down Mouse.position

mouseDown = let down = keepIf identity True Mouse.isDown
            in Mousedown << floatize <~ sampleOn down Mouse.position

floatize : (Int, Int) -> (Float, Float)
floatize (x,y) = (toFloat x, toFloat y)
