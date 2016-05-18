{-# OPTIONS_GHC -fno-warn-orphans #-}
module Main where

-- If this were more than one kata, I would have a folder structure for these

import Data.List (group, isInfixOf)
import Numerals
import Numeric.Natural (Natural)
import Test.QuickCheck
import Test.Tasty
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

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


-- unit tests ----------------------------------------
-- at this point I would add the reversible property and just implement the function
-- but to demonstrate a more TDD oriented approach, let's hand-code some unit tests:

unitTests = testGroup "Unit tests"
  [ testCase "Simple ones" $
      convertArabicToNumerals 3 @?= [I,I,I]

  , testCase "Simple subtraction" $
      convertArabicToNumerals 4 @?= [I,V]

  , testCase "Simple addition" $
      convertArabicToNumerals 11 @?= [X,I]
  ]

-- back to more properties -------------------------------

-- now that I have a working definition lets add more properties to reflect the spec
prop_noRepeatVLD :: Natural -> Bool
prop_noRepeatVLD nat =
      let nums = convertArabicToNumerals nat
      in atMostOne V nums && atMostOne L nums && atMostOne D nums
    where
      atMostOne n ns = length (filter (==n) ns) <= 1

prop_subtractionsOnlyFromNext2Highest :: Natural -> Bool
prop_subtractionsOnlyFromNext2Highest nat =
    let nums = convertArabicToNumerals nat
      in all (notContains nums) badSubtractions
    where
      notContains numerals bad = not (bad `isInfixOf` numerals)
      badSubtractions =
          [ [I,L], [I,C], [I,D], [I,M]
          , [X,D], [X,M]
          ]

prop_onlyOneSubtractionPerNumeral :: Natural -> Bool
prop_onlyOneSubtractionPerNumeral nat =
    let nums = convertArabicToNumerals nat
      in all (notContains nums) badSubtractions
    where
      notContains numerals bad = not (bad `isInfixOf` numerals)
      badSubtractions =
          [ [I,I,X], [X,X,C], [C,C,M] ]


-- now let's get to feature 2. Reversibility is important for other properties too
prop_reversible :: Natural -> Bool
prop_reversible n = convertNumeralsToArabic (convertArabicToNumerals n) == n

-- Test Suite ----------------------------------


main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties"
    [ QC.testProperty "The symbols 'I', 'X', 'C', and 'M' can be repeated at most 3 times in a row." prop_only3InRow
    , QC.testProperty "At least one numeral if above zero" prop_nonEmpty
    , QC.testProperty "The symbols 'V', 'L', and 'D' can never be repeated" prop_noRepeatVLD
    , QC.testProperty "The '1' symbols ('I', 'X', and 'C') can only be subtracted from the 2 next highest values " prop_subtractionsOnlyFromNext2Highest
    , QC.testProperty "Only one subtraction can be made per numeral ('XC' is allowed, 'XXC' is not)" prop_onlyOneSubtractionPerNumeral
    , QC.testProperty "Reversible" prop_reversible
    ]
