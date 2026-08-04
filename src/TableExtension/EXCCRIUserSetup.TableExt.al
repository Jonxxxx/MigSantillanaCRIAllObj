tableextension 55246 EXCCRIUserSetup extends "User Setup"
{
    fields
    {
        field(55225; "Permite modificar Cupon"; Boolean)
        {
            Caption = 'Allow modify Coupon';
            DataClassification = CustomerContent;
        }
        field(55226; "Permite Reimprimir Historicos"; Boolean)
        {
            Caption = 'Allow Print Posted Documents';
            DataClassification = CustomerContent;
        }
        field(55227; "Modifica Fecha Pedidos Venta"; Boolean)
        {
            Caption = 'Modify date in Sales Order';
            DataClassification = CustomerContent;
        }
        field(55228; "Permite Modificar NIT en Hist."; Boolean)
        {
            Caption = 'Allow to modify VAT in Posted Inv.';
            DataClassification = CustomerContent;
        }
        field(55229; "Permite Anular Folios IFacere"; Boolean)
        {
            Caption = 'Allow to void Folios at IFacere';
            DataClassification = CustomerContent;
        }
        field(55230; "Modifica Precio Venta"; Boolean)
        {
            Caption = 'Modify Sales Price';
            DataClassification = CustomerContent;
        }
        field(55231; "Modifica Descuento Venta"; Boolean)
        {
            Caption = 'Modify Sales Discount';
            DataClassification = CustomerContent;
        }
        field(55232; "Desbloquea Clientes"; Boolean)
        {
            Caption = 'Unlock Customers';
            DataClassification = CustomerContent;
        }
        field(55233; "Modifica Desc. prod. Lin. Vta."; Boolean)
        {
            Caption = 'Modify Item Desc. in Sales Line';
            DataClassification = CustomerContent;
        }
        field(55234; "Usuario Movilidad"; Boolean)
        {
            Caption = 'Mobile user';
            DataClassification = CustomerContent;
        }
        field(55235; "Ubicacion Impresion Etiqueta"; Text[250])
        {
            Caption = 'Label print path';
            DataClassification = CustomerContent;
        }
        field(55236; "Mod. Fecha Recep. Fact. Vta."; Boolean)
        {
            Caption = 'Modify Reception date in Sales Invoice';
            DataClassification = CustomerContent;
        }
        field(55237; "Puerto Imp. Fiscal"; Text[30])
        {
            Caption = 'Fiscal Printer Port';
            DataClassification = CustomerContent;
        }
        field(55238; "Velocidad Imp. Fiscal"; Integer)
        {
            Caption = 'Fiscal Printer Port Speed';
            DataClassification = CustomerContent;
        }
        field(55239; "Aprueba Cantidades"; Boolean)
        {
            Caption = 'Approve Sales Qty.';
            DataClassification = CustomerContent;
        }
        field(55242; "Puerto Impresora Etiquetas"; Text[30])
        {
            Caption = 'Labels Printer Port';
            DataClassification = CustomerContent;
        }
        field(55243; "Tipo Conexion Impr. Etiquetas"; Option)
        {
            Caption = 'Label Printer Connection Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Local,"Terminal Service";
        }
        field(55246; "Aprueba Cantidades Transf."; Boolean)
        {
            Caption = 'Approve Transfer Qty.';
            DataClassification = CustomerContent;
        }
        field(55247; "Anula Hoja de Ruta"; Boolean)
        {
            Caption = 'Void Route Guide';
            DataClassification = CustomerContent;
        }
        field(55248; "Nombre Maquina Etiqueta Caja"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(55249; "Nombre Impresora. Etiq. Caja"; Text[30])
        {
            Caption = 'Tag Box Printer Shared Name';
            DataClassification = CustomerContent;
        }
        field(55026; "Desbloquea Productos"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55027; "Desbloquea Proveedores"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55028; "Desbloquea Activos Fijos"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55030; "Desbloquea Contactos"; Boolean)
        {
            Caption = 'Unlock Contacts';
            DataClassification = CustomerContent;
        }
        field(55031; "Permitir Descuento Hasta"; Decimal)
        {
            Caption = 'Allow Discount Up To (%)';
            DataClassification = CustomerContent;
        }
        field(55032; "Desbloquea Proyectos"; Boolean)
        {
            Caption = 'Unblock Jobs';
            DataClassification = CustomerContent;
        }
        field(55033; "Desbloquea Empleados"; Boolean)
        {
            Caption = 'Unblock Employees';
            DataClassification = CustomerContent;
        }
        field(55199; "Permite Mod. Fecha Recep. Doc."; Boolean)
        {
            Caption = 'Allow Document Reception Date Modification';
            DataClassification = CustomerContent;
        }
        field(54005; "Permite Obviar Packing"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(56000; "Permite cambiar estado packing"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(56001; "Activa/Inactiva Maestros"; Boolean)
        {
            Caption = 'Active/Inactive Files';
            DataClassification = CustomerContent;
        }
        field(75000; "Editar Prod. MdM Parcial"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(75001; "Editar Prod. MdM Total"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(75002; "Arranca Cola Proyecto MdM"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(75003; "Modificar Ped E-commerce"; Boolean)
        {
            Caption = 'Modify E-commerce Orders';
            DataClassification = CustomerContent;
        }
    }
}
