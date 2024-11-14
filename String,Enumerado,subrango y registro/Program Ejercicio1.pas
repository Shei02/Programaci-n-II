Program Ejercicio1
Type
    tfecha = record
        Dia: 1..31;
        Mes: 1..12;
        Anio: 2000..2022;
    End;
    
Procedure cargaFecha (var Fecha:tfecha);
var
    Dia,mes,anio:Integer;
    Esta:Boolean = false;
Begin
    Writeln('Dia: ');
    Read(fecha.dia);
    While (Dia > 32) and not (esta) do 
        Begin
            Writeln('por favor ingrese otro dia: ');
            Read(Fecha.Dia);
            If (Dia < 32) then
                Esta:= True;
        End;
    Esta:= False;
    Writeln('Mes: ');
    Read(fecha.Mes);
    While (Mes > 12) and not (esta) do
        Begin
            Writeln('por favor ingrese un mes valido: ');
            Read(Fecha.mes);
            If (Mes < 12) then 
                Esta:= True;
        End;
    Esta:= False;
    Writeln('Año: ');
    Read(fecha.Anio);
    While (Anio > 2022) and not (Esta) do 
        Begin
            Writeln('por favor ingrese otro año: ');
            Read(Fecha.anio);
            If (Anio < 2022) then
                Esta:= True;
        End;
End;

Procedure sumarDias (var Fecha:tfecha);
Var
    Valor:Integer;
Begin
    Writeln('Ingrese la cantidad de dias a sumar: ');
    Readln(Valor);
    with fecha do
        Begin
            If (dia+valor > 31) then
                Begin
                    If (mes+1 <= 12) then
                        Mes+= 1
                    else
                        Begin
                            Mes:= 1;
                            anio+= 1;
                        end;
                    Dia:= (dia+valor) - 31;
                End
            Else
                dia:= dia+valor;
        end;
End;

Function diferenciaFechas(fecha:tfecha; resta:tfecha):Integer;
var
    diferencia,dia1,dia2,mes1,mes2,anio1,anio2:Integer;
Begin
    anio1:= (fecha.anio)*365;
    mes1:= (fecha.mes)*31;
    dia1:= (fecha.dia) + mes1 + anio1;
    anio2:= (resta.anio)*365;
    mes2:= (resta.mes)*31;
    dia2:= (resta.dia) + mes2 + anio2;
    diferencia:= dia1 - dia2;
    diferenciaFechas:= diferencia;
End;

procedure imprimir (var fecha:TFecha);
begin
    with fecha do
    writeln('La Fecha es: ',dia,' / ',mes,' / ',anio);
end;

Procedure fechaMenor (Fecha:tfecha; fecha2:tfecha);
var
    fechamenor,dia,mes,anio:Integer;
Begin
    If (fecha.anio < fecha2.anio) then
        Begin
            Writeln('la fecha mayor es: ');
            imprimir(fecha2);
        End
    Else
        If (fecha.anio > fecha2.anio) then
            Begin
                Writeln('la fecha mayor es: ');
                imprimir(fecha);
            End
        Else
            If (fecha.anio = fecha2.anio) then
                Begin
                    If (fecha.mes < fecha2.mes) then
                        Begin
                            Writeln('la fecha mayor es: ');
                            imprimir(fecha2);
                        End
                    Else
                        If (fecha.mes > fecha2.mes) then
                            Begin
                                Writeln('la fecha mayor es: ');
                                imprimir(fecha);
                            End
                        Else
                            If (fecha.mes = fecha2.mes) then
                                Begin
                                    If (fecha.dia < fecha2.dia) then
                                        Begin
                                            Writeln('la fecha mayor es: ');
                                            imprimir(fecha2);
                                        End
                                    else
                                        if (fecha.dia > fecha2.dia) then
                                            Begin
                                                Writeln('le fecha mayor es: ');
                                                imprimir(fecha);
                                            End
                                        Else 
                                            If (fecha.dia = fecha2.dia) then
                                                Writeln('las fechas son iguales');
                                End;
                End;
End;

//programa principal
Var
    Fecha:tfecha;
    Fecha2:tfecha;
    Dia,Mes,Anio,dif:Integer;
Begin
    cargaFecha(fecha);
    imprimir(fecha);
    cargafecha(fecha2);
    imprimir(fecha2);
    sumarDias(fecha);
    imprimir(fecha);
    dif:= diferenciaFechas(fecha,fecha2);
    Writeln('la diferencia es: ', dif);
    fechamenor(fecha,fecha2);
End.