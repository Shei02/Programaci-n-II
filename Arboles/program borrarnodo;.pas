program borrarnodo;
type
    puntero = ^registro;
    
    registro = record 
        valor: integer;
        menor: puntero;
        mayor: puntero;
    end;

Procedure CrearNodo(var nodo: puntero);
begin
    new(nodo);
    writeln('Meteme un valorcito: ');
    readln( nodo^.valor);
    nodo^.menor := nil;
    nodo^.mayor := nil;
end;
   
Procedure AgregarNodo(var nodo: puntero; nuevoNodo: puntero);
begin
    if(nodo = nil) then
        nodo := nuevoNodo
    else if nodo^.valor > nuevoNodo^.valor then
        AgregarNodo(nodo^.menor, nuevoNodo)
    else
        AgregarNodo(nodo^.mayor, nuevoNodo);
end;

Procedure ImprimirNodo(nodo: puntero);
begin
    if(nodo <> nil) then
    begin
        writeln(' - ', nodo^.valor);
        ImprimirNodo(nodo^.menor);
        ImprimirNodo(nodo^.mayor);
    end;
end;

Procedure CrearArbol(var arbol: puntero);
var nuevoNodo: puntero;
    i: integer;
begin   
    arbol := nil;
    for i := 1 to 8 do
    begin
        CrearNodo(nuevoNodo);
        AgregarNodo(arbol, nuevoNodo);
    end;
end;

// Encontrar el mayor de los menores (Reemplazo)
Procedure BuscarReemplazo(var nodo, reemplazo: puntero);
begin
    if(nodo^.mayor = nil) then begin
        reemplazo := nodo;
        // Vincula cuando es necesario
        // Apunta a nil automaticamente
        nodo := nodo^.menor;
    end else
        BuscarReemplazo(nodo^.mayor, reemplazo);
end;

// Arbol es el nodo a borrar
Procedure BorrarNodo(var aBorrar: puntero);
var reemplazo: puntero;
begin
    if(aBorrar^.mayor <> nil) and (aBorrar^.menor <> nil) then
    begin
        // Conseguir un nodo de reemplazo, desvinculado.
        BuscarReemplazo(aBorrar^.menor, reemplazo);
        reemplazo^.menor := aBorrar^.menor;
        reemplazo^.mayor := aBorrar^.mayor;
        
    // Si es una hoja, entra a las dos condiciones
    // Y reemplazo es = nil
    end else if (aBorrar^.menor = nil) then
        reemplazo := aBorrar^.mayor
    else
        reemplazo := aBorrar^.menor;
    
    dispose(aBorrar);
    aBorrar := reemplazo;
end;

Procedure Borrar(var arbol: puntero; numero: integer);
begin
    if (nil <> arbol) then
        if (numero = arbol^.valor) then
            BorrarNodo(arbol)
        else
            if (numero > arbol^.valor) then
                Borrar(arbol^.mayor, numero)
            else
                Borrar(arbol^.menor, numero);
end; 

var arbol: puntero;
    numero: integer;
begin
    CrearArbol(arbol);
    ImprimirNodo(arbol);
    
    writeln('Número a borrar: ');
    readln(numero);
    Borrar(arbol, numero);
    
    ImprimirNodo(arbol);
end.