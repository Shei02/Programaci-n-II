program listaseleccion6
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

procedure ordenarseleccion (var lista:puntero);
var
    cursor,cursor2,menor,anteriormenor,siguiente,siguien2:puntero;
begin
    cursor:= lista;
    menor:= lista;
    cursor2:= cursor;
    siguiente:=cursor^.sig;
    while (cursor2^.sig <> nil) do 
        begin
            //encuentro menor
            if (cursor2^.sig^.nro < menor^.nro) then
                begin
                    menor:= cursor2^.sig;
                    anteriormenor:= cursor2;
                end;
            cursor2:=cursor2^.sig;
        end;
    //caso 1
    //parte 1
    if (lista = anteriormenor) then
        begin
            writeln('caso 1, parte 1: ');
            lista:=menor;
            cursor^.sig:= menor^.sig;
            menor^.sig:= cursor; 
            imprimirlista(lista);
        end
    else
        //parte 2
        if (lista <> menor) then
            begin
                writeln('caso 1, parte 2: ');
                lista:= menor;
                cursor^.sig:= menor^.sig;
                anteriormenor^.sig:= cursor;
                menor^.sig:= siguiente;
                imprimirlista(lista);
            end;
    //caso 2
    cursor:=lista;
    while (cursor^.sig <> nil) do
        begin
            siguiente:=cursor^.sig;
            cursor2:= cursor^.sig;
            menor:= cursor^.sig;
            while (cursor2^.sig <> nil) do 
                begin
                    if (cursor2^.sig^.nro < menor^.nro) then
                        begin        
                            menor:=cursor2^.sig;
                            anteriormenor:= cursor2;
                        end;
                    cursor2:= cursor2^.sig;
                end;
            if (cursor^.sig <> menor) then
                begin
                    //parte 1
                    if (siguiente = anteriormenor) then
                        begin
                            writeln('caso 2, parte 1: ');
                            cursor^.sig:= menor;
                            anteriormenor^.sig:= menor^.sig;
                            menor^.sig:= anteriormenor;
                            imprimirlista(lista);
                        end
                    //parte 2
                    else
                        begin
                            writeln('caso 2, parte 2: ');
                            siguien2:= siguiente^.sig;
                            cursor^.sig:=menor;
                            anteriormenor^.sig:= siguiente;
                            siguiente^.sig:= menor^.sig;
                            menor^.sig:= siguien2; 
                            imprimirlista(lista);
                        end;
                end;
            cursor:= cursor^.sig;
        end;
end;

//programa principal
var
    lista:puntero;
begin
    crearlista(lista);
    Writeln('la lista es: ');
    imprimirlista(lista);
    ordenarseleccion(lista);
end.