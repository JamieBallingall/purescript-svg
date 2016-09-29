module Main where

import Prelude (Unit, ($))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Svg
import Xml (XmlQuote(..), xml2string)

egsvg :: Document
egsvg = Document (tinyHeader 1000.0 800.0)
        [
          Rectangle 10.0 10.1 200.3 200.4 (Style (Color 1.0 2.0 3.0 0.5)),
          Circle 250.0 250.1 90.3 (Style (Color 12.0 22.0 32.0 0.1))
        ]

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log $ xml2string DoubleQuote $ document2xml egsvg
