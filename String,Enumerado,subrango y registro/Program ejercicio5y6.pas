Program ejercicio5y6
const
    Ruta = '/work/SArtaza_Emple.dat';
Type
    categorias = (Administrativo,Operario,Gerente,Maestranza);

    tfecha = record
        dia:1..31;
        mes:1..12;
        Anio:2000..2050;
    End;
    
    templeado = record 
        nrolegajo: 1..4;
        nombreYapellido:String;
        Edad:Integer;
        fecingreso:tfecha;
        categoria:categorias;
        Sueldo:longInt;
    End;

 Arch = file of templeado;

Procedure cargaEmpleado (var Empleado:templeado; var archivos:arch; var esta:boolean);    
var
    I:Char;
Begin
    readln(I);
    esta:= false;
    While (upcase(I) <> 'N') do
        Begin
            Writeln('Ingrese nro legajo: ');
            Readln(empleado.nrolegajo);
            Writeln('Ingrese nombre y apellido: ');
            Readln(empleado.nombreYapellido);
            Writeln('Ingrese edad: ');
            Readln(empleado.edad);
            Writeln('Ingrese fecha de ingreso al trabajo: ');
            Readln(empleado.fecingreso.dia);
            Readln(empleado.fecingreso.mes);
            Readln(empleado.fecingreso.anio);
            Writeln('Ingrese categoria: ');
            readln(empleado.categoria);
            Writeln('Ingrese sueldo: ');
            Readln(empleado.sueldo);
            Writeln;
            Write('desea seguir cargando?: S/N ');
            writeln;
            Readln(I);
            If (upcase(I) = 'N') then
                Esta:= true;
            While (upcase(I) <> 'S') and (upcase(I) <> 'N') do
                Begin
                    readln(I)
                End;
            Write(Archivos,empleado);
        End;
End;
    
Procedure AgregarEmpleado (var Archivos:Arch);    
Var
    I:Char;
    Empleado:templeado;
    esta:boolean = false;
begin
    Writeln('Quiere cargar un nuevo empleado: S/N');
    Readln(I);
    While (upcase(I) = 'S') and not (esta) do
        Begin
            Seek(Archivos,Filesize(archivos));
            cargaEmpleado(Empleado,archivos,esta);
            While (upcase(I) <> 'S') and (upcase(I) <> 'N') do 
                Readln(I);
        End;
end;

Function eliminar (var empleado:Arch; dato:Integer):Boolean;
var
    posactual:Integer;
    valor:templeado;
    esta:boolean = false;
Begin
    posactual:= filepos(empleado);
    seek(empleado,0);
    While not eof (empleado) and not (esta) do 
        Begin
            read(empleado,valor);
            if (dato = valor.nrolegajo) then
                esta:= true;
        End;
    If (Esta = true) then
        Begin
            eliminar:= Esta;
            seek(empleado,filepos(empleado)-1);
        end
    Else
        Begin
            Writeln('el empleado no existe');
            seek(empleado,posactual);
        end;
end;

Procedure borrarEmpleado (var Archivos:Arch);
var
    legajo:Integer;
    temporal:Arch;
    dato:templeado;
    Esta:Boolean;
Begin
    Assign(temporal,'/work/SArtaza_temp.dat');
    rewrite(temporal);
    Writeln('Ingrese el numero de legajo que desea borrar: ');
    Readln(legajo);
    Esta:= eliminar(archivos,legajo);
    Reset(Archivos);
    While not eof(archivos) and (esta) do 
        Begin
            Read(Archivos,dato);        
            If (legajo <> dato.nrolegajo) then
                Write(temporal,dato);
        End; 
    if (esta) then
        begin
            rewrite(archivos);
            seek(temporal,0);
            while not eof(temporal) do
                begin
                    read(temporal,dato);
                    write(archivos,dato);
                End;
        End;
    Close(temporal);
End;

Function aceptar ():boolean;
var
    dato:char;
begin
    readln(dato);
    While (upcase(dato) <> 'S') and (upcase(dato) <> 'N') do 
        begin
            Readln(dato);
        end;
    If (upcase(dato) = 'S') then
        aceptar:= true
    Else
        aceptar:= false;
