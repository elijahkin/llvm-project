//===--- AArch64.h - Declare AArch64 target feature support -----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares AArch64 TargetInfo objects.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_LIB_BASIC_TARGETS_AARCH64_H
#define LLVM_CLANG_LIB_BASIC_TARGETS_AARCH64_H

#include "OSTargets.h"
#include "clang/Basic/TargetBuiltins.h"
#include "llvm/TargetParser/AArch64TargetParser.h"
#include <optional>

namespace clang {
namespace targets {

enum AArch64AddrSpace { ptr32_sptr = 270, ptr32_uptr = 271, ptr64 = 272 };

static const unsigned ARM64AddrSpaceMap[] = {
    0, // Default
    0, // opencl_global
    0, // opencl_local
    0, // opencl_constant
    0, // opencl_private
    0, // opencl_generic
    0, // opencl_global_device
    0, // opencl_global_host
    0, // cuda_device
    0, // cuda_constant
    0, // cuda_shared
    0, // sycl_global
    0, // sycl_global_device
    0, // sycl_global_host
    0, // sycl_local
    0, // sycl_private
    static_cast<unsigned>(AArch64AddrSpace::ptr32_sptr),
    static_cast<unsigned>(AArch64AddrSpace::ptr32_uptr),
    static_cast<unsigned>(AArch64AddrSpace::ptr64),
    0, // hlsl_groupshared
    0, // hlsl_constant
    0, // hlsl_private
    0, // hlsl_device
    0, // hlsl_input
    // Wasm address space values for this target are dummy values,
    // as it is only enabled for Wasm targets.
    20, // wasm_funcref
};

class LLVM_LIBRARY_VISIBILITY AArch64TargetInfo : public TargetInfo {
  virtual void setDataLayout() = 0;
  static const TargetInfo::GCCRegAlias GCCRegAliases[];
  static const char *const GCCRegNames[];

  enum FPUModeEnum {
    FPUMode = (1 << 0),
    NeonMode = (1 << 1),
    SveMode = (1 << 2),
  };

  unsigned FPU = FPUMode;
  bool HasCRC = false;
  bool HasCSSC = false;
  bool HasAES = false;
  bool HasSHA2 = false;
  bool HasSHA3 = false;
  bool HasSM4 = false;
  bool HasFullFP16 = false;
  bool HasDotProd = false;
  bool HasFP16FML = false;
  bool HasMTE = false;
  bool HasTME = false;
  bool HasPAuth = false;
  bool HasLS64 = false;
  bool HasRandGen = false;
  bool HasMatMul = false;
  bool HasBFloat16 = false;
  bool HasSVE2 = false;
  bool HasSVE2p1 = false;
  bool HasSVEAES = false;
  bool HasSVE2SHA3 = false;
  bool HasSVE2SM4 = false;
  bool HasSVEB16B16 = false;
  bool HasSVEBitPerm = false;
  bool HasMatmulFP64 = false;
  bool HasMatmulFP32 = false;
  bool HasLSE = false;
  bool HasFlagM = false;
  bool HasAlternativeNZCV = false;
  bool HasMOPS = false;
  bool HasD128 = false;
  bool HasRCPC = false;
  bool HasRDM = false;
  bool HasDIT = false;
  bool HasCCPP = false;
  bool HasCCDP = false;
  bool HasFRInt3264 = false;
  bool HasSME = false;
  bool HasSME2 = false;
  bool HasSMEF64F64 = false;
  bool HasSMEI16I64 = false;
  bool HasSMEF16F16 = false;
  bool HasSMEB16B16 = false;
  bool HasSME2p1 = false;
  bool HasFP8 = false;
  bool HasFP8FMA = false;
  bool HasFP8DOT2 = false;
  bool HasFP8DOT4 = false;
  bool HasSSVE_FP8DOT2 = false;
  bool HasSSVE_FP8DOT4 = false;
  bool HasSSVE_FP8FMA = false;
  bool HasSME_F8F32 = false;
  bool HasSME_F8F16 = false;
  bool HasSB = false;
  bool HasPredRes = false;
  bool HasSSBS = false;
  bool HasBTI = false;
  bool HasWFxT = false;
  bool HasJSCVT = false;
  bool HasFCMA = false;
  bool HasNoFP = false;
  bool HasNoNeon = false;
  bool HasNoSVE = false;
  bool HasFMV = true;
  bool HasGCS = false;
  bool HasRCPC3 = false;
  bool HasSMEFA64 = false;
  bool HasPAuthLR = false;

