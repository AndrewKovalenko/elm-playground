module Update exposing (update)

import Messages exposing (..)
import Models exposing (..)
import Routing exposing (parseLocation)
import Commands exposing (..)
import RemoteData

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Messages.FetchPlayers playersList ->
            ( {model | players = playersList} , Cmd.none)
        
        Messages.LocationChanges location ->
            let newRoute = 
                parseLocation location
            in 
                ({ model | route = newRoute}, Cmd.none)
        
        ChangeLevel player newLevel ->
            let 
                updatedPlayer =
                    { player | level = newLevel }
            in
                ( model, savePlayerCmd updatedPlayer )

        PlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        PlayerSave (Err error) ->
            ( model, Cmd.none )

updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }