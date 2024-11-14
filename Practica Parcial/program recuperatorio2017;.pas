program recuperatorio2017;

//----------------------------------------------------------------DECLARACION DE TIPOS Y CONSTANTES----------------------------------------------------------------------------------//

type 
    
    PuntArbol=^NodoArbol;
    
    NodoArbol= record
        nro_patente,anio:Integer;
        Menores,Mayores:PuntArbol;
    end;

    PuntLista=^NodoLista;
    
    NodoLista= record
        CantPatentes,Anio:Integer;
        Ant,Sig:PuntLista;
    end;
    
//-------------------------------------------------------------------CARGA DE DATOS-----------------------------------------------------------------------------------------------//

procedure AltaDeNodo(var Arbol:PuntArbol; Nodo:PuntArbol);
//Este procedimiento da de alta un nodo en un arbol y en una lista
begin
    If (Arbol=Nil) then
        Arbol:=Nodo
    Else if (Arbol^.nro_patente<=Nodo^.nro_patente) then
        AltaDeNodo(Arbol^.Mayores, Nodo)
    Else if (Arbol^.nro_patente>Nodo^.nro_patente) then
        AltaDeNodo(Arbol^.Menores, Nodo);
end;

procedure CrearNodo(var Nodo:PuntArbol);
//Este procedimiento genera un nodo 
begin
    New(Nodo);
    Nodo^.Mayores:=Nil;
    Nodo^.Menores:=Nil;
    WriteLn('Ingrese año de patente');
    ReadLn(Nodo^.anio);
    WriteLn('Ingrese numero de patente');
    ReadLn(Nodo^.nro_patente);
end;

procedure CrearArbol(var Arbol:PuntArbol);
//Este procedimiento crea el arbol de patentes
var Cantidad,i:Integer;
    Nodo:PuntArbol;
begin
    WriteLn('Ingrese cantidad de patentes que desea cargar');
    ReadLn(Cantidad);
    for i:=1 to Cantidad do
     begin
        CrearNodo(Nodo);
        AltaDeNodo(Arbol,Nodo);
     end;
end;

//------------------------------------------------------------------IMPRESION DE DATOS----------------------------------------------------------------------------------------//

procedure ImprimirInOrderAsc(Arbol:PuntArbol);
begin
    If (Arbol<>Nil) then
     begin
      ImprimirInOrderAsc(Arbol^.Menores); 
      WriteLn('|N° de patente: ',Arbol^.nro_patente,'|Año: ',Arbol^.anio,'|');
      ImprimirInOrderAsc(Arbol^.Mayores);
     end;
end;

procedure ImprimirArbolAsc(Arbol:PuntArbol);
begin
    WriteLn('Los datos del arbol son: ');
    WriteLn;
    ImprimirInOrderAsc(Arbol);
    WriteLn('_____________________');
end;

procedure ImprimirListaDoble (Lista:PuntLista);
    {Imprime la lista doblemente vinculada}
begin
    writeln(' ');
    writeln('-------LISTA DE PATENTES POR AÑOS----------');
    writeln(' ');
    while (Lista<>Nil) do begin
        writeln('-- -- -- -- -- -- -- --');
        writeln('|Año: ',Lista^.Anio,'|Cantidad de patentes: ',Lista^ .CantPatentes,'|');
        writeln(' ');
        Lista:=Lista^.Sig;
    end;
end;
//--------------------------------------------------------------------FUNCIONES-----------------------------------------------------------------------------------//

function BuscaAnio (Lista:PuntLista;Anio:integer):PuntLista;
    {Busca el año en la lista y devuelve un puntero apuntando al mismo,
    si no está devuelve nil}
begin
    if (Lista<>nil) and (Lista^.Anio <= Anio) then
        if (Lista^.Anio = Anio) then
            BuscaAnio:=Lista
        else
            BuscaAnio:=BuscaAnio(Lista^.Sig,Anio)
    else
        BuscaAnio:=Nil;
end;
//--------------------------------------------------------------------------------------------------------------------------------------------------------//

procedure SolicitarRango (var PatMin,PatMax,ProfMax:integer);
    {Solicita el rango para recorrer el árbol}
begin
    writeln(' ');
    writeln('DEFINICIÓN DEL RANGO');
    writeln(' ');
    write('Ingrese la patente mínima: ');
    readln(PatMin);
    write('Ingrese la patente máxima: ');
    readln(PatMax);
    write('Ingrese la profundidad máxima: ');
    readln(ProfMax);
    writeln(' ');
end;

function NuevoNodo (NodoArbol:PuntArbol):PuntLista;
    {Crea un nodo para la lista doble con los datos del nodo del árbol}
var Nuevo:PuntLista;
begin
    New(Nuevo);
    Nuevo^.Sig:=Nil;
    Nuevo^.Ant:=Nil;
    Nuevo^.Anio:=NodoArbol^.Anio;
    Nuevo^.CantPatentes:=1;
    NuevoNodo:=Nuevo;
