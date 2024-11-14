Program Archivo7b.pas
Const
    Ruta = '/work/SArtaza_Enteros_Dat';
Type 
    ArchINT = File of Integer;
Var
    Archivos:ArchINT;
    
Procedure cargaArchivos(var Archivos:ArchINT);
var
    I:Integer;
Begin
    Assign(Archivos,Ruta);
    Rewrite(Archivos);
    For I:= 0 to 10 do
        Begin
            Write(Archivos,random(30));
        End;
End;

Procedure Intercambio (var Archivos:ArchINT; Elem1,Elem2:Integer);
var
    Aux1,Aux2,posI:Integer;
Begin
    posI:= Filepos(Archivos);
    Seek(Archivos,Elem1);
    Read(Archivos,Aux1);
    Seek(Archivos,Elem2);
    Read(Archivos,Aux2);
    //cambio de elemento  
    Seek(Archivos,Elem1);
    Write(Archivos,Aux2);
    Seek(Archivos,Elem2);
    Write(Archivos,Aux1);
    Seek(Archivos,posI-1);
End;

Procedure Burbujeo (Var Archivos:ArchINT);
var
    Elem1,Elem2:Integer;
    Esta:Boolean = False;
Begin 
    While not (Esta) do
        Begin
            Esta:= True;
            Reset(Archivos);
            While (Filepos(Archivos) < Filesize(Archivos)-1) do 
                Begin
                    Read(Archivos,Elem1);
                    Read(Archivos,Elem2);
                    If (Elem1 > Elem2) then
                        Begin
                            Intercambio(Archivos,Filepos(Archivos)-2,Filepos(Archivos)-1);
                            Esta:= False;
                        End
                    Else
                        Seek(Archivos,Filepos(Archivos)-1);
                End;
        End;
End;

Procedure Imprimir (var Archivos:ArchINT);
var
    Dato:Integer;
Begin
    Reset(Archivos);
    Write('{');
    While not eof (Archivos) do 
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
    Randomize;
    cargaArchivos(Archivos);
    Imprimir(Archivos);
    Writeln;
    Burbujeo(Archivos);
    Imprimir(Archivos);
End.