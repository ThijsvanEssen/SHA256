-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256_types.all;

entity sha256_topentity_0 is
  port(arg    : in std_logic_vector(319 downto 0);
       result : out sha256_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256_topentity_0 is
begin
  sha256_digest_result : entity sha256_digest
    port map
      (result  => result
      ,block_r => arg);
end;
