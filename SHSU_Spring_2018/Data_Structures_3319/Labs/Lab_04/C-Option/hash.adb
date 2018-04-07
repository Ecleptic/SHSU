with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;

procedure hash is

	package FIO is new Float_IO(float); use FIO;

	subtype string16 is String(1..16);
	subtype string6 is String(1..6);
	subtype slice is String(1..2);
	type largeNumber is mod 2**64;

	function char2large is new Ada.Unchecked_Conversion(character, largeNumber);
	function slice2large is new Ada.Unchecked_Conversion(slice, largeNumber);
	function large2int is new Ada.Unchecked_Conversion(largeNumber, integer);

	type tableEntry is
		record
			key: string16;
			address: integer;
			probes: integer;
		end record;

	table: array(0..127) of tableEntry; --because arrays should start at 0 dammit. (but I guess it's okay that strings won't)

	function hash(str: string16) return integer is
		str1: slice := "  ";
		str2: slice := "  ";
	begin
		for i in 1..2
		loop
			str1(i) := str(i+2); --characters 3-4
			str2(i) := str(i+7); -- characters 8-9
			put("str1(i)");
			new_line;
			put(str1(i));
			new_line(2);
			put("str2(i)");
			new_line;
			put(str2(i));
			new_line(2);
		end loop;
		return large2int((((slice2large(str1) + slice2large(str2))*256) + char2large(str(1))) mod 128);
	end hash;




	val : integer;
begin
	new_line(3);
	put_line("hello");
	val:= hash("Aguirrie        "); --65
	put(integer'Image(val));
end hash;