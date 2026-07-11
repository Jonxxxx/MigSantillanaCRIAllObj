page 56069 "Crea Cupones en Lote"
{
    // #140677, RRT, 14.05.2018: Que varios usuarios puedan crear simultaneamente cupones por lote.

    ApplicationArea = Basic, Suite, Service;
    DelayedInsert = false;
    PageType = List;
    SourceTable = Table51015;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Año Escolar"; "Año Escolar")
                {
                }
                field("Cod. Colegio"; "Cod. Colegio")
                {
                }
                field("Nombre Cliente"; "Nombre Cliente")
                {
                }
                field("Grado del Alumno"; "Grado Alumno")
                {
                    Caption = 'Grado del Alumno';
                    TableRelation = Grado;
                }
                field("Descuento a colegio"; "Dto Colegio")
                {
                    Caption = 'Nombre Vendedor';
                }
                field("Descuento a padre"; "Dto Padre")
                {
                    Caption = 'Descuento a padre';
                }
                field("Dto. Aplica a Lineas"; "Dto. Aplica a Lineas")
                {
                }
                field("Nombre Maestro"; "Nombre Maestro")
                {
                }
                field("Dto. Maestro"; "Dto. Maestro")
                {
                }
                field("Descripción"; Descripcion)
                {
                    Caption = 'Description';
                }
                field("Válido desde:"; "Valido Desde")
                {
                    Caption = 'Valid From';
                }
                field("Válido Hasta:"; "Valido Hasta")
                {
                    Caption = 'Valid To:';
                }
                field("Cód. Vendedor"; "Cod. Vendedor")
                {
                    Caption = 'Salesperson Code';
                    TableRelation = "Salesperson/Purchaser";
                }
                field("Nombre vendedor"; NombreVendedor("Cod. Vendedor"))
                {
                    Caption = 'Nombre vendedor';
                    Editable = false;
                }
                field("Cantidad Limite"; "Cantidad Limite")
                {
                }
                field("Importe Dto. Limite"; "Importe Dto. Limite")
                {
                }
                field("Cantidad de Cupones"; "Cantidad Cupones")
                {
                    Caption = 'Coupons Qty.';
                }
            }
            part(Lineas; 56070)
            {
                SubPageLink = Lote = FIELD(Lote);
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
                RunPageLink = No. Lote cupon=FIELD(Lote);
                RunPageView = SORTING(No. Lote cupon)
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
                    cuFunSantillana.cuCreaCupones("Cod. Colegio","Cod. Vendedor",NombreVendedor("Cod. Vendedor"),"Valido Desde","Valido Hasta","Grado Alumno","Dto Colegio",
                                                  "Dto Padre","Año Escolar",NombreColegio("Cod. Colegio"),Descripcion,"Cantidad Cupones",Lote,"Cantidad Limite","Importe Dto. Limite","Cod. Cliente","Nombre Cliente");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //+#140677
        //DELETEALL(TRUE);
        //... Sólo borramos los del usuario.
        SETRANGE(Usuario,USERID);
        DELETEALL(TRUE);
        SETRANGE(Usuario);
        //-#140677

        INSERT(TRUE);
        FILTERGROUP(2);
        SETFILTER(Lote,'%1',Lote);
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

