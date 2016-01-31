module Test.Main where

import Prelude

import Control.Monad.Eff (Eff)
import Data.Foldable (fold, foldl)
import Data.Maybe (Maybe(..))
import Data.NonEmpty (NonEmpty(), (:|), fold1, foldl1, oneOf, head, tail, singleton)
import Test.Assert (ASSERT, assert)

type AtLeastTwo f a = NonEmpty (NonEmpty f) a

second :: forall f a. AtLeastTwo f a -> a
second = tail >>> head

main :: Eff (assert :: ASSERT) Unit
main = do
  assert $ singleton 0 == 0 :| []
  assert $ 0 :| Nothing /= 0 :| Just 1
  assert $ foldl1 (+) (1 :| [2, 3]) == 6
  assert $ foldl (+) 0 (1 :| [2, 3]) == 6
  assert $ fold1 ("Hello" :| [" ", "World"]) == "Hello World"
  assert $ fold ("Hello" :| [" ", "World"]) == "Hello World"
  assert $ oneOf (0 :| Nothing) == oneOf (0 :| Just 1)
  assert $ second (1 :| 2 :| [3, 4]) == 2
