program ejercicioCuatro;
type
    tipoNodo = ^Tnodo;
    tipoInvert = ^TInvert;
    Tnodo = record
        ApellidoYNombre : string[33]; 
        Curso : integer; 
        DNI : Longint;
        Domicilio : String;
        Telefono : Longint;
        sig : tipoNodo;
    end;
    TInvert = record
        sig:tipoInvert;
        Alumno:tipoNodo;
    end;
    
procedure imprimirLista(lista:TipoNodo);
begin
    while (lista <> nil) do
    begin
        writeln('Apellido y Nombre:');
        writeln(lista^.ApellidoYNombre);
        writeln('Curso:');
        writeln(lista^.Curso);
        {writeln('Numero de documento:');
        readln(lista^.DNI);
        writeln('Domicilio:');
        readln(lista^.Domicilio);
        writeln('Numero de telefono:');
        readln(lista^.telefono);}
        lista := lista^.sig;
    end;
end;

procedure crearNodo(var nodo:TipoNodo);
begin
    new(nodo);
    writeln('Inserte un Apellido y Nombre:');
    readln(nodo^.ApellidoYNombre);
    writeln('Indique un curso:');
    readln(nodo^.curso);
    {writeln('Numero de documento:');
    readln(nodo^.DNI);
    writeln('Ingrese el domicilio:');
    readln(nodo^.domicilio);
    writeln('Numero de telefono:');
    readln(nodo^.telefono);}
    nodo^.sig := nil;
end;


procedure crearLista(var Lista:TipoNodo);
var
    discernible : integer;
    cursor : TipoNodo;
begin
    discernible:=1;
    crearNodo(Lista);
    cursor := Lista;
    writeln('------------------------------------------------');
    while (discernible <> -1) do
    begin
        crearNodo(cursor^.sig);
        cursor := cursor^.sig;
        writeln('inserte un valor, con -1 no ingresa');
        readln(discernible);
    end;
end;

procedure InsertarOrdenadoListaInvertida(var Alpha:tipoInvert; lista:tipoNodo);
var
    cursor,nodoNuevo,Ant:tipoInvert;
    Andar:boolean;
begin
    Andar:=false;
    if (alpha = nil) then //Primera casilla apunta a nil;
    begin
        new(Alpha);
        Alpha^.alumno:=Lista;
        Alpha^.sig:=Nil;
    end
    else // si ya alpha apunta a algo lo que quiero es://
    begin
        cursor:=Alpha;
        while (cursor<>nil) do
        begin
            if (andar=false) and (Lista^.ApellidoYNombre >= Cursor^.alumno^.ApellidoYNombre) then
                begin
                    new(nodoNuevo);
                    nodoNuevo^.alumno:=Lista;
                    nodonuevo^.sig:=cursor^.sig;
                    cursor^.sig:=nodoNuevo;
                    andar:=true;
                end;
            if (andar=false) and (Lista^.ApellidoYNombre < Cursor^.alumno^.ApellidoYNombre) then
            begin
                new(nodoNuevo);
                nodoNuevo^.alumno:=lista;
                andar:=true;
                if (cursor = alpha) then
                begin
                    Alpha:=nodoNuevo;
                    nodoNuevo^.sig:=cursor;
                end
                else
                begin
                    Ant^.sig:=nodoNuevo;
                    nodoNuevo^.sig:=cursor;
                end;
            end;
            Ant:=cursor;
            cursor:=cursor^.sig;
        end;
    end;
end;
    

procedure crearListaInvertida(var Alpha:tipoInvert; lista:tipoNodo); //Conectar puntero con la Lista//
begin
    if (lista = nil) then
        writeln('sali de aca sofia');
    while (lista<> nil) do
    begin
        InsertarOrdenadoListaInvertida(Alpha,Lista);
        writeln('Entrando jijiji');
        
        lista:=lista^.sig;
    end;
    writeln('Saliendo jjiijij');
end;
    
procedure ImprimirListaInvertida(alpha:tipoInvert);
begin
    while (alpha<>nil) do
    begin
        writeln('Apellido y nombre:');
        writeln(Alpha^.alumno^.ApellidoYNombre);
        alpha:=alpha^.sig;
    end;
end;

procedure insertarOrdenado(beta:tiponodo;var lista:tiponodo);
var
    cursor,anterior:tiponodo;
    rango:boolean;
begin
    writeln('puto');
    rango:=false;
    if (lista=nil) then//primer caso
        lista:= beta;     //inserto beta, por eso va 1ro lista
    cursor:=lista;
    anterior:=lista;
    while (cursor <> nil) and (rango=false)do
    begin
        writeln('puto2');
        if (beta^.apellidoynombre < cursor^.apellidoynombre)  then  //medio, agregar a izq
        begin
            beta^.sig:=cursor;
            anterior^.sig:=beta;
            rango:=true;
            writeln('puto4');
        end;
        if (beta^.apellidoynombre > cursor^.apellidoynombre) then //segundo caso// aregar a derec
        begin
            if cursor^.sig <> nil then
                beta:=cursor^.sig;
            cursor^.sig:=beta;
            rango:=true;
            writeln('puto3');
        end;
        anterior:=cursor;
        cursor:=cursor^.sig;
    end;
end;

{procedure DarDeAlta(var Alpha:TipoInvert; var lista:tipoNodo ; Beta:tiponodo);
begin
    insertarOrdenado(beta,lista);
end;}

//programa principal//
var
    LaLista,Beta:tipoNodo;
    Alpha:tipoInvert;
begin
    crearLista(LaLista);
    imprimirLista(LaLista);
    writeln('\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\');
    //crearListaInvertida(Alpha,LaLista);
    //imprimirListaInvertida(Alpha);
    CrearNodo(Beta);
    //DarDeAlta(Alpha,LaLista,Beta);
    insertarOrdenado(beta,lalista);
    imprimirLista(Lalista);
end.