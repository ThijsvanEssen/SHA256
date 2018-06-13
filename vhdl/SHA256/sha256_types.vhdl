library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package sha256_types is
  type array_of_std_logic_vector_32 is array (integer range <>) of std_logic_vector(31 downto 0);
  type tup2_0 is record
    tup2_0_sel0 : sha256_types.array_of_std_logic_vector_32(0 to 7);
    tup2_0_sel1 : sha256_types.array_of_std_logic_vector_32(0 to 0);
  end record;
  type array_of_array_of_64_std_logic_vector_32 is array (integer range <>) of sha256_types.array_of_std_logic_vector_32(0 to 63);
  type tup2 is record
    tup2_sel0 : std_logic_vector(31 downto 0);
    tup2_sel1 : std_logic_vector(31 downto 0);
  end record;
  type array_of_array_of_8_std_logic_vector_32 is array (integer range <>) of sha256_types.array_of_std_logic_vector_32(0 to 7);
  type array_of_tup2 is array (integer range <>) of sha256_types.tup2;
  type array_of_std_logic_vector_512 is array (integer range <>) of std_logic_vector(511 downto 0);
  type tup2_1 is record
    tup2_1_sel0 : sha256_types.array_of_std_logic_vector_32(0 to 0);
    tup2_1_sel1 : sha256_types.array_of_std_logic_vector_32(0 to 63);
  end record;
  function toSLV (slv : in std_logic_vector) return std_logic_vector;
  function toSLV (value :  sha256_types.array_of_std_logic_vector_32) return std_logic_vector;
  function toSLV (p : sha256_types.tup2_0) return std_logic_vector;
  function toSLV (value :  sha256_types.array_of_array_of_64_std_logic_vector_32) return std_logic_vector;
  function toSLV (p : sha256_types.tup2) return std_logic_vector;
  function toSLV (value :  sha256_types.array_of_array_of_8_std_logic_vector_32) return std_logic_vector;
  function toSLV (value :  sha256_types.array_of_tup2) return std_logic_vector;
  function toSLV (value :  sha256_types.array_of_std_logic_vector_512) return std_logic_vector;
  function toSLV (b : in boolean) return std_logic_vector;
  function fromSLV (sl : in std_logic_vector) return boolean;
  function tagToEnum (s : in signed) return boolean;
  function dataToTag (b : in boolean) return signed;
  function toSLV (p : sha256_types.tup2_1) return std_logic_vector;
end;

package body sha256_types is
  function toSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function toSLV (value :  sha256_types.array_of_std_logic_vector_32) return std_logic_vector is
    alias ivalue    : sha256_types.array_of_std_logic_vector_32(1 to value'length) is value;
    variable result : std_logic_vector(1 to value'length * 32);
  begin
    for i in ivalue'range loop
      result(((i - 1) * 32) + 1 to i*32) := toSLV(ivalue(i));
    end loop;
    return result;
  end;
  function toSLV (p : sha256_types.tup2_0) return std_logic_vector is
  begin
    return (toSLV(p.tup2_0_sel0) & toSLV(p.tup2_0_sel1));
  end;
  function toSLV (value :  sha256_types.array_of_array_of_64_std_logic_vector_32) return std_logic_vector is
    alias ivalue    : sha256_types.array_of_array_of_64_std_logic_vector_32(1 to value'length) is value;
    variable result : std_logic_vector(1 to value'length * 2048);
  begin
    for i in ivalue'range loop
      result(((i - 1) * 2048) + 1 to i*2048) := toSLV(ivalue(i));
    end loop;
    return result;
  end;
  function toSLV (p : sha256_types.tup2) return std_logic_vector is
  begin
    return (toSLV(p.tup2_sel0) & toSLV(p.tup2_sel1));
  end;
  function toSLV (value :  sha256_types.array_of_array_of_8_std_logic_vector_32) return std_logic_vector is
    alias ivalue    : sha256_types.array_of_array_of_8_std_logic_vector_32(1 to value'length) is value;
    variable result : std_logic_vector(1 to value'length * 256);
  begin
    for i in ivalue'range loop
      result(((i - 1) * 256) + 1 to i*256) := toSLV(ivalue(i));
    end loop;
    return result;
  end;
  function toSLV (value :  sha256_types.array_of_tup2) return std_logic_vector is
    alias ivalue    : sha256_types.array_of_tup2(1 to value'length) is value;
    variable result : std_logic_vector(1 to value'length * 64);
  begin
    for i in ivalue'range loop
      result(((i - 1) * 64) + 1 to i*64) := toSLV(ivalue(i));
    end loop;
    return result;
  end;
  function toSLV (value :  sha256_types.array_of_std_logic_vector_512) return std_logic_vector is
    alias ivalue    : sha256_types.array_of_std_logic_vector_512(1 to value'length) is value;
    variable result : std_logic_vector(1 to value'length * 512);
  begin
    for i in ivalue'range loop
      result(((i - 1) * 512) + 1 to i*512) := toSLV(ivalue(i));
    end loop;
    return result;
  end;
  function toSLV (b : in boolean) return std_logic_vector is
  begin
    if b then
      return "1";
    else
      return "0";
    end if;
  end;
  function fromSLV (sl : in std_logic_vector) return boolean is
  begin
    if sl = "1" then
      return true;
    else
      return false;
    end if;
  end;
  function tagToEnum (s : in signed) return boolean is
  begin
    if s = to_signed(0,64) then
      return false;
    else
      return true;
    end if;
  end;
  function dataToTag (b : in boolean) return signed is
  begin
    if b then
      return to_signed(1,64);
    else
      return to_signed(0,64);
    end if;
  end;
  function toSLV (p : sha256_types.tup2_1) return std_logic_vector is
  begin
    return (toSLV(p.tup2_1_sel0) & toSLV(p.tup2_1_sel1));
  end;
end;
