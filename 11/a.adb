with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Exceptions; use Ada.Exceptions;

procedure A is
	type Seat is (E, O, F); -- Empty, Occupied or Floor
	type Boat is ARRAY (Natural range <>, Natural range <>) of Seat;

	Width : Natural := 10;
	Height : Natural := 10;
	MyBoat : Boat (1..Width, 1..Height);

	Has_Changed : Boolean;
	Max_Runs : constant := 1e3; -- Max runs until we abort the simulation.

	Bad_Input : exception;

	procedure Read_Boat (Name : String) is
		File : File_Type;
		Y : Integer;
	begin
		Open (File => File, Mode => In_File, Name => Name);

		Y := 1;

		declare
			S : String := Get_Line (File);
		begin
			Reset (File);

			while not End_Of_File (File) loop
				S := Get_Line (File);
				for X in 1..S'Length loop
					case S(X) is
						when 'L' => MyBoat(X, Y) := E;
						when '#' => MyBoat(X, Y) := O;
						when '.' => MyBoat(X, Y) := F;
						when others => raise Bad_Input with "Invalid character in boat";
					end case;
				end loop;
				Y := Y + 1;
			end loop;
		end;

		Has_Changed := true;
	end Read_Boat;

	function Around (X : Integer; Y : Integer) return Natural is
		Val : Natural := 0;
	begin
		if Y > 1 then
			if X > 1 and then MyBoat (X - 1, Y - 1) = O then
				Val := Val + 1;
			end if;
			if MyBoat (X, Y - 1) = O then
				Val := Val + 1;
			end if;
			if X < Width and then MyBoat (X + 1, Y - 1) = O then
				Val := Val + 1;
			end if;
		end if;

		if X > 1 and then MyBoat (X - 1, Y) = O then
			Val := Val + 1;
		end if;
		if X < Width and then MyBoat (X + 1, Y) = O then
			Val := Val + 1;
		end if;

		if Y < Height then
			if X > 1 and then MyBoat (X - 1, Y + 1) = O then
				Val := Val + 1;
			end if;
			if MyBoat (X, Y + 1) = O then
				Val := Val + 1;
			end if;
			if X < Width and then MyBoat (X + 1, Y + 1) = O then
				Val := Val + 1;
			end if;
		end if;

		return Val;
	end Around;

	procedure Run_Once is
		NextBoat : Boat (1..Width, 1..Height);
	begin
		Has_Changed := false;

		for X in 1..Width loop
			for Y in 1..Height loop
				if MyBoat (X, Y) = E and then Around (X, Y) = 0 then
					NextBoat (X, Y) := O;
					Has_Changed := true;
				elsif MyBoat (X, Y) = O and then Around (X, Y) >= 4 then
					NextBoat (X, Y) := E;
					Has_Changed := true;
				else
					NextBoat (X, Y) := MyBoat (X, Y);
				end if;
			end loop;
		end loop;
		MyBoat := NextBoat;
	end Run_Once;

	procedure Print_Boat is
	begin
		for Y in 1..Height loop
			for X in 1..Width loop
				--Put (MyBoat(X, Y)'Image);
				case MyBoat (X, Y) is
					when E => Put ("L");
					when O => Put ("#");
					when F => Put (".");
				end case;
			end loop;
			Put_Line ("");
		end loop;
	end Print_Boat;

	procedure Run is
		Runs : Integer;
	begin
		Runs := 0;
		while Has_Changed and Runs < Max_Runs loop
			Run_Once;
			Runs := Runs + 1;
		end loop;
	end Run;

begin
	begin
		Read_Boat ("test1.txt");
	exception
		when Bad_Input => Put("Cannot read input");
	end;

	Put_Line ("before:");
	Print_Boat;

	--Run_Once;
	--Put_Line ("-----------");
	--Put_Line ("afterwards:");
	--Print_Boat;

	Run;
end A;

