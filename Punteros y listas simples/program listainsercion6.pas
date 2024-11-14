program listainsercion6
const
    discernible = -1;
type
    puntero = ^nodo;
        nodo = record
            nro:integer;
            sig:puntero;
    end;
    
procedure crearnodo (var nodo:puntero; dato:integer);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.nro:= dato;
end;

procedure crearlista (var lista:puntero);
var
    dato:integer;
    cursor:puntero;
begin
    lista:= nil;
    writeln('ingrese valores a la lista: ');
    readln(dato);
    if (dato <> discernible) then
        begin
            crearnodo(lista,dato);
            cursor:= lista;
            readln(dato);
            while (dato <> discernible) do 
                begin
                    crearnodo(cursor^.sig,dato);
                    cursor:= cursor^.sig;
                    readln(dato);
                end;
        end;
end;

procedure imprimirlista(lista:puntero);
var
    cursor:puntero;
begin
    cursor:= lista;
    while (cursor <> nil) do 
        begin
            writeln(cursor^.nro);
            cursor:= cursor^.sig;
        end;
end;

procedure ordenarinsercion (var lista:puntero);
var
    cursor,cursor2:puntero;
    guardar,reemplazar:integer;
begin
    cursor:=lista;
    while (cursor <> nil) do
        begin
            cursor2:=lista;
            while (cursor^.nro > cursor2^.nro) and (cursor2^.sig <> cursor) do 
                begin
                    cursor2:= cursor2^.sig;
                end;
            if (cursor^.nro < cursor2^.nro) then
                begin
                    reemplazar:= cursor^.nro;
                    guardar:= cursor2^.nro;
                    while (cursor2 <> cursor) do
                        begin
                            cursor2^.nro:=reemplazar;
                            cursor2:=cursor2^.sig;
                            reemplazar:=guardar;
                            guardar:=cursor2^.nro;
                        end;
                    cursor2^.nro:=reemplazar;
                end;
            cursor:=cursor^.sig;
        end;
    writeln('Lista ordenada por insercion: ');
    imprimirlista(lista);
end;

//programa principal
var
    lista:puntero;
begin
    crearlista(lista);
    Writeln('la lista es: ');
    imprimirlista(lista);
    ordenarinsercion(lista);
end.