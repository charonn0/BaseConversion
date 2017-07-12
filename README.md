# BaseConversion
This project permits conversions to and from base-10 and any base between 2 and 64 in Realbasic.

For example, converting a numeric value into a hexadecimal (base-16) string:

```vbnet
  Dim num As UInt64 = 17
  Dim hexstring As String = BaseConvert.ToBase(num, 16)
```

All conversions are performed using UNsigned integers.

## Extending Val()
The `BaseConvert.Val()` method works like `Realbasic.Val`, with the addition of a few extra literals besides `&h`, `&o` and `&b`:

* `&t`: Ternary/base-3
* `&d`: Decimal/base-10
* `&g`: Hexatrigesimal/base-36

## Limitations
* Negative numbers are not supported. All conversions use `UInt64`.
* Exceptionally large numbers (`&h8fffffffffffffff` or greater) will not convert properly due to arithmetic overflow. 
