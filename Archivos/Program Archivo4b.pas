Program Archivo4b.pas
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

Function BuscarElementoBinaria (var Archivos:ArchINT; Dato:Integer):Integer;
var
    Inicio,Fin,Medio,Elem:Integer;
    Esta:Boolean = False;
Begin
    Reset(Archivos);
    Inicio:= 0;
    Fin:= Filesize(Archivos);
    While (Fin >= Inicio) and not (Esta) do
        Begin
            Medio:= (Inicio + Fin) div 2;
            Writeln('soy medio: ', Medio);
            Seek(Archivos,Medio);
            Read(Archivos,Elem);
            If (Elem = Dato) then
                Begin
                    Esta:= True;
                End
            Else
                If (Elem < Dato) then
                    Begin
                        Inicio:= Medio + 1;
                        Writeln('soy Inicio: ', Inicio);
                    End    
                Else
                    If (Elem > Dato) then
                        Begin
                            Fin:= Medio - 1;
                            Writeln('soy fin: ', Fin);
                        End;
        End;
    If (Esta = True) then
        BuscarElementoBinaria:= Filepos(Archivos)-1
    Else
        BuscarElementoBinaria:= -1;
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

//programa principal
Begin
    Assign(Archivos,Ruta1);
    cargaArchivo(Archivos);
    Imprimir(Archivos);
    Writeln;
    Writeln('Ingrese el numero a buscar: ');
    Readln(Dato);
    Pos:= BuscarElementoBinaria(Archivos,Dato);
    Writeln('Posicion del Elemento: ', Pos);
    Close(Archivos);
End.