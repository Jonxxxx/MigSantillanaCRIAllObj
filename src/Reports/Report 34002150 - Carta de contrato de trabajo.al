report 55791 "Carta de contrato de trabajo"
{
    RDLCLayout = 'src/ReportsLayout/Carta de contrato de trabajo.rdl';
    WordLayout = 'src/ReportsLayout/Carta de contrato de trabajo.docx';
    Caption = 'Work contract lletter';
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
            column(Dia; FORMAT(TODAY, 0, '<Day,2>'))
            {
            }
            column(Nombre_Dia; NombreDia)
            {
            }
            column(Nombre_Mes; NombreMes)
            {
            }
            column(Estado_Civil; Employee."Estado civil")
            {
            }
            column(Address_; Employee.Address)
            {
            }
            column(City_; Employee.City)
            {
            }
            column(Job_Title; Employee."Job Title")
            {
            }
            column(Importe_Texto; ImporteTexto[1])
            {
            }
            column(Salario; SalarioEmp)
            {
            }
            column(Tipo_Salario; TipoContrato)
            {
            }
            column(Nombre_Rep; RepresentantesEmpresa.Nombre)
            {
            }
            column(Nombre_Empresa; EmpresasCot."Nombre Empresa cotizacion")
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

                SalarioEmp := 0;
                PerfilSalario.RESET;
                PerfilSalario.SETRANGE("No. empleado", "No.");
                PerfilSalario.SETRANGE("Salario Base", TRUE);
                PerfilSalario.FINDSET;
                REPEAT
                    SalarioEmp += PerfilSalario.Importe;
                UNTIL PerfilSalario.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                EmpresasCot.FINDFIRST;
                RepresentantesEmpresa.RESET;
                RepresentantesEmpresa.SETRANGE("Empresa cotizacion", EmpresasCot."Empresa cotizacion");
                RepresentantesEmpresa.SETFILTER(Figurar, '%1|%2', RepresentantesEmpresa.Figurar::"Contratos laborales", RepresentantesEmpresa.Figurar::"Todo tipo documento");
                RepresentantesEmpresa.FINDFIRST;
                RepresentantesEmpresa.TESTFIELD(Nombre);
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
        RepresentantesEmpresa: Record 55743;
        EmpresasCot: Record 55741;
        PerfilSalario: Record 55756;
        NombreDia: Text[60];
        NombreMes: Text[60];
        ImporteTexto: array[2] of Text[1024];
        TipoContrato: Text[60];
        SalarioEmp: Decimal;
}

