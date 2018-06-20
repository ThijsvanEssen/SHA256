-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256_types.all;

entity sha256_testbench is
  port(done : out boolean);
end;

architecture structural of sha256_testbench is
  signal finished : boolean;
  signal arg      : std_logic_vector(319 downto 0);
  signal result   : sha256_types.array_of_std_logic_vector_32(0 to 7);
begin
  done <= finished;
  
  totest : entity sha256_topentity_0
    port map
      (arg    => arg
      ,result => result);
  
  arg <= std_logic_vector'(0 to 319 => 'X');
  
  finished <=
  -- pragma translate_off
              false,
  -- pragma translate_on
              true
  -- pragma translate_off
              after 100 ns
  -- pragma translate_on
              ;
end;
