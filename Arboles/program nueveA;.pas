program nueveA;
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

function longitud(nodo: TipoArbol): integer;
var longMayores, longMenores, raiz: integer;
begin
    if(nodo <> nil) then begin
        longMayores := longitud(nodo^.mayor);
        longMenores := longitud(nodo^.menor);
        raiz:= 1;
    
        longitud:= longMayores + longMenores + raiz;
    end else
        longitud := 0;
end;

// programa principal // 
var
    ElArbol:TipoArbol;
begin
    ElArbol := Nil;
    CargarArbol(ElArbol);
    writeln('-------------------------------------');
    ImprimirArbol(ElArbol);
    writeln('--------------------------------------');
    writeln('Nodos totales: ', longitud(Elarbol));
end.