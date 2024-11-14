program registros4
const
    ruta = '/work/Sartaza.dat';
type
    tsocios = record
        dni: longint;
        nrosocio: integer;
        nombre: string;
        apellido: string;
        anio: integer;
        end;
archsocio = file of tsocios;

procedure cargardatos(var socios:tsocios; var dni0:boolean);
begin
    writeln('dni: ');
    readln(socios.dni);
    dni0:= false;
    with socios do
        begin
            if (socios.dni = 0) then
                dni0:= true
            else
                begin
                    writeln('nro de socio: '); readln(nrosocio);
                    writeln('nombre: '); readln(nombre);
                    writeln('apellido: '); readln(apellido);
                    writeln('año: '); readln(anio);
                    writeln;
                end;
        end;
end;
procedure cargaarchivo(var archivo: archsocio);
var
    socio:tsocios;
    termina:boolean = false;
begin
    assign(archivo,ruta);
    rewrite(archivo);
    while (termina <> true) do
        begin
            cargardatos(socio,termina);
            write(archivo,socio);
            write('cargado: ');
        end;
end;
procedure mostrarregistro(socios:tsocios);
begin
    with socios do
        begin
            writeln('dni: ',dni);
            writeln('nro de socios: ',nrosocio);
            writeln('nombre: ',nombre);
            writeln('apellido: ',apellido);
            writeln('año: ',anio);
        end;
end;
procedure mostrararchivo(var archivo: archsocio);
var
    i:integer;
    reg:tsocios;
begin
    seek(archivo,0);
    writeln('maximo: ',filesize(archivo));
    i:= 0;
    while (i <= filesize(archivo)-1) do
        begin
            read(archivo,reg);
            mostrarregistro(reg);
            i+=1;
        end;
end;
procedure buscarsocio(var archivo:archsocio);
var
    dniabuscar:longint;
    reg:tsocios;
    esta:boolean= false;
begin
    write('digite un dni a buscar: '); readln(dniabuscar);
    seek(archivo,0);
    while not eof(archivo) and (not (esta))do
        begin
            read(archivo,reg);
            if (reg.dni = dniabuscar) then
                begin
                    esta:=true;
                end;
        end;
    if (esta = true)then
        mostrarregistro(reg)
    else
        writeln('no se encontro el socio: ');
    
end;
var
    archivo:archsocio;
    socios:tsocios;
    dni0:boolean;
begin
    cargaarchivo(archivo);
    writeln;
    //mostrararchivo(archivo);
    //buscarsocio(archivo);
    close(archivo);
end.