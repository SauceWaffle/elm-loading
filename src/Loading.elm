module Loading exposing (..)

{-| This module will apply a vector animated loading SVG into a node send in with a Bool.


# Types
@docs NodeStats, SpinnerOptions

# Loading
@docs nodeIsLoading, nodeIsLoadingWithOptions, loadingNode

# Internal
@docs defaultOptions, spinnerNode

-}

import Native.Loading
import Html exposing (..)
import Html.Attributes exposing (..)
import Svg exposing (svg,circle,animate)
import Svg.Attributes exposing (..)


{-| Get the position of the object as it appears and the size of it

-}
type alias NodeStats =
  { x : Float
  , y : Float
  , height: Float
  , width: Float
  }


{-| Options to set the color of the spinner, background, and size of spinner

-}
type alias SpinnerOptions =
  { bgcolor : String
  , spinnercolor : String
  , spinnerscale : Int
  }



{-| Takes in a bool of whether the node is waiting on something to load, and the node.

  Returns a new node that contains the node given and a div that wraps the entire node
    to show the loading SVG.

-}
nodeIsLoading : Bool -> Html a -> Html a
nodeIsLoading b h =
  let
    options = defaultOptions
    origStats = Native.objStats h
  in
    if b
      then loadingNode options origStats h
      else h


{-| Returns the node with customized options for appearence

-}
nodeIsLoadingWithOptions : Bool -> SpinnerOptions -> Html a -> Html a
nodeIsLoadingWithOptions b o h =
    let
      options = o
      origStats = Native.objStats h
    in
      if b
        then loadingNode options origStats h
        else h



{-| Return the new node that contains both the spinner and original node

-}
loadingNode : SpinnerOptions -> NodeStats -> Html a -> Html a
loadingNode o s h =
  let
    styling = Html.Attributes.style
              [ ("background-color", o.bgcolor)
              , ("position", "fixed")
              , ("left", ((toString s.x) ++ "px") )
              , ("top", ((toString s.y) ++ "px") )
              , ("height", ((toString s.height) ++ "px") )
              , ("width", ((toString s.width) ++ "px") )
              , ("z-index", "99999")
              ]

    newDiv =  div []
                  [ div [ styling ] [ spinnerNode o s ]
                  , h
                  ]
  in
    newDiv





{-| Default options for the spinner

-}
defaultOptions : SpinnerOptions
defaultOptions =
  { bgcolor = "rgba(200,200,200,0.7)"
  , spinnercolor = "#000000"
  , spinnerscale = 100
  }


{-| SVG code for the spinner object

-}
spinnerNode : SpinnerOptions -> NodeStats -> Html a
spinnerNode opts stats =
  let
    scaledSize = if stats.width >= 126 && stats.height >= 126
                      then 1.26 * (toFloat opts.spinnerscale)
                      else if stats.width < 126 && stats.width < stats.height
                              then 1.26 * ((stats.width / 126) * 100)
                              else 1.26 * ((stats.height/ 126) * 100)
    sizing = (toString scaledSize) ++ "px"
  in
    svg
      [ version "1.1"
      , Svg.Attributes.width sizing
      , Svg.Attributes.height sizing
      , viewBox "0 0 126 126"
      , Html.Attributes.style
          [ ("position", "absolute")
          , ("top", "50%")
          , ("left", "50%")
          , ("transform", "translate(-50%,-50%)")
          ]
      ]
      [ circle [ cx "63", cy "18", r "18", fill opts.spinnercolor ]
            [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                      , values "18;15;13;11;9;7;5;3;18", calcMode "linear", repeatCount "indefinite"
                      ] []
            ]
      , circle [ cx "93", cy "33", r "3", fill opts.spinnercolor ]
             [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                      , values "3;18;15;13;11;9;7;5;3", calcMode "linear", repeatCount "indefinite"
                      ] []
             ]
      , circle [ cx "108", cy "63", r "5", fill opts.spinnercolor ]
            [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                      , values "5;3;18;15;13;11;9;7;5", calcMode "linear", repeatCount "indefinite"
                      ] []
            ]
      , circle [ cx "93", cy "93", r "7", fill opts.spinnercolor ]
             [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                      , values "7;5;3;18;15;13;11;9;7", calcMode "linear", repeatCount "indefinite"
                      ] []
             ]
      , circle [ cx "63", cy "108", r "9", fill opts.spinnercolor ]
            [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                      , values "9;7;5;3;18;15;13;11;9", calcMode "linear", repeatCount "indefinite"
                      ] []
            ]
      , circle [ cx "33", cy "93", r "11", fill opts.spinnercolor ]
            [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                      , values "11;9;7;5;3;18;15;13;11", calcMode "linear", repeatCount "indefinite"
                      ] []
            ]
      , circle [ cx "18", cy "63", r "13", fill opts.spinnercolor ]
            [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                      , values "13;11;9;7;5;3;18;15;13", calcMode "linear", repeatCount "indefinite"
                      ] []
            ]
      , circle [ cx "33", cy "33", r "15", fill opts.spinnercolor ]
          [ animate [ attributeName "r", from "18",  to "18", begin "0s", dur "2s"
                    , values "15;13;11;9;7;5;3;18;15", calcMode "linear", repeatCount "indefinite"
                    ] []
          ]
      ]
