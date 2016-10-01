module FrontPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Link =
    { text : String, url : String }


makeNav : List Link -> Html a
makeNav routes =
    nav []
        [ ul [ class "nav nav-tabs" ]
            (List.map makeLink routes)
        ]


makeLink : Link -> Html a
makeLink link =
    li [] [ a [ href link.url ] [ text link.text ] ]


makeHeader : String -> Html a
makeHeader title =
    div [ class "page-header" ]
        [ h1 [] [ text title ]
        ]
