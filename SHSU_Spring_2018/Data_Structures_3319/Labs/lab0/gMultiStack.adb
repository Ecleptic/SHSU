with Ada.Text_IO; use Ada.Text_IO;

package body gMultiStack is

	type NameType is (Burris, Zhou, Shashidhar, Shannon, Yang, Smith, Wei,
		Rabieh, Song, Cho, Varol, Karabiyik, Cooper, McGuire, Najar, An, Deering, Hope,
		Pray, NoHope);
	package NameType_IO is new Ada.Text_IO.Enumeration_IO(NameType);
	use NameType_IO;

	package IIO is new Ada.Text_IO.Integer_IO(integer); use IIO;
	
	function getLowerBound return integer is
		low: integer;
		Output: File_Type;
	begin
		Create(Output, Append_File, Output_File);
		put("Enter lower bound for array: ");
		put(Output, "Enter lower bound for array: ");
		get(low);
		put(Output, low'Image);
		Close(Output);
		return low;
	end getLowerBound;
	
	function getUpperBound return integer is
		high: integer;
		Output: File_Type;
	begin
		Open(Output, Append_File, Output_File);
		put("Enter upper bound for array: ");
		put(Output, "Enter upper bound for array: ");
		get(high);
		put(Output, high'Image);
		Close(Output);
		return high;
	end getUpperBound;
	
	function getNumOfStacks return integer is
		num: integer;
		Output: File_Type;
	begin
		Open(Output, Append_File, Output_File);
		put("Enter number of stacks: ");
		put(Output, "Enter number of stacks: ");
		get(num);
		put(Output, num'Image);
		Close(Output);
		return num;
	end getNumOfStacks;
		
	function floor(x: float) return integer is
		temp: integer;
	begin
		temp := integer(x);
		if (float(temp) <= x) then
			return temp;
		else
			return temp - 1;
		end if;
	end floor;

	procedure runMultiStack is
		StackSpace: arrayType(getLowerBound..getUpperBound);
		
		N: integer := getNumOfStacks;
		L: integer;
		M: integer;
		K: integer;
		
		Base: intArray(1..N + 1);
		Top: intArray(1..N);
		Info: intArray(1..N + 1);		--holds OldTop, Growth, and NewBase
		
		opcode: String := "  ";
		input: MyType;
		temp: String := " ";
		
		Output: File_Type;
	begin
		Open(Output, Append_File, Output_File);
		put("Enter lower bound for stacks: ");
		put(Output, "Enter lower bound for stacks: ");
		IIO.get(L);
		put_line(Output, L'Image);
		put("Enter upper bound for stacks: ");
		put(Output, "Enter upper bound for stacks: ");
		IIO.get(M);
		put_Line(Output, M'Image);
		put_line(Output, "");
		
		for J in 1..N loop
			Base(j) := floor((float(J) - 1.0)/float(N)*(float(M) - float(L))) + L;
			Top(j) := Base(J);
			Info(J) := Top(J);		--collect OldTop values
		end loop;
		Base(N + 1) := M;
		Info(N + 1) := M;
		
		new_line;
		put("Begin Opcodes, type 'EX' to quit: "); new_line;
		put(Output, "Begin Opcodes, type 'EX' to quit: ");
		Close(Output);
		
		while opcode /= "EX" loop		--loop until exit or out of memory
			put("Opcode: "); new_line;
			Open(Output, Append_File, Output_File);
			put_line(Output, "Opcode: ");
			Ada.Text_IO.get(opcode);
			put(Output, opcode); put(Output, " ");
			
			if opcode(1) = 'I' then
				get(input);
				put(Output, convert(input)); put_Line(Output, ""); put_Line(Output, "");
				
				temp(1) := opcode(2);
				K := Integer'Value(temp);
				Top(K) := Top(K) + 1;
				if Top(K) > Base(K + 1) then
					put("OVERFLOW: calling 'reallocate'..."); new_line;
					put_line(Output, "OVERFLOW: calling 'reallocate'..."); put_Line(Output, "");
					
					put_line(Output, "---------------------------------------------------------");
					put_line(Output, "<><><>Before<><><>");
					Close(Output);
					print(StackSpace, L, M, N, Base, Top, Info);
					if reallocate(StackSpace, Info, Base, Top, L, M, N, K, input) = false then
						opcode := "EX";
					end if;
					if opcode /= "EX" then
						Open(Output, Append_File, Output_File);
						put_line(Output, "");
						put_line(Output, "<><><>After<><><>");
						Close(Output);
						print(StackSpace, L, M, N, Base, Top, Info);
						Open(Output, Append_File, Output_File);
						put_line(Output, "---------------------------------------------------------");
						put_Line(Output, "");
						Close(Output);
					end if;
				else
					StackSpace(Top(K)) := input;
					Close(Output);
				end if;
			end if;
			if opcode(1) = 'D' then
				temp(1) := opcode(2);
				K := Integer'Value(temp);
				if Top(K) = Base(K) then
					put("UNDERFLOW: nothing in this stack to delete!"); new_line;
					put_Line(Output, ""); put_Line(Output, "");
					put_line(Output, "UNDERFLOW: nothing in this stack to delete!");
					put_Line(Output, "");
				else
					put_Line(Output, ""); put_Line(Output, "");
					input := StackSpace(Top(K));
					Top(K) := Top(K) - 1;
				end if;
				Close(Output);
			end if;
			new_line;
		end loop;
	end runMultiStack;
	
	function reallocate(StackSpace: in out arrayType; Info: in out intArray;
		Base: in out intArray; Top: in out intArray; L: integer; M: integer;
		N: integer; K: integer; input: MyType) return boolean is
		
		AvailSpace: integer;
		TotalInc: integer := 0;
		MinSpace: integer := floor(0.05*(float(M) - float(L)));
		J: integer := N;
		Alpha: float;
		Beta: float;
		Sigma: float;
		Tau: float;
		temp: integer;
		
		Output: File_Type;
	begin
		if MinSpace = 0 then
			MinSpace := 1;
		end if;
		AvailSpace := M - L;
		while J > 0 loop
			AvailSpace := AvailSpace - (Top(J) - Base(J));
			if Top(J) > Info(J) then
				Info(J) := Top(J) - Info(J);
				TotalInc := TotalInc + Info(J);
			else
				Info(J) := 0;
			end if;
			J := J - 1;
		end loop;
		if AvailSpace < (MinSpace - 1) then
			put("OUT OF MEMORY, terminating program...");
			Open(Output, Append_File, Output_File);
			put_Line(Output, "");
			put(Output, "OUT OF MEMORY, terminating program...");
			Close(Output);
			return false;
		end if;
		Alpha := 0.15 * float(AvailSpace) / float(N);
		Beta := 0.85 * float(AvailSpace) / float(TotalInc);
		Sigma := 0.0;
		temp := Info(1);
		Info(1) := Base(1);
		for J in 2..N loop
			Tau := Sigma + Alpha + float(temp)*Beta;
			temp := Info(J);
			Info(J) := Info(J-1) + Top(J-1) - Base(J-1) + floor(Tau) - floor(Sigma);
			Sigma := Tau;
		end loop;
		Top(K) := Top(K) - 1;
		movestack(StackSpace, Info, Top, Base, N);
		Top(K) := Top(K) + 1;
		StackSpace(Top(K)) := input;
		for J in 1..N loop
			Info(J) := Top(J);
		end loop;
		return true;
	end reallocate;
	
	procedure movestack(StackSpace: in out arrayType; Info: intArray;
		Top: in out intArray; Base: in out intArray; N: integer) is
		Delt: integer;
	begin	
		for J in 2..N loop
			if Info(J) < Base(J) then
				Delt := Base(J) - Info(J);
				for L in (Base(J)+1)..Top(J) loop
					StackSpace(L - Delt) := StackSpace(L);
				end loop;
				Base(J) := Info(J);
				Top(J) := Top(J) - Delt;
			end if;
		end loop;
		for J in reverse 2..N loop
			if Info(J) > Base(J) then
				Delt := Info(J) - Base(J);
				for L in reverse (Base(J)+1)..Top(J) loop
					StackSpace(L + Delt) := StackSpace(L);
				end loop;
				Base(J) := Info(J);
				Top(J) := Top(J) + Delt;
			end if;
		end loop;
	end movestack;
	
	procedure print(StackSpace: arrayType; L: integer; M: integer;
		N: integer; Base: intArray; Top: intArray; Info: intArray) is
		Output: File_Type;
	begin
		Open(Output, Append_File, Output_File);
		for J in 1..N+1 loop
			put("Base["); put(J,0); put("]: "); put(Base(J),0); put("  ");
			put(Output, "Base["); put(Output, J'Image); put(Output, "]: ");
			put(Output, Base(J)'Image); put(Output, "  ");
			if J <= N then
				put("Top["); put(J,0); put("]: "); put(Top(J),0); put("  ");
				put(Output, "Top["); put(Output, J'Image); put(Output, "]: ");
				put(Output, Top(J)'Image); put(Output, "  ");
				put("OldTop["); put(J,0); put("]: "); put(Info(J),0); put("  ");
				put(Output, "OldTop["); put(Output, J'Image); put(Output, "]: ");
				put(Output, Info(J)'Image); put_line(Output, "  ");
			end if;
			new_line;
		end loop;
		put_line(Output, ""); put_line(Output, "");
		new_line;
		
		for j in 1..N loop
			for i in Base(j)+1..Top(j) loop
				if i <= Base(j+1) then
					put(i,0); put(": "); put(StackSpace(i)); new_line;
					put(Output, i'Image); put(Output, ": ");
					put_line(Output, convert(StackSpace(i)));
				end if;
			end loop;
			for i in Top(j)+1..Base(j+1) loop
				put(i,0); put(":"); put(" "); new_line;
				put(Output, i'Image); put(Output, ":"); put_line(Output, " ");
			end loop;
		end loop;
		Close(Output);
		new_line;
	end print;
begin
	runMultiStack;
end gMultiStack;