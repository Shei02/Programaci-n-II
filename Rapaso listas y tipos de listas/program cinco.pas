program cinco
type
    puntEmpleado = ^empleadoLista;
    puntCategoria = ^categoria;
    categorias = (A, B, C, D);

    empleadoLista = record
        nombre: string[40];
        categoria: categorias;
        sueldo: integer;
        sig: puntEmpleado;
    end;
    
    empleado = record
        nombre: string[40];
        categoria: categorias;
        sueldo: integer;
    end;

    categoria = record
        categoria: categorias;
        rama: puntEmpleado;
        sig: puntCategoria;
    end;
    
    archEmpleados = file of empleado;

Procedure AbrirArchivo(var archivo: archEmpleados);
begin
    assign(archivo,'/work/lazarovttac_empleados.dat');
    {$I-}
    reset(archivo);
    {$I+}
    if ioresult <> 0 then
        rewrite(archivo);
end;

Procedure CrearEmpleado(var emple: empleado);
begin
    writeln('Ingrese el Nombre del empleado:');
    readln(emple.nombre);
    
    writeln('Ingrese la categoria del empleado:');
    readln(emple.categoria);
    
    writeln('Ingrese el sueldo del empleado:');
    readln(emple.sueldo);
end;

Procedure ImprimirEmpleado(emple: empleado);
begin
    writeln('----------------------');
    
    writeln(emple.categoria);
    writeln(emple.nombre);
    writeln(emple.sueldo);
    
    writeln('----------------------');
end;

Procedure ImprimirArchivo(var archivo: archEmpleados);
var emple: empleado;
    i: integer;
begin
    seek(archivo, 0);
    while not eof(archivo) do
    begin
        read(archivo, emple);
        ImprimirEmpleado(emple);
    end;
end;

Procedure CrearArchivo(var archivo: archEmpleados);
var nuevoEmpleado: empleado;
    i: integer;
begin
    seek(archivo, 0);
    for i := 1 to 5 do
    begin
        CrearEmpleado(nuevoEmpleado);
        write(archivo, nuevoEmpleado);
    end;
end;

// --------------------------------------------------------
// --------------------------------------------------------

function nodoEmpleado(emple: empleado): puntEmpleado;
var nodo: puntEmpleado;
begin
    new(nodo);
    nodo^.nombre := emple.nombre;
    nodo^.sueldo := emple.sueldo;
    nodo^.categoria := emple.categoria;
    nodo^.sig := nil;
    
    nodoEmpleado := nodo;
end;

function categoriaCorrespondiente(lista: puntCategoria; categoria: categorias): puntCategoria;
begin
    categoriaCorrespondiente := nil;
    while lista <> nil do
    begin
        if (lista^.categoria = categoria) then
            categoriaCorrespondiente := lista;
            
        lista := lista^.sig;
    end;
    if categoriaCorrespondiente = nil then writeln('No existe una categoría: ', categoria);
end;

function categoriaAnterior(lista: puntCategoria; categoria: categorias): puntCategoria;
begin
    categoriaAnterior := nil;
    while lista^.sig <> nil do
    begin
        if (lista^.sig^.categoria = categoria) then
            categoriaAnterior := lista;
            
        lista := lista^.sig;
    end;
end;

Procedure InsertarOrdenado(var lista: puntCategoria; nodo: puntEmpleado);
var cursor, anterior: puntEmpleado;
    listo: boolean;
begin
    writeln('Entramo');
    if(lista^.rama = nil) then
    begin
        writeln('1');
        new(lista^.rama);
        lista^.rama := nodo;
    end 
    else if(lista^.rama^.nombre > nodo^.nombre) then
    begin
        writeln('2');
        nodo^.sig := lista^.rama;
        lista^.rama := nodo;
    end 
    else begin
        writeln('3');
        cursor := lista^.rama;
        anterior := cursor;
        listo := false;
        
        while not listo and (cursor <> nil) do
        begin
            if(cursor^.nombre > nodo^.nombre) then
            begin
                anterior^.sig := nodo;
                nodo^.sig := cursor;
                listo := true;
            end else if (cursor^.sig = nil) then 
            begin
                cursor^.sig := nodo;
                listo := true;
            end;
            cursor := cursor^.sig;
        end;
    end;
