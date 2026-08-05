page 55698 "Lista Imp.Mdm Tabla"
{
    CardPageID = "Imp.MdM Tabla";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = true;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = 55685;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Rec.Id)
                {
                    ApplicationArea = All;
                    ToolTip = 'Id';
                    Visible = false;
                }
                field(Operacion; Rec.Operacion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Operacion';
                    Visible = false;
                }
                field("Id Tabla"; Rec."Id Tabla")
                {
                    ApplicationArea = All;
                    ToolTip = 'Id Tabla';
                }
                field(Campo; cFumImp.GetTableCaption(Rec."Id Tabla"))
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Tabla';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field("Code MdM"; Rec."Code MdM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code MdM';
                }
                field(Descripcion; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                }
                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tipo';
                }
                field("Nombre Elemento"; Rec."Nombre Elemento")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Elemento';
                }
                field(Visible; Rec.Visible)
                {
                    ApplicationArea = All;
                    ToolTip = 'Visible';
                }
                field(Procesado; Rec.Procesado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Procesado';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Tabla)
            {
                Caption = 'Tabla';
                Image = "Table";
                action(Ver)
                {
                    ApplicationArea = All;
                    Caption = 'Ver';
                    ToolTip = 'Ver';
                    Image = View;
                    RunObject = Page 55685;
                    RunPageOnRec = true;
                }
                action(Ficha)
                {
                    ApplicationArea = All;
                    Caption = 'Ficha';
                    ToolTip = 'Ficha';
                    Image = Form;

                    trigger OnAction()
                    begin

                        VerFicha;
                    end;
                }
            }
            action("Solo Pendientes")
            {

                ApplicationArea = All;
                Caption = 'Solo Pendientes';
                ToolTip = 'Solo Pendientes';
                trigger OnAction()
                begin
                    SETRANGE(Procesado, FALSE);
                end;
            }
        }
    }

    var
        cFumImp: Codeunit 55682;
}

