Program Ejercicio2
Uses sysutils;
Const
    Inicio = 1;
    maxArr = 3;
Type 
    talumno = record
        nrolibreta:Integer;
        nombre:string;
        codFacultad: 1..9;
        codCarrera: 10..99;
        anioCursada:Integer;
    End;
    
    arregloalumnos = array[inicio..maxArr] of talumno;
    
Procedure cargaAlumno (var arreglo:arregloalumnos);
var
    I:Integer;
Begin
    For I:= Inicio to maxArr do 
        Begin
            Writeln('----Registro '+IntToStr(I)+'----');
            Writeln('Nro libreta: ');
            Readln(Arreglo[I].nrolibreta);
            Writeln('Nombre alumno: ');
            Readln(Arreglo[I].nombre);
            Writeln('Cod de facultad: ');
            Readln(Arreglo[I].codFacultad);
            Writeln('Cod de carrera: ');
            Readln(Arreglo[I].codCarrera);
            Writeln('Año de cursada: ');
            Readln(Arreglo[I].anioCursada);
        End;
End;

Procedure cargaAlumno (var alumno:talumno);
Begin
    Writeln('Cargue los datos del nuevo alumno: ');
    Writeln;
    Writeln('Ingrese Nro libreta: ');
    Readln(alumno.nrolibreta);
    Writeln('Ingrese Nombre alumno: ');
    Readln(Alumno.nombre);
    Writeln('Ingrese Cod de facultad: ');
    Readln(Alumno.codFacultad);
    Writeln('Ingrese Cod de carrera: ');
    Readln(Alumno.codCarrera);
    Writeln('Ingrese Año de cursada: ');
    Readln(Alumno.anioCursada);
End;

Procedure ImprimirAlumno (Arreglo:arregloalumnos);
var
    I:Integer;
Begin
    For I:= Inicio to maxArr do 
        with arreglo[I] do 
            Begin
                Writeln('Nro libreta: ', nrolibreta);
                Writeln('Nombre alumno: ', nombre);
                Writeln('Cod de facultad: ', codfacultad);
                Writeln('Cod de carrera: ', codcarrera);
                Writeln('Año de cursada: ', aniocursada);
            End;
End;

Function posicion (arreglo:arregloalumnos; alumnos:talumno):Integer;
var
    pos:Integer;
Begin
    pos:= Inicio;
    While (pos <= maxArr) and (Arreglo[pos].nombre < alumnos.nombre) do 
        Begin
            pos += 1;
        end;
    posicion:= pos;
End;

Procedure corrimientoderecha(var Arreglo:Arregloalumnos; alumnos:talumno);
var
    I,Pos:integer;
Begin
    Pos:= posicion(Arreglo,alumnos);
    For I:= maxArr downto pos+1 do 
        Arreglo[I]:= Arreglo[I-1];
End;

Procedure ingresarnuevoalumno (var Arreglo:Arregloalumnos; nuevoalumno:talumno);
var
    pos:Integer;
begin
    pos:= posicion(Arreglo,nuevoalumno);
    corrimientoderecha(Arreglo,nuevoalumno);
    Arreglo[pos]:= nuevoalumno;
end;

//programa principal
Var 
    alumno:talumno;
    Arreglo:arregloalumnos;
    pos:Integer;
Begin
    cargaAlumno(arreglo);
    imprimiralumno(arreglo);
    cargaAlumno(Alumno);
    ingresarnuevoalumno(arreglo,alumno);
    imprimiralumno(arreglo);
End.