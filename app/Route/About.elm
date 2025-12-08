module Route.About exposing (..)

import BackendTask exposing (BackendTask)
import Common exposing (h1)
import Element exposing (..)
import Element.Font as Font
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html
import Html.Attributes
import LanguageTag.Language
import LanguageTag.Region
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    { message : String
    }


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed Data
        |> BackendTask.andMap
            (BackendTask.succeed "Hello!")


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "Kitchen Rave"
        , image =
            { url = [ "kchnrave.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "Kitchen Rave"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Kitchen Rave берет свое начло в 2024 году с проведения спонтанных закрытых тусовок на самых обычных кухнях как рекция на токсичную атмосферу, создавая безопасное камерное пространство."
        , locale = Just ( LanguageTag.Language.ru, LanguageTag.Region.ru )
        , title = "Kitchen Rave"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "Kitchen Rave"
    , body =
        column [ width fill ]
            [ el (centerX :: h1) (text "About")
            , el [ height (px 32) ] none
            , el [ width fill ] <|
                html <|
                    Html.div
                        [ Html.Attributes.style "padding" "55.88% 0 0 0"
                        , Html.Attributes.style "position" "relative"
                        ]
                        [ Html.iframe
                            [ Html.Attributes.src "https://player.vimeo.com/video/1144347790?badge=0&autopause=0&player_id=0&app_id=58479&autoplay=1&muted=1&loop=1"
                            , Html.Attributes.attribute "frameborder" "0"
                            , Html.Attributes.attribute "allow" "autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share"
                            , Html.Attributes.attribute "referrerpolicy" "strict-origin-when-cross-origin"
                            , Html.Attributes.style "position" "absolute"
                            , Html.Attributes.style "top" "0"
                            , Html.Attributes.style "left" "0"
                            , Html.Attributes.style "width" "100%"
                            , Html.Attributes.style "height" "100%"
                            , Html.Attributes.title "Kitchen Rave"
                            ]
                            []
                        ]
            , el [ height (px 32) ] none
            , paragraph []
                [ text "Kitchen Rave берет свое начло в 2024 году с проведения спонтанных закрытых тусовок на самых обычных кухнях как рекция на токсичную атмосферу, создавая безопасное камерное пространство."
                ]
            , el [ height (px 16) ] none
            , paragraph []
                [ text "Сейчас Kitchen Rave открывает свои двери для более широкой аудитории и предлагает погрузиться в андерграйндную бочку."
                ]
            , el [ height (px 64) ] none
            ]
    }
