module Main where
import Model (..)
import Display (display)
import Input (actions)
import Update (update)
import Util (changes)
import Mouse
import Window

port points : Signal [(Float, Float)]
port points = changes [] <| lift .points state

state = foldp update initialState actions

main = display <~ Mouse.position ~ Window.dimensions ~ state
