-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256reg_types.all;

entity sha256reg_compressblock is
  port(pts    : in sha256reg_types.array_of_std_logic_vector_32(0 to 63);
       h      : in sha256reg_types.array_of_std_logic_vector_32(0 to 7);
       result : out sha256reg_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256reg_compressblock is
  signal ws1_app_arg   : sha256reg_types.array_of_tup2(0 to 63);
  signal ws1_app_arg_0 : sha256reg_types.array_of_array_of_8_std_logic_vector_32(0 to 63);
  signal ws            : sha256reg_types.array_of_array_of_8_std_logic_vector_32(0 to 64);
  signal ws1           : sha256reg_types.array_of_array_of_8_std_logic_vector_32(0 to 63);
begin
  -- zipWith begin
  zipwith : block
    signal vec1 : sha256reg_types.array_of_std_logic_vector_32(0 to 63);
    signal vec2 : sha256reg_types.array_of_std_logic_vector_32(0 to 63);
  begin
    vec1 <= sha256reg_types.array_of_std_logic_vector_32'(std_logic_vector'(x"428A2F98"),std_logic_vector'(x"71374491"),std_logic_vector'(x"B5C0FBCF"),std_logic_vector'(x"E9B5DBA5"),std_logic_vector'(x"3956C25B"),std_logic_vector'(x"59F111F1"),std_logic_vector'(x"923F82A4"),std_logic_vector'(x"AB1C5ED5"),std_logic_vector'(x"D807AA98"),std_logic_vector'(x"12835B01"),std_logic_vector'(x"243185BE"),std_logic_vector'(x"550C7DC3"),std_logic_vector'(x"72BE5D74"),std_logic_vector'(x"80DEB1FE"),std_logic_vector'(x"9BDC06A7"),std_logic_vector'(x"C19BF174"),std_logic_vector'(x"E49B69C1"),std_logic_vector'(x"EFBE4786"),std_logic_vector'(x"0FC19DC6"),std_logic_vector'(x"240CA1CC"),std_logic_vector'(x"2DE92C6F"),std_logic_vector'(x"4A7484AA"),std_logic_vector'(x"5CB0A9DC"),std_logic_vector'(x"76F988DA"),std_logic_vector'(x"983E5152"),std_logic_vector'(x"A831C66D"),std_logic_vector'(x"B00327C8"),std_logic_vector'(x"BF597FC7"),std_logic_vector'(x"C6E00BF3"),std_logic_vector'(x"D5A79147"),std_logic_vector'(x"06CA6351"),std_logic_vector'(x"14292967"),std_logic_vector'(x"27B70A85"),std_logic_vector'(x"2E1B2138"),std_logic_vector'(x"4D2C6DFC"),std_logic_vector'(x"53380D13"),std_logic_vector'(x"650A7354"),std_logic_vector'(x"766A0ABB"),std_logic_vector'(x"81C2C92E"),std_logic_vector'(x"92722C85"),std_logic_vector'(x"A2BFE8A1"),std_logic_vector'(x"A81A664B"),std_logic_vector'(x"C24B8B70"),std_logic_vector'(x"C76C51A3"),std_logic_vector'(x"D192E819"),std_logic_vector'(x"D6990624"),std_logic_vector'(x"F40E3585"),std_logic_vector'(x"106AA070"),std_logic_vector'(x"19A4C116"),std_logic_vector'(x"1E376C08"),std_logic_vector'(x"2748774C"),std_logic_vector'(x"34B0BCB5"),std_logic_vector'(x"391C0CB3"),std_logic_vector'(x"4ED8AA4A"),std_logic_vector'(x"5B9CCA4F"),std_logic_vector'(x"682E6FF3"),std_logic_vector'(x"748F82EE"),std_logic_vector'(x"78A5636F"),std_logic_vector'(x"84C87814"),std_logic_vector'(x"8CC70208"),std_logic_vector'(x"90BEFFFA"),std_logic_vector'(x"A4506CEB"),std_logic_vector'(x"BEF9A3F7"),std_logic_vector'(x"C67178F2"));
    vec2 <= pts;
    zipwith_0 : for i in ws1_app_arg'range generate
    begin
      ws1_app_arg(i) <= (tup2_sel0 => vec1(i)
  ,tup2_sel1 => vec2(i));
    end generate;
  end block;
  -- zipWith end
  
  -- init begin
  ws1_app_arg_0 <= ws(0 to ws'high - 1);
  -- init end
  
  ws <= sha256reg_types.array_of_array_of_8_std_logic_vector_32'(sha256reg_types.array_of_std_logic_vector_32'(h) & ws1);
  
  -- zipWith begin
  zipwith_1 : for i_0 in ws1'range generate
  begin
    sha256reg_compressblock_specf_0 : entity sha256reg_compressblock_specf
  port map
  (result => ws1(i_0)
  ,x => ws1_app_arg(i_0)
  ,y => ws1_app_arg_0(i_0));
  end generate;
  -- zipWith end
  
  -- last begin 
  result <= ws(ws'high);
  -- last end
end;
