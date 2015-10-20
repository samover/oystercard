# Makers Academy: Oystercard

## Introduction:

There is one class in this project:
  Oystercard.

  Oystercard contains the following methods:

    * top_up
    * deduct
    *`balance`
    *`in_journey`
    *`touch_in`
    *`touch_out`


## Challenge 09:
  `touch_in` will fail if balance is below the `MINIMUM_FARE` (1£)

## Challenge 10:
  `touch_out` will trigger `deduct`ion of `MINIMUM_FARE`
  `deduct` method is passive and can therefore be made private.
  Unit test involving `deduct` needs updating to reflect that.

## Challenge 11:
  Introduced a station argument to the `touch_in` method in order to enable journey tracking.
  Within the `Oystercard` class, the instance variable `entry_station` was also introduced.

  In order to run tests smoothly, `pending do; end` statements were used to isolate `touch_in` related tests.
