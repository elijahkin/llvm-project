; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+sse2 < %s | FileCheck %s --check-prefix=SSE
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+avx < %s | FileCheck %s --check-prefix=AVX
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+avx512f < %s | FileCheck %s --check-prefix=AVX

; Verify we fold loads into unary sse intrinsics only when optimizing for size

define float @rcpss(ptr %a) {
; SSE-LABEL: rcpss:
; SSE:       # %bb.0:
; SSE-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE-NEXT:    rcpss %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rcpss:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; AVX-NEXT:    vrcpss %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.rcp.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define float @rsqrtss(ptr %a) {
; SSE-LABEL: rsqrtss:
; SSE:       # %bb.0:
; SSE-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE-NEXT:    rsqrtss %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rsqrtss:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; AVX-NEXT:    vrsqrtss %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define float @sqrtss(ptr %a) {
; SSE-LABEL: sqrtss:
; SSE:       # %bb.0:
; SSE-NEXT:    movss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; SSE-NEXT:    sqrtss %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtss:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; AVX-NEXT:    vsqrtss %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define double @sqrtsd(ptr %a) {
; SSE-LABEL: sqrtsd:
; SSE:       # %bb.0:
; SSE-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; SSE-NEXT:    sqrtsd %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtsd:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; AVX-NEXT:    vsqrtsd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load double, ptr %a
    %ins = insertelement <2 x double> undef, double %ld, i32 0
    %res = tail call <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double> %ins)
    %ext = extractelement <2 x double> %res, i32 0
    ret double %ext
}

define float @rcpss_size(ptr %a) optsize {
; SSE-LABEL: rcpss_size:
; SSE:       # %bb.0:
; SSE-NEXT:    rcpss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rcpss_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vrcpss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.rcp.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define <4 x float> @rcpss_full_size(ptr %a) optsize {
; SSE-LABEL: rcpss_full_size:
; SSE:       # %bb.0:
; SSE-NEXT:    rcpss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rcpss_full_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vrcpss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.rcp.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define float @rcpss_pgso(ptr %a) !prof !14 {
; SSE-LABEL: rcpss_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    rcpss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rcpss_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vrcpss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.rcp.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define <4 x float> @rcpss_full_pgso(ptr %a) !prof !14 {
; SSE-LABEL: rcpss_full_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    rcpss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rcpss_full_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vrcpss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.rcp.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define float @rsqrtss_size(ptr %a) optsize {
; SSE-LABEL: rsqrtss_size:
; SSE:       # %bb.0:
; SSE-NEXT:    rsqrtss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rsqrtss_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vrsqrtss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define <4 x float> @rsqrtss_full_size(ptr %a) optsize {
; SSE-LABEL: rsqrtss_full_size:
; SSE:       # %bb.0:
; SSE-NEXT:    rsqrtss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rsqrtss_full_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vrsqrtss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define float @rsqrtss_pgso(ptr %a) !prof !14 {
; SSE-LABEL: rsqrtss_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    rsqrtss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rsqrtss_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vrsqrtss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define <4 x float> @rsqrtss_full_pgso(ptr %a) !prof !14 {
; SSE-LABEL: rsqrtss_full_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    rsqrtss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: rsqrtss_full_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vrsqrtss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define float @sqrtss_size(ptr %a) optsize{
; SSE-LABEL: sqrtss_size:
; SSE:       # %bb.0:
; SSE-NEXT:    sqrtss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtss_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vsqrtss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define <4 x float> @sqrtss_full_size(ptr %a) optsize{
; SSE-LABEL: sqrtss_full_size:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    sqrtss %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtss_full_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    vsqrtss %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define <4 x float> @sqrtss_full_size_volatile(ptr %a) optsize{
; SSE-LABEL: sqrtss_full_size_volatile:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    sqrtss %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtss_full_size_volatile:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    vsqrtss %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load volatile <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define float @sqrtss_pgso(ptr %a) !prof !14 {
; SSE-LABEL: sqrtss_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    sqrtss (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtss_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vsqrtss (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load float, ptr %a
    %ins = insertelement <4 x float> undef, float %ld, i32 0
    %res = tail call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %ins)
    %ext = extractelement <4 x float> %res, i32 0
    ret float %ext
}

define <4 x float> @sqrtss_full_pgso(ptr %a) !prof !14 {
; SSE-LABEL: sqrtss_full_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    sqrtss %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtss_full_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    vsqrtss %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define <4 x float> @sqrtss_full_pgso_volatile(ptr %a) !prof !14 {
; SSE-LABEL: sqrtss_full_pgso_volatile:
; SSE:       # %bb.0:
; SSE-NEXT:    movaps (%rdi), %xmm0
; SSE-NEXT:    sqrtss %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtss_full_pgso_volatile:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    vsqrtss %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load volatile <4 x float>, ptr %a
    %res = tail call <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float> %ld)
    ret <4 x float> %res
}

define double @sqrtsd_size(ptr %a) optsize {
; SSE-LABEL: sqrtsd_size:
; SSE:       # %bb.0:
; SSE-NEXT:    sqrtsd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtsd_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vsqrtsd (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load double, ptr %a
    %ins = insertelement <2 x double> undef, double %ld, i32 0
    %res = tail call <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double> %ins)
    %ext = extractelement <2 x double> %res, i32 0
    ret double %ext
}

define <2 x double> @sqrtsd_full_size(ptr %a) optsize {
; SSE-LABEL: sqrtsd_full_size:
; SSE:       # %bb.0:
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    sqrtsd %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtsd_full_size:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovapd (%rdi), %xmm0
; AVX-NEXT:    vsqrtsd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load <2 x double>, ptr %a
    %res = tail call <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double> %ld)
    ret <2 x double> %res
}

define <2 x double> @sqrtsd_full_size_volatile(ptr %a) optsize {
; SSE-LABEL: sqrtsd_full_size_volatile:
; SSE:       # %bb.0:
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    sqrtsd %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtsd_full_size_volatile:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovapd (%rdi), %xmm0
; AVX-NEXT:    vsqrtsd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load volatile <2 x double>, ptr %a
    %res = tail call <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double> %ld)
    ret <2 x double> %res
}

define double @sqrtsd_pgso(ptr %a) !prof !14 {
; SSE-LABEL: sqrtsd_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    sqrtsd (%rdi), %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtsd_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vsqrtsd (%rdi), %xmm15, %xmm0
; AVX-NEXT:    retq
    %ld = load double, ptr %a
    %ins = insertelement <2 x double> undef, double %ld, i32 0
    %res = tail call <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double> %ins)
    %ext = extractelement <2 x double> %res, i32 0
    ret double %ext
}

define <2 x double> @sqrtsd_full_pgso(ptr %a) !prof !14 {
; SSE-LABEL: sqrtsd_full_pgso:
; SSE:       # %bb.0:
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    sqrtsd %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtsd_full_pgso:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovapd (%rdi), %xmm0
; AVX-NEXT:    vsqrtsd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load <2 x double>, ptr %a
    %res = tail call <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double> %ld)
    ret <2 x double> %res
}

define <2 x double> @sqrtsd_full_pgso_volatile(ptr %a) !prof !14 {
; SSE-LABEL: sqrtsd_full_pgso_volatile:
; SSE:       # %bb.0:
; SSE-NEXT:    movapd (%rdi), %xmm0
; SSE-NEXT:    sqrtsd %xmm0, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: sqrtsd_full_pgso_volatile:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovapd (%rdi), %xmm0
; AVX-NEXT:    vsqrtsd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
    %ld = load volatile <2 x double>, ptr %a
    %res = tail call <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double> %ld)
    ret <2 x double> %res
}

declare <4 x float> @llvm.x86.sse.rcp.ss(<4 x float>) nounwind readnone
declare <4 x float> @llvm.x86.sse.rsqrt.ss(<4 x float>) nounwind readnone
declare <4 x float> @llvm.x86.sse.sqrt.ss(<4 x float>) nounwind readnone
declare <2 x double> @llvm.x86.sse2.sqrt.sd(<2 x double>) nounwind readnone

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"ProfileSummary", !1}
!1 = !{!2, !3, !4, !5, !6, !7, !8, !9}
!2 = !{!"ProfileFormat", !"InstrProf"}
!3 = !{!"TotalCount", i64 10000}
!4 = !{!"MaxCount", i64 10}
!5 = !{!"MaxInternalCount", i64 1}
!6 = !{!"MaxFunctionCount", i64 1000}
!7 = !{!"NumCounts", i64 3}
!8 = !{!"NumFunctions", i64 3}
!9 = !{!"DetailedSummary", !10}
!10 = !{!11, !12, !13}
!11 = !{i32 10000, i64 100, i32 1}
!12 = !{i32 999000, i64 100, i32 1}
!13 = !{i32 999999, i64 1, i32 2}
!14 = !{!"function_entry_count", i64 0}
