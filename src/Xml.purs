module Xml where

import Prelude ((<$>), (<>), ($), (-), (*), (+))
import Data.Foldable
import Data.Array

data XmlElement = XmlElement String (Array XmlAttribute) (Array XmlElement)
data XmlAttribute = XmlAttribute String String
data XmlQuote = SingleQuote | DoubleQuote
data XmlStyle = XmlStyle XmlQuote Int

xml2string ∷ XmlStyle → XmlElement → String
xml2string (XmlStyle SingleQuote indentSpaces) element = xml2stringIndented 0 indentSpaces "'" element
xml2string (XmlStyle DoubleQuote indentSpaces) element = xml2stringIndented 0 indentSpaces "\"" element

xml2stringIndented ∷ Int → Int → String → XmlElement → String
xml2stringIndented indent spaces quote (XmlElement tag attributes children) =
  indentation <> "<" <> tag <> attributeString <> ">" <> childrenString <> "</" <> tag <> ">"
  where
    indentation = repeat (spaces * indent) " "
    childrenString = (if (null children) then "" else ("\n" <> (intercalate "\n" $ (xml2stringIndented (indent + 1) spaces quote) <$> children) <> "\n"))
    attributeString = fold (attribute2string quote <$> attributes)

attribute2string ∷ String → XmlAttribute → String
attribute2string quote (XmlAttribute lhs rhs) =
  " " <> lhs <> "=" <> quote <> rhs <> quote

quote2string ∷ XmlQuote → String
quote2string SingleQuote = "'"
quote2string DoubleQuote = "\""

repeat ∷ Int → String → String
repeat 0 _ = ""
repeat n value = value <> repeat (n - 1) value

defaultStyle ∷ XmlStyle
defaultStyle = XmlStyle DoubleQuote 3
