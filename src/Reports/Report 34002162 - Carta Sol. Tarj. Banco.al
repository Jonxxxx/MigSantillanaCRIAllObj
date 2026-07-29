report 34002162 "Carta Sol. Tarj. Banco"
{
    RDLCLayout = 'src/ReportsLayout/Carta Sol. Tarj. Banco.rdl';
    WordLayout = 'src/ReportsLayout/Carta Sol. Tarj. Banco.docx';
    Caption = 'Letter opening Movil card';
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
                Representante.RESET;
                Representante.SETRANGE("Empresa cotizacion", Company);
                Representante.FINDFIRST;

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

                NombreDia := FuncionesNom.FechaLarga(TODAY);

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
        FuncionesNom: Codeunit 34002104;
        ChkTransMgt: Report 10400;
        Contrato: Record 34002109;
        Representante: Record 34002102;
        NombreDia: Text[60];
        NombreMes: Text[60];
        ImporteTexto: array[2] of Text[1024];
        TipoContrato: Text[60];
}

