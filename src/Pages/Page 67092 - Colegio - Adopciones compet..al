page 55551 "Colegio - Adopciones compet."
{
    DataCaptionFields = "Cod. Colegio", "Nombre Colegio", "Cod. Nivel";
    PageType = Card;
    SourceTable = 55500;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cod. Editorial"; Rec."Cod. Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Editorial';
                }
                field("Cod. Producto Editora"; Rec."Cod. Producto Editora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Producto Editora';
                }
                field("Cod. Grado"; Rec."Cod. Grado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Grado';
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Editorial"; Rec."Nombre Editorial")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Editorial';
                    Editable = false;
                    Visible = false;
                }
                field("Nombre Colegio"; Rec."Nombre Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Colegio';
                    Editable = false;
                }
                field("Descripcion producto"; Rec."Descripcion producto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion producto';
                    Editable = false;
                }
                field("Nombre Producto Editora"; Rec."Nombre Producto Editora")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Producto Editora';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        VALIDATE("Cod. Colegio", CodColegio);
        VALIDATE("Cod. Promotor", CodPromotor);
        VALIDATE("Cod. Producto", CodProducto);
        VALIDATE("Cod. Nivel", CodNivel);
        "Cod. Grado" := CodGrado;
    end;

    trigger OnOpenPage()
    begin
        SETRANGE("Cod. Colegio", CodColegio);
        SETRANGE("Cod. Promotor", CodPromotor);
        SETRANGE("Cod. Producto", CodProducto);
        SETRANGE("Cod. Nivel", CodNivel);
        SETRANGE("Cod. Grado", CodGrado);
        //MESSAGE('%1',GETFILTERS);
    end;

    var
        CodColegio: Code[20];
        CodPromotor: Code[20];
        CodProducto: Code[20];
        CodNivel: Code[20];
        CodGrado: Code[20];

    procedure RecibeParametros(CodCol: Code[20]; CodProm: Code[20]; CodProd: Code[20]; CodNiv: Code[20]; CodGrad: Code[20])
    begin
        CodColegio := CodCol;
        CodPromotor := CodProm;
        CodProducto := CodProd;
        CodNivel := CodNiv;
        CodGrado := CodGrad;
    end;
}

