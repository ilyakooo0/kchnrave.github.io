module Common exposing (..)

import Element exposing (..)
import Element.Events as Ev
import Element.Font as Font


leagueSpartan : Attribute msg
leagueSpartan =
    Font.family [ Font.typeface "League Spartan", Font.sansSerif ]


h1 : List (Attr () msg)
h1 =
    [ Font.size 64, Font.bold, leagueSpartan ]


h2 : List (Attr () msg)
h2 =
    [ Font.size 32, Font.bold, leagueSpartan ]
