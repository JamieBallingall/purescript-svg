module Main where

import Prelude (Unit, ($))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Svg
import Xml

egsvg ∷ Document
egsvg = Document (defaultHeader 1000.0 800.0)
        [
          Rectangle (Point 10.0 10.1) 200.3 200.4 (Style (Color 1.0 2.0 3.0 0.5)),
          Circle (Point 250.0 250.2) 90.3 (Style (Color 12.0 22.0 32.0 0.1))
        ]

main ∷ ∀ e. Eff (console ∷ CONSOLE | e) Unit
main = do
  log $ xml2string defaultStyle $ document2xml egsvg
