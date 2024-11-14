Program TrabajoFinalTelegram;
Uses sysutils,crt;
type
    nomusuario = string[8];
    tpassword = string[8];
    
    puntArbol = ^tusuario;
        tusuario = record
            nombre: nomusuario;
            password: tpassword;
            menores:puntArbol;
            mayores:puntArbol;
        end;
        
    puntLissms = ^tSms;
        tsms = record
            fechaHora: string;
            texto: String;
            Usuario: puntArbol;
            visto: boolean;
            sigmens: puntlissms;
        end;
        
    puntLisConv = ^tConversacion;
        tConversacion = record
            codConv: Integer;
            Usuario1: puntArbol;
            Usuario2: puntArbol;
            sig: puntLisConv;
            sigsms: puntLissms;
        end;

    archUsuarios = record
        nombre: nomusuario;
        password: tpassword;
    end;

    archConversaciones = record
        codConv:Integer;
        Usuario1: nomusuario;
        Usuario2: nomusuario;
    end;
    
    archMensajes = record
        codConv: integer;
        fechaHora:string;
        mensaje: String;
        Usuario: nomusuario;
        Leido: boolean;
    end;
    
    archUser = file of archusuarios;
    archConv = file of archConversaciones;
    archsms = file of archMensajes;
    
//type de la lista que se crea para mostrar los hiperconectados
    puntlisHiper = ^tlishiper;
        tlishiper = record
        usuario: nomusuario;
        cantConv: Integer;
        sig: puntlisHiper;
    end;
    
//---------------------Modulos------------------------------
//modulos generales
procedure altanodo (var nodo:puntArbol; dato:archUsuarios);
//este procedimiento da el alta de un nodo en el arbol
begin
    new(nodo);
    nodo^.nombre:= dato.nombre;
    nodo^.password:= dato.password;
    nodo^.mayores:= nil;
    nodo^.menores:= nil;
end;

procedure agregarnodoarbol (var nodo:puntarbol; nuevonodo:puntArbol);  
//agrega un nodo al arbol por orden alfabetico
begin
    if (nodo = nil) then
        nodo:= nuevonodo
    else
        if (nodo^.nombre < nuevonodo^.nombre) then
            agregarnodoarbol(nodo^.mayores,nuevonodo)
        else
            agregarnodoarbol(nodo^.menores,nuevonodo);
end;

function punterousuario (arbol:puntarbol; usuario:nomusuario):puntArbol;
begin
    if (arbol = nil) then
        punterousuario:= nil
    else
        if (usuario = arbol^.nombre) then
            punterousuario:= arbol
        else
            if (usuario > arbol^.nombre) then
                punterousuario:= punterousuario(arbol^.mayores,usuario)
            else
                punterousuario:= punterousuario(arbol^.menores,usuario);
end;

procedure crearnodoSms(var nodosms:puntLissms; dato:archmensajes; arbol:puntarbol);
//crea un nodo mensaje en la lista de mensajes
begin
    new(nodosms);
    nodosms^.fechaHora:= DateTimeToStr(Now);
    nodosms^.texto:= dato.mensaje;
    nodosms^.usuario:= punterousuario(arbol,dato.usuario);
    nodosms^.visto:= dato.leido;
    nodosms^.sigmens:= nil;
end;

procedure agregarsmsalInicio (var listasms:puntlissms; dato:archmensajes; arbol:puntarbol);
//agrega un nuevo nodo al inicio de la lista mensaje
var
    nodo:puntlissms;
begin
    crearnodoSms(nodo,dato,arbol);
    nodo^.sigmens:= listasms;
    listasms:= nodo;
end;

procedure crearnodoconv (var nodoconv:puntlisConv; usuario:puntArbol; dato:archConversaciones);
//crea un nodo en la lista conversacion
begin
    new(nodoconv);
    nodoconv^.sig:= nil;
    nodoconv^.sigsms:= nil;
    nodoconv^.codConv:= dato.codConv;
    nodoconv^.Usuario1:= punterousuario(usuario,dato.usuario1);
    nodoconv^.usuario2:= punterousuario(usuario,dato.usuario2);
end;

procedure agregaralfinal(var listaconv:puntlisconv; dato:archConversaciones; arbol:puntarbol);
begin
    if (listaconv = nil) then
        crearnodoconv(listaconv,arbol,dato)    
    else
        begin
            if (listaconv^.sig = nil) then
                dato.codconv:= listaconv^.codconv+1;
            agregaralfinal(listaconv^.sig,dato,arbol);
        end;
end;

