module Main exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.App
import Widget
import Lister


-- MODEL


type alias AppModel =
    { widgetModel : Widget.Model
    , listerModel : Lister.Model
    }


initialModel : AppModel
initialModel =
    { widgetModel = Widget.initialModel
    , listerModel = Lister.initialModel
    }


init : ( AppModel, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = WidgetMsg Widget.Msg
    | ListerMsg Lister.Msg



-- VIEW


view : AppModel -> Html Msg
view model =
    Html.div [ class "container" ]
        [ Html.App.map WidgetMsg (Widget.view model.widgetModel)
        , Html.div [ class "row" ]
            [ Html.div [ class "col-sm-3" ]
                [ Html.App.map ListerMsg (Lister.view model.listerModel)
                ]
            ]
        ]



-- UPDATE


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
    case message of
        WidgetMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    Widget.update subMsg model.widgetModel
            in
                ( { model | widgetModel = updatedWidgetModel }, Cmd.map WidgetMsg widgetCmd )

        ListerMsg subMsg ->
            let
                ( updatedListerModel, listerCmd ) =
                    Lister.update subMsg model.listerModel
            in
                ( { model | listerModel = updatedListerModel }, Cmd.map ListerMsg listerCmd )



-- SUBSCIPTIONS


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none



-- APP


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
