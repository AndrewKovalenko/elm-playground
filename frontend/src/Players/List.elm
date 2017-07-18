module Players.List exposing (view)

import RemoteData exposing (WebData)
import Models exposing (Player)
import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Messages exposing (Msg)
import Routing exposing (..)

view: WebData (List Player) -> Html Msg
view responce =
  div []
    [ nav 
    , mayBeList responce
    ]    

nav : Html Msg
nav =
  div [class "clearfix mb2 white bg-black"]
    [ div [class "left p2"] [text "Players"]]

mayBeList : WebData (List Player) -> Html Msg
mayBeList responce =
  case responce of 
    RemoteData.NotAsked -> 
      text ""
    
    RemoteData.Loading -> 
      text "Loading..."
    
    RemoteData.Success players ->
      list players

    RemoteData.Failure error -> 
      text (toString error)

list : List Player -> Html Msg
list players =
  div [class "p2"]
    [ table []
        [ thead []
          [ tr []
            [ th [] [text "id"]
            , th [] [text "Name"]
            , th [] [text "Level"]
            , th [] [text "Actions"]

            ]
          ]
        , tbody [] (List.map playerRow players)
        ]
    ]

playerRow: Player -> Html Msg
playerRow player =
  tr []
    [ td [] [text player.id]
    , td [] [text player.name]
    , td [] [text (toString player.level)]
    , td [] [ editBtn player ]
    ]

editBtn : Player -> Html.Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]