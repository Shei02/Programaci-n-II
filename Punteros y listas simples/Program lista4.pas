Program lista4
Const
    discernible = -1;
Type
    puntero = ^nodo;
    nodo = record
        nro:integer;
        sig:puntero;
    End;
    
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
    writeln('Ingrese valores a la lista: ');
    readln(dato);
    If (dato <> discernible) then
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

function esta (lista:puntero; dato:integer):boolean;
var
    encontro:boolean;
    cursor:puntero;
begin
    cursor:= lista;
    While (cursor <> nil) and (cursor^.nro <> dato) do 
        begin
            cursor:= cursor^.sig;
        end;
    if (cursor <> nil) then
        esta:= true
    else
        esta:= false;
end;

procedure imprimirlista (lista:puntero);
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

procedure eliminardato (var lista:puntero);
var
    estoy:boolean;
    dato:integer;
    cursor,aEliminar:puntero;
begin
    cursor:=lista;
    writeln('ingrese dato: ');
    readln(dato);
    crearnodo(aEliminar,dato);
    estoy:= esta(cursor,dato);
    if (estoy) then
        begin
            If (cursor^.nro = aEliminar^.nro) then
                Begin
                    aEliminar:= cursor;
                    cursor:= cursor^.sig;
                    dispose(aEliminar);
                    lista:= cursor;
                end
            else
                cursor:= lista;
                while (cursor^.sig^.nro <> aEliminar^.nro) do
                    begin
                        Cursor:= cursor^.sig;
                    end;
                if (cursor <> nil) then
                    begin
                        aEliminar:= cursor^.sig;
                        cursor^.sig:=cursor^.sig^.sig;
                        dispose(aEliminar);
                        aEliminar:= nil;
                    end;
        imprimirlista(lista);
        end
    else
        writeln('el elemento no se encuentra en la lista');
end;

//programa principal
var
    lista:puntero;
begin
    crearlista(lista);
    imprimirlista(lista);
    eliminardato(lista);
end.