end;

Procedure CrearCategorias(var lista: puntCategoria);
var cat: categorias;
    cursor: puntCategoria;
begin
    for cat := low(categorias) to high(categorias) do
    begin
        if(lista = nil) then
        begin
            new(lista);
            lista^.categoria := cat;
            lista^.rama := nil;
            lista^.sig := nil;
            
            cursor := lista;
        end else begin
            new(cursor^.sig);
            cursor^.sig^.categoria := cat;
            cursor^.sig^.rama := nil;
            cursor^.sig^.sig := nil;
            
            cursor := cursor^.sig;
        end;
    end;
end;

Procedure CompletarCategorias(var archivo: archEmpleados; var lista: puntCategoria);
var 
    emple: empleado;
    tronco: puntCategoria;
    xd: puntEmpleado;
begin
    seek(archivo, 0);
    
    while not eof(archivo) do begin
        read(archivo, emple);
        tronco := categoriaCorrespondiente(lista, emple.categoria);
        if(tronco = nil) then
            writeln('La categoría del empleado no existe.')
        else begin
            xd := nodoEmpleado(emple);
            InsertarOrdenado(tronco, xd);
        end;
    end;
end;

Procedure CrearLista(var archivo: archEmpleados; var lista: puntCategoria);
begin
    CrearCategorias(lista);
    CompletarCategorias(archivo, lista);
end;

// --------------------------------------------------------
// --------------------------------------------------------

Procedure ImprimirLista(tronco: puntCategoria);
var cat: categorias;
    hoja: puntEmpleado;
    rama: puntCategoria;
begin   
    for cat := low(categorias) to high(categorias) do
    begin
        writeln(cat);
        rama := categoriaCorrespondiente(tronco, cat);
        
        if(rama <> nil) then
        begin
            hoja := rama^.rama;
            while hoja <> nil do
            begin
                write(' - ', hoja^.nombre);
                hoja := hoja^.sig;
            end;
            writeln(' ');
        end;
    end;
end;

Procedure EliminarCategoria(var lista: puntCategoria; cat: categorias);
var tronco, anteriorTronco: puntCategoria;
    cursor, anterior: puntEmpleado;
begin
    writeln('Eliminando ', cat);
    
    tronco := categoriaCorrespondiente(lista, cat);
    
    writeln('Tronco conseguido...');
    writeln(tronco^.categoria);
    writeln(anteriorTronco^.categoria);
    
    if(tronco = nil) then
        writeln('No se puede eliminar una categoría inexistente.')
    else
    begin
        if(tronco^.rama <> nil) then begin
            cursor := tronco^.rama^.sig;
            anterior := tronco^.rama;
            
            while anterior <> nil do
            begin
                writeln('Eliminando a ', anterior^.nombre);
                
                dispose(anterior);
                anterior := cursor;
                if(cursor <> nil) then
                    cursor := cursor^.sig;
            end;
        end;
        
        anteriorTronco := categoriaAnterior(lista, cat);
        
        if(tronco = lista) then
        begin
            lista := lista^.sig;
            dispose(tronco);
        end else begin
            anteriorTronco^.sig := tronco^.sig;
            dispose(tronco);
        end;
    end;

end;

var
    archivoDeEmpleados: archEmpleados;
    empleados: puntCategoria;
    cat: categorias;
begin
    AbrirArchivo(archivoDeEmpleados);
    // CrearArchivo(archivoDeEmpleados);
    ImprimirArchivo(archivoDeEmpleados);
    
    CrearLista(archivoDeEmpleados, empleados);
    ImprimirLista(empleados);
    
    writeln('Te gustaria decirme, por favor, si no te molesta, cuando puedas, si queres, no es importante, una categoria, plis...');
    readln(cat);
    
    EliminarCategoria(empleados, cat);
    ImprimirLista(empleados);
    
    close(archivoDeEmpleados);
end.