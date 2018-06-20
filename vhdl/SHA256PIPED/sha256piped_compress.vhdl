-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256piped_types.all;

entity sha256piped_compress is
  port(ds     : in sha256piped_types.array_of_std_logic_vector_32(0 to 7);
       ds1    : in sha256piped_types.tup2;
       result : out sha256piped_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256piped_compress is
  signal case_alt         : sha256piped_types.array_of_std_logic_vector_32(0 to 7);
  signal case_scrut       : sha256piped_types.tup2_0;
  signal result_0         : sha256piped_types.array_of_std_logic_vector_32(0 to 8);
  signal x                : sha256piped_types.array_of_std_logic_vector_32(0 to 7);
  signal app_arg          : sha256piped_types.array_of_std_logic_vector_32(0 to 0);
  signal app_arg_0        : sha256piped_types.array_of_std_logic_vector_32(0 to 7);
  signal app_arg_1        : std_logic_vector(31 downto 0);
  signal app_arg_2        : sha256piped_types.array_of_std_logic_vector_32(0 to 6);
  signal a                : std_logic_vector(31 downto 0);
  signal app_arg_3        : std_logic_vector(31 downto 0);
  signal app_arg_4        : sha256piped_types.array_of_std_logic_vector_32(0 to 5);
  signal temp1            : std_logic_vector(31 downto 0);
  signal b                : std_logic_vector(31 downto 0);
  signal app_arg_5        : std_logic_vector(31 downto 0);
  signal app_arg_6        : std_logic_vector(31 downto 0);
  signal app_arg_7        : sha256piped_types.array_of_std_logic_vector_32(0 to 4);
  signal temp1_app_arg    : std_logic_vector(31 downto 0);
  signal c                : std_logic_vector(31 downto 0);
  signal w                : std_logic_vector(31 downto 0);
  signal scrut            : sha256piped_types.array_of_std_logic_vector_32(0 to 6);
  signal app_arg_8        : std_logic_vector(31 downto 0);
  signal app_arg_9        : std_logic_vector(31 downto 0);
  signal app_arg_10       : std_logic_vector(31 downto 0);
  signal app_arg_11       : std_logic_vector(31 downto 0);
  signal app_arg_12       : std_logic_vector(31 downto 0);
  signal app_arg_13       : sha256piped_types.array_of_std_logic_vector_32(0 to 3);
  signal temp1_app_arg_0  : std_logic_vector(31 downto 0);
  signal k1               : std_logic_vector(31 downto 0);
  signal scrut1           : sha256piped_types.array_of_std_logic_vector_32(0 to 5);
  signal app_arg_14       : std_logic_vector(31 downto 0);
  signal app_arg_15       : std_logic_vector(31 downto 0);
  signal app_arg_16       : std_logic_vector(31 downto 0);
  signal app_arg_17       : std_logic_vector(31 downto 0);
  signal app_arg_18       : std_logic_vector(31 downto 0);
  signal app_arg_19       : sha256piped_types.array_of_std_logic_vector_32(0 to 2);
  signal temp1_app_arg_1  : std_logic_vector(31 downto 0);
  signal temp1_app_arg_2  : std_logic_vector(31 downto 0);
  signal e                : std_logic_vector(31 downto 0);
  signal app_arg_20       : sha256piped_types.array_of_std_logic_vector_32(0 to 1);
  signal temp1_app_arg_3  : std_logic_vector(31 downto 0);
  signal temp1_app_arg_4  : std_logic_vector(31 downto 0);
  signal temp1_app_arg_5  : std_logic_vector(31 downto 0);
  signal h                : std_logic_vector(31 downto 0);
  signal f                : std_logic_vector(31 downto 0);
  signal scrut3           : sha256piped_types.array_of_std_logic_vector_32(0 to 3);
  signal scrut2           : sha256piped_types.array_of_std_logic_vector_32(0 to 4);
  signal app_arg_21       : sha256piped_types.array_of_std_logic_vector_32(0 to 0);
  signal temp1_app_arg_6  : std_logic_vector(31 downto 0);
  signal temp1_app_arg_7  : std_logic_vector(31 downto 0);
  signal temp1_app_arg_8  : std_logic_vector(31 downto 0);
  signal g                : std_logic_vector(31 downto 0);
  signal scrut6           : sha256piped_types.array_of_std_logic_vector_32(0 to 0);
  signal scrut4           : sha256piped_types.array_of_std_logic_vector_32(0 to 2);
  signal temp1_app_arg_9  : std_logic_vector(31 downto 0);
  signal temp1_app_arg_10 : std_logic_vector(31 downto 0);
  signal scrut5           : sha256piped_types.array_of_std_logic_vector_32(0 to 1);
begin
  result <= case_alt;
  
  case_alt <= x;
  
  -- splitAt begin
  case_scrut <= (result_0(0 to 8-1)
             ,result_0(8 to result_0'high));
  -- splitAt end
  
  result_0 <= sha256piped_types.array_of_std_logic_vector_32'(sha256piped_types.array_of_std_logic_vector_32'(app_arg) & sha256piped_types.array_of_std_logic_vector_32'(app_arg_0));
  
  x <= case_scrut.tup2_0_sel0;
  
  app_arg <= sha256piped_types.array_of_std_logic_vector_32'(0 => app_arg_1);
  
  app_arg_0 <= sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(a) & app_arg_2);
  
  app_arg_1 <= std_logic_vector(unsigned(temp1) + unsigned(app_arg_3));
  
  app_arg_2 <= sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(b) & app_arg_4);
  
  -- head begin 
  a <= ds(0);
  -- head end
  
  app_arg_3 <= std_logic_vector(unsigned(app_arg_5) + unsigned(app_arg_6));
  
  app_arg_4 <= sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(c) & app_arg_7);
  
  temp1 <= std_logic_vector(unsigned(temp1_app_arg) + unsigned(w));
  
  -- head begin 
  b <= scrut(0);
  -- head end
  
  app_arg_5 <= app_arg_8 xor app_arg_9;
  
  app_arg_6 <= app_arg_10 xor app_arg_11;
  
  app_arg_7 <= sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(app_arg_12) & app_arg_13);
  
  temp1_app_arg <= std_logic_vector(unsigned(temp1_app_arg_0) + unsigned(k1));
  
  -- head begin 
  c <= scrut1(0);
  -- head end
  
  w <= ds1.tup2_sel1;
  
  -- tail begin
  scrut <= ds(1 to ds'high);
  -- tail end
  
  app_arg_8 <= app_arg_14 xor app_arg_15;
  
  app_arg_9 <= std_logic_vector(rotate_right(unsigned(a),to_integer(to_signed(22,64))));
  
  app_arg_10 <= app_arg_16 xor app_arg_17;
  
  app_arg_11 <= b and c;
  
  app_arg_12 <= std_logic_vector(unsigned(app_arg_18) + unsigned(temp1));
  
  app_arg_13 <= sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(e) & app_arg_19);
  
  temp1_app_arg_0 <= std_logic_vector(unsigned(temp1_app_arg_1) + unsigned(temp1_app_arg_2));
  
  k1 <= ds1.tup2_sel0;
  
  -- tail begin
  scrut1 <= scrut(1 to scrut'high);
  -- tail end
  
  app_arg_14 <= std_logic_vector(rotate_right(unsigned(a),to_integer(to_signed(2,64))));
  
  app_arg_15 <= std_logic_vector(rotate_right(unsigned(a),to_integer(to_signed(13,64))));
  
  app_arg_16 <= a and b;
  
  app_arg_17 <= a and c;
  
  -- head begin 
  app_arg_18 <= scrut2(0);
  -- head end
  
  app_arg_19 <= sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(f) & app_arg_20);
  
  temp1_app_arg_1 <= std_logic_vector(unsigned(h) + unsigned(temp1_app_arg_3));
  
  temp1_app_arg_2 <= temp1_app_arg_4 xor temp1_app_arg_5;
  
  -- head begin 
  e <= scrut3(0);
  -- head end
  
  app_arg_20 <= sha256piped_types.array_of_std_logic_vector_32'(std_logic_vector'(g) & app_arg_21);
  
  temp1_app_arg_3 <= temp1_app_arg_6 xor temp1_app_arg_7;
  
  temp1_app_arg_4 <= e and f;
  
  temp1_app_arg_5 <= temp1_app_arg_8 and g;
  
  -- head begin 
  h <= scrut6(0);
  -- head end
  
  -- head begin 
  f <= scrut4(0);
  -- head end
  
  -- tail begin
  scrut3 <= scrut2(1 to scrut2'high);
  -- tail end
  
  -- tail begin
  scrut2 <= scrut1(1 to scrut1'high);
  -- tail end
  
  app_arg_21 <= sha256piped_types.array_of_std_logic_vector_32'(0 => h);
  
  temp1_app_arg_6 <= temp1_app_arg_9 xor temp1_app_arg_10;
  
  temp1_app_arg_7 <= std_logic_vector(rotate_right(unsigned(e),to_integer(to_signed(25,64))));
  
  temp1_app_arg_8 <= not e;
  
  -- head begin 
  g <= scrut5(0);
  -- head end
  
  -- tail begin
  scrut6 <= scrut5(1 to scrut5'high);
  -- tail end
  
  -- tail begin
  scrut4 <= scrut3(1 to scrut3'high);
  -- tail end
  
  temp1_app_arg_9 <= std_logic_vector(rotate_right(unsigned(e),to_integer(to_signed(6,64))));
  
  temp1_app_arg_10 <= std_logic_vector(rotate_right(unsigned(e),to_integer(to_signed(11,64))));
  
  -- tail begin
  scrut5 <= scrut4(1 to scrut4'high);
  -- tail end
end;
