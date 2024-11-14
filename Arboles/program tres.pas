program tres;
const;
    //ruta = '/work/archivoint_.dat';
type
    puntero = ^tarbol;
        tarbol = record
            nroAlumno:integer;
            DNI:longint;
            mayores:puntero;
            menores:puntero;
        end;

procedure crearnodo(var nodo:puntero);
begin
    new(nodo);
    writeln('Ingrese DNI: ');
    readln(nodo^.DNI);
    writeln('Ingrese nro de alumno: ');
    readln(nodo^.nroAlumno);
    nodo^.mayores:= nil;
    nodo^.menores:= nil;
end;

procedure Agregarnodo(var nodo:puntero; nuevonodo:puntero);
var 
    DNI:longint;
begin
    if (nodo = nil) then
        nodo:= nuevonodo
    else
        begin
            if (nuevonodo^.DNI > nodo^.DNI) then
                Agregarnodo(nodo^.mayores,nuevonodo)
            else
                agregarnodo(nodo^.menores,nuevonodo);
        end;
end;

procedure cargaArbol (var arbol:puntero);
var
    i:integer;
    nodo:puntero;
begin
    for i:= 1 to 5 do
        begin
            crearnodo(nodo);
            agregarnodo(arbol,nodo);
        end;
end;

//busqueda por orden del arbol (DNI)
function devuelveNroAlumno (arbol:puntero; BDNI:integer):integer;
begin
    if (arbol <> nil) then
        begin
            if (arbol^.DNI = BDNI) then
                begin
                    devuelveNroAlumno:= arbol^.nroAlumno;
                end
            else
                if (arbol^.DNI < BDNI) then
                    devuelveNroAlumno:= devuelveNroAlumno(arbol^.mayores,BDNI)
                else
                    devuelveNroAlumno:= devuelveNroAlumno(arbol^.menores,BDNI)
        end
    else
        begin
            writeln('El arbol esta vacio o el DNI ingresado no existe');
            devuelveNroAlumno:= -1;
        end;
end;

//busqueda por distinto orden del arbol (NRO ALUMNO)
function devuelveDNI (arbol:puntero; nroAlumno:integer):longint;
begin
    if (arbol <> nil) then
        begin
            if (arbol^.nroAlumno = nroAlumno) then
                devuelveDNI:= arbol^.DNI
            else
                begin
                    devuelveDNI:= devuelveDNI(arbol^.mayores,nroAlumno);
                    if (devuelveDNI = -1) then
                        devuelveDNI:= devuelveDNI(arbol^.menores,nroAlumno);
                end
        end
    else
        begin
            writeln('El arbol esta vacio o el nro de alumno ingresado no existe');
            devuelveDNI:= -1;
        end;
end;

Procedure imprimirarbol(arbol:puntero);
begin
    if (arbol <> nil) then
        begin
            writeln(arbol^.DNI);
            imprimirarbol(arbol^.menores);
            imprimirarbol(arbol^.mayores);
        end;
end;

//programa principal
var
    arbol:puntero;
    BDNI:longint;
    nroAlumno:integer;
begin
    arbol:= nil;
    cargaArbol(arbol);
    writeln('El arbol es: ');
    imprimirarbol(arbol);
    writeln('Ingrese el DNI a buscar: ');
    readln(BDNI);
    writeln(devuelveNroAlumno(arbol,BDNI));
    writeln('Ingrese el Nro de alumno a buscar: ');
    readln(NroAlumno);
    writeln(devuelveDNI(arbol,nroAlumno));
end.