-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256piped_types.all;

entity sha256piped_digest_specf is
  port(x               : in std_logic_vector(511 downto 0);
       y               : in sha256piped_types.array_of_std_logic_vector_32(0 to 7);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out sha256piped_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256piped_digest_specf is
  signal app_arg   : sha256piped_types.array_of_std_logic_vector_32(0 to 15);
  signal app_arg_0 : sha256piped_types.array_of_std_logic_vector_32(0 to 15);
  signal app_arg_1 : sha256piped_types.array_of_std_logic_vector_32(0 to 63);
begin
  -- unconcatBitVector begin
  unconcatbitvector : block
    signal vec : std_logic_vector(511 downto 0);
  begin
    vec <= x;
    unconcatbitvectoriter_loop : for i in app_arg'range generate
      app_arg(app_arg'high - i) <= vec(((i * 32) + 32 - 1) downto (i * 32));
    end generate;
  end block;
  -- unconcatBitVector end
  
  -- map begin
  map_r : for i_0 in app_arg_0'range generate
  begin
    sha256piped_bitpackbitvector1_0 : entity sha256piped_bitpackbitvector1
  port map
  (result => app_arg_0(i_0)
  ,v => app_arg(i_0));
  end generate;
  -- map end
  
  app_arg_1 <= sha256piped_types.array_of_std_logic_vector_32'(sha256piped_types.array_of_std_logic_vector_32'((sha256piped_types.array_of_std_logic_vector_32'(0 to 48-1 =>  std_logic_vector'(x"00000000") ))) & sha256piped_types.array_of_std_logic_vector_32'(app_arg_0));
  
  sha256piped_processblock_result : entity sha256piped_processblock
    port map
      (result          => result
      ,system1000      => system1000
      ,system1000_rstn => system1000_rstn
      ,h               => y
      ,block_r         => app_arg_1);
end;
