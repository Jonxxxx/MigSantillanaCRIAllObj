report 34002118 "Recibo Pago Sobres 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Recibo Pago Sobres 2.rdlc';
    Permissions = TableData 34002117 = rimd,
                  TableData 34002118 = rimd;

    dataset
    {
        dataitem("Historico Cab. nomina"; 34002117)
        {
            DataItemTableView = SORTING("No. empleado", Ano, Periodo, "Tipo Nomina");
            RequestFilterFields = "No. empleado", "Tipo de nomina", Periodo;
            column(ImportIngreso_5_; ImportIngreso[5])
            {
            }
            column(ImportIngreso_4_; ImportIngreso[4])
            {
            }
            column(DescIngreso_4_; DescIngreso[4])
            {
            }
            column(DescIngreso_5_; DescIngreso[5])
            {
            }
            column(DescIngreso_3_; DescIngreso[3])
            {
            }
            column(ImportIngreso_3_; ImportIngreso[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescIngreso_2_; DescIngreso[2])
            {
            }
            column(ImportIngreso_2_; ImportIngreso[2])
            {
            }
            column(DescIngreso_1_; DescIngreso[1])
            {
            }
            column(ImportIngreso_1_; ImportIngreso[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImporteIngresoTotal_1_; ImporteIngresoTotal[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescDeducc_4_; DescDeducc[4])
            {
            }
            column(ABS_ImportEgreso_4__; ABS(ImportEgreso[4]))
            {
            }
            column(DescDeducc_3_; DescDeducc[3])
            {
            }
            column(ABS_ImportEgreso_3__; ABS(ImportEgreso[3]))
            {
            }
            column(DescDeducc_2_; DescDeducc[2])
            {
            }
            column(ABS_ImportEgreso_2__; ABS(ImportEgreso[2]))
            {
            }
            column(DescDeducc_1_; DescDeducc[1])
            {
            }
            column(ABS_ImportEgreso_1__; ABS(ImportEgreso[1]))
            {
            }
            column(TextNombre_1_; TextNombre[1])
            {
            }
            column(TextCed_1_; TextCed[1])
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1000000033; COMPANYNAME)
            {
            }
            column(TODAY_Control1000000034; TODAY)
            {
            }
            column(ABS_ImportEgresoTotal_1__; ABS(ImportEgresoTotal[1]))
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImportIngreso_10_; ImportIngreso[10])
            {
            }
            column(ImportIngreso_9_; ImportIngreso[9])
            {
            }
            column(DescIngreso_9_; DescIngreso[9])
            {
            }
            column(DescIngreso_10_; DescIngreso[10])
            {
            }
            column(DescIngreso_8_; DescIngreso[8])
            {
            }
            column(ImportIngreso_8_; ImportIngreso[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescIngreso_7_; DescIngreso[7])
            {
            }
            column(ImportIngreso_7_; ImportIngreso[7])
            {
            }
            column(DescIngreso_6_; DescIngreso[6])
            {
            }
            column(ImportIngreso_6_; ImportIngreso[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImporteIngresoTotal_2_; ImporteIngresoTotal[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescDeducc_6_; DescDeducc[6])
            {
            }
            column(ABS_ImportEgreso_6__; ABS(ImportEgreso[6]))
            {
            }
            column(DescDeducc_8_; DescDeducc[8])
            {
            }
            column(ABS_ImportEgreso_8__; ABS(ImportEgreso[8]))
            {
            }
            column(DescDeducc_7_; DescDeducc[7])
            {
            }
            column(ABS_ImportEgreso_7__; ABS(ImportEgreso[7]))
            {
            }
            column(DescDeducc_5_; DescDeducc[5])
            {
            }
            column(ABS_ImportEgreso_5__; ABS(ImportEgreso[5]))
            {
            }
            column(TextNombre_2_; TextNombre[2])
            {
            }
            column(TextCed_2_; TextCed[2])
            {
            }
            column(TODAY_Control1000000063; TODAY)
            {
            }
            column(COMPANYNAME_Control1000000065; COMPANYNAME)
            {
            }
            column(COMPANYNAME_Control1000000067; COMPANYNAME)
            {
            }
            column(TODAY_Control1000000068; TODAY)
            {
            }
            column(ABS_ImportEgresoTotal_2__; ABS(ImportEgresoTotal[2]))
            {
                DecimalPlaces = 2 : 2;
            }
            column(ABS_ImportEgreso_12__; ABS(ImportEgreso[12]))
            {
            }
            column(ABS_ImportEgreso_11__; ABS(ImportEgreso[11]))
            {
            }
            column(ABS_ImportEgreso_10__; ABS(ImportEgreso[10]))
            {
            }
            column(ABS_ImportEgreso_9__; ABS(ImportEgreso[9]))
            {
            }
            column(ABS_ImportEgresoTotal_3__; ABS(ImportEgresoTotal[3]))
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImporteIngresoTotal_3_; ImporteIngresoTotal[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescDeducc_12_; DescDeducc[12])
            {
            }
            column(DescDeducc_11_; DescDeducc[11])
            {
            }
            column(DescDeducc_10_; DescDeducc[10])
            {
            }
            column(DescDeducc_9_; DescDeducc[9])
            {
            }
            column(ImportIngreso_15_; ImportIngreso[15])
            {
            }
            column(DescIngreso_15_; DescIngreso[15])
            {
            }
            column(ImportIngreso_14_; ImportIngreso[14])
            {
            }
            column(DescIngreso_14_; DescIngreso[14])
            {
            }
            column(DescIngreso_13_; DescIngreso[13])
            {
            }
            column(ImportIngreso_13_; ImportIngreso[13])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescIngreso_12_; DescIngreso[12])
            {
            }
            column(ImportIngreso_12_; ImportIngreso[12])
            {
            }
            column(DescIngreso_11_; DescIngreso[11])
            {
            }
            column(ImportIngreso_11_; ImportIngreso[11])
            {
                DecimalPlaces = 2 : 2;
            }
            column(TextNombre_3_; TextNombre[3])
            {
            }
            column(TextCed_3_; TextCed[3])
            {
            }
            column(COMPANYNAME_Control1000000100; COMPANYNAME)
            {
            }
            column(TODAY_Control1000000101; TODAY)
            {
            }
            column(COMPANYNAME_Control1000000103; COMPANYNAME)
            {
            }
            column(TODAY_Control1000000104; TODAY)
            {
            }
            column(ImporteIngresoTotal_1____ImportEgresoTotal_1_; ImporteIngresoTotal[1] + ImportEgresoTotal[1])
            {
            }
            column(ImporteIngresoTotal_2____ImportEgresoTotal_2_; ImporteIngresoTotal[2] + ImportEgresoTotal[2])
            {
            }
            column(ImporteIngresoTotal_3____ImportEgresoTotal_3_; ImporteIngresoTotal[3] + ImportEgresoTotal[3])
            {
            }
            column(ImporteIngresoTotal_1____ImportEgresoTotal_1__Control1000000118; ImporteIngresoTotal[1] + ImportEgresoTotal[1])
            {
            }
            column(ABS_ImportEgresoTotal_1___Control1000000119; ABS(ImportEgresoTotal[1]))
            {
                DecimalPlaces = 2 : 2;
            }
            column(ABS_ImportEgreso_4___Control1000000120; ABS(ImportEgreso[4]))
            {
            }
            column(ABS_ImportEgreso_3___Control1000000121; ABS(ImportEgreso[3]))
            {
            }
            column(ABS_ImportEgreso_2___Control1000000122; ABS(ImportEgreso[2]))
            {
            }
            column(DescDeducc_4__Control1000000123; DescDeducc[4])
            {
            }
            column(DescDeducc_3__Control1000000124; DescDeducc[3])
            {
            }
            column(DescDeducc_2__Control1000000125; DescDeducc[2])
            {
            }
            column(DescDeducc_1__Control1000000127; DescDeducc[1])
            {
            }
            column(ABS_ImportEgreso_1___Control1000000128; ABS(ImportEgreso[1]))
            {
            }
            column(ImporteIngresoTotal_1__Control1000000132; ImporteIngresoTotal[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImportIngreso_5__Control1000000134; ImportIngreso[5])
            {
            }
            column(DescIngreso_5__Control1000000135; DescIngreso[5])
            {
            }
            column(ImportIngreso_4__Control1000000136; ImportIngreso[4])
            {
            }
            column(DescIngreso_4__Control1000000137; DescIngreso[4])
            {
            }
            column(DescIngreso_3__Control1000000138; DescIngreso[3])
            {
            }
            column(ImportIngreso_3__Control1000000139; ImportIngreso[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescIngreso_2__Control1000000140; DescIngreso[2])
            {
            }
            column(ImportIngreso_2__Control1000000141; ImportIngreso[2])
            {
            }
            column(DescIngreso_1__Control1000000142; DescIngreso[1])
            {
            }
            column(ImportIngreso_1__Control1000000143; ImportIngreso[1])
            {
                DecimalPlaces = 2 : 2;
            }
            column(TextNombre_1__Control1000000146; TextNombre[1])
            {
            }
            column(ImporteIngresoTotal_2____ImportEgresoTotal_2__Control1000000148; ImporteIngresoTotal[2] + ImportEgresoTotal[2])
            {
            }
            column(TextNombre_2__Control1000000152; TextNombre[2])
            {
            }
            column(ImporteIngresoTotal_3____ImportEgresoTotal_3__Control1000000156; ImporteIngresoTotal[3] + ImportEgresoTotal[3])
            {
            }
            column(TextNombre_3__Control1000000162; TextNombre[3])
            {
            }
            column(Periodo; Periodo)
            {
            }
            column(No_____NumSobre_1_; 'No. ' + NumSobre[1])
            {
            }
            column(No_____NumSobre_1__Control1000000166; 'No. ' + NumSobre[1])
            {
            }
            column(No_____NumSobre_2_; 'No. ' + NumSobre[2])
            {
            }
            column(No_____NumSobre_2__Control1000000172; 'No. ' + NumSobre[2])
            {
            }
            column(No_____NumSobre_3_; 'No. ' + NumSobre[3])
            {
            }
            column(Periodo_Control1000000176; Periodo)
            {
            }
            column(No_____NumSobre_3__Control1000000178; 'No. ' + NumSobre[3])
            {
            }
            column(Periodo_Control1000000179; Periodo)
            {
            }
            column(Periodo_Control1000000180; Periodo)
            {
            }
            column(ABS_ImportEgreso_6___Control1000000193; ABS(ImportEgreso[6]))
            {
            }
            column(DescDeducc_6__Control1000000194; DescDeducc[6])
            {
            }
            column(ABS_ImportEgresoTotal_2___Control1000000195; ABS(ImportEgresoTotal[2]))
            {
                DecimalPlaces = 2 : 2;
            }
            column(ABS_ImportEgreso_8___Control1000000196; ABS(ImportEgreso[8]))
            {
            }
            column(ABS_ImportEgreso_7___Control1000000197; ABS(ImportEgreso[7]))
            {
            }
            column(DescDeducc_8__Control1000000198; DescDeducc[8])
            {
            }
            column(DescDeducc_7__Control1000000199; DescDeducc[7])
            {
            }
            column(DescDeducc_5__Control1000000201; DescDeducc[5])
            {
            }
            column(ABS_ImportEgreso_5___Control1000000202; ABS(ImportEgreso[5]))
            {
            }
            column(ABS_ImportEgresoTotal_3___Control1000000215; ABS(ImportEgresoTotal[3]))
            {
                DecimalPlaces = 2 : 2;
            }
            column(ABS_ImportEgreso_12___Control1000000216; ABS(ImportEgreso[12]))
            {
            }
            column(DescDeducc_12__Control1000000217; DescDeducc[12])
            {
            }
            column(ABS_ImportEgreso_11___Control1000000219; ABS(ImportEgreso[11]))
            {
            }
            column(DescDeducc_11__Control1000000220; DescDeducc[11])
            {
            }
            column(ABS_ImportEgreso_10___Control1000000221; ABS(ImportEgreso[10]))
            {
            }
            column(DescDeducc_10__Control1000000222; DescDeducc[10])
            {
            }
            column(ABS_ImportEgreso_9___Control1000000223; ABS(ImportEgreso[9]))
            {
            }
            column(DescDeducc_9__Control1000000224; DescDeducc[9])
            {
            }
            column(ImporteIngresoTotal_3__Control1000000203; ImporteIngresoTotal[3])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImportIngreso_15__Control1000000204; ImportIngreso[15])
            {
            }
            column(DescIngreso_15__Control1000000206; DescIngreso[15])
            {
            }
            column(ImportIngreso_14__Control1000000207; ImportIngreso[14])
            {
            }
            column(DescIngreso_14__Control1000000208; DescIngreso[14])
            {
            }
            column(DescIngreso_13__Control1000000209; DescIngreso[13])
            {
            }
            column(ImportIngreso_13__Control1000000210; ImportIngreso[13])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescIngreso_12__Control1000000211; DescIngreso[12])
            {
            }
            column(ImportIngreso_12__Control1000000212; ImportIngreso[12])
            {
            }
            column(DescIngreso_11__Control1000000213; DescIngreso[11])
            {
            }
            column(ImportIngreso_11__Control1000000214; ImportIngreso[11])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImporteIngresoTotal_2__Control1000000225; ImporteIngresoTotal[2])
            {
                DecimalPlaces = 2 : 2;
            }
            column(ImportIngreso_10__Control1000000226; ImportIngreso[10])
            {
            }
            column(DescIngreso_10__Control1000000227; DescIngreso[10])
            {
            }
            column(ImportIngreso_9__Control1000000229; ImportIngreso[9])
            {
            }
            column(DescIngreso_9__Control1000000230; DescIngreso[9])
            {
            }
            column(DescIngreso_8__Control1000000231; DescIngreso[8])
            {
            }
            column(ImportIngreso_8__Control1000000232; ImportIngreso[8])
            {
                DecimalPlaces = 2 : 2;
            }
            column(DescIngreso_7__Control1000000233; DescIngreso[7])
            {
            }
            column(ImportIngreso_7__Control1000000234; ImportIngreso[7])
            {
            }
            column(DescIngreso_6__Control1000000235; DescIngreso[6])
            {
            }
            column(ImportIngreso_6__Control1000000236; ImportIngreso[6])
            {
                DecimalPlaces = 2 : 2;
            }
            column(Periodo_Control1000000168; Periodo)
            {
            }
            column(Periodo_Control1000000169; Periodo)
            {
            }
            column(TextCed_3__Control1000000028; TextCed[3])
            {
            }
            column(txtDesc_3_; txtDesc[3])
            {
            }
            column(txtDesc_2_; txtDesc[2])
            {
            }
            column(txtDesc_1_; txtDesc[1])
            {
            }
            column(Imprimir; Imprimir)
            {
            }
            column(DEDUCTIONSCaption; DEDUCTIONSCaptionLbl)
            {
            }
            column(Total_IncomesCaption; Total_IncomesCaptionLbl)
            {
            }
            column(TextNombre_1_Caption; TextNombre_1_CaptionLbl)
            {
            }
            column(TextCed_1_Caption; TextCed_1_CaptionLbl)
            {
            }
            column(TODAYCaption; TODAYCaptionLbl)
            {
            }
            column(INCOMECaption; INCOMECaptionLbl)
            {
            }
            column(TODAY_Control1000000034Caption; TODAY_Control1000000034CaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(DEDUCTIONSCaption_Control1000000048; DEDUCTIONSCaption_Control1000000048Lbl)
            {
            }
            column(Total_IncomesCaption_Control1000000050; Total_IncomesCaption_Control1000000050Lbl)
            {
            }
            column(TextNombre_2_Caption; TextNombre_2_CaptionLbl)
            {
            }
            column(TextCed_2_Caption; TextCed_2_CaptionLbl)
            {
            }
            column(TODAY_Control1000000063Caption; TODAY_Control1000000063CaptionLbl)
            {
            }
            column(INCOMECaption_Control1000000066; INCOMECaption_Control1000000066Lbl)
            {
            }
            column(TODAY_Control1000000068Caption; TODAY_Control1000000068CaptionLbl)
            {
            }
            column(Total_DeductionsCaption_Control1000000071; Total_DeductionsCaption_Control1000000071Lbl)
            {
            }
            column(DEDUCTIONSCaption_Control1000000077; DEDUCTIONSCaption_Control1000000077Lbl)
            {
            }
            column(Total_IncomesCaption_Control1000000079; Total_IncomesCaption_Control1000000079Lbl)
            {
            }
            column(Total_DeductionsCaption_Control1000000084; Total_DeductionsCaption_Control1000000084Lbl)
            {
            }
            column(INCOMECaption_Control1000000095; INCOMECaption_Control1000000095Lbl)
            {
            }
            column(TextNombre_3_Caption; TextNombre_3_CaptionLbl)
            {
            }
            column(TextCed_3_Caption; TextCed_3_CaptionLbl)
            {
            }
            column(TODAY_Control1000000101Caption; TODAY_Control1000000101CaptionLbl)
            {
            }
            column(TODAY_Control1000000104Caption; TODAY_Control1000000104CaptionLbl)
            {
            }
            column(ImporteIngresoTotal_1____ImportEgresoTotal_1_Caption; ImporteIngresoTotal_1____ImportEgresoTotal_1_CaptionLbl)
            {
            }
            column(Recibido_ConformeCaption; Recibido_ConformeCaptionLbl)
            {
            }
            column(ImporteIngresoTotal_2____ImportEgresoTotal_2_Caption; ImporteIngresoTotal_2____ImportEgresoTotal_2_CaptionLbl)
            {
            }
            column(Recibido_ConformeCaption_Control1000000112; Recibido_ConformeCaption_Control1000000112Lbl)
            {
            }
            column(Recibido_ConformeCaption_Control1000000115; Recibido_ConformeCaption_Control1000000115Lbl)
            {
            }
            column(ImporteIngresoTotal_3____ImportEgresoTotal_3_Caption; ImporteIngresoTotal_3____ImportEgresoTotal_3_CaptionLbl)
            {
            }
            column(ImporteIngresoTotal_1____ImportEgresoTotal_1__Control1000000118Caption; ImporteIngresoTotal_1____ImportEgresoTotal_1__Control1000000118CaptionLbl)
            {
            }
            column(Total_DeductionsCaption_Control1000000126; Total_DeductionsCaption_Control1000000126Lbl)
            {
            }
            column(DEDUCTIONSCaption_Control1000000129; DEDUCTIONSCaption_Control1000000129Lbl)
            {
            }
            column(Recibido_ConformeCaption_Control1000000131; Recibido_ConformeCaption_Control1000000131Lbl)
            {
            }
            column(Total_IncomesCaption_Control1000000133; Total_IncomesCaption_Control1000000133Lbl)
            {
            }
            column(INCOMECaption_Control1000000145; INCOMECaption_Control1000000145Lbl)
            {
            }
            column(TextNombre_1__Control1000000146Caption; TextNombre_1__Control1000000146CaptionLbl)
            {
            }
            column(ImporteIngresoTotal_2____ImportEgresoTotal_2__Control1000000148Caption; ImporteIngresoTotal_2____ImportEgresoTotal_2__Control1000000148CaptionLbl)
            {
            }
            column(DEDUCTIONSCaption_Control1000000149; DEDUCTIONSCaption_Control1000000149Lbl)
            {
            }
            column(INCOMECaption_Control1000000151; INCOMECaption_Control1000000151Lbl)
            {
            }
            column(TextNombre_2__Control1000000152Caption; TextNombre_2__Control1000000152CaptionLbl)
            {
            }
            column(Recibido_ConformeCaption_Control1000000155; Recibido_ConformeCaption_Control1000000155Lbl)
            {
            }
            column(ImporteIngresoTotal_3____ImportEgresoTotal_3__Control1000000156Caption; ImporteIngresoTotal_3____ImportEgresoTotal_3__Control1000000156CaptionLbl)
            {
            }
            column(DEDUCTIONSCaption_Control1000000157; DEDUCTIONSCaption_Control1000000157Lbl)
            {
            }
            column(Recibido_ConformeCaption_Control1000000159; Recibido_ConformeCaption_Control1000000159Lbl)
            {
            }
            column(INCOMECaption_Control1000000161; INCOMECaption_Control1000000161Lbl)
            {
            }
            column(TextNombre_3__Control1000000162Caption; TextNombre_3__Control1000000162CaptionLbl)
            {
            }
            column(Total_DeductionsCaption_Control1000000200; Total_DeductionsCaption_Control1000000200Lbl)
            {
            }
            column(Total_DeductionsCaption_Control1000000218; Total_DeductionsCaption_Control1000000218Lbl)
            {
            }
            column(Total_IncomesCaption_Control1000000205; Total_IncomesCaption_Control1000000205Lbl)
            {
            }
            column(Total_IncomesCaption_Control1000000228; Total_IncomesCaption_Control1000000228Lbl)
            {
            }
            column(Historico_Cab__nomina_No__empleado; "No. empleado")
            {
            }
            column(Historico_Cab__nomina_Ano; Ano)
            {
            }
            column(Historico_Cab__nomina_Periodo; Periodo)
            {
            }
            column(Historico_Cab__nomina_Tipo_Nomina; "Tipo Nomina")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PeriodoText := Text0001 + FORMAT("Historico Cab. nomina".Inicio) + Text0002 + FORMAT("Historico Cab. nomina".Fin);
                rEmpleado.GET("No. empleado");
                CLEAR(TotIng);
                CLEAR(TotDed);

                IF Imprimir THEN BEGIN
                    CLEAR(DescIngreso);
                    CLEAR(DescDeducc);
                    CLEAR(ImportIngreso);
                    CLEAR(ImportEgreso);
                    CLEAR(ImporteIngresoTotal);
                    CLEAR(ImportEgresoTotal);
                    CLEAR(txtDesc);
                    Imprimir := FALSE;
                END;

                Seq += 1;

                CALCFIELDS("Total Ingresos", "Total deducciones");

                TotIng := "Total Ingresos";
                TotDed := "Total deducciones";

                Contador += 1;
                NoSobre += 1;

                TextNombre[Contador] := "No. empleado" + ', ' + Nombre;
                TextCed[Contador] := rEmpleado."Document ID";

                NumSobre[Contador] := FORMAT(NoSobre, 4, '<Integer,4><Filler Character,0>');


                i := 0;
                id := 0;
                ii := 5;
                iid := 4;
                iii := 10;
                iiid := 8;

                rLinNom.RESET;
                rLinNom.SETRANGE("No. empleado", "No. empleado");
                rLinNom.SETRANGE("Tipo nomina", "Tipo Nomina");
                rLinNom.SETRANGE(Periodo, Periodo);
                IF rLinNom.FINDSET(FALSE, FALSE) THEN
                    REPEAT
                        CASE Contador OF
                            1:
                                BEGIN
                                    IF rLinNom."Tipo concepto" = rLinNom."Tipo concepto"::Ingresos THEN BEGIN
                                        i += 1;
                                        DescIngreso[i] := rLinNom.Descripcion;
                                        ImportIngreso[i] := rLinNom.Total;
                                        ImporteIngresoTotal[Contador] += ImportIngreso[i];
                                    END
                                    ELSE BEGIN
                                        id += 1;
                                        DescDeducc[id] := rLinNom.Descripcion;
                                        ImportEgreso[id] := rLinNom.Total;
                                        ImportEgresoTotal[Contador] += ImportEgreso[id];
                                    END;
                                END;
                            2:
                                BEGIN
                                    IF rLinNom."Tipo concepto" = rLinNom."Tipo concepto"::Ingresos THEN BEGIN
                                        ii += 1;
                                        DescIngreso[ii] := rLinNom.Descripcion;
                                        ImportIngreso[ii] := rLinNom.Total;
                                        ImporteIngresoTotal[Contador] += ImportIngreso[ii];
                                    END
                                    ELSE BEGIN
                                        iid += 1;
                                        DescDeducc[iid] := rLinNom.Descripcion;
                                        ImportEgreso[iid] := rLinNom.Total;
                                        ImportEgresoTotal[Contador] += ImportEgreso[iid];
                                    END;
                                END
                            ELSE BEGIN
                                IF rLinNom."Tipo concepto" = rLinNom."Tipo concepto"::Ingresos THEN BEGIN
                                    iii += 1;
                                    DescIngreso[iii] := rLinNom.Descripcion;
                                    ImportIngreso[iii] := rLinNom.Total;
                                    ImporteIngresoTotal[Contador] += ImportIngreso[iii];
                                END
                                ELSE BEGIN
                                    iiid += 1;
                                    DescDeducc[iiid] := rLinNom.Descripcion;
                                    ImportEgreso[iiid] := rLinNom.Total;
                                    ImportEgresoTotal[Contador] += ImportEgreso[iiid];
                                END;
                            END;
                        END;

                    UNTIL rLinNom.NEXT = 0;

                IF NOT rCargos.GET(Cargo) THEN
                    rCargos.INIT
                ELSE
                    txtDesc[Contador] := rCargos.Descripcion;

                IF NOT rDepto.GET(rEmpleado.Departamento) THEN
                    rDepto.INIT
                ELSE
                    txtDesc[Contador] += ' / ' + rDepto.Descripcion;

                IF NOT rSubDepto.GET(rEmpleado.Departamento, rEmpleado."Sub-Departamento") THEN
                    rSubDepto.INIT
                ELSE
                    txtDesc[Contador] += ' / ' + rSubDepto.Descripcion;

                IF Tot = Seq THEN
                    Contador := 3;

                IF Contador = 3 THEN BEGIN
                    Imprimir := TRUE;
                    Contador := 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                rEmpresa.GET();
                Contador := 0;
                Imprimir := FALSE;
                Tot := COUNT;
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

    var
        rEmpleado: Record 5200;
        rEmpresa: Record 79;
        rLinNom: Record 34002118;
        rCargos: Record 34002110;
        rDepto: Record 34002135;
        rSubDepto: Record 34002136;
        DescIngreso: array[15] of Text[50];
        DescDeducc: array[15] of Text[50];
        ImportIngreso: array[15] of Decimal;
        ImportEgreso: array[15] of Decimal;
        i: Integer;
        ii: Integer;
        iii: Integer;
        id: Integer;
        iid: Integer;
        iiid: Integer;
        ImporteIngresoTotal: array[3] of Decimal;
        ImportEgresoTotal: array[3] of Decimal;
        TotIng: Decimal;
        TotDed: Decimal;
        TextNombre: array[3] of Text[60];
        TextCed: array[3] of Text[30];
        Contador: Integer;
        Imprimir: Boolean;
        NoSobre: Integer;
        Text0001: Label 'Periodo ';
        Text0002: Label ' to ';
        PeriodoText: Text[150];
        NumSobre: array[3] of Text[30];
        Tot: Integer;
        Seq: Integer;
        txtDesc: array[3] of Text[250];
        DEDUCTIONSCaptionLbl: Label 'DEDUCTIONS';
        Total_IncomesCaptionLbl: Label 'Total Incomes';
        TextNombre_1_CaptionLbl: Label 'Employee';
        TextCed_1_CaptionLbl: Label 'Document';
        TODAYCaptionLbl: Label 'Date:';
        INCOMECaptionLbl: Label 'INCOME';
        TODAY_Control1000000034CaptionLbl: Label 'Date:';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        DEDUCTIONSCaption_Control1000000048Lbl: Label 'DEDUCTIONS';
        Total_IncomesCaption_Control1000000050Lbl: Label 'Total Incomes';
        TextNombre_2_CaptionLbl: Label 'Employee';
        TextCed_2_CaptionLbl: Label 'Document';
        TODAY_Control1000000063CaptionLbl: Label 'Date:';
        INCOMECaption_Control1000000066Lbl: Label 'INCOME';
        TODAY_Control1000000068CaptionLbl: Label 'Date:';
        Total_DeductionsCaption_Control1000000071Lbl: Label 'Total Deductions';
        DEDUCTIONSCaption_Control1000000077Lbl: Label 'DEDUCTIONS';
        Total_IncomesCaption_Control1000000079Lbl: Label 'Total Incomes';
        Total_DeductionsCaption_Control1000000084Lbl: Label 'Total Deductions';
        INCOMECaption_Control1000000095Lbl: Label 'INCOME';
        TextNombre_3_CaptionLbl: Label 'Employee';
        TextCed_3_CaptionLbl: Label 'Document';
        TODAY_Control1000000101CaptionLbl: Label 'Date:';
        TODAY_Control1000000104CaptionLbl: Label 'Date:';
        ImporteIngresoTotal_1____ImportEgresoTotal_1_CaptionLbl: Label 'Net Income';
        Recibido_ConformeCaptionLbl: Label 'Recibido Conforme';
        ImporteIngresoTotal_2____ImportEgresoTotal_2_CaptionLbl: Label 'Net Income';
        Recibido_ConformeCaption_Control1000000112Lbl: Label 'Recibido Conforme';
        Recibido_ConformeCaption_Control1000000115Lbl: Label 'Recibido Conforme';
        ImporteIngresoTotal_3____ImportEgresoTotal_3_CaptionLbl: Label 'Net Income';
        ImporteIngresoTotal_1____ImportEgresoTotal_1__Control1000000118CaptionLbl: Label 'Net Income';
        Total_DeductionsCaption_Control1000000126Lbl: Label 'Total Deductions';
        DEDUCTIONSCaption_Control1000000129Lbl: Label 'DEDUCTIONS';
        Recibido_ConformeCaption_Control1000000131Lbl: Label 'Recibido Conforme';
        Total_IncomesCaption_Control1000000133Lbl: Label 'Total Incomes';
        INCOMECaption_Control1000000145Lbl: Label 'INCOME';
        TextNombre_1__Control1000000146CaptionLbl: Label 'Employee';
        ImporteIngresoTotal_2____ImportEgresoTotal_2__Control1000000148CaptionLbl: Label 'Net Income';
        DEDUCTIONSCaption_Control1000000149Lbl: Label 'DEDUCTIONS';
        INCOMECaption_Control1000000151Lbl: Label 'INCOME';
        TextNombre_2__Control1000000152CaptionLbl: Label 'Employee';
        Recibido_ConformeCaption_Control1000000155Lbl: Label 'Recibido Conforme';
        ImporteIngresoTotal_3____ImportEgresoTotal_3__Control1000000156CaptionLbl: Label 'Net Income';
        DEDUCTIONSCaption_Control1000000157Lbl: Label 'DEDUCTIONS';
        Recibido_ConformeCaption_Control1000000159Lbl: Label 'Recibido Conforme';
        INCOMECaption_Control1000000161Lbl: Label 'INCOME';
        TextNombre_3__Control1000000162CaptionLbl: Label 'Employee';
        Total_DeductionsCaption_Control1000000200Lbl: Label 'Total Deductions';
        Total_DeductionsCaption_Control1000000218Lbl: Label 'Total Deductions';
        Total_IncomesCaption_Control1000000205Lbl: Label 'Total Incomes';
        Total_IncomesCaption_Control1000000228Lbl: Label 'Total Incomes';
}

