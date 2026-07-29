page 56069 "Crea Cupones en Lote"
{
    // #140677, RRT, 14.05.2018: Que varios usuarios puedan crear simultaneamente cupones por lote.

    ApplicationArea = Basic, Suite, Service;
    DelayedInsert = false;
    PageType = List;
    SourceTable = 51015;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Año Escolar"; Rec."Ano Escolar")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ano Escolar';
                }
                field("Cod. Colegio"; Rec."Cod. Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Colegio';
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Cliente';
                }
                field("Grado del Alumno"; Rec."Grado Alumno")
                {
                    ApplicationArea = All;
                    ToolTip = 'Grado Alumno';
                    Caption = 'Grado del Alumno';
                    TableRelation = Grado;
                }
                field("Descuento a colegio"; Rec."Dto Colegio")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto Colegio';
                    Caption = 'Nombre Vendedor';
                }
                field("Descuento a padre"; Rec."Dto Padre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto Padre';
                    Caption = 'Descuento a padre';
                }
                field("Dto. Aplica a Lineas"; Rec."Dto. Aplica a Lineas")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Aplica a Lineas';
                }
                field("Nombre Maestro"; Rec."Nombre Maestro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre Maestro';
                }
                field("Dto. Maestro"; Rec."Dto. Maestro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Dto. Maestro';
                }
                field("Descripcion"; Rec.Descripcion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Descripcion';
                    Caption = 'Description';
                }
                field("Válido desde:"; Rec."Valido Desde")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valido Desde';
                    Caption = 'Valid From';
                }
                field("Válido Hasta:"; Rec."Valido Hasta")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valido Hasta';
                    Caption = 'Valid To:';
                }
                field("Cod. Vendedor"; Rec."Cod. Vendedor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cod. Vendedor';
                    Caption = 'Salesperson Code';
                    TableRelation = "Salesperson/Purchaser";
                }
                field("Nombre vendedor"; NombreVendedor("Cod. Vendedor"))
                {
                    ApplicationArea = All;
                    Caption = 'Nombre vendedor';
                    Editable = false;
                }
                field("Cantidad Limite"; Rec."Cantidad Limite")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Limite';
                }
                field("Importe Dto. Limite"; Rec."Importe Dto. Limite")
                {
                    ApplicationArea = All;
                    ToolTip = 'Importe Dto. Limite';
                }
                field("Cantidad de Cupones"; Rec."Cantidad Cupones")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cantidad Cupones';
                    Caption = 'Coupons Qty.';
                }
            }
            part(Lineas; 56070)
            {
                SubPageLink = Lote = FIELD("Lote");
                SubPageView = SORTING("Cod. Producto")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("G&rupo Negocio")
            {
                Caption = 'Business Group';
                Image = BreakRulesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 51011;
                RunPageLink = "No. Lote cupon" = FIELD(Lote);
                RunPageView = SORTING("No. Lote cupon", "Grupo Negocio")
                              ORDER(Ascending);
            }
            action("&Generar")
            {
                Caption = '&Generate';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    ComprobarLote(Lote);
                    cuFunSantillana.cuCreaCupones(Rec."Cod. Colegio", Rec."Cod. Vendedor", NombreVendedor(Rec."Cod. Vendedor"), Rec."Valido Desde", Rec."Valido Hasta", Rec."Grado Alumno", Rec."Dto Colegio",
                                                 Rec."Dto Padre", Rec."Ano Escolar", NombreColegio(Rec."Cod. Colegio"), Rec.Descripcion, Rec."Cantidad Cupones", Rec.Lote, Rec."Cantidad Limite", Rec."Importe Dto. Limite", Rec."Cod. Cliente", Rec."Nombre Cliente");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //+#140677
        //DELETEALL(TRUE);
        //... Solo borramos los del usuario.
        SETRANGE(Usuario, USERID);
        DELETEALL(TRUE);
        SETRANGE(Usuario);
        //-#140677

        INSERT(TRUE);
        FILTERGROUP(2);
        SETFILTER(Lote, '%1', Lote);
        FILTERGROUP(0);
    end;

    var
        cuFunSantillana: Codeunit 56000;

    procedure NombreColegio(pColegio: Code[20]): Text
    var
        rContact: Record 5050;
    begin

        IF pColegio = '' THEN
            EXIT
        ELSE
            IF rContact.GET(pColegio) THEN
                EXIT(rContact.Name);
    end;

    procedure NombreVendedor(pVendedor: Code[10]): Text
    var
        rSalesPerson: Record 13;
    begin

        IF pVendedor = '' THEN
            EXIT
        ELSE
            IF rSalesPerson.GET(pVendedor) THEN
                EXIT(rSalesPerson.Name);
    end;
}

