-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256piped_types.all;

entity sha256piped_digest is
  port(blocks          : in sha256piped_types.array_of_std_logic_vector_512(0 to 0);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out sha256piped_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256piped_digest is
  signal ws1_app_arg : sha256piped_types.array_of_array_of_8_std_logic_vector_32(0 to 0);
  signal ws          : sha256piped_types.array_of_array_of_8_std_logic_vector_32(0 to 1);
  signal ws1         : sha256piped_types.array_of_array_of_8_std_logic_vector_32(0 to 0);
begin
  -- init begin
  ws1_app_arg <= ws(0 to ws'high - 1);
  -- init end
  
  ws <= sha256piped_types.array_of_array_of_8_std_logic_vector_32'(sha256piped_types.array_of_std_logic_vector_32'(sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(x"6A09E667")
                                                                                                                                                                  ,std_logic_vector'(x"BB67AE85")
                                                                                                                                                                  ,std_logic_vector'(x"3C6EF372")
                                                                                                                                                                  ,std_logic_vector'(x"A54FF53A")
                                                                                                                                                                  ,std_logic_vector'(x"510E527F")
                                                                                                                                                                  ,std_logic_vector'(x"9B05688C")
                                                                                                                                                                  ,std_logic_vector'(x"1F83D9AB")
                                                                                                                                                                  ,std_logic_vector'(x"5BE0CD19"))) & ws1);
  
  -- zipWith begin
  zipwith : for i in ws1'range generate
  begin
    sha256piped_digest_specf_0 : entity sha256piped_digest_specf
  port map
  (result => ws1(i)
  ,system1000 => system1000
  ,system1000_rstn => system1000_rstn
  ,x => blocks(i)
  ,y => ws1_app_arg(i));
  end generate;
  -- zipWith end
  
  -- last begin 
  result <= ws(ws'high);
  -- last end
end;
