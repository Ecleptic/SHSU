with Ada.Text_IO; use Ada.Text_IO;
with Ada.Unchecked_Conversion;

procedure hash is

	package FIO is new Float_IO(float); use FIO;

	Input: File_Type;
	Output: File_Type;

	subtype string16 is String(1..16);
	subtype slice is String(1..2);
	subtype cSlice is String(1..6);
	type longInt is mod 2**64;

	function charToLong is new Ada.Unchecked_Conversion(character, longInt);
	function sliceToLong is new Ada.Unchecked_Conversion(slice, longInt);
	function cSliceToLong is new Ada.Unchecked_Conversion(cSlice, longInt);
	function longToInt is new Ada.Unchecked_Conversion(longInt, integer);

	type tableEntry is
		record
			key: string16;
			address: integer;
			probes: integer;
		end record;

	table: array(0..127) of tableEntry; --because arrays should start at 0 dammit. (but I guess it's okay that strings won't)

	procedure initTable is
	begin
		for i in 0..127
		loop
			table(i).key := "Undefined_Key   ";
			table(i).address := 0;
			table(i).probes := 0;
		end loop;
	end initTable;

	function hash(str: string16) return integer is
		str1: slice := str(3..4);
		str2: slice :=  str(8..9);
	begin

		return longToInt((((sliceToLong(str1) + sliceToLong(str2))*256) + charToLong(str(1))) mod 128);
	end hash;

	function cameronHash(str: string16) return integer is
	--str1: cSlice := str(1..6);
	begin
		-- put_line(integer'image(longToInt(charToLong(str(1)) + charToLong(str(2)) + charToLong(str(3))) mod 128));
		return (longToInt(charToLong(str(1)) + charToLong(str(2)) + charToLong(str(3))) mod 128);
	end cameronHash;

	procedure insert(str: string16; initialProbe: integer; isLinear: boolean) is
		isPlaced: boolean := false;
		knt: integer := initialProbe;
		timesWrapped: integer := 0;
		wrapKnt: integer := 0;
		R : integer := 1;
		numBits: integer := 0;
	begin
		if isLinear = true
		then
			while isPlaced = false
			loop
				if table(knt).key = "Undefined_Key   "
				then
					table(knt).key := str;
					table(knt).address := initialProbe;
					table(knt).probes := knt + wrapKnt - initialProbe + 1;
					isPlaced := true;
				elsif knt = 127
				then
					timesWrapped := timesWrapped + 1;
					wrapKnt := knt + 1;
					knt := 0;
				elsif timesWrapped > 128
				then
					put_line("ERR: Out of space");
					isPlaced := true;
				else
					knt := knt + 1;
				end if;
			end loop;
		else
			wrapKnt := 1;
			while isPlaced = false
			loop
				if table(knt).key = "Undefined_Key   "
				then
					table(knt).key := str;
					table(knt).address := initialProbe;
					table(knt).probes := wrapKnt;
					isPlaced := true;
				elsif timesWrapped > 128
				then
					put_line("ERR: Out of space");
					isPlaced := true;
				else
					R := R * 5;
					R := R mod 512;
					numBits := R / 4;
					knt := initialProbe + numBits;
					if knt > 127
					then
						knt := knt - 127;
					end if;
					wrapKnt := wrapKnt + 1;
				end if;
			end loop;
		end if;
	end insert;

	procedure printTable is
	begin
		put_line(Character'Val (9) & Character'Val (9) & "Key "  & Character'Val (9) & Character'Val (9) & "Address" & Character'Val (9) & Character'Val (9) & "Probes");
		for i in 0..127 loop
			put(integer'image(i)); --0,1,2,3
			put(":" & Character'Val (9) & "|" & Character'Val (9));
			put(table(i).key);
			put(" |" & Character'Val (2));
			put(integer'image(table(i).address));
			put_line(Character'Val (9) & Character'Val (9) & "|" & integer'Image(table(i).probes));
		end loop;
	end printTable;

	procedure first30Stats is
	maxProbes: integer := 1; minProbes: integer := 128; avgProbes: float := 0.0;
	begin
		for i in 0..29 loop
			--put_line(integer'Image(table(i).probes));
			avgProbes := avgProbes + float(table(i).probes);
			if table(i).probes > maxProbes
			then
				maxProbes := table(i).probes;
			elsif  table(i).probes < minProbes and table(i).probes > 0
			then
				minProbes := table(i).probes;
			end if;
		end loop;
		avgProbes := float(avgProbes) / float(30);
		put_line("Stats for the first 30 entries");
		put_line("Minimum Probes: " & integer'image(minProbes));
		put_line("Maximum Probes: " & integer'image(maxProbes));
		put_line("Average Probes: " & float'image(avgProbes));
	end first30Stats;

	procedure last30Stats is
	maxProbes: integer := 1; minProbes: integer := 128; avgProbes: float := 0.0;
	begin
		for i in 97..127 loop
			--put_line(integer'Image(table(i).probes));
			avgProbes := (avgProbes) + float(table(i).probes);
			if table(i).probes > maxProbes
			then
				maxProbes := table(i).probes;
			elsif  table(i).probes < minProbes and table(i).probes > 0
			then
				minProbes := table(i).probes;
			end if;
		end loop;
		avgProbes := float(avgProbes) / float(30);
		put_line("Stats for the last 30 entries");
		put_line("Minimum Probes: " & integer'image(minProbes));
		put_line("Maximum Probes: " & integer'image(maxProbes));
		put_line("Average Probes: " & float'image(avgProbes));
	end last30Stats;



	val : integer;
	Line: string(1..17);
	actualLine: string16;
begin

	 initTable;
	 new_line(3);

	put_line("Linear Insertion");
	Open(Input, In_File, "Words.txt");
	put_line("filling to 50%");
	for i in 0..63 -- fill to 50%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the newline character
		insert(actualLine,hash(actualLine), true);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	new_line(2);
	put_line("filling to 90%");
	for i in 64..115 -- fill to 90%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the new line character
		insert(actualLine,hash(actualLine), true);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	Close(input);
	initTable;

	new_line(3);
	put_line("Random Insertion");
	Open(Input, In_File, "Words.txt");
	put_line("filling to 50%");
	for i in 0..63 -- fill to 50%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the new line character
		insert(actualLine,hash(actualLine), false);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	new_line(2);
	put_line("filling to 90%");
	for i in 64..115 -- fill to 90%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the new line character
		insert(actualLine,hash(actualLine), true);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	Close(input);


	initTable;
	new_line(3);

	put_line("WITH MY HASH");

	put_line("Linear Insertion");
	Open(Input, In_File, "Words.txt");
	put_line("filling to 50%");
	for i in 0..63 -- fill to 50%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the newline character
		insert(actualLine,cameronHash(actualLine), true);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	new_line(2);
	put_line("filling to 90%");
	for i in 64..115 -- fill to 90%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the new line character
		insert(actualLine,cameronHash(actualLine), true);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	Close(input);
	initTable;
	-- printTable;
	new_line(3);
	put_line("Random Insertion");
	Open(Input, In_File, "Words.txt");
	put_line("filling to 50%");
	for i in 0..63 -- fill to 50%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the new line character
		insert(actualLine,cameronHash(actualLine), false);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	new_line(2);
	put_line("filling to 90%");
	for i in 64..115 -- fill to 90%
	loop
		Line := Get_Line(Input);
		actualLine := Line(1..16); -- need to remove the new line character
		insert(actualLine,cameronHash(actualLine), true);
	end loop;
	-- printTable;
	first30Stats;
	last30Stats;
	Close(input);

end hash;