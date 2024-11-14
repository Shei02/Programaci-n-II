program ejercicio_6;
{
    
}

type 
    PuntExamen = ^TExamen;
    TExamen = record
        nroAlumno: integer;
        materia: string;
        notaFinal: real;
        mayor: PuntExamen;
        menor: PuntExamen;
    end;
    
    PuntLista = ^TLista;
    Tlista = record
        nroAlumno: integer;
        notaFinal: real;
        anterior, siguiente: PuntLista; 
    end;

{                           methods                                            }

////////////////////////////////////////////////////////////////////////////////
//                          Arbol/ExamenesDeAlumnos                           //
Procedure ImprimirArbolAscendente(ciudades:PuntExamen);
Begin
    If (ciudades <> Nil) Then
    Begin
        ImprimirArbolAscendente(ciudades^.menor);
        writeln('--------------------------');
        writeln('Numero de alumno: ',ciudades^.nroAlumno);
        writeln('Materia: ',ciudades^.materia);
        writeln('Nota final: ',ciudades^.notaFinal);
        writeln('--------------------------');
        ImprimirArbolAscendente(ciudades^.mayor);
    End;
End;
procedure InsertarOrdenadoExamen (var examenesDeAlumnos: PuntExamen; examen: PuntExamen);
begin 
    if (examenesDeAlumnos = nil) then 
        examenesDeAlumnos:= examen
    else begin 
        if (examenesDeAlumnos^.nroAlumno < examen^.nroAlumno) then
            InsertarOrdenadoExamen (examenesDeAlumnos^.mayor, examen)
        else 
            InsertarOrdenadoExamen (examenesDeAlumnos^.menor, examen);
    end;
end;

procedure CrearNodoExamen (var examen: PuntExamen; nroAlumno: integer; //Crea el nodo del arbol
                              materia: string; notaFinal: real); 
begin 
    new(examen);
    examen^.nroAlumno := nroAlumno;
    examen^.materia := materia;
    examen^.notaFinal := notaFinal;
    examen^.menor := nil;
    examen^.mayor := nil;
end;


procedure CrearExamenes (var examenesDeAlumnos: PuntExamen); //Crea el árbol
var 
    nroAlumno, i, cantidad, numeroAlumnoMaximo, numeroAlumnoMinimo: integer; 
    materia: string;
    notaFinal: real;
    examen: PuntExamen;
begin 
    writeln('Ingrese la cantidad que desea ingresar al árbol: ');
    readln(cantidad);
    for i:= 1 to cantidad do begin 
        writeln('Ingresar nro Alumno');
        readln(nroAlumno);
        writeln('Ingresar materia: ');
        readln(materia);
        writeln('Ingresar nota Final: ');
        readln(notafinal);
        CrearNodoExamen(examen, nroAlumno, materia, notaFinal);
        InsertarOrdenadoExamen(examenesDeAlumnos, examen);
    end;
end;



////////////////////////////////////////////////////////////////////////////////
//                        lista                                               //
Procedure Imprimirlista(lista:PuntLista);
Begin
    If (lista <> Nil) Then
    Begin
        writeln('Num alumno: ',lista^.nroAlumno);
        writeln('Nota Final: ',lista^.notaFinal);
        imprimirlista(lista^.siguiente);
    End;
End;
function BuscaAlumnoEnLista (lista: PuntLista; alumno: integer): Puntlista; 
//RECORDAR DEVOLVER EL ANTERIOR
begin 
    if (lista^.nroAlumno = alumno) then
        BuscaAlumnoEnLista := lista
    else if (lista^.siguiente <> nil) and (lista^.siguiente^.nroAlumno = alumno) then 
        BuscaAlumnoEnLista:= lista
    else
        BuscaAlumnoEnLista(lista^.siguiente, alumno);
end;

