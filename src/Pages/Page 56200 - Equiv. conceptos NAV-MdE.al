page 55353 "Equiv. conceptos NAV-MdE"
{
    ApplicationArea = Basic, Suite, Service;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Show';
    SourceTable = 34002111;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            fixed("Tipo dato MdE")
            {
                Caption = 'Tipo dato MdE';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                field(MdEEquivalenceJX; GetMdEEquiv)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
            }
            repeater(Group)
            {
                FreezeColumn = "Descripcion";
                field(Codigo; Rec.Codigo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Codigo';
                    Editable = false;
                }
                field(Descripcion; Rec."Descripcion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                    Editable = false;
                }
                field(Concept01JX; BooleanArray[1])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[1];
                    Visible = NoColumns > 0;

                    trigger OnValidate()
                    begin
                        ValidateColumn(1);
                    end;
                }
                field(Concept02JX; BooleanArray[2])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[2];
                    Visible = NoColumns > 1;

                    trigger OnValidate()
                    begin
                        ValidateColumn(2);
                    end;
                }
                field(Concept03JX; BooleanArray[3])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[3];
                    Visible = NoColumns > 2;

                    trigger OnValidate()
                    begin
                        ValidateColumn(3);
                    end;
                }
                field(Concept04JX; BooleanArray[4])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[4];
                    Visible = NoColumns > 3;

                    trigger OnValidate()
                    begin
                        ValidateColumn(4);
                    end;
                }
                field(Concept05JX; BooleanArray[5])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[5];
                    Visible = NoColumns > 4;

                    trigger OnValidate()
                    begin
                        ValidateColumn(5);
                    end;
                }
                field(Concept06JX; BooleanArray[6])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[6];
                    Visible = NoColumns > 5;

                    trigger OnValidate()
                    begin
                        ValidateColumn(6);
                    end;
                }
                field(Concept07JX; BooleanArray[7])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[7];
                    Visible = NoColumns > 6;

                    trigger OnValidate()
                    begin
                        ValidateColumn(7);
                    end;
                }
                field(Concept08JX; BooleanArray[8])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[8];
                    Visible = NoColumns > 7;

                    trigger OnValidate()
                    begin
                        ValidateColumn(8);
                    end;
                }
                field(Concept09JX; BooleanArray[9])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[9];
                    Visible = NoColumns > 8;

                    trigger OnValidate()
                    begin
                        ValidateColumn(9);
                    end;
                }
                field(Concept10JX; BooleanArray[10])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[10];
                    Visible = NoColumns > 9;

                    trigger OnValidate()
                    begin
                        ValidateColumn(10);
                    end;
                }
                field(Concept11JX; BooleanArray[11])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[11];
                    Visible = NoColumns > 10;

                    trigger OnValidate()
                    begin
                        ValidateColumn(11);
                    end;
                }
                field(Concept12JX; BooleanArray[12])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[12];
                    Visible = NoColumns > 11;

                    trigger OnValidate()
                    begin
                        ValidateColumn(12);
                    end;
                }
                field(Concept13JX; BooleanArray[13])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[13];
                    Visible = NoColumns > 12;

                    trigger OnValidate()
                    begin
                        ValidateColumn(13);
                    end;
                }
                field(Concept14JX; BooleanArray[14])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[14];
                    Visible = NoColumns > 13;

                    trigger OnValidate()
                    begin
                        ValidateColumn(14);
                    end;
                }
                field(Concept15JX; BooleanArray[15])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[15];
                    Visible = NoColumns > 14;

                    trigger OnValidate()
                    begin
                        ValidateColumn(15);
                    end;
                }
                field(Concept16JX; BooleanArray[16])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[16];
                    Visible = NoColumns > 15;

                    trigger OnValidate()
                    begin
                        ValidateColumn(16);
                    end;
                }
                field(Concept17JX; BooleanArray[17])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[17];
                    Visible = NoColumns > 16;

                    trigger OnValidate()
                    begin
                        ValidateColumn(17);
                    end;
                }
                field(Concept18JX; BooleanArray[18])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[18];
                    Visible = NoColumns > 17;

                    trigger OnValidate()
                    begin
                        ValidateColumn(18);
                    end;
                }
                field(Concept19JX; BooleanArray[19])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[19];
                    Visible = NoColumns > 18;

                    trigger OnValidate()
                    begin
                        ValidateColumn(19);
                    end;
                }
                field(Concept20JX; BooleanArray[20])
                {
                    ApplicationArea = All;
                    CaptionClass = ColumnNameArray[20];
                    Visible = NoColumns > 19;

                    trigger OnValidate()
                    begin
                        ValidateColumn(20);
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Informacion Real Mensual")
            {
                ApplicationArea = All;
                Caption = 'Informacion Real Mensual';
                ToolTip = 'Informacion Real Mensual';
                Enabled = MdEDataType = 1;
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MdEDataType := MdEDataType::IRM;
                    SetNoColumns;
                end;
            }
            action("Compensacion Teorica")
            {
                ApplicationArea = All;
                Caption = 'Compensacion Teorica';
                ToolTip = 'Compensacion Teorica';
                Enabled = MdEDataType = 0;
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MdEDataType := MdEDataType::CT;
                    SetNoColumns;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        i: Integer;
    begin
        FOR i := 1 TO NoColumns DO BEGIN
            IF MdEDataType = MdEDataType::IRM THEN
                BooleanArray[i] := EquivNavMdE.GET(Codigo, i, 0) AND (EquivNavMdE.Porcentaje > 0)
            ELSE
                BooleanArray[i] := EquivNavMdE.GET(Codigo, 0, i) AND (EquivNavMdE.Porcentaje > 0)
        END;
    end;

    trigger OnOpenPage()
    begin
        SetNoColumns;
    end;

    var
        EquivNavMdE: Record 55354;
        BooleanArray: array[20] of Boolean;
        ColumnNameArray: array[20] of Text[20];
        NoColumns: Integer;
        MdEDataType: Option IRM,CT;
        Text000: Label 'Informacion Real Mensual';
        Text001: Label 'Compensacion Teorica';

    procedure SetNoColumns()
    var
        i: Integer;
    begin
        CLEAR(ColumnNameArray);
        NoColumns := EquivNavMdE.GetNoConcepts(MdEDataType);
        FOR i := 1 TO NoColumns DO BEGIN
            IF MdEDataType = MdEDataType::IRM THEN BEGIN
                EquivNavMdE."Concepto IRM" := i;
                ColumnNameArray[i] := STRSUBSTNO('%1', EquivNavMdE."Concepto IRM");
            END
            ELSE BEGIN
                EquivNavMdE."Concepto CT" := i;
                ColumnNameArray[i] := STRSUBSTNO('%1', EquivNavMdE."Concepto CT");
            END;
        END;
        CurrPage.UPDATE(FALSE);
    end;

    procedure ValidateColumn(Column: Integer)
    var
        IrmVal: Integer;
        CtVal: Integer;
    begin
        IF MdEDataType = MdEDataType::IRM THEN
            IrmVal := Column
        ELSE
            CtVal := Column;

        IF BooleanArray[Column] THEN BEGIN
            IF EquivNavMdE.GET(Codigo, IrmVal, CtVal) THEN BEGIN
                EquivNavMdE.Porcentaje := 1;
                EquivNavMdE.MODIFY;
            END
            ELSE BEGIN
                EquivNavMdE."Concepto NAV" := Codigo;
                EquivNavMdE."Concepto IRM" := IrmVal;
                EquivNavMdE."Concepto CT" := CtVal;
                EquivNavMdE.Porcentaje := 1;
                EquivNavMdE.INSERT;
            END
        END
        ELSE BEGIN
            IF EquivNavMdE.GET(Codigo, IrmVal, CtVal) THEN
                EquivNavMdE.DELETE;
        END;
    end;

    procedure GetMdEEquiv(): Text[50]
    begin
        IF MdEDataType = MdEDataType::IRM THEN
            EXIT(Text000)
        ELSE
            EXIT(Text001);
    end;
}

