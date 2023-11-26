// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VCONTROL__SYMS_H_
#define VERILATED_VCONTROL__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vcontrol.h"

// INCLUDE MODULE CLASSES
#include "Vcontrol___024root.h"

// SYMS CLASS (contains all model state)
class Vcontrol__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vcontrol* const __Vm_modelp;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vcontrol___024root             TOP;

    // CONSTRUCTORS
    Vcontrol__Syms(VerilatedContext* contextp, const char* namep, Vcontrol* modelp);
    ~Vcontrol__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
