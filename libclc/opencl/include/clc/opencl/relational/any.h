//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef __CLC_OPENCL_RELATIONAL_ANY_H__
#define __CLC_OPENCL_RELATIONAL_ANY_H__

#include <clc/opencl/opencl-base.h>

#define _CLC_ANY_DECL(TYPE) _CLC_OVERLOAD _CLC_DECL int any(TYPE v);

#define _CLC_VECTOR_ANY_DECL(TYPE)                                             \
  _CLC_ANY_DECL(TYPE)                                                          \
  _CLC_ANY_DECL(TYPE##2)                                                       \
  _CLC_ANY_DECL(TYPE##3)                                                       \
  _CLC_ANY_DECL(TYPE##4)                                                       \
  _CLC_ANY_DECL(TYPE##8)                                                       \
  _CLC_ANY_DECL(TYPE##16)

_CLC_VECTOR_ANY_DECL(char)
_CLC_VECTOR_ANY_DECL(short)
_CLC_VECTOR_ANY_DECL(int)
_CLC_VECTOR_ANY_DECL(long)

#undef _CLC_ANY_DECL
#undef _CLC_VECTOR_ANY_DECL

#endif // __CLC_OPENCL_RELATIONAL_ANY_H__
