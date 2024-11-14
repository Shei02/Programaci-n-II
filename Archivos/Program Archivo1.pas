Program Archivo1.pas

Type
    ArchINT = File of Integer;

Var 
    Archivos:ArchINT;
    
Procedure cargaArchivo(var Archivos:ArchINT);
Var
    I,Valor:Integer;
Begin
    Assign(Archivos,'/work/SArtaza_enteros.dat');
    Rewrite(Archivos);
    For I:= 1 to 3 do
        Begin
            Writeln('Ingrese valores:' );
            Readln(Valor);
            Write(Archivos,Valor);
        End;
    Close(Archivos);
End;

Procedure MostrarArchivo(var Archivos:ArchINT);
Var
    Valor:Integer;
Begin
    Reset(Archivos);
    Writeln('Valores del archivo: ');
    While not eof(Archivos) do
        Begin
            Read(Archivos,Valor);
            Writeln(Valor);
        End;
    Close(Archivos);
End;

Procedure AgregarValor(var Archivos:ArchINT);
var
    Valor:Integer;
Begin
    Reset(Archivos);
    Seek(Archivos,Filesize(Archivos));
    Write('Ingrese valor al final del archivo: ');
    Readln(Valor);
    Write(Archivos,Valor);
    Close(Archivos);
End;

Function Promedio (var Archivos:ArchINT):Real;
var
    Prom:Real;
    Valor:Integer;
Begin
    Prom:= 0;
    Reset(Archivos);
    While not eof(Archivos) do
        Begin
            Read(Archivos,Valor);
            Prom:= (Prom+Valor);
        End;
    Prom:= Prom / Filesize(Archivos);
    Close(Archivos);
    Promedio:= Prom;
End;

Function Mayor (var Archivos:ArchINT):Integer;
var
    Valor,Aux:Integer;
Begin
    Aux:= 0;
    Reset(Archivos);
    While not eof(Archivos) do
        Read(Archivos,Valor);
            If (Valor > Aux) then
                Aux:= Valor;
    Mayor:= Aux;
End;

Begin
    cargaArchivo(Archivos);
    MostrarArchivo(Archivos);
    AgregarValor(Archivos);
    MostrarArchivo(Archivos);
    Write('Promedio del Archivo es: ', Promedio(Archivos));
    Writeln;
    Write('El elemento mayor del archivo es: ', Mayor(Archivos));
end.