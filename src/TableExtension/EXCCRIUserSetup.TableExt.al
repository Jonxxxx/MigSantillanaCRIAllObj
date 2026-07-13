tableextension 50021 EXCCRIUserSetup extends "User Setup"
{
    fields
    {
        field(50000; "Permite modificar Cupon"; Boolean)
        {
            Caption = 'Allow modify Coupon';
            DataClassification = ToBeClassified;
        }
        field(50001; "Permite Reimprimir Historicos"; Boolean)
        {
            Caption = 'Allow Print Posted Documents';
            DataClassification = ToBeClassified;
        }
        field(50002; "Modifica Fecha Pedidos Venta"; Boolean)
        {
            Caption = 'Modify date in Sales Order';
            DataClassification = ToBeClassified;
        }
        field(50003; "Permite Modificar NIT en Hist."; Boolean)
        {
            Caption = 'Allow to modify VAT in Posted Inv.';
            DataClassification = ToBeClassified;
        }
        field(50004; "Permite Anular Folios IFacere"; Boolean)
        {
            Caption = 'Allow to void Folios at IFacere';
            DataClassification = ToBeClassified;
        }
        field(50005; "Modifica Precio Venta"; Boolean)
        {
            Caption = 'Modify Sales Price';
            DataClassification = ToBeClassified;
        }
        field(50006; "Modifica Descuento Venta"; Boolean)
        {
            Caption = 'Modify Sales Discount';
            DataClassification = ToBeClassified;
        }
        field(50007; "Desbloquea Clientes"; Boolean)
        {
            Caption = 'Unlock Customers';
            DataClassification = ToBeClassified;
        }
        field(50008; "Modifica Desc. prod. Lin. Vta."; Boolean)
        {
            Caption = 'Modify Item Desc. in Sales Line';
            DataClassification = ToBeClassified;
        }
        field(50009; "Usuario Movilidad"; Boolean)
        {
            Caption = 'Mobile user';
            DataClassification = ToBeClassified;
        }
        field(50010; "Ubicacion Impresion Etiqueta"; Text[250])
        {
            Caption = 'Label print path';
            DataClassification = ToBeClassified;
        }
        field(50011; "Mod. Fecha Recep. Fact. Vta."; Boolean)
        {
            Caption = 'Modify Reception date in Sales Invoice';
            DataClassification = ToBeClassified;
        }
        field(50012; "Puerto Imp. Fiscal"; Text[30])
        {
            Caption = 'Fiscal Printer Port';
            DataClassification = ToBeClassified;
        }
        field(50013; "Velocidad Imp. Fiscal"; Integer)
        {
            Caption = 'Fiscal Printer Port Speed';
            DataClassification = ToBeClassified;
        }
        field(50014; "Aprueba Cantidades"; Boolean)
        {
            Caption = 'Approve Sales Qty.';
            DataClassification = ToBeClassified;
        }
        field(50017; "Puerto Impresora Etiquetas"; Text[30])
        {
            Caption = 'Labels Printer Port';
            DataClassification = ToBeClassified;
        }
        field(50018; "Tipo Conexion Impr. Etiquetas"; Option)
        {
            Caption = 'Label Printer Connection Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Local,"Terminal Service";
        }
        field(50021; "Aprueba Cantidades Transf."; Boolean)
        {
            Caption = 'Approve Transfer Qty.';
            DataClassification = ToBeClassified;
        }
        field(50022; "Anula Hoja de Ruta"; Boolean)
        {
            Caption = 'Void Route Guide';
            DataClassification = ToBeClassified;
        }
        field(50023; "Nombre Maquina Etiqueta Caja"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Nombre Impresora. Etiq. Caja"; Text[30])
        {
            Caption = 'Tag Box Printer Shared Name';
            DataClassification = ToBeClassified;
        }
        field(50026; "Desbloquea Productos"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Desbloquea Proveedores"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Desbloquea Activos Fijos"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Desbloquea Contactos"; Boolean)
        {
            Caption = 'Unlock Contacts';
            DataClassification = ToBeClassified;
        }
        field(50031; "Permitir Descuento Hasta"; Decimal)
        {
            Caption = 'Allow Discount Up To (%)';
            DataClassification = ToBeClassified;
        }
        field(50032; "Desbloquea Proyectos"; Boolean)
        {
            Caption = 'Unblock Jobs';
            DataClassification = ToBeClassified;
        }
        field(50033; "Desbloquea Empleados"; Boolean)
        {
            Caption = 'Unblock Employees';
            DataClassification = ToBeClassified;
        }
        field(52500; "Permite Mod. Fecha Recep. Doc."; Boolean)
        {
            Caption = 'Allow Document Reception Date Modification';
            DataClassification = ToBeClassified;
        }
        field(54005; "Permite Obviar Packing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56000; "Permite cambiar estado packing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56001; "Activa/Inactiva Maestros"; Boolean)
        {
            Caption = 'Active/Inactive Files';
            DataClassification = ToBeClassified;
        }
        field(75000; "Editar Prod. MdM Parcial"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75001; "Editar Prod. MdM Total"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75002; "Arranca Cola Proyecto MdM"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75003; "Modificar Ped E-commerce"; Boolean)
        {
            Caption = 'Modify E-commerce Orders';
            DataClassification = ToBeClassified;
        }
    }
}
