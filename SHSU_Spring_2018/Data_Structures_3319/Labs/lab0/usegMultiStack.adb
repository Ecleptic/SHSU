with gMultiStack;
with Ada.Text_IO; use Ada.Text_IO;

procedure usegMultiStack is
	
	type NameType is (Burris, Zhou, Shashidhar, Shannon, Yang, Smith, Wei,
		Rabieh, Song, Cho, Varol, Karabiyik, Cooper, McGuire, Najar, An, Deering, Hope,
		Pray, NoHope);
	package NameType_IO is new Ada.Text_IO.Enumeration_IO(NameType);
	use NameType_IO;
	
	type MonthName is (January, February, March, April, May, June, July,
		August, September, October, November, December);
	package MonthName_IO is new Ada.Text_IO.Enumeration_IO(MonthName);
	
	package IIO is new Ada.Text_IO.Integer_IO(integer); use IIO;
		
	type Date is record
		Month: MonthName;
		Day: Integer range 1..31;
		Year: Integer range 1400..2020;
	end record;
	
	procedure GetDate(X: in out Date) is
	begin
		MonthName_IO.get(X.Month);
		IIO.get(X.Day);
		IIO.get(X.Year);
	end GetDate;
	
	procedure PutDate(X: Date) is
	begin
		MonthName_IO.put(X.Month); put(" ");
		IIO.put(X.Day, 0); put(", ");
		IIO.put(X.Year, 0);
	end PutDate;
	
	function DateToString(X: Date) return String is
	begin
		return X.month'Image & " " & X.day'Image & ", " & X.year'Image;
	end DateToString;
	
	procedure GetName(X: in out NameType) is
	begin
		NameType_IO.get(X);
	end GetName;
	
	procedure PutName(X: NameType) is
	begin
		NameType_IO.put(X);
	end PutName;
	
	function NameToString(X: NameType) return String is
	begin
		return X'Image;
	end NameToString;
	
	procedure GetChar(X: in out character) is
	begin
		get(X);
	end GetChar;
	
	procedure PutChar(X: character) is
	begin
		put(X);
	end PutChar;
	
	function CharToString(X: character) return String is
	begin
		return X'Image;
	end CharToString;
	
	procedure GetInt(X: in out integer) is
	begin
		IIO.get(X);
	end GetInt;
	
	procedure PutInt(X: integer) is
	begin
		IIO.put(X);
	end PutInt;
	
	function IntToString(X: integer) return String is
	begin
		return X'Image;
	end IntToString;
	
	package Go is new gMultiStack(NameType, "NameOutput.txt", GetName, PutName, NameToString);
	use Go;
	
	package Go2 is new gMultiStack(Date, "DateOutput.txt", GetDate, PutDate, DateToString);
	use Go2;
	
begin
	null;
end usegMultiStack;