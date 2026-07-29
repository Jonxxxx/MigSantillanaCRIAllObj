report 34002151 "Carta de constancia de trabajo"
{
    RDLCLayout = 'src/ReportsLayout/Carta de constancia de trabajo.rdl';
    WordLayout = 'src/ReportsLayout/Carta de constancia de trabajo.docx';
    Caption = 'Proof of employment letter';
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
            column(Emp_dia; FORMAT("Employment Date", 0, '<Day,2>'))
            {
            }
            column(Emp_Mes; FORMAT("Employment Date", 0, '<Month text>'))
            {
            }
            column(Emp_Ano; FORMAT("Employment Date", 0, '<Year4>'))
            {
            }
            column(Salario; Employee.Salario)
            {
            }
            column(Job_Title; Employee."Job Title")
            {
            }
            column(Fecha_Dia; FORMAT(TODAY, 0, '<Day,2>'))
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
        Representante: Record 34002102;
        ChkTransMgt: Report 34003010;
        NombreDia: Text[60];
        NombreMes: Text[60];
        ImporteTexto: array[2] of Text[1024];
}

