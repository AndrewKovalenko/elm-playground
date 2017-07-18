module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import Update exposing (update)
import Html exposing (program)
import View exposing (view)
import Subscriptions exposing (subscriptions)
import Commands exposing (fetchPlayers)
import Navigation exposing (Location)
import Routing


init: Location -> (Model, Cmd Msg)
init location = 
    let currentRoute = 
        Routing.parseLocation location
    in
        ( initialModel currentRoute, fetchPlayers )

main : Program Never Model Msg
main =
    Navigation.program Messages.LocationChanges
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }