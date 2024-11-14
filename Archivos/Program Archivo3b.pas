Program Archivo3b.pas
Const
    Inicio = 1;
    maxArr = 100;
    Discernible = '/';
Type 
    Arr = Array[Inicio..maxArr] of Char;
    ArchCHAR = File of Char;
    
var
    Archivo:ArchCHAR;
    Nombre:String;
    Max:Integer;
    Arreglo:Arr;

Procedure cargaArchivo (var Archivo:ArchCHAR; var Max:Integer);
var
    Valor:Char;
Begin
    Valor:= '0';
    Rewrite(Archivo);
    While (Valor <> Discernible) do 
        Begin
            Read(Valor);
            Write(Archivo,Valor);
        End;
    Max:= Filesize(Archivo)-1;
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

Procedure cargaArreglo(var Arreglo:Arr; var Archivo:ArchCHAR; Max:Integer);
var
    I:Integer;
    Valor:Char;
Begin
    Reset(Archivo);
    For I:= Inicio to max do  
        Begin
            Read(Archivo,Valor);
            Arreglo[I]:= Valor;
        End;
End;

Procedure Ordenamiento (var Arreglo:Arr; max:Integer);
var
    I,J:Integer;
    Dato:Char;
    Orden:Boolean=False;
Begin
    While not Orden do
        Begin
            Orden:= True;
            For I:= Inicio to Max do 
                Begin
                    For J:= I+1 to Max-1 do 
                        If (Arreglo[I] > Arreglo[J]) then
                            Begin
                                Orden:= False;
                                Dato:= Arreglo[I];
                                Arreglo[I]:= Arreglo[J];
                                Arreglo[J]:= Dato;
                            End;
                End;
        End;
End;

Procedure ImprimirArr (Arreglo:Arr; Max:Integer);
var
    I:Integer;
Begin
    For I:= Inicio to Max do 
        Write(Arreglo[I], ' ');
End;

Begin
    Writeln('Ingrese nombre del archivo: ');
    Readln(Nombre);
    Assign(Archivo,Nombre);
    cargaArchivo(Archivo,max);
    Imprimir(Archivo);
    cargaArreglo(Arreglo,Archivo,max);
    Write('El Arreglo es: ');
    Ordenamiento(Arreglo,max);
    ImprimirArr(Arreglo,max);
    Close(Archivo);
End.