module Xml where

import Prelude ((<$>), (<>), ($))
import Data.Foldable

data XmlElement = XmlElement String (Array XmlAttribute) (Array XmlElement)
data XmlAttribute = XmlAttribute String String
data XmlQuote = SingleQuote | DoubleQuote

xml2string :: XmlQuote -> XmlElement -> String
xml2string quote (XmlElement tag attributes children) =
  "<" <>
  tag <>
  fold (attribute2string quote <$> attributes) <>
  ">\n" <>
  (intercalate "\n" $ (xml2string quote) <$> children) <>
  "\n</" <>
  tag <>
  ">"

attribute2string :: XmlQuote -> XmlAttribute -> String
attribute2string quote (XmlAttribute lhs rhs) =
  " " <> lhs <> "=" <> q <> rhs <> q
  where q = quote2string quote

quote2string :: XmlQuote -> String
quote2string SingleQuote = "'"
quote2string DoubleQuote = "\""
