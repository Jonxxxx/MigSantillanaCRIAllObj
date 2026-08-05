report 55794 "Carta a quien pueda interesar"
{
    RDLCLayout = 'src/ReportsLayout/Carta a quien pueda interesar.rdl';
    WordLayout = 'src/ReportsLayout/Carta a quien pueda interesar.docx';
    Caption = 'Letter to whom it may concern';
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
            column(Ano_Contrato; FORMAT(Employee."Employment Date", 0, '<Year4>'))
            {
            }
            column(Emp_dia; FORMAT("Employment Date", 0, '<Day,2>'))
            {
            }
            column(Emp_Mes; FORMAT("Employment Date", 0, '<Month text>'))
            {
            }
            column(Emp_Ano; FORMAT("Employment Date", 0, '<Year4>'))
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
            column(Tipo_Salario; TipoContrato)
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
                CASE FORMAT(Employee."Employment Date", 0, '<Month,2>') OF
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

                ChkTransMgt.FormatNoText(ImporteTexto, Salario, 2058, '');
                ImporteTexto[1] := DELCHR(ImporteTexto[1], '=', '*');

                NombreDia := FuncionesNom.FechaCorta(Employee."Employment Date");

                Contrato.RESET;
                Contrato.SETRANGE("Cod. contrato", "Emplymt. Contract Code");
                Contrato.SETRANGE("No. empleado", "No.");
                Contrato.SETRANGE(Activo, TRUE);
                Contrato.FINDFIRST;
                IF (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal) OR
                  (Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Mensual) THEN
                    TipoContrato := 'salario fijo mensual'
                ELSE
                    TipoContrato := 'salario por hora';
            end;

            trigger OnPreDataItem()
            begin
                Representante.RESET;
                Representante.FINDFIRST;
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
        FuncionesNom: Codeunit 55745;
        ChkTransMgt: Report 34003010;
        Contrato: Record 55750;
        Representante: Record 55743;
        NombreDia: Text[60];
        NombreMes: Text[60];
        ImporteTexto: array[2] of Text[1024];
        TipoContrato: Text[60];
}

