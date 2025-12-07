module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Element exposing (..)
import Element.Font as Font
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
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
        , siteName = "elm-pages"
        , image =
            { url = [ "images", "icon-png.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Welcome to elm-pages!"
        , locale = Nothing
        , title = "elm-pages is running"
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
            [ row [ centerX ]
                [ el [ width (px 16) ] none
                , image
                    [ paddingEach
                        { left = 16
                        , right = 16
                        , top = 0
                        , bottom = 0
                        }
                    , width fill
                    , height (maximum 700 shrink)
                    ]
                    { src = "/13.JPG", description = "Kitchen Rave #13 poster. Dekadance x Kitchen Rave. Medium: Denis Kudla, Depressive Tuesday, Lavia, Rooina, Shinovich, Stepan Borin, Sveta Rain, Volchiy Voy, Хtonь. Under: ++++ (UK), Bats, CEKTA, DRAAG, KHNN, Replicant, VISHSCALE (UK), Zaur Gapienko. 26/12. DEX. Start: 23:00." }
                , el [ width (px 16) ] none
                ]
            , el [ height (px 32) ] none
            , link [ centerX ]
                { url = "https://dekadance.timepad.ru/event/3707943/", label = el [ Font.underline ] (text "купить билет") }
            ]
    }
