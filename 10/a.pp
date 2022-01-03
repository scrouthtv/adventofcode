program A;

uses
	Sysutils, fgl;

const
	FNAME = 'in1.txt';

type
	TIntList = specialize TFPGList<integer>;
	TIntEnumerator = specialize TFPGListEnumerator<integer>;

var
	f : TextFile;
	mids : TIntList;
	x : string;
	i : integer;
	enum : TIntEnumerator;
	onesteps : integer;
	threesteps : integer;

function CompareInt(const i1, i2: integer): LongInt;
begin
	if (i1 < i2) then
		Exit(-1)
	else if (i1 > i2) then
		Exit(1)
	else
		Exit(0);
end;

begin
	Assign(f, FNAME);
	Reset(f);

	mids := TIntList.Create();

	while not EOF(f) do
	begin
		Readln(f, x);
		i := StrToInt(x);
		mids.Add(i);
	end;

	writeln('Read file.');
	mids.Sort(@CompareInt);
	writeln('Sorted.');

	(*)enum := mids.GetEnumerator();
	while enum.MoveNext() do
	begin
		writeln(enum.Current);
	end;*)

	i := 0;
	onesteps := 0;
	threesteps := 1; (* last step *)
	enum := mids.GetEnumerator();
	while enum.MoveNext() do
	begin
		case (enum.Current - i) of
			1: inc(onesteps);
			2: ;
			3: inc(threesteps);
			else writeln('impossible step');
		end;
		i := enum.Current;
	end;

	writeln();
	writeln(Format('steps of one: %D, steps of three: %D.', [onesteps, threesteps]));
	writeln(Format('Multiplied: %D', [ onesteps * threesteps ]));
end.
