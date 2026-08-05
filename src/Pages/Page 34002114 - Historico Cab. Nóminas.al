page 55755 "Historico Cab. Nominas"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = 55758;
    SourceTableView = SORTING(Ano, Periodo, "No. empleado");

    layout
    {
        area(content)
        {
            field(Filtros; '')
            {
                ApplicationArea = All;
                CaptionClass = FORMAT('Filtros : ' + GETFILTERS);
                Editable = false;
            }
            group(General)
            {
                Caption = 'General';
                field("No. empleado"; Rec."No. empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'No. empleado';
                    Editable = false;
                    Importance = Promoted;
                }
                field(Nombre; Rec.Nombre)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Centro trabajo"; Rec."Centro trabajo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Centro trabajo';
                    Editable = false;
                }
                field(Inicio; Rec.Inicio)
                {
                    ApplicationArea = All;
                    ToolTip = 'Inicio';
                    Editable = false;
                    Importance = Promoted;
                }
                field(Fin; Rec.Fin)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fin';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Tipo Empleado"; Rec."Tipo Empleado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Empleado';
                    Editable = false;
                }
                field("Tipo de nomina"; Rec."Tipo de nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo de nomina';
                    Editable = false;
                }
                field("Tipo Nomina"; Rec."Tipo Nomina")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Nomina';
                    Editable = false;
                }
                field("Fecha Entrada"; Rec."Fecha Entrada")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Entrada';
                    Editable = false;
                }
                field("Fecha Salida"; Rec."Fecha Salida")
                {
                    ApplicationArea = All;
                    ToolTip = 'Fecha Salida';
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 1 Code';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shortcut Dimension 2 Code';
                    Editable = false;
                }
            }
            part(HistLinNom; 55765)
            {
                SubPageLink = "No. empleado" = FIELD("No. empleado"),
                              "Tipo de nomina" = FIELD("Tipo de nomina"),
                              Periodo = FIELD(Periodo);
            }
            group(Bases)
            {
                Caption = 'Bases';
                field("Base ISR"; Rec."Base ISR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Base ISR';
                    Caption = 'Base ISR';
                    Editable = false;
                }
                field("Total Ingresos"; Rec."Total Ingresos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total Ingresos';
                    Caption = 'Total Ingresos';
                    Editable = false;
                }
                field("Total deducciones"; Rec."Total deducciones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total deducciones';
                    Editable = false;
                }
                field("Forma de Cobro"; Rec."Forma de Cobro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Forma de Cobro';
                    Editable = false;
                }
                field("Tipo Cuenta"; Rec."Tipo Cuenta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo Cuenta';
                    Editable = false;
                }
                field(Cuenta; Rec.Cuenta)
                {
                    ApplicationArea = All;
                    ToolTip = 'Cuenta';
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
                    ApplicationArea = All;
                    Caption = 'Statistic';
                    ToolTip = 'Statistic';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 55767;
                    RunPageLink = "No. Documento" = FIELD("No. Documento"),
                                  "No. empleado" = FIELD("No. empleado"),
                                  "Tipo de nomina" = FIELD("Tipo de nomina"),
                                  Periodo = FIELD(Periodo);
                    ShortCutKey = 'F7';
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    ToolTip = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }

                action("<Action83>$")
                {
                    ApplicationArea = All;
                    Caption = 'Batch voids';
                    ToolTip = 'Batch voids';
                    Image = Cancel;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    // TODO: Manual review - Custom report 55764 is unavailable as the required object type.
                    // Original code: RunObject = Report 55764;

                    trigger OnAction()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
            }

            action(editar)
            {
                ApplicationArea = All;
                Caption = 'editar';
                ToolTip = 'editar';
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
                ApplicationArea = All;
                Caption = 'P&rint';
                ToolTip = 'P&rint';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                // TODO: Manual review - Custom codeunit 55744 is unavailable as the required object type.
                // Original code: RunObject = Codeunit 55744;
            }
        }
    }

    var
        RegEmpCotizacion: Record 55741;
        TipoEmpleado: Option Fijos,Temporales,Otros,Todos;
}

