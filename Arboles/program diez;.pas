program diez;
const
    discernible = -1;
type 
    tlista = ^tipolista;
        tipolista = record
            nro:integer;
            sig:tlista;
        end;
    
    puntero = ^tarbol;
        tarbol = record
            nro:integer;
            menores:puntero;
            mayores:puntero;
        end;
 
procedure crearnodoarbol(var nodoarbol:puntero; mitad:tlista);
begin
    new(nodoarbol);
    nodoarbol^.nro:= mitad^.nro;
    nodoarbol^.mayores:= nil;
    nodoarbol^.menores:= nil;
end;
        
procedure crearnodolista(var nodolista:tlista; dato:integer);
begin
    new(nodolista);
    nodolista^.nro:= dato;
    nodolista^.sig:= nil;
end;

procedure crearlista (var lista:tlista);
var
    cursor:tlista;
    dato:integer;
begin
    lista:= nil;
    writeln('ingrese valores a la lista: ');
    readln(dato);
    if (dato <> discernible) then
        begin
            crearnodolista(lista,dato);
            cursor:= lista;
            readln(dato);
            while (dato <> discernible) do 
                begin
                    crearnodolista(cursor^.sig,dato);
                    cursor:= cursor^.sig;
                    readln(dato);
                end;
        end;
end;

procedure mostrarlista (lista:tlista);
var
    cursor:tlista;
begin
    cursor:= lista;
    while (cursor <> nil) do
        begin
            writeln(cursor^.nro);
            cursor:= cursor^.sig;
        end;
end;

function mitad (lista:tlista):tlista;
var
    aux1,aux2:tlista;
begin
    aux1:=lista;
    aux2:=lista^.sig;
    while (aux2 <> nil) and (aux2^.sig <> nil) do 
        begin
            aux2:= aux2^.sig^.sig;
            aux1:= aux1^.sig;
        end;
    mitad:= aux1;
end;

procedure cortarlista (var lista:tlista; var menores:tlista; var mayores:tlista; var mitadd:tlista);
begin
    mitadd:= mitad(lista);
    mayores:= mitadd^.sig;
    mitadd^.sig:= nil;
    menores:= lista;
    lista:= nil;
end;

{procedure agregarnodo(var arbol:puntero; nuevonodo:puntero);
begin
    if (arbol = nil) then
        arbol:= nuevonodo
    else
        begin
            if (nuevonodo^.nro > arbol^.nro) then
                agregarnodo(arbol^.mayores,nuevonodo)
            else
                agregarnodo(arbol^.menores,nuevonodo);
        end;
end;

procedure pasarListaArbol (var arbol:puntero; lista:tlista);
var
    nuevonodo:puntero;
    menores,mayores,mitad:tlista;
begin
    if (lista <> nil) then
        begin
            cortarlista(lista,menores,mayores,mitad);
            crearnodoarbol(nuevonodo,mitad);
            agregarnodo(arbol,nuevonodo);
            pasarListaArbol(arbol, menores);
            pasarListaArbol(arbol, mayores);
        end;
end;}

procedure pasarListaArbol (var arbol:puntero; lista:tlista);
var
    menores,mayores,mitad:tlista;
begin
    if (lista^.sig <> nil) then
        begin
            cortarlista(lista,menores,mayores,mitad);
            crearnodoarbol(arbol,mitad);
            pasarListaArbol(arbol^.menores, menores);
            pasarListaArbol(arbol^.mayores, mayores);
        end
    else
        crearnodoarbol(arbol,lista);
end;

//pre-order        
procedure imprimirArbol (arbol:puntero);
Begin
    If (arbol <> nil) then 
        begin
            writeln (arbol^.Nro);
            imprimirArbol (arbol^.Mayores);
            imprimirArbol (arbol^.Menores);
        End;
End;

//programa principal
var
    lista:tlista;
    arbol:puntero;
begin
    arbol:= nil;
    crearlista(lista);
    Writeln('la lista es: ');
    mostrarlista(lista);
    pasarListaArbol(arbol,lista);
    writeln('El arbol es: ');
    imprimirArbol(arbol);
end.