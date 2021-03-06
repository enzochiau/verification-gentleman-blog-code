// Copyright 2014 Tudor Timisescu (verificationgentleman.com)
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

`ifndef DRAIN_TIME_MAIN_TEST
`define DRAIN_TIME_MAIN_TEST

class drain_time_main_test extends uvm_test;
  `uvm_component_utils(drain_time_main_test)
  
  function new(string name = "drain_time_main_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_phase main_phase = phase.find_by_name("main", 0);
    main_phase.phase_done.set_drain_time(this, 10);
  endfunction
  
  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("MAIN", "Wasting some time", UVM_LOW)
    #15;
    `uvm_info("MAIN", "Wasted some time", UVM_LOW)
    phase.drop_objection(this);
  endtask
  
  function void report_phase(uvm_phase phase);
    `uvm_info("REPORT", "Ended", UVM_NONE)
  endfunction
  
endclass

`endif // DRAIN_TIME_MAIN_TEST
