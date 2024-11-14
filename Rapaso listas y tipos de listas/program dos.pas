program dos
const
    discernible = -1;
type
    puntero = ^tlista;
        tlista = record
            nro:real;
            pos:integer;
            sig:puntero;
            ant:puntero;
        end;

procedure crearnodo(var nodo:puntero; valor:real; contador:integer);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.ant:= nil;
    nodo^.nro:= valor;
    nodo^.pos:= contador;
end;

procedure crearlista (var lista:puntero);
var
    cursor:puntero;
    dato:real;
    contador:integer;
begin
    lista:= nil;
    contador:= 1;
    writeln('ingrese valores a la lista: ');
    readln(dato);
    crearnodo(lista,dato,contador);
    cursor:= lista;
    contador+= 1;
    readln(dato);
    while (dato <> discernible) do 
        begin
            crearnodo(cursor^.sig,dato,contador);
            cursor^.sig^.ant:= cursor;
            cursor:=cursor^.sig;
            contador+= 1;
            readln(dato);
        end;
end;

procedure imprimirlista (lista:puntero);
var
    cursor:puntero;
begin
    cursor:= lista;
    while (cursor <> nil) do
        begin
            writeln(cursor^.nro:0:2);
            cursor:= cursor^.sig;
        end;
end;

procedure eliminar (var lista:puntero);
var
    cursor:puntero;
    posicion:integer;
    corte:boolean=false;
begin
    writeln('ingrese la posicion que desea eliminar: ');
    readln(posicion);
    cursor:= lista;
    if (cursor^.pos = posicion) then
        begin
            lista:=cursor^.sig;
            corte:=true;
        end;
    while (cursor^.sig <> nil) and (cursor^.pos <> posicion) do
        begin
            Cursor:= cursor^.sig;
        end;
    if (cursor^.sig <> nil) and (cursor^.pos = posicion) and (corte = false) then
        begin
            Cursor^.ant^.sig:= cursor^.Sig;
            Cursor^.sig^.ant:= cursor^.ant;
            Dispose(cursor);
            cursor:= nil;
            corte:=true;
        end;
    if (corte = false) and (cursor^.sig = nil) and (cursor^.pos = posicion) then
        begin
            cursor^.ant^.sig:= cursor^.sig;
            dispose(cursor^.sig);
            cursor^.sig:= nil;
            corte:= true;
        end;
    if (corte = false) then
        writeln('la posicion no existe')
    else
        begin
            writeln('Lista modificada: ');
            imprimirlista(lista);
        end;
end;

//programa principal
var
    lista:puntero;
begin
    crearlista(lista);
    writeln('La lista es: ');
    imprimirlista(lista);
    eliminar(lista);
end.