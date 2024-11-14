Program lista2
const
    inicio = 1;
    fin = 4;
type
    puntero = ^nodo;
    nodo = record
        nro:integer;
        sig:puntero;
    end;
    
    tarreglo = array [inicio..fin] of integer;
    
procedure cargaarreglo (var arreglo:tarreglo);
var
    i:integer;
begin   
    for i:= inicio to fin do
        arreglo[I]:= random(100)+1;
end;

procedure crearnodo(var nodo:puntero; elem:integer);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.nro:= elem;
end;

procedure cargalista (var lista:puntero; arreglo:tarreglo);
var
    cursor:puntero;
    i:integer;
begin
    crearnodo(lista,arreglo[inicio]);
    cursor:= lista;
    for i:= inicio+1 to fin do
        begin
            crearnodo(cursor^.sig,arreglo[i]);
            cursor:= cursor^.sig;
        end;
end;

function sumatoria (lista:puntero):integer;
var
    i,suma:integer;
    cursor:puntero;
begin
    cursor:=lista;
    suma:=0;
    while (cursor <> nil) do 
        begin
            suma += cursor^.nro;
            cursor:= cursor^.sig;
        end;
    sumatoria:= suma;
end;

function cantelem (lista:puntero):integer;
var
    contador:integer;
    cursor:puntero;
begin
    contador:=0;
    cursor:= lista;
    while (cursor <> nil) do 
        begin
            cursor:= cursor^.sig;
            contador += 1;
        end;
    cantelem:= contador;
end;

function promedio (lista:puntero):real;
begin
    promedio:= sumatoria(lista) div cantelem(lista);
end;

function maximo (lista:puntero):integer;
var
    elem1,elem2:integer;
    cursor:puntero;
begin
    cursor:= lista;
    elem1:= cursor^.nro;
    While (cursor <> nil) do 
        begin
            elem2:= cursor^.nro;
            cursor:= cursor^.sig;
            if (elem2 > elem1) then 
                elem1:= elem2;
        end;
    maximo:=elem1;
end;

{procedure mostrararr (arreglo:tarreglo);
var
    i:integer;
begin
    for i:= inicio to fin do
        Begin
            writeln('Pos: ', I);
            writeln(arreglo[i]);
        end;
end;}

procedure mostrarlista (lista:puntero);
var
    cursor:puntero;
begin
    cursor:=lista;
    writeln('la lista es: ');
    while (cursor <> nil) do
        begin
            writeln(cursor^.nro);
            cursor:= cursor^.sig;
        end;
end;

var
    lista:puntero;
    arreglo:tarreglo;
begin
    randomize;
    cargaarreglo(arreglo);
    //mostrararr(arreglo);
    cargalista(lista,arreglo);
    mostrarlista(lista);
    Writeln('La sumatoria es: ', sumatoria(lista));
    writeln('La cantidad de elementos es: ', cantelem(lista));
    writeln('El promedio es: ', promedio(lista):0:2);
    Writeln('El elemento mayor es: ', maximo(lista));
end.