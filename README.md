# elm-loading
This module will apply an animated loading SVG into a node sent in with a Bool.

It sets a fixed div over the node that was provided. This node MUST have an id associated
wth it or it will not be found and a console message will display that it cannot be found.

The spinner defaults to being 126px x 126px if the div containing it is big enough.
If it is not big enough, then the spinner will scale down to fit the height or width.
Spinner size can be customized with nodeIsLoadingWithOptions.

## Usage
    myView : Html msg
    myView =
      nodeIsLoading True
        <| div [ id "my-loading-div" ] [ text "This is a div" ]
