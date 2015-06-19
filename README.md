# BaseConversion
This project permits conversions to and from base-10 and any base between 2 and 63 in Realbasic.

For example, converting a numeric value into a hexadecimal (base-16) string:

```vbnet
  Dim num As UInt64 = 17
  Dim hexstring As String = BaseConvert.ToBase(num, 16)
```

All conversion are performed using UNsigned integers.
