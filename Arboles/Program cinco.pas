program cinco;
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
    nodo^.nro:= dato;
    nodo^.mayores:=nil;
    nodo^.menores:=nil;
end;
    
procedure agregarnodo(var nodo:puntarbol; nuevonodo:puntarbol);
begin
    if (nodo = nil) then
        nodo:= nuevonodo
    else
        begin
            if (nuevonodo^.nro > nodo^.nro) then
                agregarnodo(nodo^.mayores,nuevonodo)
            else
                agregarnodo(nodo^.menores,nuevonodo);
        end;
end;

procedure cargaArbol (var arbol:puntarbol);
var
    i,dato:integer;
    nodo:puntarbol;
begin
    writeln('Ingrese valores: ');
    for i:= 1 to 5 do 
        begin   
            readln(dato);
            crearnodo(nodo,dato);
            agregarnodo(arbol,nodo);
        end;
end;

//busqueda por el orden que tiene el arbol
function menorOrdenado (arbol:puntarbol):integer;
begin
    if (arbol <> nil) then
        begin
            if (arbol^.menores = nil) then
                menorOrdenado:= arbol^.nro
            else
                menorOrdenado:= menorOrdenado(arbol^.menores);
        end;
end;

//busqueda por orden distinto al que tiene el arbol
function menorDesordenado (arbol:puntarbol):integer;
begin   
    If (arbol <> nil) then
        begin
            if (arbol^.menores = nil) then
                menorDesordenado:= arbol^.nro
            else
                begin
                    menorDesordenado:= menorDesordenado(arbol^.mayores);
                    if (menorDesordenado = -1) then
                        menorDesordenado:= menorDesordenado(arbol^.menores);
                end;
        end;
end;

procedure imprimirArbol (arbol:puntarbol);
begin
    if (arbol <> nil) then
        begin
            writeln(arbol^.nro);
            imprimirarbol(arbol^.menores);
            imprimirarbol(arbol^.mayores);
        end;
end;

//programa principal
var 
    arbol:puntarbol;
begin
    arbol:= nil;
    cargaarbol(arbol);
    Writeln('El arbol es: ');
    imprimirarbol(arbol);
    writeln('El menor elemento es: ');
    //writeln(menorOrdenado(arbol));
    writeln(menorDesordenado(arbol));
end.