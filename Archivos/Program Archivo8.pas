Program Archivo8.pas
Const
    Inicio = 1;
    maxArr = 6;
    Ruta = '/work/SArtaza_Promedio.Dat';

Type 
    arrReal = Array [Inicio..maxArr] of Real;
    ArchREAL = File of arrReal;
Var
    Archivos:ArchREAL;
    Alumnos:Integer;
    Arreglo:arrREAL;
    
Procedure cargaArchivos (var Archivos:ArchREAL; Alumnos:Integer);
var
    I,J,Dato:Integer;
    Arreglo:arrREAL;
Begin
    Assign(Archivos,Ruta);
    Rewrite(Archivos);
    For I:= 0 to Alumnos do 
        Begin
            Writeln('Ingrese notas: ');
            For J:= Inicio to maxArr-1 do
                Begin    
                    Readln(Dato);
                    Arreglo[J]:= Dato;
                End;    
            Arreglo[maxArr]:= 0;
            Write(Archivos,Arreglo);
        End;
End;

Procedure imprimirArr (Arreglo:arrREAL);
var
    I:Integer;
Begin
    For I:= Inicio to maxArr do 
        Begin
            Write(Arreglo[I]:0:2, ' ');
        End;
    Writeln;
End;

Procedure Imprimir (var Archivos:ArchREAL);
var
    Arreglo:arrREAL;
    I:Integer;
Begin
    Reset(Archivos);
    For I:= 0 to Filesize(Archivos) do 
        While not eof(Archivos) do
            Begin
                Read(Archivos,Arreglo);
                imprimirArr(Arreglo);
            End;
End;

Procedure calcularPromedio (var Archivos:ArchREAL);
var
    I:Integer;
    Suma:Real;
    Arreglo:arrREAL;
Begin
    Reset(Archivos);
    While not eof(Archivos) do  
        Begin
            Read(Archivos,Arreglo);
            Suma:= 0;
            For I:= Inicio to maxArr-1 do
                Suma+= Arreglo[I];
            Arreglo[maxArr]:= (Suma / (maxArr-1));
            Seek(Archivos,filepos(Archivos)-1);
            Write(Archivos,Arreglo);
        End;
End;

//Programa principal
Begin
    Writeln('Ingrese la cantidad de alumnos: ');
    Read(Alumnos);
    cargaArchivos(Archivos,Alumnos);
    Writeln('El archivos con las notas es: ');
    Imprimir(Archivos);
    Writeln;
    Writeln('El archivos con los promedios es: ');
    CalcularPromedio(Archivos);
    Imprimir(Archivos);
    Close(Archivos);
End.