procedure DesvincularLista (var alumnoDesvinculado: PuntLista);
var aux: PuntLista;
begin 
    aux := alumnoDesvinculado;
    alumnoDesvinculado^.siguiente:= alumnoDesvinculado^.siguiente^.siguiente;
    alumnoDesvinculado^.siguiente^.anterior:= alumnoDesvinculado;
    aux^.siguiente:= nil;
    aux^.anterior:= nil; //Esto es para desvincular literalmente el nodito. 
    alumnoDesvinculado := aux;
end;

procedure InsertarOrdenadoEnLista (var lista: PuntLista; nodo: PuntLista);
begin 
    if ((lista = nil) or (nodo^.Notafinal <= lista^.notaFinal)) then begin
        nodo^.siguiente := lista; 
        //nodo^.anterior := lista^.anterior;
        nodo^.anterior := lista^.siguiente^.anterior;
        lista := nodo; //Se inserta el nodo ordenado. 
    end else 
        InsertarOrdenadoEnLista (lista^.siguiente, nodo);
end;

procedure CrearNodoLista (examenesDeAlumnos: PuntExamen; var alumno: PuntLista); 
begin 
    new (alumno);
    alumno^.nroAlumno:= examenesDeAlumnos^.nroAlumno;
    alumno^.notaFinal := examenesDeAlumnos^.notaFinal;
    alumno^.siguiente := nil;
    alumno^.anterior := nil;
end;

procedure CrearLista (var lista: PuntLista; examenesDeAlumnos: PuntExamen;
                          numeroAlumnoMaximo, numeroAlumnoMinimo: integer);
var nuevoAlumno: PuntLista;
begin 
    if (examenesDeAlumnos <> nil) then begin 
        if ((numeroAlumnoMaximo < examenesDeAlumnos^.nroAlumno) or (numeroAlumnoMinimo > examenesDeAlumnos^.nroAlumno)) then begin
            //Estamos afuera del rango
            nuevoAlumno:= BuscaAlumnoEnLista(lista, examenesDeAlumnos^.nroAlumno);
            if (nuevoAlumno <> nil) then begin
                if (nuevoAlumno^.siguiente <> nil) then begin
                    if (examenesDeAlumnos^.notaFinal > nuevoAlumno^.siguiente^.notaFinal) then begin
                        //Desvinculamos el nodo, lo modificamos, luego lo insertamos ordenadamente :). 
                        DesvincularLista(nuevoAlumno); 
                        nuevoAlumno^.siguiente^.notaFinal := examenesDeAlumnos^.notaFinal;
                        InsertarOrdenadoEnlista (lista, nuevoAlumno); 
                    end;
                end else
                    if (examenesDeAlumnos^.notaFinal > nuevoAlumno^.notaFinal) then 
                        nuevoAlumno^.notaFinal := examenesDeAlumnos^.notaFinal;
            end else begin 
                CrearNodoLista (examenesDeAlumnos, nuevoAlumno);
                InsertarOrdenadoEnLista (lista, nuevoAlumno);
            end;
        end;
        CrearLista(lista, examenesDeAlumnos^.menor, numeroAlumnoMaximo, numeroAlumnoMinimo);
        CrearLista(lista, examenesDeAlumnos^.mayor, numeroAlumnoMaximo, numeroAlumnoMinimo);
    end;
end;


// Main Program 
var 
    examenesDeAlumnos: PuntExamen; 
    lista: PuntLista;
    numeroAlumnoMaximo, numeroAlumnoMinimo: integer;
begin 
    examenesDeAlumnos := nil;
    CrearExamenes(examenesDeAlumnos);
    ImprimirArbolAscendente(examenesDeAlumnos);
    writeln('Ingrese el numero de alumno máximo que desea buscar: ');
    readln(numeroAlumnoMaximo);
    writeln('Ingrese el numero de alumno mínimo que desea buscar: ');
    readln(numeroAlumnoMinimo);
    CrearLista(lista, examenesDeAlumnos, numeroAlumnoMaximo, numeroAlumnoMinimo);
    ImprimirLista(lista);
end.