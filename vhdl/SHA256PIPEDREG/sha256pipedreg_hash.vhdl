-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.sha256pipedreg_types.all;

entity sha256pipedreg_hash is
  port(hashstate       : in sha256pipedreg_types.array_of_std_logic_vector_32(0 to 7);
       block_r         : in std_logic_vector(511 downto 0);
       -- clock
       system1000      : in std_logic;
       -- asynchronous reset: active low
       system1000_rstn : in std_logic;
       result          : out sha256pipedreg_types.array_of_std_logic_vector_32(0 to 7));
end;

architecture structural of sha256pipedreg_hash is
  signal xs_app_arg   : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 15);
  signal xs_app_arg_0 : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 15);
  signal xs_app_arg_1 : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 63);
  signal xs_app_arg_2 : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 63);
  signal xs_app_arg_3 : sha256pipedreg_types.array_of_array_of_64_std_logic_vector_32(0 to 47);
  signal xs_app_arg_4 : sha256pipedreg_types.array_of_array_of_64_std_logic_vector_32(0 to 47);
  signal xs_app_arg_5 : sha256pipedreg_types.array_of_array_of_64_std_logic_vector_32(0 to 48);
  signal xs           : sha256pipedreg_types.array_of_array_of_64_std_logic_vector_32(0 to 47);
  signal result_0     : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 63);
  signal x            : std_logic_vector(511 downto 0);
  signal x_0          : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 63);
  signal result_1     : sha256pipedreg_types.array_of_std_logic_vector_32(0 to 7);
begin
  -- unconcatBitVector begin
  unconcatbitvector : block
    signal vec : std_logic_vector(511 downto 0);
  begin
    vec <= x;
    unconcatbitvectoriter_loop : for i in xs_app_arg'range generate
      xs_app_arg(xs_app_arg'high - i) <= vec(((i * 32) + 32 - 1) downto (i * 32));
    end generate;
  end block;
  -- unconcatBitVector end
  
  -- map begin
  map_r : for i_0 in xs_app_arg_0'range generate
  begin
    sha256pipedreg_bitpackbitvector1_0 : entity sha256pipedreg_bitpackbitvector1
  port map
  (result => xs_app_arg_0(i_0)
  ,v => xs_app_arg(i_0));
  end generate;
  -- map end
  
  xs_app_arg_1 <= sha256pipedreg_types.array_of_std_logic_vector_32'(sha256pipedreg_types.array_of_std_logic_vector_32'((sha256pipedreg_types.array_of_std_logic_vector_32'(0 to 48-1 =>  std_logic_vector'(x"00000000") ))) & sha256pipedreg_types.array_of_std_logic_vector_32'(xs_app_arg_0));
  
  sha256pipedreg_constructschedule_xs_app_arg_2 : entity sha256pipedreg_constructschedule
    port map
      (result => xs_app_arg_2
      ,w      => xs_app_arg_1);
  
  xs_app_arg_3 <= xs;
  
  -- map begin
  map_r_1 : for i_1 in xs_app_arg_4'range generate
  begin
    sha256pipedreg_constructschedule_1 : entity sha256pipedreg_constructschedule
  port map
  (result => xs_app_arg_4(i_1)
  ,w => xs_app_arg_3(i_1));
  end generate;
  -- map end
  
  xs_app_arg_5 <= sha256pipedreg_types.array_of_array_of_64_std_logic_vector_32'(sha256pipedreg_types.array_of_std_logic_vector_32'(xs_app_arg_2) & xs_app_arg_4);
  
  -- init begin
  xs <= xs_app_arg_5(0 to xs_app_arg_5'high - 1);
  -- init end
  
  -- last begin 
  result_0 <= xs(xs'high);
  -- last end
  
  -- register begin
  sha256pipedreg_hash_register : process(system1000,system1000_rstn)
  begin
    if system1000_rstn = '0' then
      x <= std_logic_vector'(x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008");
    elsif rising_edge(system1000) then
      x <= block_r;
    end if;
  end process;
  -- register end
  
  -- register begin
  sha256pipedreg_hash_register_0 : process(system1000,system1000_rstn)
  begin
    if system1000_rstn = '0' then
      x_0 <= (sha256pipedreg_types.array_of_std_logic_vector_32'(0 to 64-1 =>  std_logic_vector'(x"00000008") ));
    elsif rising_edge(system1000) then
      x_0 <= result_0;
    end if;
  end process;
  -- register end
  
  sha256pipedreg_compressblock_result_1 : entity sha256pipedreg_compressblock
    port map
      (result => result_1
      ,pts    => x_0
      ,h      => hashstate);
  
  -- zipWith begin
  zipwith : for i_2 in result'range generate
  begin
    result(i_2) <= std_logic_vector(unsigned(hashstate(i_2)) + unsigned(result_1(i_2)));
  end generate;
  -- zipWith end
end;
