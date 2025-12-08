module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Background as Background
import Element.Font as Font
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }


type Msg
    = SharedMsg SharedMsg


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    {}


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( {}
    , Effect.none
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg globalMsg ->
            ( model, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        [ layout
            [ Background.color (rgb 0 0 0)
            , Font.color (rgb 1 1 1)
            , Font.family [ Font.typeface "Noto Sans", Font.sansSerif ]
            ]
            (column [ width fill, centerX, width (maximum 700 fill), paddingEach { left = 16, right = 16, top = 0, bottom = 0 } ]
                [ html
                    (Html.img
                        [ Html.Attributes.src "https://mc.yandex.ru/watch/105714817"
                        , Html.Attributes.style "position" "absolute"
                        , Html.Attributes.style "left" "-9999px"
                        ]
                        []
                    )
                , link [ centerX ]
                    { url = "/"
                    , label =
                        image
                            [ width (px 350)
                            , paddingEach { top = 16, bottom = 32, left = 0, right = 0 }
                            ]
                            { src = "/logo.svg"
                            , description = "Kitchen Rave"
                            }
                    }
                , wrappedRow [ centerX, spacing 16 ]
                    [ link []
                        { url = "/about"
                        , label = el [ Font.underline ] (text "About")
                        }
                    , link []
                        { url = "/events/kr11"
                        , label = el [ Font.underline ] (text "KR#11")
                        }
                    ]
                , el [ height (px 64) ] none
                , pageView.body
                , el [ height (px 32) ] none
                ]
            )
        ]
    , title = pageView.title
    }
