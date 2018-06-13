-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256piped_types.all;

entity sha256piped_processblock is
  port(h               : in sha256piped_types.array_of_std_logic_vector_32(0 to 7);
       block_r         : in sha256piped_types.array_of_std_logic_vector_32(0 to 63);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out sha256piped_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256piped_processblock is
  signal xs_app_arg   : sha256piped_types.array_of_std_logic_vector_32(0 to 63);
  signal xs_app_arg_0 : sha256piped_types.array_of_array_of_64_std_logic_vector_32(0 to 47);
  signal xs_app_arg_1 : sha256piped_types.array_of_array_of_64_std_logic_vector_32(0 to 47);
  signal xs_app_arg_2 : sha256piped_types.array_of_array_of_64_std_logic_vector_32(0 to 48);
  signal xs           : sha256piped_types.array_of_array_of_64_std_logic_vector_32(0 to 47);
  signal result_0     : sha256piped_types.array_of_std_logic_vector_32(0 to 63);
  signal x            : sha256piped_types.array_of_std_logic_vector_32(0 to 7);
begin
  sha256piped_constructschedule_xs_app_arg : entity sha256piped_constructschedule
    port map
      (result => xs_app_arg
      ,w      => block_r);
  
  xs_app_arg_0 <= xs;
  
  -- map begin
  map_r : for i in xs_app_arg_1'range generate
  begin
    sha256piped_constructschedule_0 : entity sha256piped_constructschedule
  port map
  (result => xs_app_arg_1(i)
  ,w => xs_app_arg_0(i));
  end generate;
  -- map end
  
  xs_app_arg_2 <= sha256piped_types.array_of_array_of_64_std_logic_vector_32'(sha256piped_types.array_of_std_logic_vector_32'(xs_app_arg) & xs_app_arg_1);
  
  -- init begin
  xs <= xs_app_arg_2(0 to xs_app_arg_2'high - 1);
  -- init end
  
  -- last begin 
  result_0 <= xs(xs'high);
  -- last end
  
  sha256piped_compressblock_x : entity sha256piped_compressblock
    port map
      (result          => x
      ,system1000      => system1000
      ,system1000_rstn => system1000_rstn
      ,pts             => result_0
      ,h               => h);
  
  -- zipWith begin
  zipwith : for i_0 in result'range generate
  begin
    result(i_0) <= std_logic_vector(unsigned(h(i_0)) + unsigned(x(i_0)));
  end generate;
  -- zipWith end
end;
