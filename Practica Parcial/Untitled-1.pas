//modulos//
function anterior(lista: puntero; valor: integer): puntero;
begin
    // No hay lista O el elemento buscado es la lista 
    if (lista = nil) or (lista^.valor = valor) then
        anterior := lista
    // Existe el siguiente
    else if (lista^.siguiente <> nil) then begin
        // No es el que buscamos
        if (lista^.siguiente^.valor <> valor) then
            anterior := anterior(lista^.siguiente, valor)
        // Es el que buscamos
        else
            anterior := lista;
    // Llegamos al final de la lista
    end else
        anterior := nil;
end;

//////////////////////////////////////////////////////////////
Procedure InsertarOrdenadoListaCircular(var ListaCirc:Parbol; Nodo,InicioEnList:Parbol);
begin
    If (ListaCirc = Nil) then
        ListaCirc := Nodo;
    else
        If (Nodo^.dni >= ListaCirc^.dni) then
            Nodo^.sig := ListaCirc;
            ListaCirc := Nodo;
        else
            if(listaCirc^.sig = inicioLista)then 
            begin
                Nodo^.sig:=listaCirc^.sig;
                listaCirc^.sig:=Nodo;
            end
            else
                InsertarOrdenadoListaCircular(ListaCirc^.sig,Nodo,InicioEnList);
end;

/////////////////////////////////////////////////////////////////
procedure Desvincular(var lista, nodo: puntero);
begin
    // Si la lista <> nil
    if(lista = nodo) then begin
        lista := lista^.sig;
        // Hay un solo nodo en la lista
        if(lista <> nil) then
            lista^.anterior := nil;
    end else if (nodo^.siguiente = nil) then
        // El nodo esta al final
        nodo^.anterior^.siguiente := nil
    else begin
        // El nodo esta al medio
        nodo^.anterior^.siguiente := nodo^.siguiente;
        nodo^.siguiente^.anterior := nodo^.anterior;
    end;
    
    nodo^.siguiente := nil;
    nodo^.anterior := nil;
end;

////////////////////////////////////////////////////////////////////////////
Procedure InsertarOrdDoblementeVinculada(var Lista:Plista; Nodo:Plista);
begin
    if (Lista = Nil) then
        Lista := Nodo
    else
        if (Nodo^.valor <= Lista^.valor) then
        begin
            Nodo^.sig := lista;
            Nodo^.ant := Lista^.ant;
            Lista^.ant := nodo;
            Lista := Nodo;
        end
        else
        InsertarOrdDoblementeVinculada(Lista^.sig,Nodo);
end;

///////////////////////////////////////////////////////////////////
//busca anterior en lista simple o doble
function BuscaAnterior(lista: p_nodo; valor: integer): p_nodo;
begin
    if (lista = nil) or (lista^.valor = valor) then
            BuscaAnterior := lista
    else if (lista^.siguiente <> nil) then begin
        if (lista^.siguiente^.valor <> valor) then
            BuscaAnterior := BuscaAnterior(lista^.siguiente, valor)
        else
            BuscaAnterior := lista;
    end else
        BuscaAnterior := nil;
end;

////////////////////////////////////////////////////////
//imprimir lista circular con recursion, cursor comienza con lista
Procedure ImprimirListaEnOrden(lista, cursor: puntero);
begin
    if(lista <> nil) then begin
        writeln(cursor^.valor);
        if cursor^.sig <> lista then
            ImprimirListaEnOrden(lista, cursor^.sig);
    end else
        writeln('La lista circular está vacía...');
end;

/////////////////////////////////////////////////////////
function menorEnArbol(arbol: puntero): integer;
begin
    if(arbol <> nil) then begin
        if(arbol^.menor <> nil) then
            menorEnArbol := menorEnArbol(arbol^.menor)
        else
            menorEnArbol := arbol^.valor;
    end else
        menorEnArbol := 0;
end;

//////////////////////////////////////////////////////
Procedure MenorArbol(Arbol:Parbol; var Menor:integer)
if (Arbol <> Nil) then
begin
    If (Arbol^.valor > Menor) then
        MenorArbol(Arbol^.Menor; Menor)
    else
        begin
            Menor := Arbol^.valor;
            MenorArbol(Arbol^.menores; Menor:integer);
        end;
end;

/////////////////////////////////////////////////////////////
Procedure ImprimirListaEnOrden(cursor: p_nodo);
begin
    if cursor <> nil then begin
        writeln(cursor^.valor);
        ImprimirListaEnOrden(cursor^.sig);
    end;
end;

//////////////////////////////////////////////////////////////
Procedure ImprimirListaAlReves(cursor: p_nodo);
begin
    if cursor <> nil then begin
        ImprimirListaAlReves(cursor^.sig);
        writeln(cursor^.valor);
    end;
end;

////////////////////////////////////////////////////////
//cargar lista circular recursivo
Procedure CrearListaCircular(var lista: puntero);
var input: integer;
    nuevoNodo: puntero;
begin
    writeln('Meteme un valorcito');
    readln(input);
    
    if(input <> -1) then begin
        CrearNodo(nuevoNodo, input);
        AgregarAlFinal(lista, lista, nuevoNodo);
        
        CrearListaCircular(lista);
    end else
        writeln('Fin de la carga');
end;

/////////////////////////////////////////////////
//agregar a lista circular
Procedure AgregarAlFinal(var lista: puntero; cursor, nodo: puntero);
begin
    if(lista = nil) then begin
        lista := nodo;
        nodo^.sig := lista;
    end else if(cursor^.sig = lista) then begin
        // Llegar al inicio de nuevo
        cursor^.sig := nodo;
        nodo^.sig := lista;
    end else
        AgregarAlFinal(lista, cursor^.sig, nodo);
end;

/////////////////////////////////////////////////////////
procedure AbrirArchivo(var Archivo: TArchivo);
begin
    {$I-} { desactiva la verificación de errores de entrada/salida}
    reset(Archivo);
    {$I+} { activa la verificación de errores entrada/salida }
    if ioresult <> 0 then 
        Rewrite(Archivo); 
end;

//procedure pasarALista(lista:tLista; arbol:tArbol; 
procedure BuscarRango(arbol:tArbol;Cotamin,cotaMax:integer; nivel:integer);
begin
	if (arbol <> nil) then begin
    	if (arbol^.nropatente => cotamin) and (arbol^.nropatente <= cotamax) then begin
            pasarALista(lista, arbol, nivel);
          	end
            else if (arbol^.nropatente < cotamin) then
            	buscarRango(arbol^.mayores,cotamin,cotamax,nivel+1)
            else if(arbol^.nropatente > cotamax) then
            	buscarRango(arbol^.menor,cotamin,cotamax,nivel+1);
    end;
end;