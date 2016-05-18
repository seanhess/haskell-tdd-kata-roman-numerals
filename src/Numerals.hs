module Numerals where

import Numeric.Natural (Natural)

-- When we have a good type system it's better to begin TDD by
-- designing the data types. This will allow us to have something
-- to check!


type Thousands = Int
type Hundreds = Int
type Tens = Int
type Ones = Int

-- Intermediate representation of a number in roman form.
-- Tally base 10 digits
data Roman10 = Roman10 Thousands Hundreds Tens Ones
              deriving (Show, Eq)

addRoman :: Roman10 -> Roman10 -> Roman10
addRoman (Roman10 a1000 a100 a10 a1) (Roman10 b1000 b100 b10 b1) =
    Roman10 (a1000 + b1000) (a100 + b100) (a10 + b10) (a1 + b1)


-- The roman representation of a digit for output
data Numeral = I | V | X | L | C | D | M
             deriving (Show, Eq, Bounded, Enum)


--------------------------------------------------------------------

fromNatural :: Natural -> Roman10
fromNatural n =
    let i = fromIntegral n
        (thousands, rest) = quotRem i 1000
        (hundreds, rest') = quotRem rest 100
        (tens, ones) = quotRem rest' 10
    in Roman10 thousands hundreds tens ones

toNatural :: Roman10 -> Natural
toNatural (Roman10 thousands hundreds tens ones) =
    fromIntegral (ones + tens * 10 + hundreds * 100 + thousands * 1000)

fromNumerals :: [Numeral] -> Roman10
fromNumerals [] = Roman10 0 0 0 0
fromNumerals (I : V : ns) = Roman10 0 0 0 4 `addRoman` fromNumerals ns
fromNumerals (I : X : ns) = Roman10 0 0 0 9 `addRoman` fromNumerals ns
fromNumerals (X : L : ns) = Roman10 0 0 4 0 `addRoman` fromNumerals ns
fromNumerals (X : C : ns) = Roman10 0 0 9 0 `addRoman` fromNumerals ns
fromNumerals (C : D : ns) = Roman10 0 4 0 0 `addRoman` fromNumerals ns
fromNumerals (C : M : ns) = Roman10 0 9 0 0 `addRoman` fromNumerals ns
fromNumerals (n : ns) = fromNumerals ns `addRoman`
    case n of
      I -> Roman10 0 0 0 1
      V -> Roman10 0 0 0 5
      X -> Roman10 0 0 1 0
      L -> Roman10 0 0 5 0
      C -> Roman10 0 1 0 0
      D -> Roman10 0 5 0 0
      M -> Roman10 1 0 0 0


toNumerals :: Roman10 -> [[Numeral]]
toNumerals (Roman10 n1000 n100 n10 n1) =
    [ numeralThousands n1000
    , numeralHundreds n100
    , numeralTens n10
    , numeralOnes n1
    ]
  where
    numeralThousands :: Thousands -> [Numeral]
    numeralThousands nt = replicate nt M

    -- it can only have 0-9
    numeralHundreds :: Hundreds -> [Numeral]
    numeralHundreds 9 = [C,M]
    numeralHundreds 8 = [D,C,C,C]
    numeralHundreds 7 = [D,C,C]
    numeralHundreds 6 = [D,C]
    numeralHundreds 5 = [D]
    numeralHundreds 4 = [C,D]
    numeralHundreds n = replicate n C

    numeralTens :: Tens -> [Numeral]
    numeralTens 9 = [X,C]
    numeralTens 8 = [L,X,X,X]
    numeralTens 7 = [L,X,X]
    numeralTens 6 = [L,X]
    numeralTens 5 = [L]
    numeralTens 4 = [X,L]
    numeralTens n = replicate n X

    numeralOnes :: Ones -> [Numeral]
    numeralOnes 9 = [I,X]
    numeralOnes 8 = [V,I,I,I]
    numeralOnes 7 = [V,I,I]
    numeralOnes 6 = [V,I]
    numeralOnes 5 = [V]
    numeralOnes 4 = [I,V]
    numeralOnes n = replicate n I

-- I can't think of any other ways to create definitions that
-- pass without implementing the function
convertArabicToNumerals :: Natural -> [Numeral]
convertArabicToNumerals = concat . toNumerals . fromNatural

convertNumeralsToArabic :: [Numeral] -> Natural
convertNumeralsToArabic = toNatural . fromNumerals


-- It is tempting to make all our functions work with strings, 
-- but we would lose type information. It's better to convert to a string
-- at the boundary of our program. We'll stick with Numeral, Roman10, and Natural
toString :: [Numeral] -> String
toString = concat . map show
