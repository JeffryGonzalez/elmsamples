module Lister exposing (..)

import Html exposing (Html, button, input, div, text, ul, li, h3)
import Html.Attributes exposing (class, value, id)
import Html.Events exposing (onClick, onInput)
import Dom
import Task
import List


type alias ListEntry =
    { text : String
    , id : Int
    }


type alias Model =
    { entry : String
    , entries : List ListEntry
    , id : Int
    , entryError : Maybe String
    }


initialModel : Model
initialModel =
    { entry = ""
    , entries = []
    , id = 0
    , entryError = Nothing
    }


type Msg
    = Entry String
    | Add
    | ClearEntry
    | Noop
    | Remove ListEntry


view model =
    div []
        [ div [] [ text model.entry ]
        , renderItems model.entries
        , input [ id "the-input", onInput Entry, value model.entry ] []
        , button [ onClick Add ] [ text "Add" ]
        , displayError model.entryError
        ]


displayError entryError =
    case entryError of
        Nothing ->
            div [] []

        Just val ->
            div [ class "alert alert-danger" ] [ text (val ++ "(Could disable the button instead)") ]


renderItems items =
    let
        displayItems =
            List.map renderItem items
    in
        ul [ class "list-unstyled" ] displayItems


renderItem item =
    li [ class "alert alert-info" ]
        [ h3 [] [ text item.text ]
        , button [ class "btn btn-xs btn-danger", onClick (Remove item) ] [ text "X" ]
        ]


update message model =
    case message of
        Noop ->
            ( model, Cmd.none )

        Entry what ->
            ( { model | entry = what }, Cmd.none )

        Add ->
            let
                newModel =
                    if model.entry /= "" then
                        { model
                            | entries = { id = model.id, text = model.entry } :: model.entries
                            , entry = ""
                            , id = model.id + 1
                            , entryError = Nothing
                        }
                    else
                        { model | entryError = Just "You must enter something" }
            in
                ( newModel, setFocusOnInput )

        ClearEntry ->
            ( { model | entry = "" }, Cmd.none )

        Remove what ->
            ( { model | entries = List.filter (\i -> i.id /= what.id) model.entries }, Cmd.none )


setFocusOnInput =
    Task.perform (always Noop) (always Noop) (Dom.focus "the-input")
