program nueve
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
    nodo^.nro:= dato;
    nodo^.sig:= nil;
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

function mitad (lista:puntero):puntero;
var
    aux1,aux2:puntero;
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

procedure ordenarmitades (var lista:puntero; var ladoIzq:puntero; var ladoDer:puntero);
var
    cursorL,cursorLI,cursorLD:puntero;
begin
    cursorL:= lista;
    cursorLI:= ladoIzq;
    cursorLD:= ladoDer;
    while (cursorLI <> nil) and (cursorLD <> nil) do 
        begin
            if (cursorLI^.nro < cursorLD^.nro) then
                begin    
                    if (cursorL = nil) then
                        begin
                            lista:= cursorLI;
                            cursorLI:= cursorLI^.sig;
                            cursorL:= lista;
                        end
                    else
                        begin
                            cursorL^.sig:= cursorLI;
                            cursorL:= cursorL^.sig;
                            cursorLI:= cursorLI^.sig;
                        end;
                end
            else
                begin    
                    if (cursorL = nil) then
                        begin
                            lista:= cursorLD;
                            cursorLD:= cursorLD^.sig;
                            cursorL:= lista;
                        end
                    else
                        begin
                            cursorL^.sig:= cursorLD;
                            cursorL:= cursorL^.sig;
                            cursorLD:= cursorLD^.sig;
                        end;
                end;
        end;
    while (cursorLI <> nil) do 
        begin
            cursorL^.sig:= cursorLI;
            cursorL:= cursorL^.sig;
            cursorLI:= cursorLI^.sig;
        end;
    while (cursorLD <> nil) do 
        begin
            cursorL^.sig:= cursorLD;
            cursorL:= cursorL^.sig;
            cursorLD:= cursorLD^.sig;
        end;
end;

procedure cortarlista (var lista:puntero; var ladoIzq:puntero; var ladoDer:puntero);
var
    mitadd:puntero;
begin
    mitadd:= mitad(lista);
    ladoDer:= mitadd^.sig;
    mitadd^.sig:= nil;
    ladoIzq:= lista;
    lista:= nil;
end;

procedure mergeSort (var lista:puntero);
var
    ladoIzq,ladoDer:puntero;
begin
    if (lista^.sig <> nil) then
        begin
            cortarlista(lista,ladoIzq,ladoDer);
            mergeSort(ladoIzq);
            mergeSort(ladoDer);
            ordenarmitades(lista,ladoIzq,ladoDer);
        end;
end;

//programa principal
var
    lista:puntero;
begin
    crearlista(lista);
    writeln('La lista es: ');
    imprimirlista(lista);
    mergeSort(lista);
    writeln('Lista ordenada por mergeSort: ');
    imprimirlista(lista);
end.