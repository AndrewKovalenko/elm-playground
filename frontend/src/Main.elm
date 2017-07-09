module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Update exposing (update)
import Html exposing (program)
import View exposing (view)
import Subscriptions exposing (subscriptions)


init: (Model, Cmd Msg)
init = 
    ( initialModel, Cmd.none )

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }