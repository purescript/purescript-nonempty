## Module Data.NonEmpty

This module defines a generic non-empty data structure, which adds an additional
element to any container type.

#### `NonEmpty`

``` purescript
data NonEmpty f a
  = NonEmpty a (f a)
```

A non-empty container of elements of type a.

For example:

```purescript
nonEmptyList :: NonEmpty List Int
nonEmptyList = 0 :| empty
```

##### Instances
``` purescript
instance showNonEmpty :: (Show a, Show (f a)) => Show (NonEmpty f a)
instance eqNonEmpty :: (Eq a, Eq (f a)) => Eq (NonEmpty f a)
instance ordNonEmpty :: (Ord a, Ord (f a)) => Ord (NonEmpty f a)
instance functorNonEmpty :: (Functor f) => Functor (NonEmpty f)
instance foldableNonEmpty :: (Foldable f) => Foldable (NonEmpty f)
instance traversableNonEmpty :: (Traversable f) => Traversable (NonEmpty f)
```

#### `(:|)`

``` purescript
(:|) :: forall f a. a -> f a -> NonEmpty f a
```

_non-associative / precedence 5_

An infix synonym for `NonEmpty`.

#### `foldl1`

``` purescript
foldl1 :: forall f a s. (Foldable f) => (a -> a -> a) -> NonEmpty f a -> a
```

foldl1

#### `foldMap1`

``` purescript
foldMap1 :: forall f a s. (Semigroup s, Foldable f) => (a -> s) -> NonEmpty f a -> s
```

Fold a non-empty structure, collecting results in a `Semigroup`. 

#### `fold1`

``` purescript
fold1 :: forall f s. (Semigroup s, Foldable f) => NonEmpty f s -> s
```

Fold a non-empty structure.


