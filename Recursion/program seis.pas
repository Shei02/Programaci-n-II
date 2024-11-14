program seis
type
    arch = file of integer;

Procedure cargaArchivo(var Archivos:Arch);
Var
    I,Valor:Integer;
Begin
    Rewrite(Archivos);
    Writeln('Ingrese valores:' );
    For I:= 1 to 3 do
        Begin
            Readln(Valor);
            Write(Archivos,Valor);
        End;
    Close(Archivos);
End;

Procedure MostrarArchivo(var Archivos:Arch);
Var
    Valor:Integer;
Begin
    if not eof(Archivos) then
        Begin
            Read(Archivos,Valor);
            Writeln(Valor);
            mostrararchivo(archivos);
        End;
End;

procedure archInv (var archivo1:arch; var archivo2:arch);
var
    valor:integer;
begin
    if not eof(archivo1) then
        begin
            read(archivo1,valor);
            archInv(archivo1,archivo2);
            write(archivo2,valor);
        end;    
end;

Procedure MostrarArch(var Archivos:Arch);
Var
    Valor:Integer;
Begin
    Writeln('Valores del archivo invertido: ');
    seek(archivos,0);
    While not eof(Archivos) do
        Begin
            Read(Archivos,Valor);
            Writeln(Valor);
        End;
End;

//programa principal
var
    archivo1:arch;
    archivo2:arch;
begin
    Assign(Archivo1,'/work/SArtaza_int.dat');
    Assign(Archivo2,'/work/SArtaza_int2.dat');
    rewrite(archivo2);
    cargaArchivo(archivo1);
    reset(archivo1);
    Writeln('Valores del archivo: ');
    mostrararchivo(archivo1);
    reset(archivo1);
    reset(archivo2);
    archInv(archivo1,archivo2);
    mostrararch(archivo2);
    close(archivo1);
    close(archivo2);
end.