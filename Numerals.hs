module Numerals where

-- When we have a good type system it's always best to start TDD by
-- designing the data types

-- natural numbers (no negative numbers)
newtype Natural = Natural { unNatural :: Int }
                  deriving (Show, Eq)

type Thousands = Natural
type Hundreds = Natural
type Tens = Natural
type Ones = Natural

-- intermediate representation of a number in roman form
data Roman10 = Roman10 Thousands Hundreds Tens Ones
              deriving (Show, Eq)

-- the roman representation of a digit for output
data Numeral = I | V | X | L | C | D | M
             deriving (Show, Eq)

