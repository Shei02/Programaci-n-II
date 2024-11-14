program ocho
const
    discernible = -1;
type
    puntero = ^tlista;
        tlista = record
            nro:integer;
            sig:puntero;
        end;

procedure crearnodo(var nodo:puntero; dato:integer);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.nro:= dato;
end;

procedure crearlista (var lista:puntero);
var
    cursor:puntero;
    dato:integer;
begin
    lista:=nil;
    writeln('ingrese valores a la lista: ');
    readln(dato);
    If (dato <> discernible) then
        begin
            Crearnodo(lista,dato);
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

procedure imprimirlista (lista:puntero);
begin
    if (lista <> nil) then 
        begin
            writeln(lista^.nro);
            imprimirlista(lista^.sig);
        end;
end;

function menor (lista:puntero):integer;
begin
    if (lista^.sig <> nil) then
        begin
            if (lista^.nro < menor(lista^.sig)) then
                menor:= lista^.nro
            else
                menor:= menor(lista^.sig);
        end
    else
        menor:= lista^.nro;
end;

//programa principal
var
    lista:puntero;
begin
    crearlista(lista);
    Writeln('La lista es: ');
    imprimirlista(lista);
    writeln('El menor elemento es: ', menor(lista));
end.