{Procedure ImprimirBoludeces(var archUsuarios:archuser; var archConversaciones:archconv; var archMensajes:archsms);
var 
    nuevoUsuario:archusuarios;
    conver: archConversaciones;
    mensaje: ArchMensajes;
begin
    writeln('USUARIOS');
    seek(archUsuarios, 0);
    while not eof(archUsuarios) do begin
        read(archUsuarios, nuevoUsuario);
        
        writeln('----------------');
        writeln('Usuario ');
        writeln('Nombre: ', nuevoUsuario.nombre);
        writeln('Password: ', nuevoUsuario.password);
        writeln('----------------');
    end;
    
    writeln('CONVERS');
    seek(archConversaciones, 0);
    while not eof(archConversaciones) do begin
        read(archConversaciones, conver);
        
        writeln('----------------');
        writeln('Conversación ');
        writeln('Codigo: ', conver.codconv);
        writeln('Usuario 1: ', conver.usuario1);
        writeln('Usuario 2: ', conver.usuario2);
        writeln('----------------');
    end;
    
    writeln('MENSAJES');
    seek(archMensajes, 0);
    while not eof(archMensajes) do begin
        read(archMensajes, mensaje);
        
        writeln('----------------');
        writeln('Codigo de conversación: ', mensaje.codconv);
        writeln('"', mensaje.mensaje, '"');
        writeln('Enviado por: ', mensaje.usuario);
        if(mensaje.leido = true) then
            writeln('--- ✅')
        else
            writeln('--- ❎');
        writeln('----------------');
    end;
end;

procedure ImprimirListaConv (lista:puntLisConv);
        procedure ImprimirListaMensajes (lista:puntLisSMS);
            begin
                if (lista <> nil) then
                    begin
                        writeln ('fechaHora ', lista^.fechahora, ' texto ', lista^.texto, ' enviado por ', lista^.Usuario^.nombre, ' visto ', lista^.visto);
                        ImprimirListaMensajes (lista^.sigmens);
                    end;
            end;
    begin
        if (lista <> nil) then
            begin
                writeln ('Codigo conv --> ', lista^.codconv);
                writeln ('Usuario 1 --> ', lista^.usuario1^.nombre);
                writeln ('Usuario 2 --> ', lista^.usuario2^.nombre);
                ImprimirListaMensajes (lista^.sigsms);
                ImprimirListaConv (lista^.sig);
            end;
    end;

procedure ImprimirArbol (arbol:puntArbol);
begin
    if (arbol <> nil) then
        begin
            ImprimirArbol(arbol^.menores);
            writeln ('Usuario --> ', arbol^.nombre);
            writeln ('Password --> ', arbol^.Password);
            ImprimirArbol(arbol^.mayores);
        end;
end;}

//carga de estructuras con los archivos //FUNCIONA
Procedure pasarArch (var ArchUsuario:archuser; var archConversac:archconv; var archMensajes:archsms; var listaconv:puntlisConv; var arbUsuario:puntArbol);
//Este procedimiento crea el arbol usuarios con el archivo usuarios y las listas a partir de los archivos mensajes y conversaciones
    Procedure abrirArchusuario (var archUsuario:archUser);
    begin
        {$I-} //deshabilito los errores
        reset(archUsuario);                         
        {$I-} // habilita los errores
        if (ioresult <> 0) then
            rewrite(archUsuario);
    end;
    Procedure abrirArchconversacion (var archConversaciones:archconv);
    begin
        {$I-} //deshabilito los errores
        reset(archConversaciones);
        {$I-} // habilita los errores
        if (ioresult <> 0) then
            rewrite(archConversaciones);
    end;
    Procedure abrirArchmensaje (var archMensajes:archSms);
    begin
        {$I-} //deshabilito los errores
        reset(archMensajes);
        {$I-} // habilita los errores
        if (ioresult <> 0) then
            rewrite(archMensajes);
    end;
    {procedure CargarArchivo1 (var archivo:ArchUser);
    var
        info:archUsuarios;
        n:integer;
    begin
        seek(archivo, 0);
        for N:= 1 to 5 do
            begin
                writeln('Ingrese el usuario: ');
                readln(info.nombre);
                writeln('Digite su contraseña: ');
                readln(info.password);
                write(archivo,info);
            end;
    end;
    procedure CargarArchivo2(var archConversaciones:archconv);
    var
        info:archconversaciones;
        n:integer;
    begin
        seek(archConversaciones,0);
        for n:= 1 to 7 do
            begin
                writeln('Ingrese el codigo de la conversacion: ');
                readln(info.codconv);
                writeln('Ingrese el usuario1: ');
                readln(info.usuario1);
                writeln('Ingrese el otro usuario2: ');
                readln(info.usuario2);
                write(archconversaciones,info);
            end;
    end;
    procedure cargararchivo3 (var archMensajes:archsms);
    var
        info:archMensajes;
        n:integer;
    begin
        seek(archMensajes,0);
        for n:=1 to 17 do 
            begin
                writeln('Ingrese el codigo de la conversacion: ');
                readln(info.codconv);
                info.fechaHora:= DateTimeToStr(Now);
                writeln('Ingrese el mensaje: ');
                readln(info.mensaje);
                writeln('Usuario que envia el mensaje: ');
                readln(info.usuario);
                info.leido:= false;
                write(archMensajes,info);
            end;
    end;}
    Procedure crearArbol (var Arbol:puntarbol; var archUsuario:archUser);
    //crea el arbol ordenado alfabeticamente con el archivo usuarios
    var
        dato:archUsuarios;
        nodo:puntArbol;
    begin
        seek(archUsuario,0);
        while not eof(archUsuario) do 
            begin
                read(archUsuario,dato);
                altanodo(nodo,dato);
                agregarnodoarbol(arbol,nodo);
                nodo:= nil;
            end;
    end;
    procedure generarlistaconversaciones(var listaConv:puntlisconv;var archConversaciones:archconv;var archMensajes:archSms; arbol:puntarbol);
    var // generar lista conversaciones
        dato:archconversaciones;
        nodo:puntlisconv;
    begin
        seek(archConversaciones,0);
        while not eof (archConversaciones) do 
            begin
                read(archConversaciones,dato);
                agregaralfinal(listaconv,dato,arbol);
            end;
    end;
    procedure generarlistaSms (var archMensajes:archsms; listaconv:puntlisConv; arbol:puntarbol);
    //pasa el archivo mensajes a la lista mensajes que se va generando al mismo tiempo. 
    var
        dato:archMensajes;
    begin
        seek(archMensajes,0);
        while not eof (archMensajes) do 
            begin
                read(archMensajes,dato);
                if (listaconv^.codConv = dato.codConv) then
                    agregarsmsalInicio(listaconv^.sigsms,dato,arbol)
                else
                    begin
                        while (listaconv^.codconv <> dato.codconv) and (listaconv <> nil) do 
                            listaconv:= listaconv^.sig;
                        if (listaconv^.codConv = dato.codConv) then
                            agregarsmsalInicio (listaconv^.sigsms,dato,arbol);
                    end;
            end;
    end;
