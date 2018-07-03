-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256reg_types.all;

entity sha256reg_digest is
  port(blocks          : in sha256reg_types.array_of_std_logic_vector_512(0 to 0);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out sha256reg_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256reg_digest is
  signal result_0      : sha256reg_types.array_of_std_logic_vector_32(0 to 7);
  signal x             : sha256reg_types.array_of_std_logic_vector_512(0 to 0);
  signal ws1           : sha256reg_types.array_of_array_of_8_std_logic_vector_32(0 to 0);
  signal ws1_app_arg   : sha256reg_types.array_of_array_of_8_std_logic_vector_32(0 to 0);
  signal ws1_app_arg_0 : sha256reg_types.array_of_array_of_8_std_logic_vector_32(0 to 1);
begin
  -- register begin
  sha256reg_digest_register : process(system1000,system1000_rstn)
  begin
    if system1000_rstn = '0' then
      result <= (sha256reg_types.array_of_std_logic_vector_32'(0 to 8-1 =>  std_logic_vector'(x"00000008") ));
    elsif rising_edge(system1000) then
      result <= result_0;
    end if;
  end process;
  -- register end
  
  -- last begin 
  result_0 <= ws1_app_arg_0(ws1_app_arg_0'high);
  -- last end
  
  -- register begin
  sha256reg_digest_register_0 : process(system1000,system1000_rstn)
  begin
    if system1000_rstn = '0' then
      x <= (sha256reg_types.array_of_std_logic_vector_512'(0 to 1-1 =>  std_logic_vector'(x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008") ));
    elsif rising_edge(system1000) then
      x <= blocks;
    end if;
  end process;
  -- register end
  
  -- zipWith begin
  zipwith : for i in ws1'range generate
  begin
    sha256reg_flip_0 : entity sha256reg_flip
  port map
  (result => ws1(i)
  ,x => x(i)
  ,y => ws1_app_arg(i));
  end generate;
  -- zipWith end
  
  -- init begin
  ws1_app_arg <= ws1_app_arg_0(0 to ws1_app_arg_0'high - 1);
  -- init end
  
  ws1_app_arg_0 <= sha256reg_types.array_of_array_of_8_std_logic_vector_32'(sha256reg_types.array_of_std_logic_vector_32'(sha256reg_types.array_of_std_logic_vector_32'(std_logic_vector'(x"6A09E667")
                                                                                                                                                                       ,std_logic_vector'(x"BB67AE85")
                                                                                                                                                                       ,std_logic_vector'(x"3C6EF372")
                                                                                                                                                                       ,std_logic_vector'(x"A54FF53A")
                                                                                                                                                                       ,std_logic_vector'(x"510E527F")
                                                                                                                                                                       ,std_logic_vector'(x"9B05688C")
                                                                                                                                                                       ,std_logic_vector'(x"1F83D9AB")
                                                                                                                                                                       ,std_logic_vector'(x"5BE0CD19"))) & ws1);
end;