end;

Procedure modificarcampo (var archivo:Arch);
var
    Esta:boolean;
    valor:templeado;
Begin
    Read(archivo,valor);
    with valor do
        Begin
            Writeln('desea modificar nro legajo? S/N ');
            If (aceptar() = true) then
                Readln(nrolegajo);
            Writeln('desea modificar nombre y apellido? S/N ');
            If (aceptar() = true) then
                Readln(nombreYapellido);
            Writeln('desea modificar edad? S/N ');
            If (aceptar() = true) then
                Readln(edad);
            Writeln('desea modificar fecha de ingreso al trabajo? S/N ');
            Writeln('desea modificar dia de ingreso al trabajo? S/N ');
            If (aceptar() = true) then    
                Readln(fecingreso.dia);
            Writeln('desea modificar mes de ingreso al trabajo? S/N ');
            If (aceptar() = true) then    
                Readln(fecingreso.mes);
            Writeln('desea modificar año de ingreso al trabajo? S/N ');
            If (aceptar() = true) then
                Readln(fecingreso.anio);
            Writeln('desea modificar categoria? S/N ');
            If (aceptar() = true) then    
                readln(categoria);
            Writeln('desea modificar sueldo? S/N ');
            If (aceptar() = true) then    
                Readln(sueldo);
        End;
    Seek(archivo,filepos(archivo)-1);
    Write(Archivo,valor);
End;

Procedure ModificarDatos (var Archivos:Arch);
var
    Legajo:Integer;
    empleado:templeado;
    Esta:Boolean;
Begin
    seek(Archivos,0);
    Writeln('Ingrese el numero de legajo que desea modificar: ');
    Readln(legajo);
    Esta:= eliminar(archivos,legajo);
    If (esta) then 
        modificarcampo(archivos);
End;

Procedure Intercambio (var Archivos:Arch; Elem1,Elem2:integer);
var
    Aux1,Aux2:templeado;
    posI:integer;
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

Procedure ordenarporlegajos (Var Archivos:Arch);
var
    Elem1,Elem2:templeado;
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
                    If (Elem1.nrolegajo > Elem2.nrolegajo) then
                        Begin
                            Intercambio(Archivos,Filepos(Archivos)-2,Filepos(Archivos)-1);
                            Esta:= False;
                        End
                    Else
                        Seek(Archivos,Filepos(Archivos)-1);
                End;
        End;
End;

Procedure mostrarempleado (empleado:templeado);
Begin
    With empleado do 
        Begin
            Writeln('Nro legajo: ');
            Writeln(empleado.nrolegajo);
            Writeln('Nombre y apellido: ');
            writeln(empleado.nombreYapellido);
            Writeln('Edad: ');
            writeln(empleado.edad);
            Writeln('Fecha de ingreso al trabajo: ');
            writeln(empleado.fecingreso.dia,' / ',empleado.fecingreso.mes,' / ',empleado.fecingreso.anio);
            Writeln('Categoria: ');
            writeln(empleado.categoria);
            Writeln('Sueldo: ');
            writeln(empleado.sueldo);   
        End;
End;

Procedure ImprimirArchivo (var Archivos:Arch);
var
    Dato:templeado;
Begin
    Seek(Archivos,0);
    Writeln('El archivo es: ');
    While not eof(Archivos) do 
        Begin
            Read(Archivos,dato);
            mostrarempleado(dato);
        End;
End;
    
//programa principal
var
    Archivo:Arch;   
    Empleado:templeado;
    Esta:boolean;
Begin
    Assign(Archivo,ruta);
    rewrite(Archivo);
    cargaempleado(empleado,archivo,Esta);
    ImprimirArchivo(archivo);
    writeln;
    agregarempleado(archivo);
    ImprimirArchivo(archivo);
    writeln;
    borrarempleado(archivo);
    ImprimirArchivo(archivo);
    writeln;
    modificardatos(Archivo);
    ImprimirArchivo(archivo);
    ordenarporlegajos(archivo);
    imprimirArchivo(archivo);
    close(Archivo);
end.