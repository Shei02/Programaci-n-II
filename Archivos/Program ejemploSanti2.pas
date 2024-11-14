Program ejemploSanti2.pas

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
    read(archivoMensaje, mensaje);
    writeln(mensaje);
    close(archivoMensaje);
end.