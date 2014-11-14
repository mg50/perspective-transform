module Main where
import Model (..)
import Display (display)
import Input (actions, mouseUp)
import Update (update)
import Mouse
import Window

port points : Signal [(Float, Float)]
port points = lift .points state

state = foldp update initialState actions

main = display <~ Mouse.position ~ Window.dimensions ~ state
