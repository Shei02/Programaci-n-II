Program Archivo4a.pas
Const
    Ruta1 = '/work/SArtaza_Enteros.dat';
Type
    ArchINT = File of Integer;
var
    Archivos:ArchINT;
    Dato,Pos:Integer;
    
Procedure cargaArchivo (var Archivos:ArchINT);
var
    I,Valor:Integer;
Begin
    Assign(Archivos,Ruta1);
    Rewrite(Archivos);
    For I:= 0 to 6 do
        Begin
            Writeln('Ingrese valores:' );
            Readln(Valor);
            Write(Archivos,Valor);
        End;
    Close(Archivos);
End;

Function BuscarElementoLineal (var Archivos:ArchINT; Dato:Integer):Integer;
var
    Elem,Inicio:Integer;
    Esta:Boolean = False;
Begin
    Inicio:= 0;
    Seek(Archivos,Inicio);
    While not eof(Archivos) and not (Esta) do
        Begin
            Read(Archivos,Elem);
            If (Elem = Dato) then
                Esta:= True;
        End;
    If (Esta) then
        BuscarElementoLineal:= Filepos(Archivos)-1
    Else
        BuscarElementoLineal:= -1;
End;

Procedure Imprimir (var Archivos:ArchINT);
var
    Valor:Integer;
Begin
    Reset(Archivos);
    Writeln('El archivo es: ');
    While not eof(Archivos) do 
        Begin
            Read(Archivos,Valor);
            Write(' ', Valor);
        End;
End;

//Programa Principal
Begin
    cargaArchivo(Archivos);
    Imprimir(Archivos);
    Writeln;
    Writeln('Ingrese el elemento a buscar: ');
    Read(Dato);
    Pos:= BuscarElementoLineal(Archivos,Dato);
    Writeln('Posicion del elemento: ', Pos);
    Close(Archivos);
End.