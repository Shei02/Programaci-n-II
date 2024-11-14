Program Archivo9.pas
Const  
    Ruta = '/work/SArtaza_Enteros.dat';
Type
    ArchINT = File of Integer;
Var
    Archivos:ArchINT;
    Limite,Dato,Resultado:Integer;
    
Procedure cargaArchivos (var Archivos:ArchINT; Limite:Integer);
var
    I, Valor:Integer;
Begin
    Rewrite(Archivos);
    Writeln('Ingrese valores: ');
    For I:= 0 to Limite do 
        Begin
            Readln(Valor);
            Write(Archivos,Valor);
        End;
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
            Writeln(Valor);
        End;
End;

Function BusquedaBinaria (var Archivos:ArchINT; Dato:Integer):Integer;
var
    Inicio,Medio,Fin,Elemento:Integer;
    Esta:Boolean = False;
Begin   
    Inicio:= 0;
    Reset(Archivos);
    Fin:= Filesize(Archivos)-1;
    While (Fin >= Inicio) and not (Esta) do 
        Begin
            Medio:= (Fin + Inicio) div 2;
            Seek(Archivos,Medio);
            Read(Archivos,Elemento);
            If (Dato = Elemento) then
                Esta:= True
            Else
                If (Dato < Elemento) then
                    Fin:= Medio - 1
                Else
                    If (Dato > Elemento) then
                        Inicio:= Medio + 1;
        End;
    If (Esta = True) then
        BusquedaBinaria:= Filepos(Archivos)-1
    Else
        BusquedaBinaria:= -1;
End;

//programa principal
Begin
    Assign(Archivos,Ruta);
    Writeln('Ingrese el limite del archivo: ');
    Readln(Limite);
    cargaArchivos(Archivos,Limite);
    Imprimir(Archivos);
    Writeln('Ingrese el dato que desea buscar: ');
    Readln(Dato);
    Resultado:= BusquedaBinaria(Archivos,Dato);
    Writeln('De no encontrar el elemento se devuelve un (-1), sino la posicion del elemento es: ', Resultado);
    Close(Archivos);
End.