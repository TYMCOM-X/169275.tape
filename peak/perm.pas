program boolean_permutation;
const
  maxn = 10;

var
  Boolstr  : packed array [0 .. maxn] of char;
  I        : integer;
  N        : integer;

procedure F (X : integer);
begin
  Boolstr[N-X] := '0';

  if (X = 1) then
    writeln(Boolstr)
  else
    F(X-1);

  Boolstr[N-X] := '1';

  if (X = 1) then
    writeln(Boolstr)
  else
    F(X-1);
end;

begin
  for I := 0 to maxn do
    Boolstr[I] := ' ';

  write('Enter the number of bits you wish to display: ');
  readln(N);

  if (N < 1) then
    writeln('N is too small - must be at least 1.')
  else if (N > maxn) then
    writeln('N is too large - must be at most ', maxn, '.')
  else
    F(N);
end.

    