  const llvm::AArch64::ArchInfo *ArchInfo = &llvm::AArch64::ARMV8A;

  std::string ABI;

public:
  AArch64TargetInfo(const llvm::Triple &Triple, const TargetOptions &Opts);

  StringRef getABI() const override;
  bool setABI(const std::string &Name) override;

  bool validateBranchProtection(StringRef Spec, StringRef Arch,
                                BranchProtectionInfo &BPI,
                                const LangOptions &LO,
                                StringRef &Err) const override;

  bool isValidCPUName(StringRef Name) const override;
  void fillValidCPUList(SmallVectorImpl<StringRef> &Values) const override;
  bool setCPU(const std::string &Name) override;

  uint64_t getFMVPriority(ArrayRef<StringRef> Features) const override;

  bool useFP16ConversionIntrinsics() const override {
    return false;
  }

  void getTargetDefinesARMV81A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV82A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV83A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV84A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV85A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV86A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV87A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV88A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV89A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV9A(const LangOptions &Opts,
                              MacroBuilder &Builder) const;
  void getTargetDefinesARMV91A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV92A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV93A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV94A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV95A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefinesARMV96A(const LangOptions &Opts,
                               MacroBuilder &Builder) const;
  void getTargetDefines(const LangOptions &Opts,
                        MacroBuilder &Builder) const override;

  llvm::SmallVector<Builtin::InfosShard> getTargetBuiltins() const override;

  std::optional<std::pair<unsigned, unsigned>>
  getVScaleRange(const LangOptions &LangOpts, ArmStreamingKind Mode,
                 llvm::StringMap<bool> *FeatureMap = nullptr) const override;
  bool doesFeatureAffectCodeGen(StringRef Name) const override;
  bool validateCpuSupports(StringRef FeatureStr) const override;
  bool hasFeature(StringRef Feature) const override;
  void setFeatureEnabled(llvm::StringMap<bool> &Features, StringRef Name,
                         bool Enabled) const override;
  bool handleTargetFeatures(std::vector<std::string> &Features,
                            DiagnosticsEngine &Diags) override;
  ParsedTargetAttr parseTargetAttr(StringRef Str) const override;
  bool supportsTargetAttributeTune() const override { return true; }
  bool supportsCpuSupports() const override { return true; }
  bool checkArithmeticFenceSupported() const override { return true; }

  bool hasBFloat16Type() const override;

  CallingConvCheckResult checkCallingConvention(CallingConv CC) const override;

  bool isCLZForZeroUndef() const override;

  BuiltinVaListKind getBuiltinVaListKind() const override;

  ArrayRef<const char *> getGCCRegNames() const override;
  ArrayRef<TargetInfo::GCCRegAlias> getGCCRegAliases() const override;

  std::string convertConstraint(const char *&Constraint) const override;

  bool validateAsmConstraint(const char *&Name,
                             TargetInfo::ConstraintInfo &Info) const override;
  bool
  validateConstraintModifier(StringRef Constraint, char Modifier, unsigned Size,
                             std::string &SuggestedModifier) const override;
  std::string_view getClobbers() const override;

  StringRef getConstraintRegister(StringRef Constraint,
                                  StringRef Expression) const override {
    return Expression;
  }

  int getEHDataRegisterNumber(unsigned RegNo) const override;

  bool validatePointerAuthKey(const llvm::APSInt &value) const override;

  const char *getBFloat16Mangling() const override { return "u6__bf16"; };

  std::pair<unsigned, unsigned> hardwareInterferenceSizes() const override {
    return std::make_pair(256, 64);
  }

  bool hasInt128Type() const override;

