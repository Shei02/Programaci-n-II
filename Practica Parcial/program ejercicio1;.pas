program ejercicio1;

type
    PuntFactura = ^TFactura;
    TFactura = record
        nroFactura: integer;
        monto: longint;
        menor, mayor: PuntFactura;
    end;

    PuntCliente = ^TCliente;
    TCliente = record
        nroCliente: integer;
        factura: PuntFactura;
        sigCliente: PuntCliente;
        puntNum: PuntCliente;
        montoPares: longint;
    end;

procedure InsertarOrdenadoEnLista (var ClientesNivel:PuntLista; nodo:PuntLista);
begin
    if (ClientesNivel = nil) or (ClientesNivel^.montoPares > nodo^.montoPares) then begin
        if (ClientesNivel <> nil) then
            nodo^.puntNum := ClientesNivel;
        ClientesNivel := nodo;
    end else
        InsertarOrdenadoEnLista(ClientesNivel^.puntNum, nodo);
end;

procedure OrdenarMonto (var ClientesNivel:PuntClientes; clientes:PuntClientes);
begin
    if (Clientes <> nil) then begin
        InsertarOrdenadoEnLista (ClientesNivel, Clientes);
        OrdenarMonto (ClientesNivel, clientes^.sigClientes);
    end;
end;
    
function SumaNivelesPares (Factura: PuntFacturas; nivel:integer): longint;
begin
    if (Facturas <> nil) then begin
        if ((nivel mod 2) = 0) then begin
            SumaNivelesPares:= Factura^.monto + SumaNivelesPares(Factura^menor, nivel+1) + SumaNivelesPares(Factura^mayor, nivel+1);
        end else begin
            SumaNivelesPares:= SumaNivelesPares(Factura^menor, nivel+1) + SumaNivelesPares(Factura^mayor, nivel+1);
        end
    end else
        SumaNivelesPares := 0;
end;
 
 procedure ActualizarMonto (Clientes:PuntClientes);
 begin
    if (clientes <> nil) then begin
        clientes^.montoPares := SumaNivelesPares(clientes^.Facturas,0);
        ActualizarOrdenado(clientes^.sigCliente);
    end;
 end;
    
 procedure ActualizarClientesNivel (var clientesNivel:PuntCliente; clientes:PuntCliente);
 begin
    if (clientes <> nil) then begin         //Si esta vacia la lista clientes no actualizo nada
        ActualizarMonto(Clientes);
        OrdenarMonto(ClientesNivel, Clientes);
    end else
        writeln('No hay lista para actualizar');
 end;

//Programa principal
var
    Clientes: PuntCliente;
    ClientesNivel: PuntCliente;
begin
    //SE CONSIDERA QUE LAS RESPECTIVAS ESTRUCTURAS YA FUERON CARGADAS
    ActualizarClientesNivel (ClientesNivel, Clientes);
end.