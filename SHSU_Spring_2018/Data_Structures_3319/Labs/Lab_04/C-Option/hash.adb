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
	statsTable: array(0..127) of tableEntry; --because arrays should start at 0 dammit. (but I guess it's okay that strings won't)

	procedure initTable is
	begin
		for i in 0..127
		loop
			table(i).key := "Undefined_Key   ";
			table(i).address := 0;
			table(i).probes := 0;
		end loop;
	end initTable;
	procedure initStatsTable is
	begin
		for i in 0..127
		loop
			statsTable(i).key := "Undefined_Key   ";
			statsTable(i).address := 0;
			statsTable(i).probes := 0;
		end loop;
	end initStatsTable;

	function hash(str: string16) return integer is
		str1: slice := str(3..4);
		str2: slice :=  str(8..9);
	begin
		return longToInt((((sliceToLong(str1) + sliceToLong(str2))*256) + charToLong(str(1))) mod 128);
	end hash;

	function cameronHash(str: string16) return integer is
	str1: cSlice := str(1..6);
	begin
		-- put_line(integer'image(longToInt(cSliceToLong(str1) xor  199933 ) mod 128));
		return (longToInt((cSliceToLong(str1) xor 3) / 100000) mod 128);
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
					knt := 0;
					timesWrapped := knt;
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
					knt := 0;
					timesWrapped := knt;
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

	procedure insertStatsTable(str: string16; initialProbe: integer; isLinear: boolean) is
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
				if statsTable(knt).key = "Undefined_Key   "
				then
					statsTable(knt).key := str;
					statsTable(knt).address := initialProbe;
					statsTable(knt).probes := knt + wrapKnt - initialProbe + 1;
					isPlaced := true;
				elsif knt = 127
				then
					timesWrapped := timesWrapped + 1;
					wrapKnt := knt + 1;
					knt := 0;
				elsif timesWrapped > 128
				then
					knt := 0;
					timesWrapped := knt;
				else
					knt := knt + 1;
				end if;
			end loop;
		else
			wrapKnt := 1;
			while isPlaced = false
			loop
				if statsTable(knt).key = "Undefined_Key   "
				then
					statsTable(knt).key := str;
					statsTable(knt).address := initialProbe;
					statsTable(knt).probes := wrapKnt;
					isPlaced := true;
				elsif timesWrapped > 128
				then
					knt := 0;
					timesWrapped := knt;
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
	end insertStatsTable;

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
	procedure printStatsTable is
	begin
		put_line(Character'Val (9) & Character'Val (9) & "Key "  & Character'Val (9) & Character'Val (9) & "Address" & Character'Val (9) & Character'Val (9) & "Probes");
		for i in 0..127 loop
			put(integer'image(i)); --0,1,2,3
			put(":" & Character'Val (9) & "|" & Character'Val (9));
			put(statsTable(i).key);
			put(" |" & Character'Val (2));
			put(integer'image(statsTable(i).address));
			put_line(Character'Val (9) & Character'Val (9) & "|" & integer'Image(statsTable(i).probes));
		end loop;
	end printStatsTable;


	procedure printStats(isLinear: boolean; givenHash: boolean; is50: boolean) is
		maxProbes: integer := 1; minProbes: integer := 128; avgProbes: float := 0.0;
		avgKnt: integer := 0;	Line: string(1..17); actualLine: string16;
	begin
		initStatsTable;
		Open(Input, In_File, "Words.txt");
		Set_Line (input, To => 1);
		if is50 = true
		then
			for i in 0..63
			loop
				Line := Get_Line(Input);
				actualLine := Line(1..16); -- need to remove the newline character
				if givenHash = true
				then
					-- put_line("not my hash");
					insertStatsTable(actualLine,hash(actualLine), isLinear);
				else
					-- put_line("my hash");
					insertStatsTable(actualLine,cameronHash(actualLine), isLinear);
				end if;
				--put_line(integer'Image(statsTable(i)).probes));
				if i < 30
				then
					for j in 0..127
					loop
						if statsTable(j).key = actualLine
						then
							if statsTable(j).probes > maxProbes
							then
								maxProbes := statsTable(j).probes;
								-- put_line("Maximum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if  statsTable(j).probes < minProbes and statsTable(j).probes > 0
							then
								minProbes := statsTable(j).probes;
								-- put_line("minimum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if statsTable(j).probes > 0
							then
								avgProbes := (avgProbes) + float(statsTable(j).probes);
								avgKnt := avgKnt + 1;
								-- put_line("Avg probes for " & statsTable(j).key & "is now" & Integer'Image(avgKnt));
							end if;
						end if;
					end loop;
				elsif i = 31
				then
					avgProbes := avgProbes / float(avgKnt);
					put_line("Stats for the first 30 entries");
					put_line("Minimum Probes: " & integer'image(minProbes));
					put_line("Maximum Probes: " & integer'image(maxProbes));
					put_line("Average Probes: " & float'image(avgProbes));
					minProbes := 128;
					maxProbes := 0;
					avgProbes := 0.0;

				elsif i > 33 and i < 63
				then
					for j in 0..127
					loop
						if statsTable(j).key = actualLine
						then
							if statsTable(j).probes > maxProbes
							then
								maxProbes := statsTable(j).probes;
								-- put_line("Maximum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if  statsTable(j).probes < minProbes and statsTable(j).probes > 0
							then
								minProbes := statsTable(j).probes;
								-- put_line("minimum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if statsTable(j).probes > 0
							then
								avgProbes := (avgProbes) + float(statsTable(j).probes);
								avgKnt := avgKnt + 1;
								-- put_line("avg probes for " & statsTable(j).key & "is now" & Integer'Image(avgKnt));
							end if;
					end if;
					end loop;

				elsif  i = 63
				then
					avgProbes := avgProbes / float(avgKnt);
					put_line("Stats for the last 30 entries");
					put_line("Minimum Probes: " & integer'image(minProbes));
					put_line("Maximum Probes: " & integer'image(maxProbes));
					put_line("Average Probes: " & float'image(avgProbes));
				end if;
			end loop;
		else
			for i in 0..115
			loop
				Line := Get_Line(Input);
				actualLine := Line(1..16); -- need to remove the newline character
				if givenHash = true
				then
					-- put_line("not my hash");
					insertStatsTable(actualLine,hash(actualLine), isLinear);
				else
					-- put_line("my hash");
					insertStatsTable(actualLine,cameronHash(actualLine), isLinear);
				end if;
				--put_line(integer'Image(statsTable(i)).probes));
				if i < 30
				then
					for j in 0..127
					loop
						if statsTable(j).key = actualLine
						then
							if statsTable(j).probes > maxProbes
							then
								maxProbes := statsTable(j).probes;
								-- put_line("Maximum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if  statsTable(j).probes < minProbes and statsTable(j).probes > 0
							then
								minProbes := statsTable(j).probes;
								-- put_line("minimum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if statsTable(j).probes > 0
							then
								avgProbes := (avgProbes) + float(statsTable(j).probes);
								avgKnt := avgKnt + 1;
								-- put_line("Avg probes for " & statsTable(j).key & "is now" & Integer'Image(avgKnt));
							end if;
						end if;
					end loop;
				elsif i = 31
				then
					avgProbes := avgProbes / float(avgKnt);
					put_line("Stats for the first 30 entries");
					put_line("Minimum Probes: " & integer'image(minProbes));
					put_line("Maximum Probes: " & integer'image(maxProbes));
					put_line("Average Probes: " & float'image(avgProbes));
					minProbes := 128;
					maxProbes := 0;
					avgProbes := 0.0;

				elsif i > 85 and i < 115
				then
					for j in 0..127
					loop
						if statsTable(j).key = actualLine
						then
							if statsTable(j).probes > maxProbes
							then
								maxProbes := statsTable(j).probes;
								-- put_line("Maximum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if  statsTable(j).probes < minProbes and statsTable(j).probes > 0
							then
								minProbes := statsTable(j).probes;
								-- put_line("minimum probes for " & statsTable(j).key & "is now" & Integer'Image(statsTable(j).probes));
							end if;
							if statsTable(j).probes > 0
							then
								avgProbes := (avgProbes) + float(statsTable(j).probes);
								avgKnt := avgKnt + 1;
								-- put_line("avg probes for " & statsTable(j).key & "is now" & Integer'Image(avgKnt));
							end if;
					end if;
					end loop;

				elsif  i = 115
				then
					avgProbes := avgProbes / float(avgKnt);
					put_line("Stats for the last 30 entries");
					put_line("Minimum Probes: " & integer'image(minProbes));
					put_line("Maximum Probes: " & integer'image(maxProbes));
					put_line("Average Probes: " & float'image(avgProbes));
				end if;
			end loop;
		end if;
		close(input);
	end printStats;



	val : integer;
	Line: string(1..17);
	actualLine: string16;
begin

	initTable;
	new_line(3);

	put_line("Linear Insertion");
		Open(Input, In_File, "Words.txt");
		Set_Line(input, To => 1);
		put_line("filling to 50%");
		for i in 0..63 -- fill to 50%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the newline character
			insert(actualLine,hash(actualLine), true);
		end loop;
		printTable;
		Close(Input);

	printStats(true,true, true);
	initTable;

		Open(Input, In_File, "Words.txt");
		Set_Line (input, To => 1);
		new_line(2);
		put_line("filling to 90%");
		for i in 0..115 -- fill to 90%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the new line character
			insert(actualLine,hash(actualLine), true);
		end loop;
		printTable;
		Close(input);


	printStats(true, true, false);

	initTable;

	new_line(3);
	put_line("Random Insertion");
		Open(Input, In_File, "Words.txt"); 		Set_Line (input, To => 1);
		put_line("filling to 50%");
		for i in 0..63 -- fill to 50%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the new line character
			insert(actualLine,hash(actualLine), false);
		end loop;
		printTable;
		Close(Input);


	printStats(false, true, true);
	initTable;

		new_line(2);
		Open(Input, In_File, "Words.txt"); 		Set_Line (input, To => 1);
		put_line("filling to 90%");
		for i in 0..115 -- fill to 90%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the new line character
			insert(actualLine,hash(actualLine), false);
		end loop;
		printTable;
		Close(input);


	printStats(false, true, false);

	initTable;
	new_line(3);

	put_line("WITH MY HASH");

	put_line("Linear Insertion");

		Open(Input, In_File, "Words.txt"); 		Set_Line (input, To => 1);
		put_line("filling to 50%");
		for i in 0..63 -- fill to 50%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the newline character
			insert(actualLine,cameronHash(actualLine), true);
		end loop;
		printTable;
		Close(Input);


	printStats(true, false, true);
	initTable;

	new_line(2);
	put_line("filling to 90%");

		Open(Input, In_File, "Words.txt"); 		Set_Line (input, To => 1);
		for i in 0..115 -- fill to 90%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the new line character
			insert(actualLine,hash(actualLine), true);
		end loop;
		printTable;
		Close(Input);


	printStats(true, false, false);

	initTable;

	new_line(3);
	put_line("Random Insertion");

		Open(Input, In_File, "Words.txt");
		Set_Line (input, To => 1);
		put_line("filling to 50%");
		for i in 0..63 -- fill to 50%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the new line character
			insert(actualLine,cameronHash(actualLine), false);
		end loop;
		printTable;
		Close(Input);


	printStats(false, false, true);
	initTable;

		Open(Input, In_File, "Words.txt"); 		Set_Line (input, To => 1);
		new_line(2);
		put_line("filling to 90%");
		for i in 0..115 -- fill to 90%
		loop
			Line := Get_Line(Input);
			actualLine := Line(1..16); -- need to remove the new line character
			insert(actualLine,hash(actualLine), false);
		end loop;
		printTable;
		Close(input);


	printStats(false, false, false);

end hash;