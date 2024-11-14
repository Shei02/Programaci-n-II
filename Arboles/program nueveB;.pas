program nueveB;
type
    TipoArbol = ^TArbol;
    TArbol = Record 
        Valor : integer;
        Mayor,Menor:TipoArbol;
    end;

Procedure CrearNodo(var Nodo:TipoArbol);
begin
    New(Nodo);
    writeln('inserte valor al nodo:');
    readln(Nodo^.valor);
    Nodo^.mayor := nil;
    Nodo^.menor := nil;
end;

Procedure InsertarEnArbol(var Arbol:TipoArbol; Nodo:TipoArbol);
begin
    if (Arbol = Nil) then
        Arbol := Nodo
    else
    begin
        if (Nodo^.valor < Arbol^.valor) then
            InsertarEnArbol(Arbol^.menor,Nodo)
        else
            InsertarEnArbol(Arbol^.mayor,Nodo);
    end;
end;

Procedure CargarArbol(var Arbol:TipoArbol);
var
    i:integer;
    Nodo:TipoArbol;
begin
    For i := 1 to 6 do
    begin
        CrearNodo(Nodo);
        InsertarEnArbol(Arbol,Nodo);
    end;
end;

Procedure ImprimirArbol(Arbol:TipoArbol);
begin
    If (arbol <> nil) then
    begin
        writeln(Arbol^.valor);
        ImprimirArbol(Arbol^.mayor);
        ImprimirArbol(Arbol^.menor);
    end;
end;

function cantidad(nodo: TipoArbol; maxval, minval: integer): integer;
begin
    if (nodo <> nil) then begin
        if (minval < nodo^.valor) and (maxval > nodo^.valor) then begin
            cantidad := cantidad(nodo^.mayor, maxval, minval) + cantidad(nodo^.menor, maxval, minval) + 1;
        end
        else if (minval > nodo^.valor) then
            cantidad := cantidad(nodo^.mayor, maxval, minval) 
        else if (maxval < nodo^.valor) then
            cantidad := cantidad(nodo^.menor, maxval, minval)
        else 
            cantidad := cantidad(nodo^.mayor, maxval, minval) + cantidad(nodo^.menor, maxval, minval);
    end else
        cantidad := 0;
end;

// programa principal // 

var
    ElArbol: TipoArbol;
    maxval, minval: integer;
begin
    ElArbol := Nil;
    CargarArbol(ElArbol);
    writeln('-------------------------------------');
    ImprimirArbol(ElArbol);
    writeln('Ingrese MaxVal: ');
    readln(maxval);
    writeln('Ingrese Minval: ');
    readln(minval);
    writeln('--------------------------------------');
    writeln('Nodos totales en el rango: ', cantidad(Elarbol, maxval, minval));
end.