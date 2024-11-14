Program Archivo3a.pas
Const
    Discernible = '/';
Type 
    ArchCHAR = File of Char;
    
var
    Archivo:ArchCHAR;
    Nombre:String;

Procedure cargaArchivo (var Archivo:ArchCHAR);
var
    Valor:Char;
Begin
    Valor:= '0';
    Rewrite(Archivo);
    While (Valor <> Discernible) do 
        Begin
            Read(Valor);
            If (Valor = 'a') or (Valor = 'e') or (Valor = 'i') or (Valor = 'o') or (Valor = 'u') then
                Begin
                    Write(Archivo,Valor);
                End;
        End;
End;

Procedure Imprimir (var Archivo:ArchCHAR);
var
    Valor:Char;
Begin
    Reset(Archivo);
    Writeln('El archivo es: ');
    While not eof(Archivo) do 
        Begin
            Read(Archivo,Valor);
            Writeln(Valor);
        End;
End;

Begin
    Writeln('Ingrese nombre del archivo: ');
    Readln(Nombre);
    Assign(Archivo,Nombre);
    cargaArchivo(Archivo);
    Imprimir(Archivo);
    Close(Archivo);
End.