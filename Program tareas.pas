Program tareas
uses sysutils,crt;
const
    ruta = '/work/ArtazaSheilatareaas_.dat';
type 
    ttareas = record
        tarea:string[50];
        fechaHora:string[25];
        realizado:boolean;
    end;
    
    puntero = ^nodo;
        nodo = record 
            tarea:ttareas;
            sig:puntero;
    end;
    
    archtareas = file of ttareas;
    
procedure abrirArchivo (var archivo:archtareas);
begin 
    {$I-} // deshabilito los errores
    reset(Archivo);
    {$I-} // habilita los errores
    if (ioresult <> 0) then 
        Rewrite(archivo);
end;

procedure crearnodo (var nodo:puntero; dato:ttareas);
begin
    new(nodo);
    nodo^.sig:= nil;
    nodo^.tarea:= dato;
end;

procedure cargarlistaArchivo (var lista:puntero; var archivo:archtareas);
var
    cursor,cursor2:puntero;
    dato:ttareas;
begin
    abrirArchivo(archivo);
    while not eof (archivo) do 
        begin
            read(archivo,dato);
            if(lista = nil) then
                begin
                    crearnodo(lista,dato);
                end
            else 
                begin
                    cursor:=lista;
                    while (cursor^.sig <> nil) do
                        begin
                            cursor:= cursor^.sig;
                        end;
                    crearnodo(cursor2,dato);
                    cursor^.sig:=cursor2;
                end;
        end;
    close(archivo);
end;

procedure cargartareas (var tareas:ttareas; esta:boolean);
var
    fechaHora:string;
begin
    textcolor(0);
    TextBackground(LightGray);
    writeln('Cargue una tarea por favor: ');
    esta:=false;
    textcolor(lightgray);
    textbackground(0);
    with tareas do 
        begin
            writeln('nombre de la tarea: '); readln(tarea);
            writeln('fecha y hora: '); fechaHora:=DateTimeToStr(now);
            writeln(fechaHora);
            Realizado:= false;
            If (realizado = false) then
                writeln('Esta tarea esta pendiente');
            writeln;
        end;
end;

procedure agregartareaalfinal (var lista:puntero);
var
    cursor,cursor2:puntero;
    dato:ttareas;
    esta:boolean;
begin
    If (lista = nil) then
        begin    
            cargartareas(dato,esta);
            crearnodo(lista,dato);
        end
    else
        begin
            cursor:=lista;
            while (cursor^.sig <> nil) do
                begin
                    cursor:= cursor^.sig;
                end;
            cargartareas(dato,esta);    
            crearnodo(cursor2,dato);
            cursor^.sig:=cursor2;
        end;
end;

procedure agregartarea (var lista:puntero);
var
    corte:char;
    esta:boolean=false;
begin
    agregartareaalfinal(lista);
    Writeln('Quiere cargar otra tarea? ');
    readln(corte);
    While (upcase(corte) <> 'S') and (upcase(corte) <> 'N') do
        begin
            writeln('Ingrese S si desea continuar la carga o N si desea dejar de cargar');
            readln(corte);
        end;
    while (upcase(corte) <> 'N') and not(esta) do 
        begin
            agregartareaalfinal(lista);
            Writeln('Quiere cargar otra tarea? ');
            readln(corte);
            if (upcase(corte) = 'N') then
                esta:= true;
            While (upcase(corte) <> 'S') and (upcase(corte) <> 'N') do
                Begin
                    writeln('Ingrese S si desea continuar la carga o N si desea dejar de cargar');
                    readln(corte);
                End;
        end;
end;

procedure imprimirlista (lista:puntero);
var
    cursor:puntero;
    contador:integer;
begin
    contador:=1;
    cursor:= lista;
    Writeln('Lista de tareas: ');
    while (cursor <> nil) do 
        begin
            Write('TAREA ', contador,':');
            writeln(cursor^.tarea.tarea);
            Write('FECHA Y HORA: ');
            writeln(cursor^.tarea.fechaHora);
            If (cursor^.tarea.realizado = true) then
                writeln('COMPLETO')
            else 
                writeln('INCOMPLETO');
            cursor:= cursor^.sig;
            contador+=1;
            writeln('------------------------------------');
        end;
end;

procedure tareaspendientes (lista:puntero; var contador:integer);
var
    cursor:puntero;