begin //pasar arch
    assign(archUsuario,'/work/shei_telegram.dat');
    assign(archConversac,'/work/sheii_telegram.dat');
    assign(archMensajes,'/work/sheiii_telegram.dat');
    abrirArchusuario(archUsuario);
    abrirArchconversacion(archConversac);
    abrirArchmensaje(archMensajes);
    //cargararchivo1(archusuario);
    creararbol(arbusuario,archUsuario);
    //imprimirArbol(arbUsuario);
    //cargararchivo2(archconversac);
    //cargararchivo3(archMensajes);
    //ImprimirBoludeces(archUsuario,archConversac,archMensajes);
    generarlistaconversaciones(listaConv,archConversac,archMensajes,arbusuario);
    generarlistaSms (archMensajes,listaconv,arbusuario);
    //ImprimirListaConv (listaconv);
    close(archUsuario);
    close(archMensajes);
    close(archConversac);
end;

procedure Guardar (var Archusuario:archuser; var archConversac:archconv; var archmensajes:archsms; listaconv:puntlisconv;arbol:puntarbol);  //CORRECCION: Esta bien definido, pero en el DE se lo representa dentro del menu.
    procedure guardararbolenarch (arbol:puntarbol; var archusuario:archuser);
        procedure creartipoarchuser (var archusuario:Archuser; arbol:puntarbol);
        var 
            dato:archUsuarios;
        begin
            dato.nombre:= arbol^.nombre;
            dato.password:= arbol^.password;
            write(archusuario,dato);
        end;
    begin //guardar del arbol
        if (arbol <> nil) then
            begin
                creartipoarchuser(archusuario,arbol);
                guardararbolenarch(arbol^.menores,archusuario);
                guardararbolenarch(arbol^.mayores,archusuario);
            end;
    end;
    procedure guardarconvenArch (listaconv:puntlisconv; var archConversaciones:archconv; var archMensaje:archsms);
        procedure guardarsmsenArch(listaSms:puntlissms; var archmensaje:archsms; codConv:integer);
            procedure creartiposmsArch (listasms:puntlissms; var archMensajes:archsms; codConv:integer);
            var
                datosms:archMensajes;
            begin
                datosms.codConv:= codConv;
                datosms.fechaHora:= listasms^.fechaHora;
                datosms.mensaje:= listasms^.texto;
                datosms.Usuario:= listasms^.usuario^.nombre;
                datosms.Leido:= listasms^.visto;
                write(ArchMensaje,datosms);
            end;
        //guardar lista mensajes en archivo mensajes
        begin
            If (listasms <> nil) then
                begin
                    creartiposmsArch(listasms,archMensaje,codConv);
                    guardarsmsenArch(listaSms^.sigmens,archmensaje,codConv);
                end;
        end;
        procedure creartipoconverArch(listaconv:puntlisConv; var archConversaciones:archconv);
        var
            dato:archConversaciones;
        begin
            dato.codConv:= listaconv^.codConv;
            dato.Usuario1:= listaconv^.usuario1^.nombre;
            dato.usuario2:= listaconv^.usuario2^.nombre;
            write(archConversaciones,dato);
        end;
    //guardar lista conversaciones en archivo conversaciones
    begin   
       if (listaconv <> nil) then
            begin 
                creartipoconverArch(listaConv,archConversaciones);
                guardarsmsenArch(listaconv^.sigsms,archmensaje,listaconv^.codConv);
                guardarconvenArch (listaconv^.sig,archConversaciones,archMensaje);
            end;
    end;
begin //guardar
    assign(archUsuario,'/work/shei_telegram.dat');
    assign(archConversac,'/work/sheii_telegram.dat');
    assign(archMensajes,'/work/sheiii_telegram.dat');
    Rewrite(archUsuario);
    rewrite(archConversac);
    rewrite(archMensajes);
    guardararbolenarch(arbol,archusuario);
    close(archUsuario);
    guardarconvenArch (listaconv,archConversac,archmensajes);
    close(archconversac);
    close(archmensajes);
end;

