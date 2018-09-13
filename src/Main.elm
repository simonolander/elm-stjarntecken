module Main exposing (..)

import Browser
import Browser.Dom
import Browser.Events
import Task exposing (perform)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Model exposing (..)
import SkyView


---- UPDATE ----



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resize size ->
            ( { model
              | windowSize = size
              }
            , Cmd.none
            )
        
        SkyDown position ->
            ( { model
              | currentMousePosition = Just position
              }
            , Cmd.none
            )
        
        SkyMove position ->
            ( { model
              | currentMousePosition = Just position
              }
            , Cmd.none
            )
        
        SkyUp position ->
            ( { model
              | currentMousePosition = Nothing
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    let 
        viewport = 3
    in
        div [ Html.Attributes.style "width" (String.fromInt model.windowSize.width ++ "px")
            , Html.Attributes.style "height" (String.fromInt model.windowSize.height ++ "px")
            ]
            [ SkyView.view model
            ]



---- PROGRAM ----


init : ( Model, Cmd Msg )
init =
    let
        commands = 
            Cmd.batch
                [ perform Resize (Task.map viewportToSize Browser.Dom.getViewport) ]
    in
        ( initialModel, commands )


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = 
            Sub.batch
                [ Browser.Events.onResize (\ w h -> Resize { width = w, height = h })
                ]
            |> always
        }


viewportToSize : Browser.Dom.Viewport -> Size
viewportToSize viewport =
    { width = Basics.floor viewport.viewport.width
    , height = Basics.floor viewport.viewport.height
    }