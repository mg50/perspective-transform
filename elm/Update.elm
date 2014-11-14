module Update (update) where
import Model (..)
import Util (set, sqDist, closest)

update action state =
  case (action, state.mode) of
    (Mousedown (x,y), SelectingPoints) -> addNewPoint x y state
    (Mouseup (x,y), SelectingPoints) -> selectingPointsMouseup x y state

    (Mousedown (x,y), MovingPoints) -> beginDrag x y state
    (Mouseup _, MovingPoints) -> endDrag state
    (Mousemove (x,y), MovingPoints) -> drag x y state

    _ -> state

drag : Float -> Float -> State -> State
drag x y st =
  case st.draggingId of
    Nothing -> st
    Just id -> let points' = set id (x,y) st.points
               in { st | points <- points' }

endDrag : State -> State
endDrag st = { st | draggingId <- Nothing }

beginDrag : Float -> Float -> State -> State
beginDrag x y st = case closest x y st.points of
                     Nothing -> st
                     Just id -> { st | draggingId <- Just id }

addNewPoint : Float -> Float -> State -> State
addNewPoint x y st = { st | points <- st.points ++ [(x, y)] }

selectingPointsMouseup : Float -> Float -> State -> State
selectingPointsMouseup x y st = if length st.points >= 4
                                then { st | mode <- MovingPoints }
                                else st
