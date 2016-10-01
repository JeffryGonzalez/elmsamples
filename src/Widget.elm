module Widget exposing (..)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (disabled, class)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { count : Int
    }


initialModel : Model
initialModel =
    { count = 0
    }



-- MESSAGES


type Msg
    = Increase
    | Decrease
    | Reset



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [] [ text (toString model.count) ]
        , button [ class "btn", onClick Increase ] [ text "Click +" ]
        , button [ class "btn", disabled (atZero model.count), onClick Decrease ] [ text "Click -" ]
        , button [ class "btn", disabled (atZero model.count), onClick Reset ] [ text "Reset" ]
        ]


atZero count =
    count == 0



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Increase ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrease ->
            ( { model | count = model.count - 1 }, Cmd.none )

        Reset ->
            ( { model | count = 0 }, Cmd.none )
