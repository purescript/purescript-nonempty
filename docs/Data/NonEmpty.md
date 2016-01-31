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
(Show a, Show (f a)) => Show (NonEmpty f a)
(Eq a, Eq (f a)) => Eq (NonEmpty f a)
(Ord a, Ord (f a)) => Ord (NonEmpty f a)
(Functor f) => Functor (NonEmpty f)
(Foldable f) => Foldable (NonEmpty f)
(Traversable f) => Traversable (NonEmpty f)
```

#### `nonEmpty`

``` purescript
nonEmpty :: forall f a. a -> f a -> NonEmpty f a
```

#### `(:|)`

``` purescript
infixr 5 nonEmpty as :|
```

_right-associative / precedence 5_

An infix synonym for `NonEmpty`.

#### `singleton`

``` purescript
singleton :: forall f a. (Plus f) => a -> NonEmpty f a
```

Create a non-empty structure with a single value.

#### `foldl1`

``` purescript
foldl1 :: forall f a. (Foldable f) => (a -> a -> a) -> NonEmpty f a -> a
```

Fold a non-empty structure, collecting results using a binary operation.

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

#### `fromNonEmpty`

``` purescript
fromNonEmpty :: forall f a r. (a -> f a -> r) -> NonEmpty f a -> r
```

#### `oneOf`

``` purescript
oneOf :: forall f a. (Alternative f) => NonEmpty f a -> f a
```

#### `head`

``` purescript
head :: forall f a. NonEmpty f a -> a
```

Get the 'first' element of a non-empty container.

#### `tail`

``` purescript
tail :: forall f a. NonEmpty f a -> f a
```

Get everything but the 'first' element of a non-empty container.


