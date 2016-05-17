module Numerals where

import Numeric.Natural (Natural)

-- When we have a good type system it's better to begin TDD by
-- designing the data types


type Thousands = Natural
type Hundreds = Natural
type Tens = Natural
type Ones = Natural


-- Intermediate representation of a number in roman form.
-- Tally base 10 digits
data Roman10 = Roman10 Thousands Hundreds Tens Ones
              deriving (Show, Eq)


-- The roman representation of a digit for output
data Numeral = I | V | X | L | C | D | M
             deriving (Show, Eq)


--------------------------------------------------------------------
-- Next we want to define the type declarations for some of the functions
-- we will be using to make sure our design is consistent

fromNatural :: Natural -> Roman10
fromNatural = undefined

toNatural :: Roman10 -> Natural
toNatural = undefined

fromNumerals :: [Numeral] -> Roman10
fromNumerals = undefined

toNumerals :: Roman10 -> [Numeral]
toNumerals = undefined

-- these will be our top-level functions
convertArabicToRoman :: Natural -> [Numeral]
convertArabicToRoman = undefined

convertRomanToArabic :: [Numeral] -> Natural
convertRomanToArabic = undefined

-- It is tempting to make all our functions work with strings, 
-- but we would lose type information. It's better to convert to a string
-- at the boundary of our program. We'll stick with Numeral, Roman10, and Natural
toString :: [Numeral] -> String
toString = undefined

fromString :: String -> Maybe [Numeral]
fromString = undefined



-- The problem is broken down into solveable pieces. We've verified that our type
-- design makes sense. It's time to go write some tests

