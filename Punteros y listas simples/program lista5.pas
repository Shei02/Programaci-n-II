program lista5
const 
    discernible = '*';
type 
    puntero = ^nodo;
        nodo = record 
            caracter:char;
            sig:puntero;
            anterior:puntero;
    end;
    
procedure crearnodo (var nodo:puntero; dato:char);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.caracter:= dato;
end;

procedure crearlista (var lista:puntero);
var
    dato:char;
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

procedure invertirlista (var lista:puntero);
var
    cursor,anterior:puntero;
begin
    cursor:= nil;
    while (lista <> nil) do
        begin
            anterior:= cursor;
            cursor:= lista;
            lista:= lista^.sig;
            cursor^.sig:= anterior;
        end;
    lista:= cursor;
end;

procedure imprimirlista (lista:puntero);
var
    cursor:puntero;
begin
    cursor:= lista;
    while (cursor <> nil) do 
        begin
            writeln(cursor^.caracter);
            cursor:= cursor^.sig;
        end;
end;

//programa principal
var
    lista:puntero;
begin
    crearlista(lista);
    writeln('la lista es: ');
    imprimirlista(lista);
    invertirlista(lista);
    writeln('la lista invertida es: ');
    imprimirlista(lista);
end.