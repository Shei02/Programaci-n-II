//////////////ARBOLES//////////////
////TYPES////
Type                                                                                
    //ARBOL///
    PuntArbol = ^TArbol;
    TArbol = record
        valor: integer;
        menor, mayor: PuntArbol;
    end;
        
    //LISTA//
    PuntLista = ^TLista;
    TLista = record
        valor: integer;
        Sig: PuntLista;
    end;
    //ARCHIVO//
    TArchivo = file of integer;


/////////CARGA///////                                                   EL ARBOL SIEMPRE:=NIL;
Procedure CrearNodo(var Nodo:TipoArbol);
begin
    New(Nodo);
    writeln('inserte valor al nodo:');
    readln(Nodo^.valor);
    Nodo^.mayor := nil;
    Nodo^.menor := nil;
end;

Procedure InsertarEnArbol(var Arbol:TipoArbol; Nodo:TipoArbol);
begin
    if (Arbol = Nil) then
        Arbol := Nodo
    else
    begin
        if (Nodo^.valor < Arbol^.valor) then
            InsertarEnArbol(Arbol^.menor,Nodo)
        else
            InsertarEnArbol(Arbol^.mayor,Nodo);
    end;
end;

Procedure CargarArbol(var Arbol:TipoArbol);
var
    i:integer;
    Nodo:TipoArbol;
begin
    i:= 0;              //PARA ENTRAR EN EL BUCLE
    while (i <> -1) do
    begin
        CrearNodo(Nodo);
        InsertarEnArbol(Arbol,Nodo);
        writeln('ingrese un valor distinto a -1 para seguir agregando nodos');    
        readln(i);
    end;
end;    

//////LONGITUD/////////
function longitud(nodo: TipoArbol): integer;
var longMayores, longMenores, raiz: integer;
begin
    if(nodo <> nil) then begin
        longMayores := longitud(nodo^.mayor);
        longMenores := longitud(nodo^.menor);
        raiz:= 1;
        
        longitud:= longMayores + longMenores + raiz;
    end else
        longitud := 0;
end; 

////////IMPRMIR/////////
procedure ImprimirArbolAscendente(arbol:PuntArbol);  
begin
    if (arbol <> nil) then
    begin
        ImprimirArbolAscendente(arbol^.menor);
        writeln('nro_facturas: ',arbol^.nro_factura);
        writeln('facturas_impagas: ',arbol^.facturas_impagas);
        writeln('------------------------------');
        ImprimirArbolAscendente(arbol^.mayor);
    end;
end;

//Imprime padre, luego mayores y por ultimo menores
procedure imprimirDescendente (arbol:PuntArbol);
begin
    if (arbol <> nil) then 
    begin
        writeln (arbol^.valor);
        imprimirAscendente(arbol^.mayores);
        imprimirAscendente(arbol^.menores);
    end;
end;

procedure imprimirPostOrder (arbol:PuntArbol);
//no se imprime un padre si no se han impreso todos sus hijos
begin
    if (arbol <> nil) then 
    begin
        imprimirAscendente(arbol^.mayores);
        imprimirAscendente(arbol^.menores);
        writeln (arbol^.valor); //padre 
    end;
end;

procedure imprimirPreOrder (arbol:PuntArbol);
//no se imprime un nodo si no se ha impreso su padre
begin
    if (arbol <> nil) then 
    begin
        writeln (arbol^.valor);
        imprimirAscendente(arbol^.menores);
        imprimirAscendente(arbol^.mayores);
    end;
end;

/////FUNCIONES////
function SumaArbol (nodo: PuntArbol): integer; //suma todos los valores de cada nodo
begin
    if (nodo <> nil) then 
        SumaArbol:= nodo^.'VALOR QUE TENGA EL TYPE' + SumaArbol (nodo^.menor) + SumaArbol (nodo^.mayor) //sumas mientras sea dist a nil
    else
        SumaArbol:= 0; //si es nil, suma 0
end;