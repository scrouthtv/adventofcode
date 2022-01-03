with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Exceptions; use Ada.Exceptions;

procedure B is
	type Seat is (E, O, F); -- Empty, Occupied or Floor
	type Boat is ARRAY (Natural range <>, Natural range <>) of Seat;

	type Direction is (NN, NE, EE, SE, SS, SW, WW, NW);
	-- north, north east, east, south east, south, south west, west, north west
	-- Primary directions (e.g. north) are explicitely given two letters for
	-- better readability.

	Name : constant String := "in1.txt";
	Width : constant := 95;
	Height : constant := 95;
	MyBoat : Boat (1..Width, 1..Height);

	Has_Changed : Boolean;
	Max_Runs : constant := 1e3; -- Max runs until we abort the simulation.
	Min_Occ : constant := 5; -- How many occupied seats people need to leave.

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

	function Is_Occupied (X : Integer; Y : Integer; Dir : Direction) return Boolean is
		SearchX : Integer := X;
		SearchY : Integer := Y;
	begin
		while true loop
			case Dir is
				when NN => SearchY := SearchY - 1;
				when NE => SearchX := SearchX + 1; SearchY := SearchY - 1;
				when EE => SearchX := SearchX + 1;
				when SE => SearchX := SearchX + 1; SearchY := SearchY + 1;
				when SS => SearchY := SearchY + 1;
				when SW => SearchX := SearchX - 1; SearchY := SearchY + 1;
				when WW => SearchX := SearchX - 1;
				when NW => SearchX := SearchX - 1; SearchY := SearchY - 1;
				when others => Put("bad direction "); Put_Line(Dir'Image);
			end case;

			if SearchX < 1 or SearchX > Width or SearchY < 1 or SearchY > Height  then
				return false;
			end if;

			if MyBoat (SearchX, SearchY) = E then
				return false;
			elsif MyBoat (SearchX, SearchY) = O then
				return true;
			end if;
		end loop;

		return false;
	end;

	-- Around counts the occupied seats around X/Y.
	function Around (X : Integer; Y : Integer) return Natural is
		Val : Natural := 0;
	begin
		for Dir in Direction loop
			if Is_Occupied(X, Y, Dir) then
				Val := Val + 1;
			end if;
		end loop;

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
				elsif MyBoat (X, Y) = O and then Around (X, Y) >= Min_Occ then
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

	function Count_Occupied return Natural is
		C : Natural := 0;
	begin
		for X in 1..Width loop
			for Y in 1..Height loop
				if MyBoat (X, Y) = O then
					C := C + 1;
				end if;
			end loop;
		end loop;

		return C;
	end Count_Occupied;

begin
	begin
		Read_Boat (Name);
	exception
		when Bad_Input => Put ("Cannot read input");
	end;

	--Put_Line ("before:");
	--Print_Boat;

	--Run_Once;
	--Put_Line ("-----------");
	--Put_Line ("afterwards:");
	--Print_Boat;

	Run;
	Put ("In the end,");
	Put (Count_Occupied'Image);
	Put_Line (" seats were occupied.");
end B;

