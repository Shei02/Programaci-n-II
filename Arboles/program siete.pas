program siete
type
    puntero = ^tipoarbol;
        tipoarbol = record
            nro:integer;
            mayores:puntero;
            menores:puntero;
        end;
        
    puntLista = ^tlista;
        tlista = record
            nro:integer;
            sig:puntlista;
        end;    
    
procedure Crearnodo(var Nodo:puntero; dato:integer);
begin
    new(nodo);
    writeln('Ingrese datos: ');
    readln(dato);
    nodo^.nro:= dato;
    nodo^.mayores:= nil;
    nodo^.menores:= nil;
end;

procedure agregarHoja (var nodo:puntero; hoja:puntero);
begin
    if (nodo = nil) then
        nodo:= hoja
    else
        if (nodo^.nro > hoja^.nro) then
            agregarHoja(nodo^.menores, hoja)
        else
            agregarHoja(nodo^.mayores, hoja);
end;

Procedure CargarArbol(var Arbol:puntero);
var
    i,dato:integer;
    Nodo:puntero;
begin
    For i := 1 to 6 do
    begin
        CrearNodo(Nodo,dato);
        agregarHoja(Arbol,Nodo);
    end;
end;

procedure crearnodoLista (var nodo:puntlista; arbol:puntero);
begin
    new(nodo);
    nodo^.nro:= arbol^.nro;
    nodo^.sig:= nil;
end;

procedure insertarAlFinal (var lista:puntlista; aux:puntlista);
begin
    if (lista^.sig = nil) then
        lista^.sig:= aux
    else 
        insertarAlFinal(lista^.sig,aux);
end;

procedure pasarArbolALista (arbol:puntero; var lista:puntlista);
var
    cursor,aux:puntlista;
    valor:integer;
begin
    if (Arbol <> nil) then
        begin
            crearnodolista(aux,arbol);
            if (lista = nil) then
                begin    
                    new(lista);
                    lista:= aux;
                    cursor:= lista;
                end
            else 
                insertarAlFinal(lista,aux);
            pasarArbolALista(arbol^.menores,lista);
            pasarArbolALista(arbol^.mayores,lista);
        end;
end;

procedure imprimirlista(lista:puntlista);
begin
    if (lista <> nil) then 
        begin
            writeln(lista^.nro);
            imprimirlista(lista^.sig);
        end;
end;

Procedure mostrarArbol(Arbol:puntero);
begin
    If (arbol <> nil) then
    begin
        writeln(Arbol^.nro);
        mostrarArbol(Arbol^.menores);
        mostrarArbol(Arbol^.mayores);
    end;
end;

//programa principal
var
    Arbol:puntero;
    lista:puntlista;
begin
    cargarArbol(arbol);
    writeln('El arbol es: ');
    mostrarArbol(arbol);
    pasarArbolALista(arbol,lista);
    writeln('La lista es: ');
    imprimirlista(lista);
end.