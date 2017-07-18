module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)

matchers: Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersScreen top
        , map PlayerScreen (s "players" </> string)
        , map PlayersScreen (s "players")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            ScreenNotFound
            
playersPath : String
playersPath =
    "#players"


playerPath : PlayerId -> String
playerPath id =
    "#players/" ++ id