program tres
const 
    discernible = -1;
type
    puntero = ^tiponumero;
        tiponumero = record
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
    lista:= nil;
    writeln('ingrese datos en la lista: ');
    readln(dato);
    crearnodo(lista,dato);
    cursor:=lista;
    readln(dato);
    while (dato <> discernible) do
        begin
            crearnodo(cursor^.sig,dato);
            cursor:= cursor^.sig;
            readln(dato);
        end;
    cursor^.sig:= lista;
end;

procedure imprimirlista (lista:puntero);
var
    cursor:puntero;
begin
    cursor:= lista;
    if (lista <> nil) then
        begin    
            writeln(cursor^.nro);
            while (cursor^.sig <> lista) do 
                begin
                    cursor:= cursor^.sig;
                    writeln(cursor^.nro);
                end;
        end;
end;

procedure eliminar (var lista:puntero);
var
    cursor,aEliminar:puntero;
    corte:boolean = false;
    valor:integer;
begin
    writeln('ingrese el valor que desea eliminar: ');
    readln(valor);
    cursor:= lista;
    if (cursor^.nro = valor) then
        begin
            while (cursor^.sig <> lista) do 
                begin
                    cursor:= cursor^.sig;
                    corte:= true;
                end;            
            if (corte = true) then
                begin
                    lista:= lista^.sig;
                    cursor^.sig:= lista;
                end
            else 
                lista:= nil;
        end;
    while (cursor^.sig <> lista) and (cursor^.sig^.nro <> valor) and (corte = false) do
        begin
            cursor:= cursor^.sig;
        end;
    if (cursor^.sig <> lista) and (cursor^.sig^.nro = valor) and (corte = false) then
        begin
            aEliminar:= cursor^.sig;
            cursor^.sig:= cursor^.sig^.sig;
            dispose(aEliminar);
            aEliminar:= nil;
            corte:=true;
        end;
    if (corte = false) and (cursor^.sig = lista) and (cursor^.sig^.nro = valor) then
        begin
            aEliminar:= cursor^.sig;
            cursor^.sig:= lista;
            dispose(aEliminar);
            aEliminar:= nil;
            corte:= true;
        end;
    if (corte = false) then
        writeln('El numero que desea eliminar no existe')
    else
        begin
            writeln('La lista modificada es: ');
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