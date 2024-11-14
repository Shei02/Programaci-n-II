program tres

function MCD (a,b:integer):integer;
begin
    if (a <> 0) and (b = 0) then
        begin
            writeln('b igual 0');
            MCD:= a;
        end;
    if (a < b) then
        begin
            writeln('menor');
            MCD:= MCD(b,a);
        end;
    if (a >= b) and (b <> 0) then
        begin
            writeln('mayor =');
            MCD:= MCD(b, a mod b);
        end;
end;

function factorial (n:integer):integer;
begin
    if (n = 0) then
        factorial:= 1
    else
        factorial:= n*factorial(n-1);
end;

function factMCD (a,b:integer):integer;
begin
    //composicion
    factMCD:=factorial(MCD(a,b));   
end;

//programa principal
var
    a,b:integer;
begin
    readln(a);
    readln(b);
    writeln('resultado: ');
    writeln(factMCD(a,b));
end.