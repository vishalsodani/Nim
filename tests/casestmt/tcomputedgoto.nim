discard """
  output: '''
yeah A enumB
yeah A enumB
yeah CD enumD
yeah CD enumE
yeah A enumB
yeah CD enumE
yeah CD enumD
yeah A enumB
yeah B enumC
yeah A enumB
yeah A enumB
yeah A enumB
'''
"""

type
  MyEnum = enum
    enumA, enumB, enumC, enumD, enumE, enumLast

proc vm() =
  var instructions: array[0..100, MyEnum]
  instructions[2] = enumC
  instructions[3] = enumD
  instructions[4] = enumA
  instructions[5] = enumD
  instructions[6] = enumC
  instructions[7] = enumA
  instructions[8] = enumB

  instructions[12] = enumE
  var pc = 0
  while true:
    {.computedGoto.}
    let instr = instructions[pc]
    let ra = instr.succ # instr.regA
    case instr
    of enumA:
      echo "yeah A ", ra
    of enumC, enumD:
      echo "yeah CD ", ra
    of enumB:
      echo "yeah B ", ra
    of enumE:
      break
    of enumLast: discard
    inc(pc)

vm()
