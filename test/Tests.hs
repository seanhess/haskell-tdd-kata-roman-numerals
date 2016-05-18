{-# OPTIONS_GHC -fno-warn-orphans #-}
module Main where

-- If this were more than one kata, I would have a folder structure for these

import Data.List (group)
import Numerals
import Numeric.Natural (Natural)
import Test.QuickCheck
import Test.Tasty
import Test.Tasty.QuickCheck as QC

-- QuickCheck is bigger than a traditional testing system. Instead of manually
-- describing results for individual inputs, we describe our assumptions as "properties"
-- that should hold for any input
-- https://www.schoolofhaskell.com/user/pbv/an-introduction-to-quickcheck-testing
-- We are "proving" our program correct, rather than simply testing



-- step one: provide Arbitrary instances for our types, allowing QuickCheck to 
-- generate random inputs for them. This leverages the existing definitions
-- for Natural, List, and members of Bounded + Enum

instance Arbitrary Numeral where
    arbitrary = arbitraryBoundedEnum

instance Arbitrary Roman10 where
    arbitrary = Roman10 <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary



-- now we start the real TDD. Properties are not the same as tests, so we don't
-- start with simple examples like in traditional TDD. We start with general
-- principles instead.


-- let's start with the following from the spec:
-- The symbols 'I', 'X', 'C', and 'M' can be repeated at most 3 times in a row.
prop_only3InRow :: Natural -> Bool
prop_only3InRow = all only3 . filter checkable . group . convertArabicToNumerals
    where
      only3 ns = length ns <= 3
      checkable = oneOf [I, X, C, M]
      oneOf set ns = head ns `elem` set

prop_nonEmpty :: Natural -> Bool
prop_nonEmpty 0 = True
prop_nonEmpty n = length (convertArabicToNumerals n) > 0




-- Test Suite ----------------------------------


main = defaultMain properties

properties :: TestTree
properties = testGroup "Properties"
    [ QC.testProperty "The symbols 'I', 'X', 'C', and 'M' can be repeated at most 3 times in a row." prop_only3InRow
    , QC.testProperty "At least one numeral if above zero" prop_nonEmpty
    ]
