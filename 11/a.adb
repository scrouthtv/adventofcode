with Ada.Text_IO; use Ada.Text_IO;

procedure A is
	type Seat is (E, O, F); -- Empty, Occupied or Floor
	type Boat is ARRAY (Natural range <>, Natural range <>) of Seat;

	X, Y : Integer;

	Width : Natural := 6;
	Height : Natural := 4;
	MyBoat : Boat(0..6, 0..4);

	procedure Clear_Boat is
	begin
		for X in 0..Width loop
			for Y in 0..Height loop
				MyBoat(X, Y) := E;
			end loop;
		end loop;
	end;

	procedure Run_Once is
	begin
		Put_Line("hey");
	end Run_Once;

	procedure Boat_Value is
	begin
		Put_Line("hey");
	end Boat_Value;

	procedure Print_Boat is
	begin
		for Y in 0..Height loop
			for X in 0..Width loop
				Put(MyBoat(X, Y)'Image);
			end loop;
			Put_Line("");
		end loop;
	end Print_Boat;

begin
	X := 0;
	Y := 0;

	Clear_Boat;
	Put_Line("before:");
	Print_Boat;
	Run_Once;

	Put_Line("-----------");
	Put_Line("afterwards:");
	Print_Boat;
end A;
