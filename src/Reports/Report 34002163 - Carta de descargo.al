report 55804 "Carta de descargo"
{
    RDLCLayout = 'src/ReportsLayout/Carta de descargo.rdl';
    WordLayout = 'src/ReportsLayout/Carta de descargo.docx';
    Caption = 'Discharge letter';
    DefaultLayout = Word;

    dataset
    {
        dataitem(Employee; 5200)
        {
            RequestFilterFields = "No.";
            column(No_; Employee."No.")
            {
            }
            column(Full_Name; Employee."Full Name")
            {
            }
            column(Document_Type; Employee."Document Type")
            {
            }
            column(Document_ID; Employee."Document ID")
            {
            }
            column(Employment_Date; Employee."Employment Date")
            {
            }
            column(Ano; FORMAT(TODAY, 0, '<Year4>'))
            {
            }
            column(Salario; Employee.Salario)
            {
            }
            column(Job_Title; Employee."Job Title")
            {
            }
            column(Dia; FORMAT(TODAY, 0, '<Day,2>'))
            {
            }
            column(Nombre_Dia; NombreDia)
            {
            }
            column(Nombre_Mes; NombreMes)
            {
            }
            column(Importe_Texto; ImporteTexto[1])
            {
            }
            column(Fecha_Fin; FORMAT(Employee."Fin contrato", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Nombre_Dia_Sal; NombreDiaSal)
            {
            }
            column(Dia_Sal; FORMAT(Employee."Fin contrato", 0, '<Day,2>'))
            {
            }
            column(Nombre_Mes_Sal; NombreMesSal)
            {
            }
            column(Ano_Sal; FORMAT(Employee."Fin contrato", 0, '<Year4>'))
            {
            }
            column(CompanyInformation_name; CompanyInformation.Name)
            {
            }
            column(Fecha_Ent_txt; FechaEnttxt)
            {
            }
            column(Importe_Liq_Txt; ImporteLiqTxt)
            {
            }
            column(Importe_Liq; ImporteLiq)
            {
            }
            column(Fecha_Fin_txt; FechaFintxt)
            {
            }
            column(Nacionalidad; Nac)
            {
            }
            column(Nombre_Rep; Representante.Nombre)
            {
            }
            column(Cargo_Rep; Representante."Job Title")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ImporteLiq := 0;
                HLN.RESET;
                HLN.SETRANGE("No. empleado", "No.");
                HLN.SETRANGE("Tipo de nomina", TiposNom.Codigo);
                HLN.FINDSET;
                REPEAT
                    ImporteLiq += HLN.Total;
                UNTIL HLN.NEXT = 0;

                ChkTransMgt.FormatNoText(ImporteTexto, ImporteLiq, 2058, '');
                ImporteLiqTxt := ImporteTexto[1];
                CASE FORMAT(TODAY, 0, '<Month,2>') OF
                    '01':
                        NombreMes := 'Enero';
                    '02':
                        NombreMes := 'Febrero';
                    '03':
                        NombreMes := 'Marzo';
                    '04':
                        NombreMes := 'Abril';
                    '05':
                        NombreMes := 'Mayo';
                    '06':
                        NombreMes := 'Junio';
                    '07':
                        NombreMes := 'Julio';
                    '08':
                        NombreMes := 'Agosto';
                    '09':
                        NombreMes := 'Septiembre';
                    '10':
                        NombreMes := 'Octubre';
                    '11':
                        NombreMes := 'Noviembre';
                    ELSE
                        NombreMes := 'Diciembre';
                END;

                CASE FORMAT(Employee."Fin contrato", 0, '<Month,2>') OF
                    '01':
                        NombreMesSal := 'Enero';
                    '02':
                        NombreMesSal := 'Febrero';
                    '03':
                        NombreMesSal := 'Marzo';
                    '04':
                        NombreMesSal := 'Abril';
                    '05':
                        NombreMesSal := 'Mayo';
                    '06':
                        NombreMesSal := 'Junio';
                    '07':
                        NombreMesSal := 'Julio';
                    '08':
                        NombreMesSal := 'Agosto';
                    '09':
                        NombreMesSal := 'Septiembre';
                    '10':
                        NombreMesSal := 'Octubre';
                    '11':
                        NombreMesSal := 'Noviembre';
                    ELSE
                        NombreMesSal := 'Diciembre';
                END;
                ChkTransMgt.FormatNoText(ImporteTexto, Salario, 2058, '');

                FechaEnttxt := FuncionesNom.FechaCorta(Employee."Employment Date");
                FechaFintxt := FuncionesNom.FechaCorta(Employee."Termination Date");
                NombreDia := FuncionesNom.FechaLarga(TODAY);

                NombreDiaSal := FuncionesNom.NombreDia(Employee."Fin contrato");
            end;

            trigger OnPreDataItem()
            begin
                TiposNom.RESET;
                TiposNom.SETRANGE("Tipo de nomina", TiposNom."Tipo de nomina"::Prestaciones);
                TiposNom.FINDFIRST;

                Representante.RESET;
                Representante.SETFILTER(Figurar, '%1|%2', Representante.Figurar::"Todo tipo documento", Representante.Figurar::"Contratos laborales");
                Representante.FINDFIRST;


                CompanyInformation.GET();
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
        CompanyInformation: Record 79;
        ChkTransMgt: Report 10400;
        HLN: Record 55759;
        TiposNom: Record 55799;
        Representante: Record 55743;
        FuncionesNom: Codeunit 55745;
        NombreDia: Text[60];
        NombreMes: Text[60];
        ImporteTexto: array[2] of Text[1024];
        ImporteTexto2: Text[1024];
        NombreDiaSal: Text[60];
        NombreMesSal: Text[60];
        iDia: Integer;
        FechaEnttxt: Text[60];
        FechaFintxt: Text[60];
        ImporteLiq: Decimal;
        ImporteLiqTxt: Text[1024];
        Nac: Text[1024];
}

