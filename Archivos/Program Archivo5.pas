Program Archivo5.pas
Const
    Inicio = 1;
    maxArr = 5;
    Ruta = '/work/SArtaza_Promedio.dat';

Type
    ArrNotas = Array [Inicio..maxArr] of Integer;
    ArchivoArr = File of ArrNotas;
Var
    Archivo:Archivoarr;
    Arreglo:ArrNotas;
    Alumnos:Integer;
    
Procedure ImprimirArr (Arreglo:ArrNotas);
Var
    I:Integer;
Begin
    For I:= Inicio to maxArr do
        Begin
            Write(Arreglo[I]);
            Write(' | ');
        End;
        Writeln;
End;

Procedure Imprimir (var Archivo:ArchivoArr);
Var
    Arreglo:ArrNotas;
Begin
    Reset(Archivo);
    Writeln('el Archivo es: ');
    While not eof(Archivo) do
        Begin
            Read(Archivo,Arreglo);
            ImprimirArr(Arreglo);
        End;
End;

Procedure CargaNotas(var Archivo:ArchivoArr; Alumnos:Integer);
Var
    I,J:Integer;
    Arreglo:ArrNotas;
Begin
    Assign(Archivo,Ruta);
    Rewrite(Archivo);
    For I:= 0 to Alumnos do
        Begin
            For J:= Inicio to maxArr do
                Begin
                    Arreglo[J]:= random(10);
                End;
            Write(Archivo,Arreglo);
        End;
End;

Function promedioAlumno(Arreglo:ArrNotas; Alumnos:Integer):ArrNotas;
Var
    I:Integer;
Begin
    For I:= Inicio to maxArr do
        Begin
            Arreglo[I]:= round(Arreglo[I] / Alumnos);
        End;
    promedioAlumno:= Arreglo;
End;

Function Promedio(var Archivo:ArchivoArr):ArrNotas; 
Var
    I:Integer;
    Aux,promedioMaterias:ArrNotas;
Begin
    Reset(Archivo);
    While not eof(Archivo) do
        Begin
            Read(Archivo,Aux);
                For I:= Inicio to maxArr do
                    Begin
                        If (Filepos(Archivo) = 1) then
                            promedioMaterias[I]:= Aux[I]
                        Else
                            promedioMaterias[I]+= Aux[I];
                    End;
        End;
    Promedio:= promedioAlumno(promedioMaterias,Filesize(Archivo));
End;

//Programa principal
Begin
    Randomize;
    //carga notas
    Writeln('Ingrese la cantida de alumnos: ');
    Readln(Alumnos);
    CargaNotas(Archivo,Alumnos);
    Imprimir(Archivo);
    //Imprimir Arreglo
    Writeln;
    Writeln('El promedio por materia es: ');
    ImprimirArr(Promedio(Archivo));
    Close(Archivo);
End.