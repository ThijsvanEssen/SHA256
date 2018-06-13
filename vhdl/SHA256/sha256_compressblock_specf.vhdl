-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256_types.all;

entity sha256_compressblock_specf is
  port(x      : in sha256_types.tup2;
       y      : in sha256_types.array_of_std_logic_vector_32(0 to 7);
       result : out sha256_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256_compressblock_specf is
begin
  sha256_compress_result : entity sha256_compress
    port map
      (result => result
      ,ds     => y
      ,ds1    => x);
end;