  bool hasBitIntType() const override { return true; }

  bool validateTarget(DiagnosticsEngine &Diags) const override;

  bool validateGlobalRegisterVariable(StringRef RegName, unsigned RegSize,
                                      bool &HasSizeMismatch) const override;

  uint64_t getPointerWidthV(LangAS AddrSpace) const override {
    if (AddrSpace == LangAS::ptr32_sptr || AddrSpace == LangAS::ptr32_uptr)
      return 32;
    if (AddrSpace == LangAS::ptr64)
      return 64;
    return PointerWidth;
  }

  uint64_t getPointerAlignV(LangAS AddrSpace) const override {
    return getPointerWidthV(AddrSpace);
  }
};

class LLVM_LIBRARY_VISIBILITY AArch64leTargetInfo : public AArch64TargetInfo {
public:
  AArch64leTargetInfo(const llvm::Triple &Triple, const TargetOptions &Opts);

  void getTargetDefines(const LangOptions &Opts,
                            MacroBuilder &Builder) const override;
private:
  void setDataLayout() override;
};

class LLVM_LIBRARY_VISIBILITY WindowsARM64TargetInfo
    : public WindowsTargetInfo<AArch64leTargetInfo> {
  const llvm::Triple Triple;

public:
  WindowsARM64TargetInfo(const llvm::Triple &Triple,
                         const TargetOptions &Opts);

  void setDataLayout() override;

  BuiltinVaListKind getBuiltinVaListKind() const override;

  CallingConvCheckResult checkCallingConvention(CallingConv CC) const override;
};

// Windows ARM, MS (C++) ABI
class LLVM_LIBRARY_VISIBILITY MicrosoftARM64TargetInfo
    : public WindowsARM64TargetInfo {
public:
  MicrosoftARM64TargetInfo(const llvm::Triple &Triple,
                           const TargetOptions &Opts);

  void getTargetDefines(const LangOptions &Opts,
                        MacroBuilder &Builder) const override;
  TargetInfo::CallingConvKind
  getCallingConvKind(bool ClangABICompat4) const override;

  unsigned getMinGlobalAlign(uint64_t TypeSize,
                             bool HasNonWeakDef) const override;
};

// ARM64 MinGW target
class LLVM_LIBRARY_VISIBILITY MinGWARM64TargetInfo
    : public WindowsARM64TargetInfo {
public:
  MinGWARM64TargetInfo(const llvm::Triple &Triple, const TargetOptions &Opts);
};

class LLVM_LIBRARY_VISIBILITY AArch64beTargetInfo : public AArch64TargetInfo {
public:
  AArch64beTargetInfo(const llvm::Triple &Triple, const TargetOptions &Opts);
  void getTargetDefines(const LangOptions &Opts,
                        MacroBuilder &Builder) const override;

private:
  void setDataLayout() override;
};

void getAppleMachOAArch64Defines(MacroBuilder &Builder, const LangOptions &Opts,
                                 const llvm::Triple &Triple);

class LLVM_LIBRARY_VISIBILITY AppleMachOAArch64TargetInfo
    : public AppleMachOTargetInfo<AArch64leTargetInfo> {
public:
  AppleMachOAArch64TargetInfo(const llvm::Triple &Triple,
                              const TargetOptions &Opts);

protected:
  void getOSDefines(const LangOptions &Opts, const llvm::Triple &Triple,
                    MacroBuilder &Builder) const override;
};

class LLVM_LIBRARY_VISIBILITY DarwinAArch64TargetInfo
    : public DarwinTargetInfo<AArch64leTargetInfo> {
public:
  DarwinAArch64TargetInfo(const llvm::Triple &Triple, const TargetOptions &Opts);

  BuiltinVaListKind getBuiltinVaListKind() const override;

 protected:
  void getOSDefines(const LangOptions &Opts, const llvm::Triple &Triple,
                    MacroBuilder &Builder) const override;
};

} // namespace targets
} // namespace clang

#endif // LLVM_CLANG_LIB_BASIC_TARGETS_AARCH64_H
