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
