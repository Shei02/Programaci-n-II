program cuatro
const 
    Min = 1;
    Max = 7;
type
    arr = array [Min..Max] of integer;

procedure CargarArreglo(var arreglo: arr);
var
    i: integer;
begin
    for i:= Min to Max do 
    begin
        writeln('ingrese elementos');
        readln(arreglo[i]);
    end;
end;

function capi (arreglo: arr; sub1, sub2: integer): boolean;
begin
    writeln('sub1:', sub1);
    writeln('sub2: ', sub2);
    if (sub1 = sub2) or (sub1 > sub2) then
        capi:= true
    else
        if arreglo[sub1] = arreglo[sub2] then 
        begin
            sub1:= sub1 + 1;
            sub2:= sub2 - 1;
            capi:= capi(arreglo, sub1, sub2);
        end
    else
        capi:= false;
end;
    
procedure ImprimirArreglo (arreglo: arr);
var
    i: integer;
begin
    for i:= Min to Max do 
    begin
        write(' | ');
        write(arreglo[i]);
    end;
end;

//Programa Principal
var
    arreglo: arr;
    sub1, sub2: integer;
begin
    CargarArreglo(arreglo);
    ImprimirArreglo(arreglo);
    sub1:= Min;
    sub2:= Max;
    writeln(' ');
    writeln('capicua: true / nocapicua: false //', capi(arreglo, sub1, sub2));
end.