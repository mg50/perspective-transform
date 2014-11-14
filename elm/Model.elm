module Model where

data Mode = SelectingPoints | MovingPoints

data Action = Mousedown (Float, Float)
            | Mouseup (Float, Float)
            | Mousemove (Float, Float)
            | NoOp

type State = { points: [(Float, Float)], mode: Mode, draggingId: Maybe Int }

initialState = { points = [], draggingId = Nothing, mode = SelectingPoints }
