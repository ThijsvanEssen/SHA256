-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256pipedreg_types.all;

entity sha256pipedreg_topentity_0 is
  port(arg             : in std_logic_vector(319 downto 0);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out sha256pipedreg_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256pipedreg_topentity_0 is
begin
  sha256pipedreg_digest_0_result : entity sha256pipedreg_digest_0
    port map
      (result          => result
      ,system1000      => system1000
      ,system1000_rstn => system1000_rstn
      ,block_r         => arg);
end;
