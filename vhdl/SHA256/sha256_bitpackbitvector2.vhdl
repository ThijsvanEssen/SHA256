-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256_types.all;

entity sha256_bitpackbitvector2 is
  port(v      : in std_logic_vector(31 downto 0);
       result : out std_logic_vector(31 downto 0));
end;

architecture structural of sha256_bitpackbitvector2 is
begin
  result <= v;
end;
