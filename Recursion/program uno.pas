program uno

function factorial (n:integer):integer;
begin
    if (n = 0) then
        factorial:= 1
    else
        factorial:= n*factorial(n-1);
end;

var
    n:integer;
begin
    readln(n);
    write('El factorial es: ');
    writeln(factorial(n));
end.