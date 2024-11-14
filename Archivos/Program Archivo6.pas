Program Archivo6.pas
Const 
    Ruta = '/work/SArtaza_Char.dat';
    Discernible = '-';
Type 
    ArchCHAR = File of Char;

Var
    Archivos:ArchCHAR;
 
Procedure cargaArchivos (var Archivos:ArchCHAR);
var
    Dato:Char;
Begin
    Dato:= '0';
    Assign(Archivos,Ruta);
    Rewrite(Archivos);
    Writeln('Ingrese datos al archivo: ');
    While (Dato <> Discernible) do
        Begin
            Readln(Dato);
            Write(Archivos,Dato);
        End;
End;

Procedure Invertir (var Archivos:ArchCHAR);
Var
    Inicio,Fin:Integer;
    PI,PF:Char;
Begin  
    Inicio:= 0;
    Fin:= Filesize(Archivos)-1;
    While (Inicio < Fin) do 
        Begin
            Seek(Archivos,Fin);
            Read(Archivos,PF);
            Seek(Archivos,Inicio);
            Read(Archivos,PI);
            //cambio de valores
            Seek(Archivos,Fin);
            Write(Archivos,PI);
            Seek(Archivos,Inicio);
            Write(Archivos,PF);
            Inicio += 1;
            Fin -= 1;
        End;
End;

Procedure Imprimir (var Archivos:ArchCHAR);
var
    Dato:Char;
Begin
    Reset(Archivos);
    Write('{');
    While not eof(Archivos) do
        Begin
            Read(Archivos,Dato);
            If (Filepos(Archivos) = 1) then
                Write(Dato)
            Else
                Write(' ', Dato);
        End;
    Write('}');
End;

//Programa Principal
Begin
    CargaArchivos(Archivos);
    Imprimir(Archivos);
    Invertir(Archivos);
    Imprimir(Archivos);
    Close(Archivos);
End.