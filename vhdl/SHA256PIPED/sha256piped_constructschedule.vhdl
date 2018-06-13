-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256piped_types.all;

entity sha256piped_constructschedule is
  port(w      : in sha256piped_types.array_of_std_logic_vector_32(0 to 63);
       result : out sha256piped_types.array_of_std_logic_vector_32(0 to 63));
end;

architecture structural of sha256piped_constructschedule is
  signal case_scrut : sha256piped_types.tup2;
  signal app_arg    : sha256piped_types.array_of_std_logic_vector_32(0 to 64);
  signal zsr        : sha256piped_types.array_of_std_logic_vector_32(0 to 63);
  signal app_arg_0  : sha256piped_types.array_of_std_logic_vector_32(0 to 0);
  signal result_0   : std_logic_vector(31 downto 0);
  signal app_arg_1  : std_logic_vector(31 downto 0);
  signal app_arg_2  : std_logic_vector(31 downto 0);
  signal app_arg_3  : std_logic_vector(31 downto 0);
  signal app_arg_4  : std_logic_vector(31 downto 0);
  signal app_arg_5  : std_logic_vector(31 downto 0);
  signal app_arg_6  : std_logic_vector(31 downto 0);
  signal app_arg_7  : std_logic_vector(31 downto 0);
  signal app_arg_8  : std_logic_vector(31 downto 0);
  signal app_arg_9  : std_logic_vector(31 downto 0);
  signal app_arg_10 : std_logic_vector(31 downto 0);
  signal app_arg_11 : std_logic_vector(31 downto 0);
  signal app_arg_12 : std_logic_vector(31 downto 0);
  signal w2         : std_logic_vector(31 downto 0);
  signal app_arg_13 : std_logic_vector(31 downto 0);
  signal app_arg_14 : std_logic_vector(31 downto 0);
  signal w15        : std_logic_vector(31 downto 0);
begin
  -- splitAt begin
  case_scrut <= (app_arg(0 to 1-1)
             ,app_arg(1 to app_arg'high));
  -- splitAt end
  
  app_arg <= sha256piped_types.array_of_std_logic_vector_32'(sha256piped_types.array_of_std_logic_vector_32'(w) & sha256piped_types.array_of_std_logic_vector_32'(app_arg_0));
  
  zsr <= case_scrut.tup2_sel1;
  
  app_arg_0 <= sha256piped_types.array_of_std_logic_vector_32'(0 => result_0);
  
  result_0 <= std_logic_vector(unsigned(app_arg_1) + unsigned(app_arg_2));
  
  app_arg_1 <= std_logic_vector(unsigned(app_arg_3) + unsigned(app_arg_4));
  
  -- index begin
  indexvec : block 
    signal vec_index : integer range 0 to 64-1;
  begin
    vec_index <= to_integer(to_signed(57,64))
    -- pragma translate_off
                 mod 64
    -- pragma translate_on
                 ;
    app_arg_2 <= w(vec_index);
  end block;
  -- index end
  
  app_arg_3 <= std_logic_vector(unsigned(app_arg_5) + unsigned(app_arg_6));
  
  app_arg_4 <= app_arg_7 xor app_arg_8;
  
  app_arg_5 <= app_arg_9 xor app_arg_10;
  
  -- index begin
  indexvec_0 : block 
    signal vec_index_0 : integer range 0 to 64-1;
  begin
    vec_index_0 <= to_integer(to_signed(48,64))
    -- pragma translate_off
                 mod 64
    -- pragma translate_on
                 ;
    app_arg_6 <= w(vec_index_0);
  end block;
  -- index end
  
  app_arg_7 <= app_arg_11 xor app_arg_12;
  
  app_arg_8 <= std_logic_vector(shift_right(unsigned(w2),to_integer(to_signed(10,64))));
  
  app_arg_9 <= app_arg_13 xor app_arg_14;
  
  app_arg_10 <= std_logic_vector(shift_right(unsigned(w15),to_integer(to_signed(3,64))));
  
  app_arg_11 <= std_logic_vector(rotate_right(unsigned(w2),to_integer(to_signed(17,64))));
  
  app_arg_12 <= std_logic_vector(rotate_right(unsigned(w2),to_integer(to_signed(19,64))));
  
  -- index begin
  indexvec_1 : block 
    signal vec_index_1 : integer range 0 to 64-1;
  begin
    vec_index_1 <= to_integer(to_signed(62,64))
    -- pragma translate_off
                 mod 64
    -- pragma translate_on
                 ;
    w2 <= w(vec_index_1);
  end block;
  -- index end
  
  app_arg_13 <= std_logic_vector(rotate_right(unsigned(w15),to_integer(to_signed(7,64))));
  
  app_arg_14 <= std_logic_vector(rotate_right(unsigned(w15),to_integer(to_signed(18,64))));
  
  -- index begin
  indexvec_2 : block 
    signal vec_index_2 : integer range 0 to 64-1;
  begin
    vec_index_2 <= to_integer(to_signed(49,64))
    -- pragma translate_off
                 mod 64
    -- pragma translate_on
                 ;
    w15 <= w(vec_index_2);
  end block;
  -- index end
  
  result <= zsr;
end;
