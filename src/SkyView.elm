module SkyView exposing (view)

import Html
import Svg exposing (..)
import Svg.Events
import Svg.Attributes exposing (..)
import Model exposing (..)
import Decoders exposing (..)
import Dict

view : Model -> Html.Html Msg
view model =
    let
        elements =
            model.stars
            |> Dict.values
            |> List.map viewStar
    in
        Svg.svg 
            [ Svg.Attributes.width (String.fromInt model.windowSize.width)
            , Svg.Attributes.height (String.fromInt model.windowSize.height)
            , Svg.Attributes.viewBox "0 0 100 100"
            , Svg.Events.on "mousedown" (decodeMouseDownEvent SkyDown)
            , Svg.Events.on "mousemove" (decodeMouseDownEvent SkyMove)
            , Svg.Events.on "mouseup" (decodeMouseDownEvent SkyUp) 
            ]
            elements


viewStar : Star -> Svg.Svg Msg
viewStar star =
    Svg.rect
        [ Svg.Attributes.x (String.fromFloat star.position.x)
        , Svg.Attributes.y (String.fromFloat star.position.y)
        , Svg.Attributes.width "1"
        , Svg.Attributes.height "1"
        , Svg.Attributes.fill "#ffffff"
        ]
        []
