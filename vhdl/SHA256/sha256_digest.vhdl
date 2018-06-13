-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256_types.all;

entity sha256_digest is
  port(block_r : in std_logic_vector(479 downto 0);
       result  : out sha256_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256_digest is
  signal app_arg   : sha256_types.array_of_std_logic_vector_32(0 to 14);
  signal app_arg_0 : sha256_types.array_of_std_logic_vector_32(0 to 14);
  signal app_arg_1 : sha256_types.array_of_std_logic_vector_32(0 to 15);
  signal app_arg_2 : sha256_types.array_of_std_logic_vector_32(0 to 15);
  signal app_arg_3 : std_logic_vector(511 downto 0);
  signal app_arg_4 : sha256_types.array_of_std_logic_vector_512(0 to 0);
begin
  -- unconcatBitVector begin
  unconcatbitvector : block
    signal vec : std_logic_vector(479 downto 0);
  begin
    vec <= block_r;
    unconcatbitvectoriter_loop : for i in app_arg'range generate
      app_arg(app_arg'high - i) <= vec(((i * 32) + 32 - 1) downto (i * 32));
    end generate;
  end block;
  -- unconcatBitVector end
  
  -- map begin
  map_r : for i_0 in app_arg_0'range generate
  begin
    sha256_bitpackbitvector1_0 : entity sha256_bitpackbitvector1
  port map
  (result => app_arg_0(i_0)
  ,v => app_arg(i_0));
  end generate;
  -- map end
  
  app_arg_1 <= sha256_types.array_of_std_logic_vector_32'(sha256_types.array_of_std_logic_vector_32'(app_arg_0) & sha256_types.array_of_std_logic_vector_32'((sha256_types.array_of_std_logic_vector_32'(0 to 1-1 =>  std_logic_vector'(x"00000000") ))));
  
  -- map begin
  map_r_1 : for i_1 in app_arg_2'range generate
  begin
    sha256_bitpackbitvector2_1 : entity sha256_bitpackbitvector2
  port map
  (result => app_arg_2(i_1)
  ,v => app_arg_1(i_1));
  end generate;
  -- map end
  
  -- concatBitVector begin
  concatbitvector : block
    signal vec_2 : sha256_types.array_of_std_logic_vector_32(0 to 15);
  begin
    vec_2 <= app_arg_2;
    concatbitvectoriter_loop : for i_2 in vec_2'range generate
      app_arg_3(((i_2 * 32) + 32 - 1) downto (i_2 * 32)) <= std_logic_vector'(vec_2(vec_2'high - i_2));
    end generate;
  end block;
  -- concatBitVector end
  
  app_arg_4 <= sha256_types.array_of_std_logic_vector_512'(0 => app_arg_3);
  
  sha256_digest_0_result : entity sha256_digest_0
    port map
      (result => result
      ,blocks => app_arg_4);
end;
