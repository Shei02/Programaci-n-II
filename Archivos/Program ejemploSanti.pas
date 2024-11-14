Program ejemploSanti

const 
    ruta = '/work/prueba2.txt'; 
type
    stringfile = file of string;

var 
    archivoMensaje: stringfile;
    mensaje:string;
    i:integer;

begin
    assign(archivoMensaje, ruta);
    reset(archivoMensaje);
        for i:= 0 to filesize(archivoMensaje)-1 do
        begin
            seek(archivoMensaje, i);
            read(archivoMensaje, mensaje);
            writeln(mensaje);
        end;
    close(archivoMensaje);
end.
