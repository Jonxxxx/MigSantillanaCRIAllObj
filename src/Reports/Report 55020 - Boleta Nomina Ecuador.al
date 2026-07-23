report 55020 "Boleta Nomina Ecuador"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Boleta Nomina Ecuador.rdlc';
    Permissions = TableData 34002117 = rimd,
                  TableData 34002118 = rimd;

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = "No. empleado", "Tipo de nomina", "Período";
            column(Historico_Cab__nomina_No__empleado; "No. empleado")
            {
            }
            column(Historico_Cab__nomina_Ano; Ano)
            {
            }
            column(Historico_Cab__nomina_Per_odo; Período)
            {
            }
            column(Historico_Cab__nomina_Tipo_Nomina; "Tipo Nomina")
            {
            }
            dataitem("Historico Lin. nomina"; 34002118)
            {
                DataItemLink = "No. empleado" = FIELD("No. empleado"),
                               Tipo Nómina=FIELD("Tipo Nomina"),
                               Período=FIELD(Período);
                DataItemTableView = SORTING("No. empleado","Tipo Nómina",Período,"No. Orden")
                                    WHERE("Texto Informativo"=CONST(False));
                column("Histórico_Lín__nómina__No__empleado_";"No. empleado")
                {
                }
                column("Histórico_Cab__nómina__Nombre";"Historico Cab. nomina".Nombre)
                {
                }
                column(txtDesc;txtDesc)
                {
                }
                column(TODAY;TODAY)
                {
                }
                column(TIME;TIME)
                {
                }
                column("Histórico_Cab__nómina__Inicio";"Historico Cab. nomina".Inicio)
                {
                }
                column("Histórico_Cab__nómina__Fin";"Historico Cab. nomina".Fin)
                {
                }
                column(TotIng___TotDed;TotIng + TotDed)
                {
                }
                column("Histórico_Cab__nómina__Cuenta";"Historico Cab. nomina".Cuenta)
                {
                }
                column(rEmpresa_Picture;rEmpresa.Picture)
                {
                }
                column(txttextoInf;TextoInformativo)
                {
                }
                column(DescDeducc_1_;DescDeducc[1])
                {
                }
                column(DescDeducc_2_;DescDeducc[2])
                {
                }
                column(DescDeducc_3_;DescDeducc[3])
                {
                }
                column(DescDeducc_4_;DescDeducc[4])
                {
                }
                column(DescDeducc_5_;DescDeducc[5])
                {
                }
                column(DescDeducc_6_;DescDeducc[6])
                {
                }
                column(DescDeducc_7_;DescDeducc[7])
                {
                }
                column(DescDeducc_8_;DescDeducc[8])
                {
                }
                column(DescDeducc_9_;DescDeducc[9])
                {
                }
                column(DescIngreso_1_;DescIngreso[1])
                {
                }
                column(DescIngreso_2_;DescIngreso[2])
                {
                }
                column(DescIngreso_3_;DescIngreso[3])
                {
                }
                column(DescIngreso_4_;DescIngreso[4])
                {
                }
                column(DescIngreso_5_;DescIngreso[5])
                {
                }
                column(DescIngreso_6_;DescIngreso[6])
                {
                }
                column(DescIngreso_7_;DescIngreso[7])
                {
                }
                column(DescIngreso_8_;DescIngreso[8])
                {
                }
                column(DescIngreso_9_;DescIngreso[9])
                {
                }
                column(DescIngreso_10_;DescIngreso[10])
                {
                }
                column(DescDeducc_10_;DescDeducc[10])
                {
                }
                column(Horas_1_;Horas[1])
                {
                    AutoFormatType = 1;
                }
                column(Horas_2_;Horas[2])
                {
                    AutoFormatType = 1;
                }
                column(Horas_3_;Horas[3])
                {
                    AutoFormatType = 1;
                }
                column(Horas_4_;Horas[4])
                {
                    AutoFormatType = 1;
                }
                column(Horas_5_;Horas[5])
                {
                    AutoFormatType = 1;
                }
                column(Horas_6_;Horas[6])
                {
                    AutoFormatType = 1;
                }
                column(Horas_7_;Horas[7])
                {
                    AutoFormatType = 1;
                }
                column(Horas_8_;Horas[8])
                {
                    AutoFormatType = 1;
                }
                column(Horas_9_;Horas[9])
                {
                    AutoFormatType = 1;
                }
                column(Horas_10_;Horas[10])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_1_;ImportIngreso[1])
                {
                    AutoFormatType = 1;
                    DecimalPlaces = 0:2;
                }
                column(ImportIngreso_2_;ImportIngreso[2])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_3_;ImportIngreso[3])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_4_;ImportIngreso[4])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_5_;ImportIngreso[5])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_6_;ImportIngreso[6])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_7_;ImportIngreso[7])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_8_;ImportIngreso[8])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_9_;ImportIngreso[9])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_10_;ImportIngreso[10])
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_1__;ABS(ImportEgreso[1]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_2__;ABS(ImportEgreso[2]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_3__;ABS(ImportEgreso[3]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_4__;ABS(ImportEgreso[4]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_5__;ABS(ImportEgreso[5]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_6__;ABS(ImportEgreso[6]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_7__;ABS(ImportEgreso[7]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_8__;ABS(ImportEgreso[8]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_9__;ABS(ImportEgreso[9]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_10__;ABS(ImportEgreso[10]))
                {
                    AutoFormatType = 1;
                }
                column(ImporteIngresoTotal;ImporteIngresoTotal)
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgresoTotal_;ABS(ImportEgresoTotal))
                {
                    AutoFormatType = 1;
                }
                column("Histórico_Lín__nómina__No__empleado_Caption";FIELDCAPTION("No. empleado"))
                {
                }
                column("Histórico_Cab__nómina__NombreCaption";Histórico_Cab__nómina__NombreCaptionLbl)
                {
                }
                column(txtDescCaption;txtDescCaptionLbl)
                {
                }
                column(TODAYCaption;TODAYCaptionLbl)
                {
                }
                column(TIMECaption;TIMECaptionLbl)
                {
                }
                column("Recibo_de_nómina_períodoCaption";Recibo_de_nómina_períodoCaptionLbl)
                {
                }
                column(alCaption;alCaptionLbl)
                {
                }
                column(TotIng___TotDedCaption;TotIng___TotDedCaptionLbl)
                {
                }
                column("Histórico_Cab__nómina__CuentaCaption";Histórico_Cab__nómina__CuentaCaptionLbl)
                {
                }
                column(V1Caption;V1CaptionLbl)
                {
                }
                column(DescuentosCaption;DescuentosCaptionLbl)
                {
                }
                column(IngresosCaption;IngresosCaptionLbl)
                {
                }
                column("DescripciónCaption";DescripciónCaptionLbl)
                {
                }
                column(HorasCaption;HorasCaptionLbl)
                {
                }
                column(ValorCaption;ValorCaptionLbl)
                {
                }
                column(ValorCaption_Control41;ValorCaption_Control41Lbl)
                {
                }
                column("DescripciónCaption_Control43";DescripciónCaption_Control43Lbl)
                {
                }
                column(Total_ingresosCaption;Total_ingresosCaptionLbl)
                {
                }
                column(Total_deduccionesCaption;Total_deduccionesCaptionLbl)
                {
                }
                column(Agree_with_ReceiveCaption;Agree_with_ReceiveCaptionLbl)
                {
                }
                column("Historico_Lin__nomina_Tipo_Nómina";"Tipo Nómina")
                {
                }
                column("Historico_Lin__nomina_Período";Período)
                {
                }
                column(Historico_Lin__nomina_No__Orden;"No. Orden")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Tipo concepto" = "Tipo concepto"::Ingresos THEN
                       BEGIN
                        i += 1;
                        DescIngreso[i]:= Descripción;
                        Horas[i]:= Cantidad;
                        ImportIngreso[i]:= Total;
                        ImporteIngresoTotal+= ImportIngreso[i];
                       END
                    ELSE
                       BEGIN
                        id += 1;
                        DescDeducc[id]:= Descripción;
                        Cant[id]:= Cantidad;
                        ImportEgreso[id]:= Total;
                        ImportEgresoTotal+= ImportEgreso[id];
                       END;
                end;

                trigger OnPreDataItem()
                begin

                    FOR i:= 1 TO 10 DO
                     BEGIN
                      DescIngreso[i]:= '';
                      Horas[i]:= 0;
                      ImportIngreso[i]:= 0;
                     END;
                    FOR id:= 1 TO 10 DO
                     BEGIN
                      DescDeducc[i]:= '';
                      Cant[i]:= 0;
                      ImportEgreso[i]:= 0;
                     END;
                    i:= 0;
                    id:= 0;
                end;
            }
            dataitem(HLN;34002118)
            {
                DataItemLink = "No. empleado"=FIELD("No. empleado"),
                               Tipo Nómina=FIELD("Tipo Nomina"),
                               Período=FIELD(Período);
                DataItemTableView = SORTING("No. empleado","Tipo Nómina",Período,"No. Orden")
                                    WHERE("Texto Informativo"=CONST(False));
                column("Histórico_Lín__nómina__No__empleado2_";"No. empleado")
                {
                }
                column("Histórico_Cab__nómina__Nombre2";"Historico Cab. nomina".Nombre)
                {
                }
                column(txtDesc2;txtDesc)
                {
                }
                column(TODAY_2;TODAY)
                {
                }
                column(TIME_2;TIME)
                {
                }
                column("Histórico_Cab__nómina__Inicio2";"Historico Cab. nomina".Inicio)
                {
                }
                column("Histórico_Cab__nómina__Fin2";"Historico Cab. nomina".Fin)
                {
                }
                column(TotIng2___TotDed;TotIng + TotDed)
                {
                    AutoFormatType = 1;
                }
                column("Histórico_Cab__nómina2__Cuenta";"Historico Cab. nomina".Cuenta)
                {
                }
                column(rEmpresa2_Picture;rEmpresa.Picture)
                {
                }
                column(txttextoInf2;TextoInformativo)
                {
                }
                column(DescDeducc_1_2;DescDeducc[1])
                {
                }
                column(DescDeducc_2_2;DescDeducc[2])
                {
                }
                column(DescDeducc_3_2;DescDeducc[3])
                {
                }
                column(DescDeducc_4_2;DescDeducc[4])
                {
                }
                column(DescDeducc_5_2;DescDeducc[5])
                {
                }
                column(DescDeducc_6_2;DescDeducc[6])
                {
                }
                column(DescDeducc_7_2;DescDeducc[7])
                {
                }
                column(DescDeducc_8_2;DescDeducc[8])
                {
                }
                column(DescDeducc_9_2;DescDeducc[9])
                {
                }
                column(DescIngreso_1_2;DescIngreso[1])
                {
                }
                column(DescIngreso_2_2;DescIngreso[2])
                {
                }
                column(DescIngreso_3_2;DescIngreso[3])
                {
                }
                column(DescIngreso_4_2;DescIngreso[4])
                {
                }
                column(DescIngreso_5_2;DescIngreso[5])
                {
                }
                column(DescIngreso_6_2;DescIngreso[6])
                {
                }
                column(DescIngreso_7_2;DescIngreso[7])
                {
                }
                column(DescIngreso_8_2;DescIngreso[8])
                {
                }
                column(DescIngreso_9_2;DescIngreso[9])
                {
                }
                column(DescIngreso_10_2;DescIngreso[10])
                {
                }
                column(DescDeducc_10_2;DescDeducc[10])
                {
                }
                column(Horas_1_2;Horas[1])
                {
                    AutoFormatType = 1;
                }
                column(Horas_2_2;Horas[2])
                {
                    AutoFormatType = 1;
                }
                column(Horas_3_2;Horas[3])
                {
                    AutoFormatType = 1;
                }
                column(Horas_4_2;Horas[4])
                {
                    AutoFormatType = 1;
                }
                column(Horas_5_2;Horas[5])
                {
                    AutoFormatType = 1;
                }
                column(Horas_6_2;Horas[6])
                {
                    AutoFormatType = 1;
                }
                column(Horas_7_2;Horas[7])
                {
                    AutoFormatType = 1;
                }
                column(Horas_8_2;Horas[8])
                {
                    AutoFormatType = 1;
                }
                column(Horas_9_2;Horas[9])
                {
                    AutoFormatType = 1;
                }
                column(Horas_10_2;Horas[10])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_1_2;ImportIngreso[1])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_2_2;ImportIngreso[2])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_3_2;ImportIngreso[3])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_4_2;ImportIngreso[4])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_5_2;ImportIngreso[5])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_6_2;ImportIngreso[6])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_7_2;ImportIngreso[7])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_8_2;ImportIngreso[8])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_9_2;ImportIngreso[9])
                {
                    AutoFormatType = 1;
                }
                column(ImportIngreso_10_2;ImportIngreso[10])
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_12__;ABS(ImportEgreso[1]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_22__;ABS(ImportEgreso[2]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_32__;ABS(ImportEgreso[3]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_42__;ABS(ImportEgreso[4]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_52__;ABS(ImportEgreso[5]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_62__;ABS(ImportEgreso[6]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_72__;ABS(ImportEgreso[7]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_82__;ABS(ImportEgreso[8]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_92__;ABS(ImportEgreso[9]))
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgreso_120__;ABS(ImportEgreso[10]))
                {
                    AutoFormatType = 1;
                }
                column(ImporteIngresoTotal2;ImporteIngresoTotal)
                {
                    AutoFormatType = 1;
                }
                column(ABS_ImportEgresoTotal2_;ABS(ImportEgresoTotal))
                {
                    AutoFormatType = 1;
                }
                column("Histórico_Lín__nómina__No__empleado2_Caption";FIELDCAPTION("No. empleado"))
                {
                }
                column("Histórico_Cab__nómina__Nombre2_Caption";Histórico_Cab__nómina__Nombre2_CaptionLbl)
                {
                }
                column(txtDescCaption2;txtDescCaption2Lbl)
                {
                }
                column(TODAY_2_Caption;TODAY_2_CaptionLbl)
                {
                }
                column(TIME_2_Caption;TIME_2_CaptionLbl)
                {
                }
                column("Recibo_de_nómina_período2Caption";Recibo_de_nómina_período2CaptionLbl)
                {
                }
                column(al2Caption;al2CaptionLbl)
                {
                }
                column(TotIng2___TotDedCaption;TotIng2___TotDedCaptionLbl)
                {
                }
                column("Histórico_Cab__nómina2__CuentaCaption";Histórico_Cab__nómina2__CuentaCaptionLbl)
                {
                }
                column(V2Caption;V2CaptionLbl)
                {
                }
                column(Descuentos2_Caption;Descuentos2_CaptionLbl)
                {
                }
                column(Ingresos2_Caption;Ingresos2_CaptionLbl)
                {
                }
                column("DescripciónC2_aption";DescripciónC2_aptionLbl)
                {
                }
                column(Horas2_Caption;Horas2_CaptionLbl)
                {
                }
                column(Valor2_Caption;Valor2_CaptionLbl)
                {
                }
                column(ValorCaption2_Control41;ValorCaption2_Control41Lbl)
                {
                }
                column("DescripciónCaption2_Control43";DescripciónCaption2_Control43Lbl)
                {
                }
                column(Total_ingresos2_Caption;Total_ingresos2_CaptionLbl)
                {
                }
                column(Total_deducciones2_Caption;Total_deducciones2_CaptionLbl)
                {
                }
                column(Agree_with_Receive2Caption;Agree_with_Receive2CaptionLbl)
                {
                }
                column("HLN_Tipo_Nómina";"Tipo Nómina")
                {
                }
                column("HLN_Período";Período)
                {
                }
                column(HLN_No__Orden;"No. Orden")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ImportIngreso);
                CLEAR(ImportEgreso);
                CLEAR(ImporteIngresoTotal);
                CLEAR(ImportEgresoTotal);
                CLEAR(TotIng);
                CLEAR(TotDed);
                CLEAR(Horas);
                CLEAR(DescIngreso);
                CLEAR(DescDeducc);
                CLEAR(Cant);
                CALCFIELDS("Total Ingresos", "Total deducciones");
                TotIng  := "Total Ingresos";
                TotDed  := "Total deducciones";
                txtDesc := '';

                IF NOT rCargos.GET(Cargo) THEN
                   rCargos.INIT
                ELSE
                   txtDesc := rCargos.Descripción;

                rEmp.GET("No. empleado");

                IF NOT rDepto.GET(rEmp.Departamento) THEN
                   rDepto.INIT
                ELSE
                   txtDesc += ' / ' + rDepto.Descripcion;

                IF NOT rSubDepto.GET(rEmp.Departamento,rEmp."Sub-Departamento") THEN
                   rSubDepto.INIT
                ELSE
                   txtDesc += ' / ' + rSubDepto.Descripcion;


                TextoInformativo := '';
                "Historico Lin. nomina".RESET;
                "Historico Lin. nomina".SETRANGE("No. empleado","No. empleado");
                "Historico Lin. nomina".SETRANGE("Tipo Nómina","Tipo Nomina");
                "Historico Lin. nomina".SETRANGE(Período,Período);
                "Historico Lin. nomina".SETRANGE("No. Documento","No. Documento");
                "Historico Lin. nomina".SETRANGE("Texto Informativo",TRUE);
                IF "Historico Lin. nomina".FINDSET THEN
                   REPEAT
                    IF FirstTime THEN
                       BEGIN
                        FirstTime := FALSE;
                        TextoInformativo := "Historico Lin. nomina".Descripción + ', ' + FORMAT(ROUND("Historico Lin. nomina".Total,0.01));
                       END
                    ELSE
                      TextoInformativo += '. ' + "Historico Lin. nomina".Descripción + ', ' + FORMAT(ROUND("Historico Lin. nomina".Total,0.01));

                   UNTIL "Historico Lin. nomina".NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                rEmpresa.GET();
                rEmpresa.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FirstTime := TRUE;
    end;

    var
        rEmpresa: Record 79;
        rEmp: Record 5200;
        rCargos: Record 34002110;
        rDepto: Record 34002135;
        rSubDepto: Record 34002136;
        DescIngreso: array [10] of Text[50];
        DescDeducc: array [10] of Text[50];
        Horas: array [10] of Decimal;
        ImportIngreso: array [10] of Decimal;
        Cant: array [10] of Decimal;
        ImportEgreso: array [10] of Decimal;
        i: Integer;
        id: Integer;
        ImporteIngresoTotal: Decimal;
        ImportEgresoTotal: Decimal;
        TotIng: Decimal;
        TotDed: Decimal;
        txtDesc: Text[250];
        TextoInformativo: Text[250];
        "Histórico_Cab__nómina__NombreCaptionLbl": Label 'Full Name';
        txtDescCaptionLbl: Label 'Cargo';
        TODAYCaptionLbl: Label 'Date:';
        TIMECaptionLbl: Label 'Time:';
        "Recibo_de_nómina_períodoCaptionLbl": Label 'Recibo de nómina período';
        alCaptionLbl: Label 'al';
        TotIng___TotDedCaptionLbl: Label 'Net Income';
        "Histórico_Cab__nómina__CuentaCaptionLbl": Label 'Bank Account';
        V1CaptionLbl: Label '1';
        DescuentosCaptionLbl: Label 'Descuentos';
        IngresosCaptionLbl: Label 'Ingresos';
        "DescripciónCaptionLbl": Label 'Descripción';
        HorasCaptionLbl: Label 'Horas';
        ValorCaptionLbl: Label 'Valor';
        ValorCaption_Control41Lbl: Label 'Valor';
        "DescripciónCaption_Control43Lbl": Label 'Descripción';
        Total_ingresosCaptionLbl: Label 'Total ingresos';
        Total_deduccionesCaptionLbl: Label 'Total deducciones';
        Agree_with_ReceiveCaptionLbl: Label 'Agree with Receive';
        "Histórico_Cab__nómina__Nombre2_CaptionLbl": Label 'Full Name';
        txtDescCaption2Lbl: Label 'Cargo';
        TODAY_2_CaptionLbl: Label 'Date:';
        TIME_2_CaptionLbl: Label 'Time:';
        "Recibo_de_nómina_período2CaptionLbl": Label 'Recibo de nómina período';
        al2CaptionLbl: Label 'al';
        TotIng2___TotDedCaptionLbl: Label 'Net Income';
        "Histórico_Cab__nómina2__CuentaCaptionLbl": Label 'Bank Account';
        V2CaptionLbl: Label '2';
        Descuentos2_CaptionLbl: Label 'Descuentos';
        Ingresos2_CaptionLbl: Label 'Ingresos';
        "DescripciónC2_aptionLbl": Label 'Descripción';
        Horas2_CaptionLbl: Label 'Horas';
        Valor2_CaptionLbl: Label 'Valor';
        ValorCaption2_Control41Lbl: Label 'Valor';
        "DescripciónCaption2_Control43Lbl": Label 'Descripción';
        Total_ingresos2_CaptionLbl: Label 'Total ingresos';
        Total_deducciones2_CaptionLbl: Label 'Total deducciones';
        Agree_with_Receive2CaptionLbl: Label 'Agree with Receive';
        FirstTime: Boolean;
}

