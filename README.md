Roman Numerals Kata
--------------------

The kata is to convert Arabic numerals into Roman and back again: http://agilekatas.co.uk/katas/romannumerals-kata

I wrote this to demonstrate a TDD approach in Haskell using property-based testing and QuickCheck.

Comments and Commit History
---------------------------

I added comments specific to particular commits to explain my work that I removed at the end. Please consider [walking through the commit history for the full context:

1. Outline data types ([Numerals.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/1384d445864c68d25e137ee1096fa099e5f9c934/Numerals.hs))
2. Outline function types ([Numerals.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/a56e85644a9207756bba1a14eb690e20b3732c16/Numerals.hs))
3. First property: only 3 V, L, or D in a row ([Tests.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/23c22158c029eb4e39018ef7118949459a93d993/test/Tests.hs), [Numerals.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/23c22158c029eb4e39018ef7118949459a93d993/src/Numerals.hs))
4. Property: At least one numeral if above zero ([Tests.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/87d482c400da49e01e7fc4468779410a35d7b04b/test/Tests.hs), [Numerals.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/87d482c400da49e01e7fc4468779410a35d7b04b/src/Numerals.hs))
5. Units tests: ones, subtraction and addition ([Tests.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/1bbf03a462d256680e7b154dffaebeb5033a285a/test/Tests.hs), [Numerals.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/1bbf03a462d256680e7b154dffaebeb5033a285a/src/Numerals.hs))
6. Property: The symbols 'V', 'L', and 'D' can never be repeated ([Tests.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/commit/a7c9c05424944229e781ff58b26ecdc9546f43ed))
7. Property: The 1 symbols can only be subtracted from the next 2 numerals ([Tests.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/commit/db806cd7914eabeb4695da400c806cd41f63c891))
8. Property: Reversible. Implement feature 2 ([Tests.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/5fb3fb380f237ab11e7cc663f6846b4e379cd94d/test/Tests.hs), [Numerals.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/blob/5fb3fb380f237ab11e7cc663f6846b4e379cd94d/src/Numerals.hs))
9. Property: Adding one to number results in one more in the numeral ([Tests.hs](https://github.com/seanhess/haskell-tdd-kata-roman-numerals/commit/a27ac5c8d38444837dc17118b7fa22fe349d4f26))

Running the Code
----------------

- Install [Stack](http://docs.haskellstack.org/en/stable/README/)

```
$ stack ghci
*Numerals Numerals> toString (convertArabicToNumerals 148)
"CXLVIII"
```

Run the tests

```
$ stack test

Progress: 1/2Tests
  Properties
    The symbols 'I', 'X', 'C', and 'M' can be repeated at most 3 times in a row.:               OK
      +++ OK, passed 100 tests.
    At least one numeral if above zero:                                                         OK
      +++ OK, passed 100 tests.
    The symbols 'V', 'L', and 'D' can never be repeated:                                        OK
      +++ OK, passed 100 tests.
    The '1' symbols ('I', 'X', and 'C') can only be subtracted from the 2 next highest values : OK
      +++ OK, passed 100 tests.
    Only one subtraction can be made per numeral ('XC' is allowed, 'XXC' is not):               OK
      +++ OK, passed 100 tests.
    Reversible:                                                                                 OK
      +++ OK, passed 100 tests.
    Adding one to number results in one more in the numeral:                                    OK
      +++ OK, passed 100 tests.
  Unit tests
    Simple ones:                                                                                OK
    Simple subtraction:                                                                         OK
    Simple addition:                                                                            OK

All 10 tests passed (0.01s)
```


Testing
-----------------------------

My comments assume the reader is not familiar with property based testing. Here are some references:

- [An introduction to QuickCheck testing](https://www.schoolofhaskell.com/user/pbv/an-introduction-to-quickcheck-testing)
- [Functional TDD: A Clash of Cultures](https://www.facebook.com/notes/kent-beck/functional-tdd-a-clash-of-cultures/472392329460303) (Especially read the comments)
- [TDD with QuickCheck](http://primitive-automaton.logdown.com/posts/142511/tdd-with-quickcheck)
- [Tasty](http://documentup.com/feuerbach/tasty)
