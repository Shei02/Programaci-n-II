program parcialpractica;
type 
	arch_entradas = record		//archivo:
  	dia:string;
    nroentrada:integer;
    Lugar:char;  //general o vip
    nroasiento:integer;
    valor:real;
  end;
  tARbol = ^nodoARbol;	//arbol:
  	nodoArbol = record
    	NumEntradas:integer;
      Lugar:char;
      ValorA:real;
      presente:boolean;
      menor,mayor:tArbol;
    end;
  
  tLista = ^nodoG; // lista gene:
  	nodoG = record
    	NroE:integer;
      NroA:integer;
    Sig:tLista;
    end;
  
  tarchivo = file of arch_entradas; //archivo:
//modulos:

procedure crearnodoArbol (var nodo:Tarbol; dato:arch_entradas); //crea los nodos del arbol a partir del archiv
begin
	new(nodo);
  with dato do begin
  nodo^.NumEntradas:=nroentrada;
  nodo^.lugar:=lugar;
  nodo^.valorA:=valor;
  nodo^.presente:=false;
  nodo^.mayor:=nil;
  nodo^.menor:=nil;
	end;
end;

procedure ActualizarArbol(var arbol:tArbol; entradanueva:integer); // buscamos el numero de entrada digitado y actualizamos el presente a true
begin
	if (arbol <> nil) then
  	begin
    	if (arbol^.Numentrada > entradanueva) then
      	ActualizarARbol(arbol^.menor,entradanueva)
      else if (arbol^.NumEntrada < entradanueva) then
      	ActualizarArbol(arbol^.mayor,entradanueva)
      else if (arbol^.nuevaentrada = entradanueva) then
      	arbol^.presente:= true;
    end;
end;

procedure CrearnodoLista(var lista:tLista; dato:arch_entradas);
begin
	new(lista);
  with dato do begin
  lista^.nroE:= nroEntrada;
  lista^.nroA:= nroasiento;
  end;
end;

procedure CargarArbol(var Arbol:tARbol; nodo:Tarbol);
begin
	if (arbol= nil) then
  	arbol:=nodo
  else if (arbol^.numEntrada > nodo^.numentrada) then
  			cargar(arbol^.menor,nodo)
  		else (arbol^.mayor,nodo);
end;

procedure imprimir(arbol:tarbol);
begin
	if (arbol <> nil) then
  	begin
    	imprimir(arbol^.menor);
      writeln(arbol^.numEntrada);
      imprimir(arbol^.mayor);
    end;
end;

procedure crearlistas (lista:tLista;dato:tLista); //una para la general otra para el vip 
begin
	if (lista = nil) then begin
  	dato^.sig:= lista;
    lista:=dato;
  end else (CrearListas(lista^.sig,dato));
end;

procedure pasararchAarbol (var arbol:tarbol; var archi:tarchivo; var ListaG,ListaV:tlista); //pasamos los datos del archivo a el arbol 
var																																													//tambien carga las listas
	dato:arch_entradas;	
  nodo:tArbol;
  nroAActualizar:integer;
  nodoL:tLista;
begin
		reset(archi);
    while not eof(archivo do begin								// si no esta vacio el archivo te crea el nodo e inserta en el arbol
    	read(archi,dato);
    	CrearnodoArbol(nodo,dato);
      CargarArbol(arbol,nodo);
        if (dato.lugar = 'G') then begin							// dependiendo de la variable char crea una lista o la otra
          Crearnodolista(nodoL,dato)
          CrearListas(listaG,nodoL);
        end
        else if(dato.lugar = 'V') then begin
          Crearnodolista(nodoL,dato);
          CrearListas(ListaV,NodoL);
          end
      end;
    imprimir(arbol);
    writeln('digite un numero a entrada a actualizar');
    Readl(nroAActualizar);
    ActualizarARbol(arbol,nroAActualizar);
end;

function CantidadEntradas(lista:tLista):integer;
begin
	if (lista <> nil) then
  	CantidadEntradas:= cantidadEntradas(lista^.sig) + 1
  else
  	cantidadEntradas:= 0;
end;

function existenAsientos (lista:tLista):boolean; // le pasan la lista de G y la lista V y la capacidad maxima de ese lugar
var
	capacidadmaxima:integer;
  Capacidad:integer;
begin
	writeln('digite la capacidad maxima de entradas');
  readln(capacidadmaxima);
  capacidad:=CantidadEntradas(lista); 
  if (capacidad < capacidadmaxima) then
  	existenAsientos:= true
  else 
  	existenAsientos:= false;
end;

function recaudacion (arbol:tarbol; nroentrada:integer):integer;    //entra el arbol y el numero de entrada (ingresado por teclado) a partir de las entradas mayores a la ingresada calcular la recaudacion
begin
	if (arbol <> nil) then begin
  	if(arbol^.numentrada < nroentrada) then 
        recaudacion:= recuadacion(arbol^.menor,nroentrada) + recaudacion(arbol^.mayor,nroentrada)
    else 
    	recaudacion:= 0;
  end;
end;

//programa principal
var
	arbol:Tarbol;
	archivo:tarchivo;
begin
end.