Program parcialprog22021;
type
    Tarbol = ^puntarbol;
        puntarbol = record
            nro_articulo:integer;
            anio_fabricacion:[1970..2025];
            menores:puntarbol;
            mayores:puntarbol;
        end;
    
    tlista = ^puntlista;
        puntlista = record
            anio_fabricacion:[1970..2025];
            cantArticulo:integer;
            sig:puntlista;
            ant:puntlista;
        end;
        
//////modulos///////
//el arbol se considera cargado
//procedure crearnodoarbol(var nodo:tarbol; dato:puntarbol);
//procedure agregarnodo (var nodo:tarbol; nuevonodo:tarbol);
//procedure cargaarbol (var arbol:tarbol);

procedure craernodolista(var lista:tlista; dato:puntlista);  //SE CREA EL PRIMER NODO DE LA LISTAVINCULADA
begin
    new(lista);
    lista^.anio_fabricacion:= dato.anio_fabricacion;
    lista^.cantArticulo:= dato.cantArticulo;
    lista^.sig:= nil;
    lista^.ant:= nil;
end;

procedure insertarOrdlistadoblementevinculada (var lista:tlista; nuevonodo:tlista);  //SE INSERTA ORDENADO EN LA LISTA POR CANTIDAD DE ARTICULO
begin
    if (lista = nil) then
        lista:= nuevonodo
    else
        if (nuevonodo^.anio_fabricacion = lista^.anio_fabricacion) then
            begin
                if (nuevonodo^.cantArticulo <= lista^.cantArticulo) then
                    begin
                        nuevonodo^.sig:= lista;
                        nuevonodo^.ant:= lista^.ant;
                        lista^.ant:= nuevonodo;
                        lista:= nuevonodo;
                    end
                else
                    insertarOrdlistadoblementeVinculada(lista^.sig,nuevonodo);
            end;
end;

procedure disvincularLista (var lista:tlista; desvinculador:tlista);
begin
    if (desvinculador^.sig = nil) and (desvinculador^.ant = nil) then
        begin
            lista = nil;
            desvinculador^.sig:= nil;
            desvinculador^.ant:= nil;
        end
    else
        if (desvinculador^.sig <> nil) and (desvinculador^.ant <> nil) then
            begin
                desvinculador^.ant^.sig:= desvinculador^.sig;
                desvinculador^.sig^.ant:= desvinculador^.ant;
            end
        else
            if (desvinculador^.sig <> nil) then
                lista:= disvinculador^.sig
            else
                if (desvinculador^.ant <> nil) then
                    desvinculador^.ant^.sig:= desvinculador^.sig;
    desvinculador^.sig:= nil;
    desvinculador^.ant:= nil;
end;

function buscaAnio (lista:tlista; anio:integer):tlista //se fija si el anio ya esta con articulos en la lista para luego poder modificarla
begin
    if (lista <> nil) then
        if (lista^.anio_fabricacion = anio) then
            buscaAnio := lista
        else
            buscaAnio:= buscaAnio (lista^.sig,anio)
    else
        buscaAnio:= nil;
end;

procedure actualizar (var desvinculador:tlista);
//actualizo la cantidad de articulos de un mismo anio en la lista
begin
    desvinculador^.cantArticulo:= desvinculador^.cantArticulo+1;
end;

procedure pasarALista (var lista:tlista; anio:integer);
var
    aux:tlista;
begin
    aux:= buscaanio(lista, anio);
    if(aux <> nil) then
        begin
            desvincularLista(lista,Aux);
            actualizar(aux);
            insertarOrdlistadoblementevinculada(lista,aux);
        end
    else
        begin
            crearnodolista(lista,anio);        
            insertarOrdlistadoblementeVinculada(lista, anio);
        end;
end;

procedure actualizarLista (var lista:tlista; arbol:tarbol; art_min,art_max:integer; prof_maxima, profundidad:integer);
begin
    if (arbol <> nil) then
        begin
            if (profundidad <= prof_maxima) then
                begin
                    if (arbol^.nro_Articulo => art_min) and (arbol^.nro_Articulo <= art_max) then  //pregunto si esta entre las cotas para pasar a la lista
                        begin
                            pasarALista(lista,arbol,prof_maxima);
                        end
                    else
                        if (arbol^.nro_articulo < art_min) then
                            buscarRango(arbol,art_min,art_max,prof_maxima+1)
                        else
                            if (arbol^.nro_articulo > art_max) then
                                buscarRango(arbol,art_min,art_max,prof_maxima+1);
        end;
end;

procedure imprimirlistadoblementevinculada(lista:tlista);
begin
    if (lista <> nil) then
        begin
            writeln('El año de fabricacion es: ');
            writeln(lista^.anio_fabricacion);
            writeln('Cantidad de articulos: ');
            writeln(lista^.cantArticulo);
            if (lista^.sig <> nil) then
                imprimirlistadoblementevinculada(lista);
        end
    else
        writeln('la lista esta vacia.');
end;

//programa principal
var
    lista:tlista;
    arbol:tarbol;
    min,max,nivel,profundidad:integer;
begin
    //cargaArbol(arbol); se considera ya cargado
    //imprimirarbol(arbol);
    writeln('ingrese una cota minima: ');
    readln(min);
    writeln('ingrese una cota maxima: ');
    readln(max);
    writeln('ingrese hasta que nivel quiere recorrer: ');
    readln(nivel);
    actualizarlista(lista,arbol,min,max,nivel,profundidad);
    imprimirlista(lista);
end.