module Messages exposing (Msg(..))

import Models exposing (Player)
import RemoteData exposing (WebData)
import Navigation exposing (Location)
import Http

type Msg 
    = FetchPlayers (WebData(List Player))
    | LocationChanges Location
    | ChangeLevel Player Int
    | PlayerSave (Result Http.Error Player)