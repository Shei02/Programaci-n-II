program Archivo7a.pas
Const
    Ruta = ('/work/SArtaza_Enteros.dat');
Type
    ArchINT = File of Integer;
Var
    Archivo:archINT;
    
Procedure cargaArchivo(var Archivo:ArchINT);
Var
    I:Integer;
Begin
    Assign(Archivo,Ruta);
    Rewrite(Archivo);
    For I:= 0 to 10 do
        Begin
            Write(Archivo,Random(30));
        End;
End;

Procedure Intercambio(var Archivo:archINT; Elem1,Elem2:Integer);
Var
    Aux1,Aux2,posI:Integer;
Begin
    posI:= Filepos(Archivo);
    Seek(Archivo,Elem1);
    Read(Archivo,Aux1);
    Seek(Archivo,Elem2);
    Read(Archivo,Aux2);
    //intercambio
    Seek(Archivo,Elem1);
    Write(Archivo,Aux2);
    Seek(Archivo,Elem2);
    Write(Archivo,Aux1);
    Seek(Archivo,posI-1);
End;

Procedure IntercambioUnaSolaVez(var Archivo:ArchINT);
Var
    Elem1,Elem2:Integer;
Begin
    Reset(Archivo);
    While (Filepos(Archivo) < Filesize(Archivo)-1) do
        Begin
            Read(Archivo,Elem1);
            Read(Archivo,Elem2);
            If (Elem1 > Elem2) then
                Begin
                    Intercambio(Archivo,Filepos(Archivo)-2,Filepos(Archivo)-1);
                End
                    Else
                        Seek(Archivo,Filepos(Archivo)-1);
        End;
End;

Procedure Imprimir(var Archivo:ArchINT);
Var
    Dato:Integer;
Begin
    Reset(Archivo);
    Write('{');
    While not eof(Archivo) do
        Begin
            Read(Archivo,Dato);
            If (Filepos(Archivo) = 1) then
                Write(Dato)
            Else
                Write(' ', Dato);
        End;
    Write('}');
End;

Begin
    Randomize;
    CargaArchivo(Archivo);
    Imprimir(Archivo);
    Writeln;
    Intercambiounasolavez(Archivo);
    Writeln;
    Imprimir(Archivo);
End.