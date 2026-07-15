page 34002114 "Historico Cab. Nominas"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = 34002117;
    SourceTableView = SORTING(Ano, Periodo, "No. empleado");

    layout
    {
        area(content)
        {
            field(Filtros; '')
            {
                CaptionClass = FORMAT('Filtros : ' + GETFILTERS);
                Editable = false;
            }
            group(General)
            {
                Caption = 'General';
                field("No. empleado"; "No. empleado")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field(Nombre; Nombre)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Centro trabajo"; "Centro trabajo")
                {
                    Editable = false;
                }
                field(Inicio; Inicio)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field(Fin; Fin)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Tipo Empleado"; "Tipo Empleado")
                {
                    Editable = false;
                }
                field("Tipo de nomina"; "Tipo de nomina")
                {
                    Editable = false;
                }
                field("Tipo Nomina"; "Tipo Nomina")
                {
                    Editable = false;
                }
                field("Fecha Entrada"; "Fecha Entrada")
                {
                    Editable = false;
                }
                field("Fecha Salida"; "Fecha Salida")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
            }
            part(HistLinNom; 34002124)
            {
                SubPageLink = "No. empleado" = FIELD("No. empleado"),
                              "Tipo de nomina" = FIELD("Tipo de nomina"),
                              Periodo = FIELD(Periodo);
            }
            group(Bases)
            {
                Caption = 'Bases';
                field("Base ISR"; "Base ISR")
                {
                    Caption = 'Base ISR';
                    Editable = false;
                }
                field("Total Ingresos"; "Total Ingresos")
                {
                    Caption = 'Total Ingresos';
                    Editable = false;
                }
                field("Total deducciones"; "Total deducciones")
                {
                    Editable = false;
                }
                field("Forma de Cobro"; "Forma de Cobro")
                {
                    Editable = false;
                }
                field("Tipo Cuenta"; "Tipo Cuenta")
                {
                    Editable = false;
                }
                field(Cuenta; Cuenta)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Payroll")
            {
                Caption = '&Payroll';
                action(Statistic)
                {
                    Caption = 'Statistic';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 34002126;
                    RunPageLink = "No. Documento" = FIELD("No. Documento"),
                                  "No. empleado" = FIELD("No. empleado"),
                                  "Tipo de nomina" = FIELD("Tipo de nomina"),
                                  Periodo = FIELD(Periodo);
                    ShortCutKey = 'F7';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }

                action("<Action83>$")
                {
                    Caption = 'Batch voids';
                    Image = Cancel;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //TODO: Ver RunObject = Report 34002123;

                    trigger OnAction()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
            }

            action(editar)
            {
                Enabled = false;
                Visible = false;

                trigger OnAction()
                begin
                    CurrPage.EDITABLE := TRUE;
                end;
            }
        }
        area(processing)
        {
            action("P&rint")
            {
                Caption = 'P&rint';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                //TODO: Ver RunObject = Codeunit 34002103;
            }
        }
    }

    var
        RegEmpCotizacion: Record 34002100;
        TipoEmpleado: Option Fijos,Temporales,Otros,Todos;
}

