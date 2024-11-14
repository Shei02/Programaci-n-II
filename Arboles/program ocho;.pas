program ocho;
type
    puntArbol = ^tarbol;
        tarbol = record
            nro:integer;
            mayores:puntarbol;
            menores:puntarbol;
        end;

procedure crearnodo(var nodo:puntarbol; dato:integer);
begin
    new(nodo);
    nodo^.nro:= dato;
    nodo^.mayores:= nil;
    nodo^.menores:= nil;
end;

procedure agregarNodo (var nodo:puntarbol; nuevonodo:puntarbol);
begin
    if (nodo=nil) then
        nodo:= nuevonodo
    else
        begin
            if (nuevonodo^.nro > nodo^.nro) then
                agregarNodo(nodo^.mayores,nuevonodo)
            else
                agregarNodo(nodo^.menores,nuevonodo);
        end;
end;

procedure cargaarbol (var arbol:puntarbol);
var
    i,dato:integer;
    nodo:puntarbol;
begin
    Writeln('ingrese valores al arbol: ');
    for i:= 1 to 6 do 
        begin
            readln(dato);
            crearnodo(nodo,dato);
            agregarnodo(arbol,nodo);
        end;
end;

procedure SumatoriaArbol (var nodo:puntarbol; var sumatoria:integer);
var 
    suma:integer;
begin
    if(nodo <> nil) then 
        begin
            SumatoriaArbol(nodo^.mayores,suma);
            nodo^.nro := nodo^.nro + suma;
        
            SumatoriaArbol(nodo^.menores,suma);
            nodo^.nro := nodo^.nro + suma;
        
            sumatoria := nodo^.nro;
        end
    else
        sumatoria := 0;
end;

//programa principal
var
    arbol:puntarbol;
    suma:integer;
begin
    cargaArbol(arbol);
    writeln('La sumatoria es: ');
    sumatoriaArbol(arbol,suma);
end.