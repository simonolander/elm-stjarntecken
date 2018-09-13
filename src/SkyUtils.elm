module SkyUtils exposing (..)

import Model exposing (..)

constellationEdgesEquals : List ConstellationEdge -> List ConstellationEdge -> Bool
constellationEdgesEquals l1 l2 =
    if List.length l1 != List.length l2
    then 
        False
    else 
        List.all (constellationEdgesContainsEdge l2) l1 && List.all (constellationEdgesContainsEdge l1) l2


constellationEdgesContainsEdge : List ConstellationEdge -> ConstellationEdge -> Bool
constellationEdgesContainsEdge list edge =
    List.any (constellationEdgeEquals edge) list


constellationEdgeEquals : ConstellationEdge -> ConstellationEdge -> Bool
constellationEdgeEquals e1 e2 =
    (e1.first == e2.first && e1.second == e2.second) || (e1.first == e2.second && e1.second == e2.first)