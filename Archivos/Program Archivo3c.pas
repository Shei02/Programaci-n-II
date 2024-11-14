Program Archivo3c.pas
Const
    Ruta1 = '/work/Original.dat';
    Ruta2 = '/work/Copia.dat';

Type
    ArchCHAR = File of Char;
var
    Archivo,ArchivoClon:ArchCHAR;
    
Procedure CargaArchivo (var Archivo:ArchCHAR);
Var
    I:Integer;
    Valor:Char;
Begin
    Valor:= '0';
    Rewrite(Archivo);
    For I:= 1 to 6 do
        Begin
            Writeln('Ingrese valores al archivo original: ');
            Readln(Valor);
            Write(Archivo,Valor);
        End;
End;

Procedure Clonar (Var Archivo:ArchCHAR; var ArchivoClon:ArchCHAR);
var
    Valor:Char;
Begin
    Reset(Archivo);
    Rewrite(ArchivoClon);
    While not eof(Archivo) do 
        Begin
            Read(Archivo,Valor);
            Write(ArchivoClon,Valor);
        End;
End;

Procedure Imprimir(var Archivo:ArchCHAR);
var
    Valor:Char;
Begin
    Reset(Archivo);
    Writeln('El archivo original es: ');
    While not eof(Archivo) do 
        Begin
            Read(Archivo,Valor);
            Writeln(Valor);
        End;
End;

Procedure ImprimirClon(var ArchivoClon:ArchCHAR);
var
    Valor:Char;
Begin
    Reset(ArchivoClon);
    Writeln('El archivo Clon es: ');
    While not eof(ArchivoClon) do 
        Begin
            Read(ArchivoClon,Valor);
            Writeln(Valor);
        End;
End;

Begin
    Assign(Archivo,Ruta1);
    cargaArchivo(Archivo);
    Imprimir(Archivo);
    Assign(ArchivoClon,Ruta2);
    Clonar(Archivo,ArchivoClon);
    ImprimirClon(ArchivoClon);
    Close(Archivo);
    Close(ArchivoClon);
End.