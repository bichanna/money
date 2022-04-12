#
# money.nim
# Money
#
# Created by Nobuharu Shimazu, @bichanna, on 4/11/2022
#

import strutils

type
  Region* {.pure.} = enum # using alpha-3 codes
    JPN       = "¥"
    USA       = "$"
    GBR       = "£"
    VNM       = "₫"
    CHN       = "CN¥"

  Money* = object
    number: float
    decimalPlace: int
    region*: Region

proc newMoney*(amount: float, region: Region): Money =
  result.number = amount

  result.region = region

  case region:
  of JPN: result.decimalPlace = 0
  of USA: result.decimalPlace = 2
  of GBR: result.decimalPlace = 2
  of VNM: result.decimalPlace = 0
  of CHN: result.decimalPlace = 2
  else:
    # not reachable
    discard

proc `$`*(obj: Money): string =
  ## Converts to readable string
  result = $obj.region & $obj.number.formatFloat(ffDecimal, obj.decimalPlace)
  if obj.decimalPlace == 0:
    result = result[0 ..< result.len - 1]