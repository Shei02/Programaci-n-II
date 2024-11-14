program ejerciciotres;
type
    Parbol = ^Tarbol
    Tarbol = Record
        Sucursal : Sucursales;
        Sig : Parbol;
        Mayor,Menor:Parbol;
    end;
        
    Sucursales = record
        nombre : string;
        facturacion : integer;
    end;
    
    Tarchivo file of sucursales;

procedure AbrirArchivo(var Archivo : Tarchivo);
begin
    assign(archivo,'/work/promocionar.dat');
    reset(archivo);
end;

Procedure CrearNodo(var Nodo:Parbol; Sucursal:Sucursales);
begin
    new(nodo);
    nodo^.nombre := Sucursal.nombre;
    nodo^.facturacion := sucursal.facturacion;
    nodo^.Sig := nil;
    nodo^.Mayor := nil;
    nodo^.Menor := nil;
end;

{Los nodos del árbol deben tener un vínculo adicional de tal manera que las sucursales puedan ser
listadas ascendentemente por facturación mediante ese vínculo. Ese nuevo orden es accedido por un
puntero inicial ORDEN_FACTURACION}

procedure InsertarOrdenado(Nodo:Parbol; var ORDEN_FACTURACION:Parbol);
begin
    If (ORDEN_FACTURACION = nil) or (ORDEN_FACTURACION^.sucursal.facturacion >= Nodo^.sucursal.facturacion)  then
    begin
        If (ORDEN_FACTURACION <> nil) then
            Nodo^.sig := ORDEN_FACTURACION;
        ORDEN_FACTURACION := Nodo;
    end
    else
        InsertarOrdenado(Nodo,ORDEN_FACTURACION^.sig);
    //Menos mal q facilitaba las cosas lu
end;


Procedure InsertarOrdenado(Nodo:Parbol; var ARB_SUCURSALES,ORDEN_FACTURACION:Parbol);
begin
    If (ARB_SUCURSALES = Nil) then
    begin
        ARB_SUCURSALES := Nodo;
        InsertarOrdenadoPorFacturacion(Nodo,ORDEN_FACTURACION);//////////////////
    end
    else // Estoy comiendo por eso tardo// //Tarta espinaca o acelga no se q es // 
        if (ARB_SUCURSALES^.nombre > Nodo^.nombre) then
            InsertarOrdenado(Nodo,ARB_SUCURSALES^.menor,ORDEN_FACTURACION);
        else if (ARB_SUCURSALES^.nombre < Nodo^.nombre) then //Else if para controlar la igualda
            InsertarOrdenado(Nodo,ARB_SUCURSALES^.mayor,ORDEN_FACTURACION);
        else
            writeln('Somos iguales.');
            
end;

Procedure Resolver(var Archivo:Tarchivo; var ARB_SUCURSALES,ORDEN_FACTURACION:Parbol);
var
    Sucursal : Sucursales; //Registro//
    nodo:Parbol;
begin
    seek(archivo,0);
    while not eof (Archivo) do
    begin
        read(Archivo,Sucursal);
        CrearNodo(nodo,Sucursal);
        InsertarOrdenado(Nodo,ARB_SUCURSALES,ORDEN_FACTURACION);
    end;
end;
// programa principal//
var
    SucursalesDat : Tarchivo;
    ARB_SUCURSALES,ORDEN_FACTURACION: Parbol;
begin

    ARB_SUCURSALES := nil;
    ORDEN_FACTURACION := nil;
    Resolver(SucursalesDat,ORDEN_FACTURACION,ARB_SUCURSALES);
    Close(SucursalesDat);
    
end.