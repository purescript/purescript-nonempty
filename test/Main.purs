module Test.Main where

import Prelude

import Data.Maybe
import Data.NonEmpty

import Control.Monad.Eff.Console

main = do
  print $ fold1 ("Hello" :| [" ", "World"])
  print $ 0 :| Nothing
  print (0 :| Nothing == 0 :| Just 1)
