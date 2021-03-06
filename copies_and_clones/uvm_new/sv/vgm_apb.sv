// Copyright 2015 Tudor Timisescu (verificationgentleman.com)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


package vgm_apb;

import uvm_pkg::*;
`include "uvm_macros.svh"


typedef enum { READ, WRITE } direction_e;


class transfer extends uvm_sequence_item;
  rand direction_e direction;
  rand bit [31:0] address;
  rand bit [31:0] data;
  rand int unsigned delay;

  function new(string name = "transfer");
    super.new(name);
  endfunction

  // Overrides the 'copy(...)' function defined in 'uvm_object' and provides
  // compile time safety (at least in some simulators).
  function void copy(transfer rhs);
    super.copy(rhs);
  endfunction

  virtual function transfer clone();
    // Requires 'utils' macro to implement 'create()'.
    //void'($cast(clone, super.clone()));

    // More portable.
    clone = new(get_name());
    clone.copy(this);

    return clone;
  endfunction

  `uvm_object_utils_begin(transfer)
    `uvm_field_enum(direction_e, direction, UVM_ALL_ON)
    `uvm_field_int(address, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(delay, UVM_ALL_ON)
  `uvm_object_utils_end
endclass


endpackage
