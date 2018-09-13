module Decoders exposing (..)

import Model exposing (..)
import Json.Decode exposing (Decoder, field, int, map2, map)


decodeMouseDownEvent : (ScreenPosition -> Msg) -> Decoder Msg
decodeMouseDownEvent fun =
    map2 ScreenPosition
        (field "clientX" int)
        (field "clientY" int)
    |> map fun