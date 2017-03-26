-- | This module defines a generic non-empty data structure, which adds an
-- | additional element to any container type.
module Data.NonEmpty
  ( NonEmpty(..)
  , singleton
  , (:|)
  , foldl1
  , foldMap1
  , fold1
  , fromNonEmpty
  , oneOf
  , head
  , tail
  ) where

import Prelude

import Control.Alt ((<|>))
import Control.Alternative (class Alternative)
import Control.Plus (class Plus, empty)

import Data.Eq (class Eq1, eq1)
import Data.Foldable (class Foldable, foldl, foldr, foldMap)
import Data.Ord (class Ord1, compare1)
import Data.Traversable (class Traversable, traverse, sequence)

-- | A non-empty container of elements of type a.
-- |
-- | For example:
-- |
-- | ```purescript
-- | nonEmptyList :: NonEmpty List Int
-- | nonEmptyList = 0 :| empty
-- | ```
data NonEmpty f a = NonEmpty a (f a)

-- | An infix synonym for `NonEmpty`.
infixr 5 NonEmpty as :|

-- | Create a non-empty structure with a single value.
singleton :: forall f a. Plus f => a -> NonEmpty f a
singleton a = a :| empty

-- | Fold a non-empty structure, collecting results using a binary operation.
foldl1 :: forall f a. Foldable f => (a -> a -> a) -> NonEmpty f a -> a
foldl1 f (a :| fa) = foldl f a fa

-- | Fold a non-empty structure, collecting results in a `Semigroup`.
foldMap1 :: forall f a s. Semigroup s => Foldable f => (a -> s) -> NonEmpty f a -> s
foldMap1 f (a :| fa) = foldl (\s a1 -> s <> f a1) (f a) fa

-- | Fold a non-empty structure.
fold1 :: forall f s. Semigroup s => Foldable f => NonEmpty f s -> s
fold1 = foldMap1 id

fromNonEmpty :: forall f a r. (a -> f a -> r) -> NonEmpty f a -> r
fromNonEmpty f (a :| fa) = a `f` fa

oneOf :: forall f a. Alternative f => NonEmpty f a -> f a
oneOf (a :| fa) = pure a <|> fa

-- | Get the 'first' element of a non-empty container.
head :: forall f a. NonEmpty f a -> a
head (x :| _) = x

-- | Get everything but the 'first' element of a non-empty container.
tail :: forall f a. NonEmpty f a -> f a
tail (_ :| xs) = xs

instance showNonEmpty :: (Show a, Show (f a)) => Show (NonEmpty f a) where
  show (a :| fa) = "(NonEmpty " <> show a <> " " <> show fa <> ")"

instance eqNonEmpty :: (Eq1 f, Eq a) => Eq (NonEmpty f a) where
  eq = eq1

instance eq1NonEmpty :: Eq1 f => Eq1 (NonEmpty f) where
  eq1 (NonEmpty a fa) (NonEmpty b fb) = a == b && fa `eq1` fb

instance ordNonEmpty :: (Ord1 f, Ord a) => Ord (NonEmpty f a) where
  compare = compare1

instance ord1NonEmpty :: Ord1 f => Ord1 (NonEmpty f) where
  compare1 (NonEmpty a fa) (NonEmpty b fb) =
    case compare a b of
      EQ -> compare1 fa fb
      c -> c

instance functorNonEmpty :: Functor f => Functor (NonEmpty f) where
  map f (a :| fa) = f a :| map f fa

instance foldableNonEmpty :: Foldable f => Foldable (NonEmpty f) where
  foldMap f (a :| fa) = f a <> foldMap f fa
  foldl f b (a :| fa) = foldl f (f b a) fa
  foldr f b (a :| fa) = f a (foldr f b fa)

instance traversableNonEmpty :: Traversable f => Traversable (NonEmpty f) where
  sequence (a :| fa) = NonEmpty <$> a <*> sequence fa
  traverse f (a :| fa) = NonEmpty <$> f a <*> traverse f fa
