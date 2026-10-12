module Test.Main where

import Prelude
import Data.Foldable (fold, foldl)
import Data.Maybe (Maybe(..))
import Data.NonEmpty (NonEmpty, (:|), oneOf, head, tail, singleton)
import Data.Semigroup.Foldable (fold1, foldl1, foldr1)
import Data.Unfoldable1 as U1
import Effect (Effect)
import Test.Assert (assert)

type AtLeastTwo f a
  = NonEmpty (NonEmpty f) a

second :: forall f a. AtLeastTwo f a -> a
second = tail >>> head

from0toN :: Int -> NonEmpty Array Int
from0toN n = U1.range 0 n

main :: Effect Unit
main = do
  assert $ singleton 0 == 0 :| []
  assert $ 0 :| Nothing /= 0 :| Just 1
  assert $ foldl1 (\l r -> "(" <> l <> r <> ")") ("a" :| [ "b", "c", "d" ]) == "(((ab)c)d)"
  assert $ foldr1 (\l r -> "(" <> l <> r <> ")") ("a" :| [ "b", "c", "d" ]) == "(a(b(cd)))"
  assert $ foldl (+) 0 (1 :| [ 2, 3 ]) == 6
  assert $ fold1 ("Hello" :| [ " ", "World" ]) == "Hello World"
  assert $ fold ("Hello" :| [ " ", "World" ]) == "Hello World"
  assert $ oneOf (0 :| Nothing) == oneOf (0 :| Just 1)
  assert $ second (1 :| 2 :| [ 3, 4 ]) == 2
  assert $ from0toN 9 == (0 :| [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ])
  assert $ (0 :| [ 1, 2 ]) <> (3 :| [ 4, 5 ]) == (0 :| [ 1, 2, 3, 4, 5 ])
  -- Monad left identity:
  assert $ (pure 9 >>= from0toN) == from0toN 9
  -- Monad right identity:
  assert $ (from0toN 9 >>= pure) == from0toN 9
  -- Monad associativity:
  assert $ (from0toN 9 >>= from0toN >>= from0toN) == (from0toN 9 >>= (\n -> from0toN n >>= from0toN))