procedure proceso (var arbol:puntArbol; var listaConv:puntlisConv; var archUsuario:archuser; var archConversaciones:archconv; var archMensajes:archsms);
    procedure MenuUno (var arbol:puntArbol; var listaConv:puntlisconv; var archUsuario:archuser; var archConversaciones:archconv; var archMensajes:archsms);
        procedure validar ();
        begin
            writeln();
            writeln();
            writeln('********************* MENU *********************');
            writeln('1- Ingresar');
            writeln('2- Agregar usuario');
            writeln('3- Usuarios hiperconectados');
            writeln('4- Salir');
            writeln();
            writeln();
        end;
        procedure login (var arbol:puntArbol; var listaconv:puntlisconv);
            procedure menuDos (var arbol:puntArbol; var listaconv:puntlisConv; puntUsuario:puntArbol);
                procedure IMPRIMIR(listasms:puntlissms; usuario:nomusuario);
                begin
                    writeln ('FechaHora: ', listasms^.fechahora);
                    writeln ('Mensaje: ', listasms^.texto); 
                    writeln('Enviado por: ', usuario); 
                    writeln('Estado: ', listasms^.visto);
                end;
                function smsnoleidostotales(listasms:puntlissms; Usuario:nomUsuario):integer;
                begin
                    if (listasms <> nil) then
                        begin    
                            if (usuario <> listasms^.usuario^.nombre) then
                                begin
                                    if (listasms^.visto = true) then
                                        smsnoleidostotales:= smsnoleidostotales(listasms^.sigmens,usuario)
                                    else
                                        smsnoleidostotales:= smsnoleidostotales(listasms^.sigmens,usuario) + 1;
                                end
                            else
                                smsnoleidostotales:= smsnoleidostotales(listasms^.sigmens,usuario);
                        end
                    else
                        smsnoleidostotales:= 0;
                end;
                function cantConversaciones (listaconv:puntlisconv; usuario:nomusuario):integer;
                begin
                    if (listaconv = nil) then
                        cantConversaciones:= 0
                    else
                        if (usuario = listaconv^.usuario1^.nombre) or (usuario = listaconv^.usuario2^.nombre) then
                            cantConversaciones:= cantConversaciones(listaconv^.sig,usuario) + 1
                        else
                            cantConversaciones:= cantConversaciones(listaconv^.sig,usuario);
                end;
                function Mensnoleidos(listaconv:puntlisConv; usuario:nomusuario):integer;
                begin
                    if (listaconv <> nil) then
                        begin
                            if (usuario = listaconv^.usuario1^.nombre) or (usuario = listaconv^.usuario2^.nombre) then
                                begin
                                    if (listaconv^.sigsms <> nil) then
                                        Mensnoleidos:= smsnoleidostotales(listaconv^.sigsms, Usuario)           //CORRECCION: falta seguir la recursion, ya que el usuario puede tener mensajes no leidos de otras conversaciones.
                                    else
                                        Mensnoleidos:= Mensnoleidos(listaconv^.sig,usuario);
                                end;
                        end;
                end;
                function codigoEnlista(listaconv:puntlisconv; codConv:integer; usuario:nomusuario):puntlisConv;
                begin
                    if (listaconv <> nil) then
                        begin
                            if (listaconv^.codConv = codConv) then
                                if (usuario = listaconv^.usuario1^.nombre) or (usuario = listaconv^.usuario2^.nombre) then
                                    codigoEnlista:= listaconv
                                else
                                    codigoEnlista:= nil
                            else
                                codigoEnlista:= codigoEnlista(listaconv^.sig,codConv,usuario);
                        end;
                end;
                function mensajesnoleidos (listasms:puntlissms; usuario:nomusuario):boolean;
                begin
                    if (listasms <> nil) then
                        begin
                            if (listasms^.usuario^.nombre <> usuario) then
                                mensajesnoleidos:= listasms^.visto
                            else
                                mensajesnoleidos:= true;
                        end;
                end;
                procedure listarsmsdeconv(listasms:puntlissms; usuario:nomusuario; contador,max:Integer);
                begin //ult sms de conversacion
                    if (listasms <> nil) then
                        begin
                            if (listasms^.usuario^.nombre <> usuario) and (contador <= max) then
                                begin
                                    listarsmsdeconv(listasms^.sigmens,usuario,contador+1,max);
                                    if (listasms^.visto = false) and (contador <= max) then
                                    begin
                                        IMPRIMIR(listasms,listasms^.usuario^.nombre);
                                        listasms^.visto:= true;
                                    end
                                    else
                                        begin
                                            if (listasms^.visto = true) and (contador <= max) and (listasms^.usuario^.nombre <> usuario) then
                                                IMPRIMIR(listasms,listasms^.usuario^.nombre);
                                        end;
                                end;
                            if (listasms^.usuario^.nombre = usuario) then
                                begin
                                    listarsmsdeconv(listasms^.sigmens,usuario,contador,max);
                                    IMPRIMIR(listasms,listasms^.usuario^.nombre);
                                end;
                        end;
                end;
                procedure validar ();
                begin
                    writeln();
                    writeln();
                    writeln('********************* SUBMENU *********************');
                    writeln('1- Ver conversaciones activas');
                    writeln('2- Ver todas las conversaciones');
                    writeln('3- Ver Ultimos mensajes de una conversacion');
                    writeln('4- Ver una conversacion');
                    writeln('5- Contestar mensaje');
                    writeln('6- Iniciar conversacion');
                    writeln('7- Borrar usuario');
                    writeln('8- Logout, volver al menú principal');
                    writeln();
                    writeln();
                end;
                procedure listarconvactivas(listaconv:puntlisconv; usuario:nomusuario);
                begin
                    if (listaconv <> nil) then
                        begin
                            if (listaconv^.sigsms <> nil) and (listaconv^.sigsms^.visto = false) then
                                begin
                                    if (usuario = listaconv^.usuario1^.nombre) then
                                        begin
                                            writeln('La cantidad de mensajes no leidos es: ',(smsnoleidostotales(listaconv^.sigsms,Usuario)));
                                            write('El usuario con el que chatea es: ');
                                            writeln(listaconv^.usuario2^.nombre);
                                            write('El codigo de la conversacion es: ');
                                            writeln(listaconv^.codConv);
                                        end;
                                    if (usuario = listaconv^.usuario2^.nombre) then
                                        begin
                                            writeln('La cantidad de mensajes no leidos es: ',(smsnoleidostotales(listaconv^.sigsms,Usuario)));
                                            write('El usuario con el que chatea es: ');
                                            writeln(listaconv^.usuario1^.nombre);
                                            write('El codigo de la conversacion es: ');
                                            writeln(listaconv^.codConv);
                                        end;
                                end;
                            listarconvactivas(listaconv^.sig,usuario);
                        end;
                end;
                procedure convdelusuario (listaConv:puntlisConv; usuario:nomusuario);
                begin
                    if (listaconv <> nil) then
                        begin
                            if (listaconv^.usuario1^.nombre = usuario) then
                                begin
                                    writeln('El codigo de esta conversacion es: ', listaconv^.codConv);
                                    writeln('Usuario logueado: ', usuario);
                                    writeln('El otro usuario de esta conversacion es: ', listaconv^.usuario2^.nombre);
                                end;
                            if (listaconv^.usuario2^.nombre = usuario) then
                                begin
                                    writeln('El codigo de esta conversacion es: ', listaconv^.codConv);
                                    writeln('Usuario logueado: ', Usuario);
                                    writeln('El otro usuario de esta conversacion es: ', listaconv^.usuario1^.nombre);
                                end;
                            convdelusuario(listaconv^.sig,usuario);
                        end;
                end;
                procedure ultimossms (listaconv:puntlisconv; usuario:nomusuario);    
                var //ultimosms
                    codigo:integer;
                    conversacion:puntlisconv;
                begin
                    writeln('Ingrese el codigo de la conversacion que desea ver los mensajes: ');
                    readln(codigo);
                    conversacion:= codigoEnlista(listaconv,codigo,usuario);
                    if (conversacion = nil) then
                        writeln('El codigo no existe')
                    else
                        listarsmsdeconv(conversacion^.sigsms,usuario,1,10); //1 = contador          //CORRECCION: lo mejor aca seria definir constantes.
                end;
                procedure mostrarconversacion(listaconv:puntlisconv; usuario:nomusuario);
                    procedure ImprimirListaMensajes (listasms:puntLissms; usuario:nomusuario);
                    begin
                        if (listasms <> nil) then
                            begin
                                if (usuario <> listasms^.usuario^.nombre) then
                                    begin
                                        if (listasms^.visto = false) then
                                            listasms^.visto:= true;
                                    end;
                                writeln('fechaHora: ', listasms^.fechahora);
                                writeln('Mensaje: ', listasms^.texto); 
                                writeln('Enviado por: ', listasms^.Usuario^.nombre);
                                writeln('Estado: ', listasms^.visto);
                                ImprimirListaMensajes (listasms^.sigmens,usuario);
                            end
                        else
                            writeln('Se termino la conversacion');
                    end;
                var //mostrar conversacion
                    codigo:integer;
                    conversacion:puntlisconv;
                begin
                    writeln('Ingrese el codigo de la conversacion que desea ver: ');
                    readln(codigo);
                    conversacion:= codigoEnlista(listaconv,codigo,usuario);
                    if (conversacion <> nil) then
                        begin
                            if (conversacion^.usuario1 <> nil) and (conversacion^.usuario2 <> nil) then
                                begin
                                    if (conversacion^.usuario1^.nombre = usuario) or (conversacion^.usuario2^.nombre = usuario) then
                                        ImprimirListaMensajes (conversacion^.sigsms,usuario)
                                    else
                                        writeln('No pertenece a esta conversacion');
                                end;
                        end
                    else
                        writeln('No existe la conversacion');
                end;
                procedure contestarsms (listaconv:puntlisconv; codigo:integer; usuario:nomusuario);
                    procedure crearnodomensj(var nodosms:puntLissms; fechaHora,sms,usuario:string; arbol:puntarbol);
                    //crea un nodo mensaje en la lista de mensajes
                    begin
                        new(nodosms);
                        nodosms^.fechaHora:= fechaHora;
                        nodosms^.texto:= sms;
                        nodosms^.usuario:= punterousuario(arbol,usuario);
                        nodosms^.visto:= false;
                        nodosms^.sigmens:= nil;
                    end;
                var //contestar sms
                    puntconv:puntlisconv;
                    dato:archmensajes;
                    mensaje:puntlissms;
                    mens,fecha:string;
                begin
                    Writeln('Ingrese el codigo de la conversacion, porfavor: ');
                    readln(codigo);
                    puntconv:= codigoEnlista(listaconv,codigo,usuario);
                    if (puntconv <> nil) then
                        begin
                            if (puntconv^.usuario1^.nombre = usuario) or (puntconv^.usuario2^.nombre = usuario) then 
                                begin
                                    listarsmsdeconv(listaconv^.sigsms,usuario,1,5);
                                    write('Contestar: ');
                                    readln(mens);
                                    fecha:= DateTimeToStr(Now);
                                    crearnodomensj(mensaje,fecha,mens,usuario,arbol);
                                    mensaje^.sigmens:= puntconv^.sigsms;
                                    puntconv^.sigsms:= mensaje;
                                end
                            else
                                writeln('No puede contestar esta conversacion, no pertenece');
                        end;
                end;
                procedure nuevaconversacion(var listaconv:puntlisconv; arbol:puntarbol; usuario:puntarbol);
                    function estaenconversacion(listaconv:puntlisconv; usuario1,usuario2:nomusuario):puntlisconv;
                    //devuelve el puntero de donde esta dicha connversacion o nil en caso de no estar 
                    begin
                        if (listaconv <> nil) then
                            begin
                                if (listaconv^.usuario1^.nombre = usuario1) and (listaconv^.usuario2^.nombre = usuario2) then
                                    estaenconversacion:= listaconv
                                else
                                    if (listaconv^.usuario2^.nombre = usuario1) and (listaconv^.usuario1^.nombre = usuario2) then
                                        estaenconversacion:= listaconv
                                    else
                                        estaenconversacion:= estaenconversacion(listaconv^.sig,usuario1,usuario2);
                            end
                        else
                            estaenconversacion:= nil;
                    end;
                var //nueva conversacion
                    nombre:puntArbol;
                    conv:puntlisconv;
                    destinatario:nomusuario;
                    dato:archconversaciones;
                    codigo:integer;
                begin
                    writeln('Ingrese el nombre del usuario al que desea escribirle: ');
                    readln(destinatario);
                    dato.usuario2:= destinatario;
                    dato.usuario1:= usuario^.nombre;
                    nombre:= punterousuario(arbol,destinatario);
                    if (nombre <> nil) then
                        begin
                            conv:= estaenconversacion(listaconv,usuario^.nombre, destinatario);
                            if (conv = nil) then
                                agregaralfinal(listaconv,dato,arbol)
                            else
                                writeln('El usuario ya esta chateando con esta persona');
                        end
                    else
                        writeln('El usuario no existe');
                end;
                procedure borrarusuario (var listaconv:puntlisconv; var arbol:puntArbol; usuario:nomusuario);
                    function buscarUsuario (listaconv:puntlisconv; usuario:nomusuario):boolean;
                    var
                        aEliminar:boolean;
                    begin
                        if (listaconv <> nil) then
                            begin
                                if (listaconv^.usuario1^.nombre = usuario) or (listaconv^.usuario2^.nombre = usuario) then
                                    begin
                                        aEliminar:= mensajesnoleidos(listaconv^.sigsms,usuario);
                                        if (aEliminar = false) then
                                            buscarUsuario:= false
                                        else
                                            buscarUsuario:= buscarUsuario(listaconv^.sig,usuario);
                                    end
                                else
                                    buscarUsuario:= buscarUsuario(listaconv^.sig,usuario);
                            end
                        else
                            buscarUsuario:= aEliminar;
                    end;
                    procedure borrarconversaciones (var listaconv:puntlisconv; usuario:nomusuario);
                        procedure borrarsms(var listasms:puntlissms; usuario:nomusuario);
                        begin
                            If (listasms <> nil) then
                                begin
                                    borrarsms(listasms^.sigmens,usuario);
                                    dispose(listasms);
                                end;
                        end;
                    begin //borrar conversaciones
                        if (listaconv <> nil) then
                            begin
                                borrarconversaciones(listaconv^.sig,usuario);
                                if (listaconv^.usuario1^.nombre = usuario) or (listaconv^.usuario2^.nombre = usuario) then
                                    //dar de baja el nodo
                                    begin
                                        borrarsms(listaconv^.sigsms,usuario);
                                        dispose(listaconv);
                                    end;
                            end;
                    end;
                    procedure bajanodoArbol(var arbol:puntArbol; usuario:nomusuario);
                        procedure borrarnodo(var aBorrar:puntArbol);
                            procedure reemplazarnodo(var nodo:puntArbol; var puntero:puntArbol);
                            //busco el mayor de los menores
                            begin
                                if (nodo^.mayores = nil) then
                                    begin
                                        puntero:= nodo;
                                        nodo:= nodo^.menores;
                                    end
                                else
                                    reemplazarnodo(nodo^.mayores,puntero);
                            end;
                        var //borrarnodo
                            reemplazo:puntArbol;
                        begin
                            if (aBorrar^.mayores <> nil) and (aBorrar^.menores <> nil) then
                                begin
                                    //consigo el nodo reemplazo, desvinculado
                                    reemplazarnodo(aBorrar^.menores,reemplazo);
                                    reemplazo^.menores:= aBorrar^.menores;
                                    reemplazo^.mayores:= aBorrar^.mayores;
                                    //si es una hoja entra a las dos condiciones
                                    //y reemplazo si = nil
                                end
                            else
                                if (aBorrar^.menores = nil) then
                                    reemplazo:= aBorrar^.mayores
                                else
                                    reemplazo:= aBorrar^.menores;
                            dispose(aBorrar);
                            aBorrar:= reemplazo;
                        end;
                    begin //baja nodo arbol
                        if (arbol <> nil) then
                            begin
                                if (usuario = arbol^.nombre) then
                                    borrarnodo(arbol)
                                else
                                    if (usuario > arbol^.nombre) then
                                        bajanodoArbol(arbol^.mayores,usuario)
                                    else
                                        bajanodoArbol(arbol^.menores,usuario);
                            end;
                    end;
                var //borrar usuario
                    opciones:integer;
                begin
                    //ImprimirArbol (arbol);
                    if (buscarUsuario(listaconv,usuario)) then
                        begin
                            borrarconversaciones(listaconv,usuario);
                            bajanodoarbol(arbol,usuario);
                            writeln();
                            //ImprimirArbol (arbol);
                        end
                    else
                        writeln('No es posible borrar el usuario');
                end;
            var //menu dos
                opcion,codigo:integer;
            begin
                opcion:= 0;
                Writeln('Bienvenido: ', puntUsuario^.nombre);
                writeln('Tienes ',  Mensnoleidos(listaconv, puntUsuario^.nombre), ' mensajes no leidos');
                writeln('Participas de ', cantConversaciones (listaconv, puntUsuario^.nombre ), ' conversaciones');
                writeln();
                while (opcion <> 8) do
                begin
                    validar();
                    writeln('Ingrese una opcion por favor: ');
                    readln(opcion);
                    while (opcion <> 1) and (opcion <> 2) and (opcion <> 3) and (opcion <> 4) and (opcion <> 5) and (opcion <> 6) and (opcion <> 7) and (opcion <> 8) do 
                        begin
                            writeln('Por favor ingrese una opcion correcta: ');
                            readln(opcion);
                        end;
                    case opcion of 
                        1: listarconvactivas(listaconv,puntusuario^.nombre); //funciona
                        2: convdelusuario(listaconv,puntusuario^.nombre); //funciona
                        3: ultimossms(listaconv,puntusuario^.nombre); //funciona
                        4: mostrarconversacion(listaconv,puntusuario^.nombre); //funciona
                        5: contestarsms(listaconv,codigo,puntusuario^.nombre); //funciona
                        6: nuevaconversacion(listaconv,arbol,puntUsuario); //funciona
                        7: borrarusuario(listaConv,arbol,puntUsuario^.nombre); //funciona
                        8: MenuUno(arbol,listaConv,archUsuario,archConversaciones,Archmensajes); //funciona
                    end;
                end;
            end;
        var// login //funciona
            nombre:nomusuario;
            password:tpassword;
            puntero:puntArbol;
        begin
            writeln();
            writeln('************************ACCEDIENDO A LOGIN************************');
            write('Ingrese el nombre de usuario: ');
            readln(nombre);
            write('Digite su contrasenia: ');
            readln(password);
            puntero:= punterousuario(arbol,nombre);
            if (puntero = nil) then 
               writeln('Usuario y/o contrasenia incorrectos')
            else
                begin
                    if (password = puntero^.password) then
                        begin
                            writeln('Usuario encontrado con exito');
                            menudos(arbol,listaconv,punterousuario(arbol,nombre));
                        end
                    else
                        writeln('No se encontro el usuario logeado');
                end;
        end;
        procedure agregarUsuario (var arbol:puntArbol); //funciona
        var //agregar usuario (invoco a alta nodo y a la funcion de buscar si el usuario existo o no)
            nuevonodo:puntArbol;
            dato:archUsuarios;
            i:integer;
        begin
            writeln('ingrese el nuevo usuario: ');
            readln(dato.nombre);
            writeln('Digite su contraseña: ');
            readln(dato.password);
            if (punterousuario(arbol,dato.nombre) = nil) then
                begin
                    altanodo(nuevonodo,dato);
                    agregarnodoarbol(arbol,nuevonodo);
                end
            else
                writeln('El usuario ya existe');
        end;
        procedure mostrarusuarioHiperconectado(listaconv:puntlisConv);
        //debo verificar si el usuario no esta cargado en la listaHiperconectada
        //si esta, debo verificar nuevamente y no hago nada 
        //si no esta, debo buscar en toda la lista conversaciones en cuantas aparece el usuario, y lo guardo en la listaHiperconectados con el nombre de usuario y la suma de las conversaciones
            procedure crearlistaconectados(var listaHiperconectada:puntlisHiper; listaconv:puntlisConv);
                function punterousuario (listaHiperconectada:puntlisHiper; usuario:nomusuario):puntlisHiper;
                begin
                    if (listaHiperconectada = nil) then
                        punterousuario:= nil
                    else
                        if (usuario = listaHiperconectada^.usuario) then
                            punterousuario:= listaHiperconectada
                        else
                            punterousuario:= punterousuario(listaHiperconectada^.sig,usuario);
                end;
                function anteriorconectada(listaHiperconectada:puntlisHiper; nombre:nomusuario):puntlisHiper;
                begin
                    if (listaHiperconectada <> nil) and (listaHiperconectada^.usuario = nombre) then
                        anteriorconectada:= nil
                    else
                        if (listaHiperconectada^.sig <> nil) then
                            begin
                                if (listaHiperconectada^.sig^.usuario <> nombre) then
                                    anteriorconectada:= anteriorconectada(listaHiperconectada^.sig,nombre)
                                else
                                    anteriorconectada:= listaHiperconectada;
                            end
                        else
                            anteriorconectada:= nil;
                end;
                procedure Crearusuarios(var listaHiperconectada:puntlisHiper; usuario:puntlisHiper; nombre:nomusuario);
                    procedure crearnodo(var nodo:puntlisHiper; Usuario:nomusuario);
                    begin
                        new(nodo);
                        nodo^.usuario:= usuario;
                        nodo^.cantConv:= 1;
                        nodo^.sig:= nil;
                    end;
                    Procedure insertardesendentemente(var listaHiperconectada:puntlisHiper; nodoNuevo:puntlisHiper);
                    begin
                        if (listaHiperconectada = nil) or (nodoNuevo^.cantConv > listaHiperconectada^.cantConv) then
                            begin
                                nodonuevo^.sig:= listaHiperconectada;
                                listaHiperconectada:= nodoNuevo;
                            end
                        else
                            insertardesendentemente(listaHiperconectada^.sig,nodoNuevo);
                    end;
                    procedure desvincular (var listaHiperconectada:puntlisHiper; usuario:puntlisHiper; anterior:puntlisHiper);
                    begin
                        if (listaHiperconectada <> nil) then
                            begin
                                if(anterior = nil) then
                                    listaHiperconectada:= listaHiperconectada^.sig
                                else
                                    anterior^.sig:= usuario^.sig;
                                usuario^.sig:= nil;
                            end;
                    end;
                begin
                    if (usuario = nil) then
                        begin
                            crearnodo(usuario,nombre);
                            insertardesendentemente(listaHiperconectada,usuario);
                        end
                    else
                        begin
                            desvincular(listaHiperconectada,usuario,anteriorconectada(listaHiperconectada,nombre));
                            usuario^.cantConv:= usuario^.cantConv + 1;
                            insertardesendentemente(listaHiperconectada,usuario);
                        end;
                end;
            var //crear lista conectados
                usuario:puntlisHiper;
            begin
                if (listaConv <> nil) then
                    begin
                        usuario:= punterousuario(listaHiperconectada,listaconv^.usuario1^.nombre);
                        crearusuarios(listaHiperconectada,usuario,listaconv^.usuario1^.nombre);
                        usuario:= punterousuario(listaHiperconectada,listaconv^.usuario2^.nombre);
                        crearusuarios(listaHiperconectada,usuario,listaconv^.usuario2^.nombre);
                        crearlistaconectados(listaHiperconectada,listaconv^.sig);
                    end;
            end;
            procedure mostrarlista(listaHiperconectada:puntlisHiper);
            begin
                if (listaHiperconectada <> nil) then
                    begin
                        writeln(listaHiperconectada^.usuario);
                        writeln(listaHiperconectada^.cantConv);
                        mostrarlista(listaHiperconectada^.sig);
                    end;
            end;
            procedure borrarlista(var listaHiperconectada:puntlisHiper);
            var
                aEliminar:puntlisHiper;
            begin
                if (listaHiperconectada <> nil) then
                    begin
                        if (listaHiperconectada <> nil) then
                            borrarlista(listaHiperconectada^.sig);
                        if (listaHiperconectada^.sig = nil) then
                            begin
                                aEliminar:= listaHiperconectada;
                                listaHiperconectada:= nil;
                                dispose(aEliminar);
                                aEliminar:= nil;
                            end
                    end;
            end;
        var //mostrar usuario hiperconectado
            listaHiper:puntlisHiper;
        begin
            listaHiper:= nil;
            crearlistaconectados(listaHiper,listaconv);
            Writeln('La lista hiperconectados es: ');
            mostrarlista(listaHiper);
            borrarlista(listaHiper);
        end;
    var
        opcion:integer;
    begin //menu 1
        opcion:= 0;
        while (opcion <> 4) do
        begin
            validar();
            writeln('Ingrese una opcion por favor: ');
            readln(opcion);
            while (opcion <> 1) and (opcion <> 2) and (opcion <> 3) and (opcion <> 4) do 
                begin
                    writeln('Por favor ingrese una opcion correcta: ');
                    readln(opcion);
                end;
            case opcion of 
                1: login(arbol,listaconv); //funciona
                2: agregarusuario(arbol); //funciona
                3: mostrarusuariohiperconectado(listaconv); //funciona
                4: guardar(archusuario,archconversaciones,archMensajes,listaconv,arbol); //funciona
            end;
        end;
    end;
begin //proceso
    MenuUno(arbol,listaConv,archusuario,archconversaciones,archMensajes);
end;

//programa Principal
var
    archUsuario:archUser;
    archConversac:archConv;
    archMensaje:archSms;
    listaconv:puntlisConv;
    arbUsuario:puntarbol;
begin
    arbUsuario:= nil;
    listaconv:= nil;
    pasarArch(ArchUsuario,archConversac,archMensaje,listaconv,arbUsuario);
    proceso(arbUsuario,listaconv,archUsuario,archConversac,ArchMensaje);
end.