end; 
//--------------------------------------------------------------CREACION DE LISTA--------------------------------------------------------------------------//

procedure ExtraerNodo (var Lista:PuntLista;Extraer:PuntLista);
    {Extrae el nodo de la lista doble}
begin
    if (Lista=Extraer) then begin
        Lista:=Lista^.Sig;
        Lista^.Ant:=Nil;    //Puedo hacerlo ya que controlé antes que Sig<>Nil
    end
    else begin
        Extraer^.Ant^.Sig:=Extraer^.Sig; //Como no es el primero sé que tiene un nodo anterior
        if (Extraer^.Sig <>NIl) then
            Extraer^.Sig^.Ant:=Extraer^.Ant;
    end;
    Extraer^.Sig:=Nil;
    Extraer^.Ant:=Nil;
end;

procedure CrearNodoListaDoble(var Nodo:PuntLista; Anio,CantPatentes:Integer);
begin
    New(Nodo);
    Nodo^.Sig:=Nil;
    Nodo^.Ant:=Nil;
    Nodo^.Anio:=Anio;
    Nodo^.CantPatentes:=CantPatentes;
end;

procedure InsertarOrdenadoEnListaDoble (var Lista:PuntLista ;Nuevo:PuntLista);
    {Inserta el nodo siguiendo un orden ascendente por cantidad de patentes}
var Cursor:PuntLista;
begin
    if (Lista=Nil) or (Nuevo^.CantPatentes < Lista^.CantPatentes) then begin
        Nuevo^.Sig:=Lista;
        if (Lista<>NIl) then
            Lista^.Ant:=Nuevo;
        Lista:=Nuevo;
    end
    else begin
        Cursor:=Lista;
        while (Cursor^.Sig<>Nil) and (Cursor^.Sig^.CantPatentes < Nuevo^.CantPatentes) do
            Cursor:=Cursor^.Sig;
        Nuevo^.Sig:=Cursor^.Sig;
        Nuevo^.Ant:=Cursor;
        if (Cursor^.Sig<>Nil) then
            Cursor^.Sig^.Ant:=Nuevo;
        Cursor^.Sig:=Nuevo;
    end;
end;
procedure GenerarListaDoble (Arbol:PuntArbol;var Lista:PuntLista; PatMin,PatMax,ProfMax,ProfActual:integer);
    {Recorre el árbol en el rango definido y genera la lista a partir del mismo}
var AnioEnLista:PuntLista;
begin
    if (Arbol<>NIl) then begin
        if (ProfActual <= ProfMax) then begin
            if (Arbol^.nro_patente >= PatMin) then begin
                GenerarListaDoble(Arbol^.Menores,Lista,PatMin,PatMax,ProfMax,ProfActual+1);
                if (Arbol^.nro_patente <= PatMax) then begin
                    AnioEnLista:=BuscaAnio(Lista,Arbol^.Anio);
                    if (AnioEnLista = Nil)then    //Si no existe el año en la lista lo creo
                        AnioEnLista:=NuevoNodo(Arbol)
                    else begin
                        AnioEnLista^.CantPatentes:=AnioEnLista^.CantPatentes+1; //Si existe sumo 1 a la cantidad
                        if (AnioEnLista^.Sig<>Nil) and (AnioEnLista^.CantPatentes > AnioEnLista^.Sig^.CantPatentes) then //Si no es el último y si alteró el orden lo debo extraer
                            ExtraerNodo(Lista,AnioEnLista)
                        else
                            AnioEnLista:=Nil;   //Si es el último o si no alteró el orden no lo debo extraer
                    end;
                    if (AnioEnLista <> Nil) then    //Si el nodo con el año está fuera de la lista lo agrego en su pos correspondiente
                        InsertarOrdenadoEnListaDoble(Lista,AnioEnLista);
                    GenerarListaDoble(Arbol^.Mayores,Lista,PatMin,PatMax,ProfMax,ProfActual+1);
                end;
            end
            else if (Arbol^.nro_patente <= PatMax) then
                GenerarListaDoble(ARbol^.Mayores,Lista,PatMin,PatMax,ProfMax,ProfActual+1);
        end;
    end;
end;





//-------------------------------------------------------------------PROGRAMA PRINCIPAL-----------------------------------------------------------------------------------------//

var Patentes:PuntArbol;
    ListaPatentes:PuntLista;
    PatMin, PatMax, ProfMax:Integer;
begin   
    CrearArbol(Patentes);
    ImprimirArbolAsc(Patentes);
    SolicitarRango(PatMin,PatMax, ProfMax);
    GenerarListaDoble(Patentes, ListaPatentes, PatMin, PatMax, ProfMax, 0);
    ImprimirListaDoble(ListaPatentes);
end.