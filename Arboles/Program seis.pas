Program seis
type
    puntarbol = ^tarbol;
        tarbol = record
            nro:integer;
            mayores:puntarbol;
            menores:puntarbol;
        end;
        
procedure crearnodo(var nodo:puntarbol; dato:integer);
begin
    new(nodo);
    nodo^.nro:=dato;
    nodo^.mayores:= nil;
    nodo^.menores:= nil;
end;

procedure agregarnodo(var nodo:puntarbol; nuevonodo:puntarbol);
begin
    if (nodo = nil) then
        nodo:= nuevonodo
    else
        begin
            if (nuevonodo^.nro < nodo^.nro) then
                agregarnodo(nodo^.menores,nuevonodo)
            else
                agregarnodo(nodo^.mayores,nuevonodo);
        end;
end;

procedure cargaarbol(var arbol:puntarbol);
var
    i,dato:integer;
    nodo:puntarbol;
begin
    writeln('ingrese valores: ');
    for i:= 1 to 6 do 
        begin
            readln(dato);
            crearnodo(nodo,dato);
            agregarnodo(arbol,nodo);
        end;
end;

procedure imprimirarbol(arbol:puntarbol);
begin
    if (arbol <> nil) then
        begin
            imprimirarbol(arbol^.mayores);
            writeln(arbol^.nro);
            imprimirarbol(arbol^.menores);
        end;
end;

function longMayor (arbol:puntarbol):integer;
var 
    contMay,contMen:integer;
begin
    if (arbol <> nil) then
        begin
            contMen:=(longMayor(arbol^.menores)+1);
            contMay:=(longMayor(arbol^.mayores)+1);
            if (contMay >= contMen) then
                longMayor:= contMay
            else
                longMayor:= contMen;
        end
    else
        longMayor:= 0;
end;

//programa Principal
var
    arbol:puntarbol;
begin
    arbol:= nil;
    cargaarbol(arbol);
    imprimirarbol(arbol);
    writeln('La rama de mayor longitud es: ');
    writeln(longMayor(arbol)+1); //se le suma 1 para que cuente la rama desde la raiz
end.