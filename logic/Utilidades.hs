module Utilidades where

splitOn :: Char -> String -> [String]
splitOn _ [] = []
splitOn c s = [x] ++ splitOn c (drop 1 y)
  where
    (x, y) = span (/= c) s
