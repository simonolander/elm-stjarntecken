module Model exposing (..)

import Dict exposing (Dict)


type alias SkyPosition =
    { x: Float
    , y: Float
    }


type alias ScreenPosition =
    { x: Int
    , y: Int
    }


type alias StarId =
    Int


type alias Star = 
    { id: StarId
    , position: SkyPosition
    }


type alias ConstellationEdge =
    { first: StarId
    , second: StarId
    }


constellationEdge : StarId -> StarId -> ConstellationEdge
constellationEdge id1 id2 =
    if id1 < id2
    then 
        { first = id1
        , second = id2
        }
    else 
        { first = id2
        , second = id1
        }


type alias Constellation = 
    { edges: List ConstellationEdge
    , name: String
    , found: Bool
    }


type alias Size =
    { width: Int
    , height: Int
    }


type Msg
    = Resize Size
    | SkyDown ScreenPosition
    | SkyMove ScreenPosition
    | SkyUp ScreenPosition


type alias Model =
    { windowSize: Size
    , stars: Dict StarId Star
    , constellations: List Constellation
    , currentSelectedStarId: Maybe StarId
    , currentMousePosition: Maybe ScreenPosition
    }


initialModel : Model
initialModel = 
    let 
        windowSize =
            Size 0 0
        
        stars = 
            [ { id = 0
              , position =
                  { x = 10
                  , y = 75
                  }
              }
            , { id = 1
              , position =
                  { x = 30
                  , y = 60
                  }
              }
            , { id = 2
              , position =
                  { x = 40
                  , y = 50
                  }
              }
            , { id = 3
              , position =
                  { x = 45
                  , y = 30
                  }
              }
            , { id = 4
              , position =
                  { x = 80
                  , y = 25
                  }
              }
            , { id = 5
              , position =
                  { x = 90
                  , y = 50
                  }
              }
            ]
            |> List.map (\ star -> ( star.id, star ))
            |> Dict.fromList

        constellations =
            [ { edges =
                  [ constellationEdge 0 1
                  , constellationEdge 1 2
                  , constellationEdge 2 3
                  , constellationEdge 3 4
                  , constellationEdge 4 5
                  , constellationEdge 5 2
                  ]
              , name = "Karlavagnen"
              , found = False
              }
            ]

        model =
            { windowSize = windowSize
            , stars = stars
            , constellations = constellations
            , currentSelectedStarId = Nothing
            , currentMousePosition = Nothing
            }
    in
        model