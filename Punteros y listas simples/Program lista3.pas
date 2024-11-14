Program lista3
Const
    valornulo = -1;
Type
//lista ordenada ascendentemente
    puntero = ^nodo;
        nodo = record
            nro:Integer;
            sig:puntero;
        end;

procedure crearnodo(var nodo:puntero; dato:integer);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.nro:= dato;
end;

Procedure cargalista (var lista:puntero);
var
    cursor:puntero;
    dato:integer;
begin
    lista:= nil;
    writeln('ingrese datos a la lista: ');
    readln(dato);
    if (dato <> valornulo) then
        begin
            crearnodo(lista,dato);
            cursor:= lista;
            readln(dato);
            while (dato <> valornulo) do
                begin
                    crearnodo(cursor^.sig,dato);
                    cursor:= cursor^.sig;
                    readln(dato);
                end;
        end;
end;

procedure ordenarascendente(var lista:puntero);
var
    dato:integer;
    cursor,aAgregar:puntero;
begin
    Writeln('ingrese dato: ');
    readln(dato);
    crearnodo(aAgregar,dato);
    If (lista = nil) then 
        begin
            lista:=aAgregar;
        end
    else
        Begin
            If (aAgregar^.nro <= lista^.nro) then
                Begin
                    aAgregar^.sig:= lista;
                    lista:=aAgregar;
                end
            else
                begin
                    cursor:= lista;
                    While (cursor^.sig <> nil) and (cursor^.sig^.nro <= aAgregar^.nro) do
                        begin
                            cursor:=cursor^.sig;  
                        end;
                    If (cursor <> nil) then
                        Begin
                            aAgregar^.sig:= cursor^.sig;
                            cursor^.sig:= aAgregar;
                        end;
                end;
        end;
end;

procedure mostrarlista (lista:puntero);
var
    cursor:puntero;
begin
    cursor:=lista;
    writeln('La lista es: ');
    while (cursor <> nil) do
        begin
            writeln(cursor^.nro);
            cursor:= cursor^.sig;
        end;
end;

var
    lista:puntero;
begin
    cargalista(lista);
    mostrarlista(lista);
    ordenarascendente(lista);
    mostrarlista(lista);
end.