begin
    contador:=1;
    cursor:= lista;
    Writeln('****************Sus tareas pendientes son: ****************');
    while (cursor <> nil) do 
        begin
            if (cursor^.tarea.realizado = false) then
                begin
                    Write('TAREA ', contador,':');
                    writeln(cursor^.tarea.tarea);
                    Write('FECHA Y HORA: ');
                    writeln(cursor^.tarea.fechaHora);
                    cursor:= cursor^.sig;
                    contador+=1;
                    writeln('-------------------------------------');
                end
            else
                if (cursor^.tarea.realizado = true) then
                    cursor:= cursor^.sig;
        end;
end;

procedure modificar (var lista:puntero);
var
    valor,I:integer;
    cursor:puntero;
begin
    I:=0;
    cursor:=lista;
    writeln('Ingrese el numero de tarea que desea modificar: ');
    readln(valor);
    while (cursor <> nil) and (I < Valor) do
        Begin
            if (cursor^.tarea.realizado = false) then
                I += 1;
            if (I <> valor) then
                cursor:= cursor^.sig;        
        end;
    If (valor = I) then
        begin
            cursor^.tarea.realizado:= true;
            textcolor(0);
            TextBackground(LightGray);
            writeln('Tarea modificada');
            textcolor(lightgray);
            textbackground(0);
        end
    else
         writeln('La tarea que desea modificar no existe');
end;

procedure marcartarealista (var lista:puntero);
var
    opcion:char;
begin
    writeln('Desea marcar tarea como completado?');
    readln(opcion);
    If (upcase(opcion) <> 'S') and (upcase(opcion) <> 'N') then
        Begin
            writeln('Ingrese nuevamente la opcion: ');
            readln(opcion);
        end;
    if (opcion = 'S') then
        modificar(lista);
end;

procedure cargaarchivo (lista:puntero; var archivos:archtareas);
var
    cursor:puntero;
    datos:ttareas;
begin
    abrirArchivo(archivos);
    cursor:=lista;
    while (cursor <> nil) do 
        begin
            datos.tarea:= cursor^.tarea.tarea;
            datos.fechaHora:= cursor^.tarea.FechaHora;
            datos.realizado:= cursor^.tarea.realizado;
            write(archivos,datos);
            cursor:=cursor^.sig;
        end;
    close(archivos);
end;

procedure imprimirarch (var archivo:archtareas);
var
    tarea:ttareas;
begin
    reset(archivo);
    while not eof(archivo) do
        begin
            read(archivo,tarea);
            writeln('--------------------------------');
            writeln('TAREA:');
            writeln(tarea.tarea);
            Write('FECHA Y HORA: ');
            writeln(tarea.fechaHora);
            If (tarea.realizado = true) then
                writeln('COMPLETO')
            else 
                writeln('INCOMPLETO');
            writeln('--------------------------------');
        end;
    close(archivo);
end;

procedure Salir (var opcion:boolean; valor:integer; var archivo:archtareas; lista:puntero);
begin
    opcion:= false;
    if (valor = 4) then
        begin
            opcion:= true;
            cargaarchivo(lista,archivo);
            imprimirarch(archivo);
        end;
    close(archivo)
end;

Procedure menu (var lista:puntero; var archivo:archtareas);
var
    opcion,contador:integer;
    esta:boolean=false;
begin
    while (opcion <> 4) do 
        begin
            writeln('***********MENU***********');
            Writeln('1- Agregar una tarea.');
            writeln('2- Listar tareas pendientes.');
            writeln('3- Modificar tarea.');
            writeln('4- Salir.');
            writeln('Ingrese una opcion: ');
            readln(opcion);
            while (opcion <> 1) and (opcion <> 2) and (opcion <> 3) and (opcion <> 4)do 
                begin
                    writeln('Por favor ingrese una opcion correcta: ');
                    readln(opcion);
                end;
            case opcion of 
                1: agregarTarea(lista);  
                2: tareaspendientes(lista,contador);  
                3: marcartarealista(lista);
                4: salir(esta,opcion,archivo,lista);
            end;
        end;
end;

//programa principal
var
    lista:puntero;
    archivo:archtareas;
begin
    assign(archivo,ruta);
    cargarListaArchivo(lista,archivo);
    menu(lista,archivo);
    imprimirlista(lista);
end.