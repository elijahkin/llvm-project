; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -show-mc-encoding < %s | FileCheck %s

@a = external dso_local global { { i64 } }

define i32 @atomic_global() nounwind {
; CHECK-LABEL: atomic_global:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    lock btsq %rax, a(%rip) # encoding: [0xf0,0x48,0x0f,0xab,0x05,A,A,A,A]
; CHECK-NEXT:    # fixup A - offset: 5, value: a, kind: reloc_riprel_4byte
; CHECK-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; CHECK-NEXT:    retq # encoding: [0xc3]
entry:
  %shl.i = shl i64 1, 0
  %0 = atomicrmw or ptr @a, i64 %shl.i monotonic, align 8
  %and.i = and i64 %shl.i, %0
  ret i32 0
}
