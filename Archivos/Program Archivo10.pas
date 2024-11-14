Program Archivo10.pas
Type 
    ArchINT = File of Integer;
Var
    Prog2:ArchINT;
    csComputacion:ArchINT;
    Legajos:ArchINT;
    Limite:Integer;
    
Procedure rutaArchivo(var archivo:ArchINT; nombre:string);
Begin
    If (nombre = '') then
        Begin
            write('Escriba el nombre del archivo: ');
            readln(nombre);
        End;
    Assign(archivo, concat('/work/SArtaza_',nombre,'.dat'));
End;    
    
Procedure cargaArchivosCs (var csComputacion:ArchINT; Limite:Integer);
var
    I,Valor:Integer;
Begin
    rutaArchivo(csComputacion,'csComputacion');
    Rewrite(csComputacion);
    Writeln('Ingrese valores: ');
    For I:= 0 to Limite do 
        Begin
            Readln(Valor);
            Write(csComputacion,Valor);
        End;
End;

Procedure cargaArchivosProg (var Prog2:ArchINT; Limite:Integer);
var
    I,Valor:Integer;
Begin
    rutaArchivo(Prog2,'Prog2');
    Rewrite(Prog2);
    Writeln('Ingrese valores: ');
    For I:= 0 to Limite do 
        Begin
            Readln(Valor);
            Write(Prog2,Valor);
        End;
End;

Procedure inscripcionesLegajos (var Legajos:ArchINT; var Prog2:ArchINT; var csComputacion:ArchINT);
var
    datoCs,datoP:Integer;
    Esta:Boolean = False;
Begin
    rutaArchivo(Legajos,'Legajos');
    Rewrite(Legajos);
    Reset(Prog2);
    Reset(csComputacion);
    While not eof (Prog2) do 
        Begin
            Read(Prog2,datoP);
            Seek(csComputacion,0);
            While not eof (csComputacion) and not (Esta) do 
                Begin
                    Read(csComputacion,datoCs);
                    If (datoP = datoCs) then
                        Begin
                            Esta:= True;
                            Write(Legajos,datoP);
                        End;
                End;
            Esta:= False;
        End;
    Close(Prog2);
    Close(csComputacion);
End;

Procedure Imprimir(var Legajos:ArchINT);
Var
    Valor:Integer;
Begin
    Reset(Legajos);
    While not eof(Legajos) do 
        Begin
            Read(Legajos,Valor);
            Write(' ', Valor);
        End;
    Close(Legajos);
End;

//Programa principal
Begin
    Writeln('Ingrese el limite del archivoCs: ');
    Readln(Limite);
    cargaArchivosCs(csComputacion,Limite);
    Writeln;
    Writeln('Ingrese el limite del archivoProg: ');
    Readln(Limite);
    cargaArchivosProg(Prog2,Limite);
    Writeln;
    inscripcionesLegajos(Legajos,Prog2,csComputacion);
    Writeln('Los alumnos incriptos en ambas materias son: ');
    Imprimir(Legajos);
End.