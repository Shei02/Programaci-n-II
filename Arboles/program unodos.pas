program unodos
const 
    ruta = '/work/archivoint_.dat';
type
    puntero = ^tarbol;
        tarbol = record
            nro:integer;
            mayores:puntero;
            menores:puntero;
        end;
     
    arch = file of Integer;

procedure crearArchivo(var archivo:arch; var max:integer);
var
    I,Valor:Integer;
begin
    Rewrite(Archivo);
    writeln('ingrese el maximo que desea cargar: ');
    readln(max);
    Writeln('Ingrese valores:' );
    For I:= 1 to max do
        Begin
            Readln(Valor);
            Write(Archivo,Valor);
        End;
    Close(Archivo);
end;

procedure crearhoja(var nodo:puntero; dato:integer);
begin
    new(nodo);
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

procedure creararbol (var arbol:puntero; var archivo:arch);
var
    nuevaHoja:puntero;
    dato:integer;
begin
    reset(archivo);
    arbol:= nil;
    while not eof(archivo) do 
        begin
            read(archivo,dato);
            crearhoja(nuevaHoja,dato);
            agregarhoja(arbol,nuevaHoja);
        end;
end;
    
//in-order        
procedure imprimirAscendente (arbol:puntero);
Begin
    If (arbol <> nil) then 
        begin
            imprimirAscendente (arbol^.Menores);
            writeln (arbol^.Nro);
            imprimirAscendente (arbol^.Mayores);
        End;
End;
    
//in-order    
procedure imprimirDescendente (arbol:puntero);
Begin
    If (arbol <> nil) then 
        begin
            imprimirDescendente (arbol^.mayores);
            writeln (arbol^.Nro);
            imprimirDescendente (arbol^.Menores);
        End;
End;    
  
//post-order        
procedure imprimirPostOrder (arbol:puntero);
Begin
    If (arbol <> nil) then 
        begin
            imprimirPostOrder (arbol^.Menores);
            imprimirPostOrder (arbol^.Mayores);
            writeln (arbol^.Nro);
        End;
End;        
        
//pre-Order        
procedure imprimirPreOrder (arbol:puntero);
Begin
    If (arbol <> nil) then 
        begin
            writeln (arbol^.Nro);
            imprimirPreOrder (arbol^.Menores);
            imprimirPreOrder (arbol^.Mayores);
        End;
End;        
//Programa Principal
var
    arbol:puntero;
    archivo:arch;
    max:integer;
begin
    Assign(Archivo,ruta);
    creararchivo(archivo,max);
    creararbol(arbol,archivo);
    writeln('El arbol es: ');
    //imprimirAscendente(arbol);
    //imprimirDescendente(arbol);
    //imprimirPostOrder(arbol);
    //imprimirPreOrder(arbol);
end.