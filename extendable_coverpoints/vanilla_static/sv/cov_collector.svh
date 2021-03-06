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


typedef operation_e array_of_operation_e[$];
typedef register_e array_of_register_e[$];



class cg_ignore_bins_policy;
  static function array_of_operation_e get_operation_ignore_bins();
    return '{};
  endfunction

  static function array_of_register_e get_op1_ignore_bins();
    return '{};
  endfunction

  static function array_of_register_e get_op2_ignore_bins();
    return '{};
  endfunction

  static function array_of_register_e get_dest_ignore_bins();
    return '{};
  endfunction
endclass



class cov_collector #(type POLICY = cg_ignore_bins_policy);
  covergroup cg with function sample(operation_e operation, register_e op1,
    register_e op2, register_e dest
  );
    coverpoint operation {
      ignore_bins ignore[] = operation with (item inside
        { POLICY::get_operation_ignore_bins() });
    }

    coverpoint op1 {
      ignore_bins ignore[] = op1 with (item inside
        { POLICY::get_op1_ignore_bins() });
    }

    coverpoint op2 {
      ignore_bins ignore[] = op2 with (item inside
        { POLICY::get_op2_ignore_bins() });
    }

    coverpoint dest {
      ignore_bins ignore[] = dest with (item inside
        { POLICY::get_dest_ignore_bins() });
    }

    operation_vs_op1 : cross operation, op1;
    operation_vs_op2 : cross operation, op2;
    operation_vs_dest : cross operation, dest;

    same_reg_both_ops : coverpoint (op1 == op2);
    same_reg_op1_and_dest : coverpoint (op1 == dest);
    same_reg_op2_and_dest : coverpoint (op2 == dest);
    same_reg_both_ops_and_dest : coverpoint (op1 == dest && op2 == dest);
  endgroup


  function new();
    cg = new();
  endfunction


  function void sample(instruction instr);
    cg.sample(instr.operation, instr.op1, instr.op2, instr.dest);
  endfunction
endclass
