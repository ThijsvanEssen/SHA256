-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256pipedreg_types.all;

entity sha256pipedreg_topentity is
  port(input_0         : in std_logic_vector(319 downto 0);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       output_0_0      : out std_logic_vector(31 downto 0);
       output_0_1      : out std_logic_vector(31 downto 0);
       output_0_2      : out std_logic_vector(31 downto 0);
       output_0_3      : out std_logic_vector(31 downto 0);
       output_0_4      : out std_logic_vector(31 downto 0);
       output_0_5      : out std_logic_vector(31 downto 0);
       output_0_6      : out std_logic_vector(31 downto 0);
       output_0_7      : out std_logic_vector(31 downto 0));
end;

architecture structural of sha256pipedreg_topentity is
  signal output_0 : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 7);
begin
  sha256pipedreg_topentity_0_inst : entity sha256pipedreg_topentity_0
    port map
      (arg             => input_0
      ,system1000      => system1000
      ,system1000_rstn => system1000_rstn
      ,result          => output_0);
  
  output_0_0 <= output_0(0);
  
  output_0_1 <= output_0(1);
  
  output_0_2 <= output_0(2);
  
  output_0_3 <= output_0(3);
  
  output_0_4 <= output_0(4);
  
  output_0_5 <= output_0(5);
  
  output_0_6 <= output_0(6);
  
  output_0_7 <= output_0(7);
end;
