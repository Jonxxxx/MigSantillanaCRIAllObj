table 70500 MCliente01
{

    fields
    {
        field(2; Tratamiento; Text[4])
        {
            Description = 'Tipo de tratamiento del cliente (Sr., Don, etc)';
        }
        field(3; "Nombre 1"; Text[100])
        {
            Description = 'Nombre del cliente';
        }
        field(4; "Nombre 2"; Text[100])
        {
            Description = 'Nombre Adicional';
        }
        field(5; "Concepto de busqueda"; Text[20])
        {
            Description = 'Denominaci n breve para ayudas de b squeda.';
        }
        field(6; "Direccion calle"; Text[200])
        {
        }
        field(7; Poblacion; Text[60])
        {
        }
        field(8; "Codigo postal/Pobl"; Text[10])
        {
        }
        field(9; Pais; Text[20])
        {
            Description = 'Nuestra codificaci n.';
        }
        field(10; Region; Text[100])
        {
            Description = 'Nuestra codificaci n. Lookup en este documento.';
        }
        field(11; "Apartado de correos"; Text[10])
        {
        }
        field(12; "Cod.postal empresa"; Text[10])
        {
            Description = 'Codigo postal de la empresa (en caso de clientes import.) Codigo postal que se asigna directamente a una empresa.';
        }
        field(13; Idioma; Text[20])
        {
            Description = 'ES Por defecto';
        }
        field(14; Telefono; Text[30])
        {
        }
        field(15; Extension; Text[30])
        {
        }
        field(16; "Telefono Movil"; Text[30])
        {
        }
        field(17; Fax; Text[41])
        {
        }
        field(18; Extension2; Text[10])
        {
        }
        field(19; Email; Text[100])
        {
        }
        field(20; Comentarios; Text[50])
        {
        }
        field(21; Acreedor; Text[10])
        {
            Description = 'Indica una clave alfanum rica, que identifica un vocamente un el proveedor, o bien, acreedor en el Sistema R/3.';
        }
        field(22; "Clave de grupo"; Text[10])
        {
            Description = 'En caso de que el deudor o proveedor pertenezca a un grupo de empresas, se puede introducir aqu  una clave de grupo. La clave de grupo puede asignarse libremente. Si se forma un matchcode mediante esta clave de grupo, podr  efectuar evaluaciones a nivel de grupo de empresas.';
        }
        field(23; "N  ident.fis.1"; Text[30])
        {
            Description = 'Indica el n mero de identificaci n fiscal.';
        }
        field(24; "N.I.F. Comunitario"; Text[20])
        {
            Description = 'N mero de identificaci n fiscal (N.I.F.CE) comunitario del deudor, acreedor o de su sociedad FI.';
        }
        field(25; "Persona fisica"; Text[20])
        {
            Description = 'Denomina una persona f sica.';
        }
        field(26; "Pais (Banco)"; Text[20])
        {
            Description = 'Identifica el Pais en el cual tiene su sede el banco.';
        }
        field(27; "Clave banco"; Text[15])
        {
            Description = 'En este campo se indica la clave bajo la cual se almacenan los datos bancarios en el Pais correspondiente.';
        }
        field(28; "Cuenta bancaria"; Text[18])
        {
            Description = 'Este campo contiene el n mero bajo el cual se lleva la cuenta en el banco.';
        }
        field(29; Titular; Text[30])
        {
            Description = 'Indicaci n adicional de nombre necesaria para la gesti n autom rtica de pagos cuando el nombre del titular de la cuenta no coincide con el nombre del deudor o del acreedor';
        }
        field(30; "Clave de control"; Text[30])
        {
            Description = 'Este campo contiene una clave de verificaci n para la combinaci n del Codigo bancario y el n mero de la cuenta bancaria.';
        }
        field(31; Iban; Text[34])
        {
            Description = 'Se trata del n mero de identificaci n un voco para representar los datos bancarios siguiendo la normativa del ECBS (European Commitee for Banking Standards). Un IBAN contiene un m ximo de 34 caracteres alfanum ricos que combina los siguientes elementos:';
        }
        field(32; "Clase Cliente"; Text[20])
        {
            Description = 'Indica la clasificaci n de clientes (por ejemplo, mayorista).Mandar nuestro tipo de cliente. Lookup en este documento.';
        }
        field(33; Ramo; Text[20])
        {
            Description = 'Clave de ramo industrial. Un ramo es una divisi n por empresas seg n el centro de gravedad de su actividad econ mica. Se utiliza la clave de ramo para limitar las evaluaciones (p. ej.,  ndice de datos maestros de acreedor). Se pueden utilizar como ramos,';
        }
        field(34; "Codigo ramo 1"; Text[10])
        {
            Description = 'Indica un Codigo que identifica un vocamente el ramo (o los ramos) del cliente.';
        }
        field(35; "Cuenta asociada"; Text[10])
        {
            Description = 'Cuenta asociada en la contabilidad principal. La cuenta asociada en la contabilidad de mayor es aquella, en la que se actualizan valores (p.ej., de facturas, pagos, etc.) paralelamente a la cuenta de la contabilidad secundaria.';
        }
        field(36; "Clave clasif"; Text[10])
        {
            Description = 'Clave para clasificar por n meros de asignaci n. Clave que simboliza la regla de estructuraci n para el campo Asignaci n en la posici n del documento.';
        }
        field(37; "Grupo Tesoreria"; Text[10])
        {
            Description = 'En la gesti n de caja se asignan deudores y acreedores a trav s de una entrada de registro maestro a grupos de tesorer a.';
        }
        field(38; "Condiciones de pago"; Text[10])
        {
            Description = 'Clave mediante la que se definen las condiciones de pago en forma de tipos de descuento y plazos de pago.';
        }
        field(39; "Gabar historial de pagos"; Text[10])
        {
            Description = 'Indicador que fija que se grabe el historial de pago del deudor. Se registran por mes natural los importes y n mero de los pagos y el promedio de d as de demora. Las informaciones se graban separadamente en para pagos con descuento y pagos netos.Mandar vacio.';
        }
        field(40; "Vias de pago"; Text[10])
        {
            Description = 'Lista de las v as de pago que pueden utilizarse en los pagos autom ticos con esta empresa colaboradora si no se ha indicado ninguna v a de pago en la partida a pagar.';
        }
        field(41; "Pago unico"; Text[10])
        {
            Description = 'Indicador: Pagar todas las partidas individualmente. A trav s de este campo se fija que se pague por separado cada partida abierta del interlocutor comercial. Esto quiere decir, que las par- tidas abiertas no se agrupar n para el pago.';
        }
        field(42; "Extracto de cuenta"; Text[10])
        {
            Description = 'Identificaci n para extractos de cuenta peri dicos. En el registro maestro puede definirse una identificaci n para que la cuenta sea tenida en consideraci n por el sistema al generar extractos peri dicos. Definiendo varias identificaciones, ser  posible formar grupos de cuentas con intervalos diferentes para los extractos de cuenta. Las identificaciones pueden definirse libremente.1Extracto de cuenta semanal o tipo 12Extracto de cuenta mensual o tipo 2';
        }
        field(43; "Cta.en deudor"; Text[30])
        {
            Description = 'Visualiza el n mero de cuenta bajo el cual se registra la propia empresa en el deudor.';
        }
        field(44; "Respons.deudor"; Text[30])
        {
            Description = 'Nombre o sigla del responsable en la empresa del deudor.';
        }
        field(45; "Tel.responsable"; Text[30])
        {
            Description = 'N mero de tel fono del responsable en interlocutor comercial';
        }
        field(46; "Telefax encarg."; Text[30])
        {
            Description = 'Telefax del encargado en el interlocutor comercial';
        }
        field(47; "Internet resp."; Text[30])
        {
            Description = 'Direcci n Internet del responsable del interlocutor comerc.';
        }
        field(48; "Nota interior"; Text[40])
        {
            Description = 'Nota interna de la contabilidad financiera. Esta nota sirve solamente para informar sobre las peculiaridades del interlocutor comercial.';
        }
        field(49; "Organizaci n"; Text[10])
        {
            Description = 'Organizaci n de ventas (Nacional, Exportaci n, Ventas Especiales, etc)';
        }
        field(50; Canal; Text[30])
        {
            Description = 'Canal de Venta (Librer as, Distribuci n, Grandes Cuentas, Televenta, etc)';
        }
        field(51; Sector; Text[10])
        {
            Description = 'Constante 10';
        }
        field(52; "Oficina ventas"; Text[10])
        {
            Description = 'Delegacion (p. ej. una sucursal) responsable de la comercializaci n de determinados productos y servicios en una determinada zona geogr fica.';
        }
        field(53; "Gr.vendedores"; Text[10])
        {
            Description = 'Grupo de comerciales responsables de la gesti n de ventas para determinados productos o prestaciones de servicios.';
        }
        field(54; "Grupo clientes"; Text[10])
        {
            Description = 'Define un determinado grupo de cliente (p. ej. mayoristas o minoristas) y se utiliza para determinar precios y con fines estad sticos.';
        }
        field(55; Moneda; Text[10])
        {
            Description = 'Moneda del cliente de un  rea de ventas. En la organizaci n de ventas indicada se liquida al cliente en esta moneda.';
        }
        field(56; "Cta.en deudor2"; Text[12])
        {
            Description = 'Este campo contiene nuestro n mero de cuenta con el cliente o proveedor.';
        }
        field(57; "Prioridad de entrega"; Text[30])
        {
            Description = 'Prioridad de entrega asignada a una posici n.01 URGENTE02 NORMAL';
        }
        field(58; "Condici n expEdicion"; Text[30])
        {
            Description = 'Estrategia general de expEdicion con la que se entregan mercanc as del proveedor al cliente.';
        }
        field(59; "Relevante ARE"; Text[30])
        {
            Description = 'Este indicador gestiona el proceso de la gesti n ARE (acuse de recibo de entrega). La gesti n ARE se activa al conectar el indicador "relevante para ARE" en la vista de expEdicion para el cliente y al asignarlo a un tipo de posici n de entrega en el Customizing.';
        }
        field(60; "Agrupamiento de pedidos"; Text[30])
        {
            Description = 'Indica si est  o no permitido agrupar los pedidos de un cliente el momento de crear las entregas.';
        }
        field(61; "Entrega completa obligatoria"; Text[30])
        {
            Description = 'Indica si un pedido de cliente o de compras debe ser suministrado completamente en una sola entrega o si puede ser suministrado en varias entregas parciales.';
        }
        field(62; "Tratam. Posterior facturas"; Text[30])
        {
            Description = 'Indica si se deben imprimir las facturas para el tratamiento manual posterior.';
        }
        field(63; Rappel; Text[30])
        {
            Description = 'Controla si se puede conceder un rappel a un cliente.';
        }
        field(64; "Determ.precios"; Text[30])
        {
            Description = 'Indicador relevante para determinaci n de precios. Si el registro maestro representa un nodo en una jerarqu a de clientes, el indicador de determinaci n de precio controlar  si el nodo es relevante para la determinaci n de precio.';
        }
        field(65; "Fechas facturaci n"; Text[30])
        {
            Description = 'Identifica el calendario que fija las fechas de facturaci n del cliente.';
        }
        field(66; "Fe.listas fact."; Text[30])
        {
            Description = 'Indica el calendario de f brica del cliente utilizado para el tratamiento de las listas de facturas.';
        }
        field(67; Incoterms; Text[30])
        {
            Description = 'F rmulas usuales de contrato que corresponden a las reglas establecidas por la Camara de Comercio Internacional (ICC).';
        }
        field(68; "Condici n de pago"; Text[30])
        {
            Description = 'Clave mediante la que se definen las condiciones de pago en forma de tipos de descuento y plazos de pago.';
        }
        field(69; "Class. Fiscal para el deudor"; Text[30])
        {
            Description = 'Identifica la obligaci n fiscal del cliente de acuerdo con la estructura fiscal de su Pais. Exento, no exento, IGIC, etc.Qu  hay que mandar?';
        }
        field(70; "Codigo Cliente Santillana"; Text[10])
        {
            Description = 'Codigo de cliente interno SAP';
        }
        field(71; "Tipo de cliente"; Text[10])
        {
            Description = 'Central  nica, Sucursal, Exterior';
        }
        field(72; "Tipo de nif"; Text[10])
        {
            Description = 'CUIT,NIT,RUC,RUT';
        }
        field(73; "L nea de negocio"; Text[10])
        {
        }
        field(74; "Grupo autoriz."; Text[10])
        {
        }
        field(75; "Zona de ventas"; Text[10])
        {
        }
        field(76; "Grupo de precios"; Text[10])
        {
        }
        field(77; "Lista de precios"; Text[10])
        {
        }
    }

    keys
    {
        key(Key1; "Codigo Cliente Santillana")
        {
        }
    }

    fieldgroups
    {
    }
}

