codeunit 56201 "Informacion Complementaria MDE"
{
    // #72814  27/06/2017 PLB: Posibilidad de exportar el IRM a Excel
    // #168444 05/09/2018 PLB: Error en el filtro sobre las cargas sociales, el problema aparecía donde se generan nóminas quincenales y se aplican cargas sociales en ambas quincenas
    // #269159 07/10/2019 RRT: Corrección en la función GetEmployeeFTE()


    trigger OnRun()
    begin
        //IRM(011116D, 301116D, 'EMP-00003',TRUE);
    end;

    var
        ConfSant: Record 56001;
        ExcelBuffer Record: 370" temporary;
        MdEMgnt: Codeunit 56202;
        XmlDoc: DotNet XmlDocument;
        XmlNode: DotNet XmlNode;
        NS: Label 'inf';
        NSUri: Label 'http://InformacionComplementariaMDE.santillana.local';
        Text002: Label 'Esta dimensión predeterminada se gestiona desde el MdE.';
        Text010: Label 'IRM';
        Text011: Label 'Información Real Mensual';

    procedure IRM(FromDate: Date; ToDate: Date; Filtro_Empleado: Text[100]; SendToExcel: Boolean)
    var
        HistLinNom: Record 34002118;
        Employee: Record 5200;
        LinAporEmp: Record 34002122;
        PerfilSalarial: Record 34002115;
        ProvisionesNom: Record 56100;
        MdEMgnt: Codeunit 56202;
        Response: Text;
        ImportesIRM: array[20] of Decimal;
        EmployeeFTE: Decimal;
    begin
        ConfSant.GET;
        ConfSant.TESTFIELD("WS Informacion Compl. MdE");
        ConfSant.TESTFIELD("Cod. pais maestros Santill");
        ConfSant.TESTFIELD("Cod. divisa local MdX");

        IF Filtro_Empleado <> '' THEN
            Employee.SETFILTER("No.", Filtro_Empleado);
        IF Employee.FINDSET THEN BEGIN
            //+#72814
            IF SendToExcel THEN
                HeadIRMExcel;
            //-#72814
            REPEAT
                CLEAR(ImportesIRM);
                CLEAR(EmployeeFTE);

                // Acumulamos por empleado
                // No. empleado,Tipo Nómina,Período,No. Orden
                HistLinNom.SETRANGE("No. empleado", Employee."No.");
                HistLinNom.SETRANGE(Período, FromDate, ToDate);
                IF HistLinNom.FINDSET THEN
                    REPEAT
                        IF HistLinNom."Tipo concepto" = HistLinNom."Tipo concepto"::Ingresos THEN // las aportaciones las procesamos en el siguiente bucle
                            CalcIRM(HistLinNom."Concepto salarial", ImportesIRM, HistLinNom.Total);
                    UNTIL HistLinNom.NEXT = 0;

                // Aportación de la empresa
                // Período,Tipo Nomina,No. Empleado,No. orden
                //LinAporEmp.SETRANGE(Período, HistLinNom.Período); //-#168444
                LinAporEmp.SETRANGE(Período, FromDate, ToDate); //+#168444
                LinAporEmp.SETRANGE("No. Empleado", Employee."No.");
                IF LinAporEmp.FINDSET THEN
                    REPEAT
                        CalcIRM(LinAporEmp."Concepto Salarial", ImportesIRM, LinAporEmp.Importe);
                    UNTIL LinAporEmp.NEXT = 0;

                //+#72814
                // Conceptos prorrateados
                ProvisionesNom.SETRANGE("Cod. Empleado", Employee."No.");
                ProvisionesNom.SETRANGE(Periodo, FromDate, ToDate);
                IF ProvisionesNom.FINDSET THEN
                    REPEAT
                        CalcIRM(ProvisionesNom."Concepto Salarial", ImportesIRM, ProvisionesNom."Importe provisionado");
                    UNTIL ProvisionesNom.NEXT = 0;
                //-#72814

                EmployeeFTE := GetEmployeeFTE(Employee."No.", FromDate, ToDate);
                IF HayImporte(ImportesIRM) OR (EmployeeFTE <> 0) THEN BEGIN
                    //+#72814
                    // sustituido por la tabla "Provisiones nominas" procesada más arriba
                    //PerfilSalarial.SETRANGE("No. empleado", Employee."No.");
                    //PerfilSalarial.SETRANGE(Prorratear, TRUE);
                    //IF PerfilSalarial.FINDSET THEN
                    //  REPEAT
                    //    CalcIRM(PerfilSalarial."Concepto salarial",ImportesIRM,ConceptoProrrateado(PerfilSalarial,HistLinNom.Período));
                    //  UNTIL PerfilSalarial.NEXT = 0;

                    IF SendToExcel THEN
                        BodyIRMExcel(Employee."No.", ImportesIRM, FromDate, ToDate, EmployeeFTE, GetEstadoIRM(Employee.Status))
                    ELSE BEGIN
                        //-#72814
                        Head('irm');
                        BodyIRM(Employee."No.", ImportesIRM, FromDate, ToDate, EmployeeFTE, GetEstadoIRM(Employee.Status));
                        MdEMgnt.SendPostRequest(ConfSant."WS Informacion Compl. MdE", '', XmlDoc.OuterXml);
                    END; //+#72814
                END;
            UNTIL Employee.NEXT = 0;

            /*//fes mig
              //+#72814
              IF SendToExcel THEN BEGIN
                ExcelBuffer.CreateBook(Text010);
                ExcelBuffer.WriteSheet(Text011,COMPANYNAME,USERID);
                ExcelBuffer.CloseBook;
                ExcelBuffer.OpenExcel;
                ExcelBuffer.UpdateBookStream;
              END;
              //-#72814
              */ //fes mig
        END;

    end;

    procedure Ceco(var DimVal Record: 349; xRec: Record 349; TipoOper: Option Insert,Modify,Delete,Rename)
    var
        vBlocked: Boolean;
    begin
        ConfSant.GET;
        IF (NOT ConfSant."MdE Activo") OR (ConfSant."Dimension Centro Coste" = '') THEN
            EXIT;

        IF DimVal."Dimension Code" <> ConfSant."Dimension Centro Coste" THEN BEGIN
            // en un rename del cód. dimension, si el cód. anterior es de centro de coste, enviamos un delete del anterior
            IF (TipoOper = TipoOper::Rename) AND (xRec."Dimension Code" = ConfSant."Dimension Centro Coste") THEN
                Ceco(xRec, xRec, TipoOper::Delete);

            EXIT;
        END;

        IF NOT (DimVal."Dimension Value Type"::Standard IN [DimVal."Dimension Value Type", xRec."Dimension Value Type"]) THEN
            EXIT;

        IF (TipoOper = TipoOper::Modify) THEN BEGIN

            // Si el tipo dim. es estándar y el anterior no, provocamos un insert
            IF (DimVal."Dimension Value Type" = DimVal."Dimension Value Type"::Standard) AND
               (xRec."Dimension Value Type" <> xRec."Dimension Value Type"::Standard) THEN
                TipoOper := TipoOper::Insert

            // Si el tipo dim. anterior es estándar y el actual no, provocamos un delete
            ELSE IF (DimVal."Dimension Value Type" <> DimVal."Dimension Value Type"::Standard) AND
               (xRec."Dimension Value Type" = xRec."Dimension Value Type"::Standard) THEN
                TipoOper := TipoOper::Delete;
        END;

        // no hacemos nada si no cambia el nombre ni el bloqueado
        IF (TipoOper = TipoOper::Modify) AND (DimVal.Name = xRec.Name) AND (DimVal.Blocked = xRec.Blocked) THEN
            EXIT;

        IF TipoOper = TipoOper::Rename THEN BEGIN
            IF xRec."Dimension Code" = ConfSant."Dimension Centro Coste" THEN
                Ceco(xRec, xRec, TipoOper::Delete);
            TipoOper := TipoOper::Insert;
            DimVal."Fecha creacion" := TODAY;
        END;

        IF TipoOper = TipoOper::Insert THEN
            DimVal."Fecha creacion" := TODAY;

        vBlocked := (TipoOper = TipoOper::Delete) OR (DimVal.Blocked);

        ConfSant.TESTFIELD("WS Informacion Compl. MdE");
        ConfSant.TESTFIELD("Cod. pais maestros Santill");

        Head('ceco');
        BodyCC(ConfSant."Cod. sociedad maestros Santill" + '_' + DimVal.Code, DimVal.Name, DimVal."Fecha creacion", GetEstadoCC(vBlocked));
        //ERROR(XmlDoc.OuterXml); //temp

        // Envío asíncrono: se realiza la petición en background (en otra sesión) para que la actual no quede parada hasta recibir respuesta del WS
        MdEMgnt.CreateAsyncPostRequest('CECO', ConfSant."WS Informacion Compl. MdE", '', XmlDoc.OuterXml);
    end;

    procedure HorariosCeco(DefaultDim: Record 352)
    var
        DimVal: Record 349;
        Contrato: Record 34002109;
        GradoOcu: Decimal;
    begin
        IF DefaultDim."Table ID" <> DATABASE::Employee THEN
            EXIT;

        IF (DefaultDim."No." = '') OR (DefaultDim."Dimension Value Code" = '') THEN
            EXIT;

        ConfSant.GET;
        IF NOT ConfSant."MdE Activo" THEN
            EXIT;

        ValidarDim(DefaultDim);

        IF (ConfSant."Dimension Centro Coste" = '') OR (DefaultDim."Dimension Code" <> ConfSant."Dimension Centro Coste") THEN
            EXIT;

        ConfSant.TESTFIELD("WS Informacion Compl. MdE");
        ConfSant.TESTFIELD("Cod. pais maestros Santill");

        IF DefaultDim."Dimension Code" <> ConfSant."Dimension Centro Coste" THEN
            EXIT;

        Contrato.SETRANGE("No. empleado", DefaultDim."No.");
        Contrato.SETFILTER("Fecha inicio", '<=%1', WORKDATE);
        Contrato.SETFILTER("Fecha finalización", '>=%1', WORKDATE);
        IF Contrato.ISEMPTY THEN
            Contrato.SETRANGE("Fecha finalización", 0D);
        IF Contrato.ISEMPTY THEN
            GradoOcu := 100
        ELSE BEGIN
            Contrato.FINDLAST;
            IF Contrato."Grado ocupacion" = 0 THEN
                GradoOcu := 100
            ELSE
                GradoOcu := Contrato."Grado ocupacion";
        END;

        Head('horariosceco');
        BodyHCC(DefaultDim."No.", ConfSant."Cod. sociedad maestros Santill" + '_' + DefaultDim."Dimension Value Code", GradoOcu);
        //ERROR(XmlDoc.OuterXml); //temp

        // Envío asíncrono: se realiza la petición en background (en otra sesión) para que la actual no quede parada hasta recibir respuesta del WS
        MdEMgnt.CreateAsyncPostRequest('HORARIOSCECO', ConfSant."WS Informacion Compl. MdE", '', XmlDoc.OuterXml);
    end;

    procedure ValidarDim(DefaultDim: Record 352)
    begin
        IF DefaultDim."Dimension Code" IN [ConfSant."Dimension Departamento", ConfSant."Dimension Division", ConfSant."Dimension Area funcional"] THEN
            ERROR(Text002);
    end;

    procedure CT(Filtro_Empleado: Text[100])
    var
        Employee: Record 5200;
        PerfSal: Record 34002115;
        ImportesCT: array[20] of Decimal;
    begin
        ConfSant.GET;
        ConfSant.TESTFIELD("WS Informacion Compl. MdE");
        ConfSant.TESTFIELD("Cod. pais maestros Santill");
        ConfSant.TESTFIELD("Cod. divisa local MdX");

        //TODO: falta frecuencia y número de pagas

        Employee.RESET;
        IF Filtro_Empleado <> '' THEN
            Employee.SETFILTER("No.", Filtro_Empleado);
        IF Employee.FINDSET THEN
            REPEAT
                CLEAR(ImportesCT);

                PerfSal.SETRANGE("No. empleado", Employee."No.");
                IF PerfSal.FINDSET THEN BEGIN
                    REPEAT
                        CalcCT(PerfSal."Concepto salarial", ImportesCT, PerfSal.Importe);
                    UNTIL PerfSal.NEXT = 0;

                    IF HayImporte(ImportesCT) THEN BEGIN
                        Head('ct');
                        BodyCT(Employee."No.", ImportesCT);
                        //ERROR(XmlDoc.OuterXml); //temp
                        MdEMgnt.SendPostRequest(ConfSant."WS Informacion Compl. MdE", '', XmlDoc.OuterXml);
                    END;
                END;
            UNTIL Employee.NEXT = 0;
    end;

    local procedure Head(Funcion: Text[30])
    var
        XmlNsMgr: DotNet XmlNamespaceManager;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
        MyDT: DateTime;
    begin
        MyDT := ROUNDDATETIME(CURRENTDATETIME);

        CLEAR(XmlDoc);

        XmlDoc := XmlDoc.XmlDocument;
        XmlDoc.LoadXml(
        '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:inf="http://InformacionComplementariaMDE.santillana.local">' +
        '<soapenv:Header/>' +
        '<soapenv:Body>' +
        '<inf:' + Funcion + '>' +
        '<inf:mensaje/>' +
        '</inf:' + Funcion + '>' +
        '</soapenv:Body>' +
        '</soapenv:Envelope>');

        XmlNsMgr := XmlNsMgr.XmlNamespaceManager(XmlDoc.NameTable);
        XmlNsMgr.AddNamespace('soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
        XmlNsMgr.AddNamespace('inf', 'http://InformacionComplementariaMDE.santillana.local');

        // nivel 0
        XmlNode := XmlDoc.SelectSingleNode('//soapenv:Body/inf:' + Funcion + '/inf:mensaje', XmlNsMgr);

        // nivel 1
        MdEMgnt.AddElement(XmlNode, 'head', '', NS, NSUri, XmlNode2);

        // nivel 2
        MdEMgnt.AddElement(XmlNode2, 'id_mensaje', '', NS, NSUri, XmlNode3); //TODO: ¿contador?
        MdEMgnt.AddElement(XmlNode2, 'sistema_origen', ConfSant.GetSistemaOrigen, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'pais_origen', ConfSant."Cod. pais maestros Santill", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'fecha_origen', MdEMgnt.FormatDateTime(TODAY, TIME), NS, NSUri, XmlNode3); // hoy
        MdEMgnt.AddElement(XmlNode2, 'tipo', '0039', NS, NSUri, XmlNode3); //valor fijo "0039"
    end;

    local procedure HeadIRMExcel()
    begin
        ExcelBuffer.NewRow;

        ExcelBuffer.AddColumn('Sociedad', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Empleado', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PeriodoDesde', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PeriodoHasta', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Estado', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('FTE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SalanFI', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaSLF', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('CompSalanFIJ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaCSF', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CompVariable', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaCV', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('SaFijTot', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaSFT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('BonoDeven', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaBD', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('BonoPagado', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaBP', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('VarComercial', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaVC', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('VarComerialDE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaVCD', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gratificacion', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaG', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ILPDeven', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaILPD', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ILPPagado', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaILPP', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Colaboraciones', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaC', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('CargasSociales', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaCS', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('OtrosGastos', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaOG', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn('Indemnizacion', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MonedaI', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure BodyIRM(EmployeeNo: Code[20]; ImportesIRM: array[20] of Decimal; FromDate: Date; ToDate: Date; FTE: Decimal; Status: Text[1])
    var
        EquivVavMde: Record 56201;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
    begin

        // nivel 1
        MdEMgnt.AddElement(XmlNode, 'body', '', NS, NSUri, XmlNode2);

        // nivel 2
        MdEMgnt.AddElement(XmlNode2, 'Sociedad', ConfSant."Cod. sociedad maestros Santill", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Empleado', EmployeeNo, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PeriodoDesde', MdEMgnt.FormatDate(FromDate), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PeriodoHasta', MdEMgnt.FormatDate(ToDate), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Estado', Status, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FTE', FORMAT(FTE, 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'SalanFI', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::SalanFI], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaSLF', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);

        MdEMgnt.AddElement(XmlNode2, 'CompSalanFIJ', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::CompSalanFIJ], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaCSF', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'CompVariable', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::CompVariable], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaCV', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);

        MdEMgnt.AddElement(XmlNode2, 'SaFijTot', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::SaFijTot], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaSFT', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);

        MdEMgnt.AddElement(XmlNode2, 'BonoDeven', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::BonoDeven], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaBD', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'BonoPagado', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::BonoPagado], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaBP', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'VarComercial', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::VarComercial], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaVC', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'VarComerialDE', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::VarComerialDE], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaVCD', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Gratificacion', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::Gratificacion], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaG', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'ILPDeven', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::ILPDeven], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaILPD', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'ILPPagado', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::ILPPagado], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaILPP', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Colaboraciones', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::Colaboraciones], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaC', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);

        MdEMgnt.AddElement(XmlNode2, 'CargasSociales', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::CargasSociales], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaCS', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'OtrosGastos', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::OtrosGastos], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaOG', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);

        MdEMgnt.AddElement(XmlNode2, 'Indemnizacion', FORMAT(ImportesIRM[EquivVavMde."Concepto IRM"::Indemnizacion], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaI', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
    end;

    local procedure BodyIRMExcel(EmployeeNo: Code[20]; ImportesIRM: array[20] of Decimal; FromDate: Date; ToDate: Date; FTE: Decimal; Status: Text[1])
    var
        EquivVavMde: Record 56201;
    begin
        // nivel 2
        ExcelBuffer.NewRow;

        ExcelBuffer.AddColumn(ConfSant."Cod. sociedad maestros Santill", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(EmployeeNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FromDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(ToDate, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(Status, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FTE, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::SalanFI], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::CompSalanFIJ], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::CompVariable], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::SaFijTot], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::BonoDeven], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::BonoPagado], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::VarComercial], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::VarComerialDE], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::Gratificacion], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::ILPDeven], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::ILPPagado], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::Colaboraciones], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::CargasSociales], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::OtrosGastos], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(ImportesIRM[EquivVavMde."Concepto IRM"::Indemnizacion], FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ConfSant."Cod. divisa local MdX", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure BodyCC(Codigo: Code[30]; Descripcion: Text[50]; FechaIni: Date; Estado: Text[1])
    var
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
    begin
        IF FechaIni = 0D THEN
            FechaIni := 010100D;

        // nivel 1
        MdEMgnt.AddElement(XmlNode, 'body', '', NS, NSUri, XmlNode2);

        // nivel 2
        MdEMgnt.AddElement(XmlNode2, 'Codigo', Codigo, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FechaIni', MdEMgnt.FormatDate(FechaIni), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Estado', Estado, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Nombre', Descripcion, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'SociedadCO', ConfSant."Cod. Sociedad CO maestros", NS, NSUri, XmlNode3);
    end;

    local procedure BodyHCC(EmployeeNo: Code[20]; DimensionValue: Code[30]; GradoOcu: Decimal)
    var
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
    begin
        // nivel 1
        MdEMgnt.AddElement(XmlNode, 'body', '', NS, NSUri, XmlNode2);

        // nivel 2
        MdEMgnt.AddElement(XmlNode2, 'Sociedad', ConfSant."Cod. sociedad maestros Santill", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MotivEvSFSF', 'DAT-PER2', NS, NSUri, XmlNode3); //Valor fijo: DAT-PER2
        MdEMgnt.AddElement(XmlNode2, 'FechaEfectiva', MdEMgnt.FormatDateTime(TODAY, TIME), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Empleado', EmployeeNo, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorOcupa', FORMAT(GradoOcu), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco1', DimensionValue, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco1', '100', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco2', '', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco2', '0', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco3', '', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco3', '0', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco4', '', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco4', '0', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco5', '', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco5', '0', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco6', '', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco6', '0', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco7', '', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco7', '0', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Ceco8', '', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'PorCeco8', '0', NS, NSUri, XmlNode3);
    end;

    local procedure BodyCT(EmployeeNo: Code[20]; ImportesCT: array[20] of Decimal)
    var
        EquivVavMde: Record 56201;
        XmlNode2: DotNet XmlNode;
        XmlNode3: DotNet XmlNode;
    begin
        // nivel 1
        MdEMgnt.AddElement(XmlNode, 'body', '', NS, NSUri, XmlNode2);

        // nivel 2
        MdEMgnt.AddElement(XmlNode2, 'Sociedad', ConfSant."Cod. sociedad maestros Santill", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MotEvSFSF', 'DAT-RETR3', NS, NSUri, XmlNode3); //TODO: Valor fijo: DAT-RETR3????
        MdEMgnt.AddElement(XmlNode2, 'FechaEfectiva', MdEMgnt.FormatDateTime(TODAY, TIME), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Empleado', EmployeeNo, NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'NPagas', '12', NS, NSUri, XmlNode3); //TODO: pagas anuales
        MdEMgnt.AddElement(XmlNode2, 'Salario', FORMAT(ImportesCT[EquivVavMde."Concepto CT"::Salario], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaS', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FreqS', 'MENSUAL', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Comple', FORMAT(ImportesCT[EquivVavMde."Concepto CT"::Comple], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaC', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FreqC', 'MENSUAL', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Bono', FORMAT(ImportesCT[EquivVavMde."Concepto CT"::Bono], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaB', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FreqB', 'MENSUAL', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'ILP', FORMAT(ImportesCT[EquivVavMde."Concepto CT"::ILP], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaILP', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FreqILP', 'MENSUAL', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'VarCom', FORMAT(ImportesCT[EquivVavMde."Concepto CT"::VarCom], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaVC', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FreqVC', 'MENSUAL', NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'Rappel', FORMAT(ImportesCT[EquivVavMde."Concepto CT"::Rappel], 0, 9), NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'MonedaR', ConfSant."Cod. divisa local MdX", NS, NSUri, XmlNode3);
        MdEMgnt.AddElement(XmlNode2, 'FreqR', 'MENSUAL', NS, NSUri, XmlNode3);
    end;

    local procedure CalcIRM(Concepto: Code[20]; var Importes: array[20] of Decimal; ImporteConcepto: Decimal)
    begin
        CalcConcepto(Concepto, 0, Importes, ImporteConcepto);
    end;

    local procedure CalcCT(Concepto: Code[20]; var Importes: array[20] of Decimal; ImporteConcepto: Decimal)
    begin
        CalcConcepto(Concepto, 1, Importes, ImporteConcepto);
    end;

    local procedure CalcConcepto(Concepto: Code[20]; MdEType: Option IRM,CT; var Importes: array[20] of Decimal; ImporteConcepto: Decimal): Boolean
    var
        EquivNavMde: Record 56201;
    begin
        IF ImporteConcepto = 0 THEN
            EXIT;

        EquivNavMde.RESET;
        EquivNavMde.SETRANGE("Concepto NAV", Concepto);
        IF MdEType = MdEType::IRM THEN
            EquivNavMde.SETRANGE("Concepto CT", 0)
        ELSE
            EquivNavMde.SETRANGE("Concepto IRM", 0);
        IF EquivNavMde.FINDSET THEN
            REPEAT
                IF MdEType = MdEType::IRM THEN
                    Importes[EquivNavMde."Concepto IRM"] += ImporteConcepto * EquivNavMde.Porcentaje
                ELSE
                    Importes[EquivNavMde."Concepto CT"] += ImporteConcepto * EquivNavMde.Porcentaje;
            UNTIL EquivNavMde.NEXT = 0;
    end;

    local procedure HayImporte(Importes: array[20] of Decimal): Boolean
    var
        i: Integer;
    begin
        FOR i := 1 TO ARRAYLEN(Importes) DO BEGIN
            IF Importes[i] <> 0 THEN
                EXIT(TRUE);
        END;
    end;

    local procedure GetEstadoIRM(Status: Option Active,Inactive,Terminated): Text[1]
    begin
        IF Status = Status::Active THEN
            EXIT('A')
        ELSE
            EXIT('I');
    end;

    local procedure GetEstadoCC(Blocked: Boolean): Text[1]
    begin
        IF Blocked THEN
            EXIT('I')
        ELSE
            EXIT('A');
    end;

    local procedure GetEmployeeFTE(EmployeeNo: Code[20]; FromDate: Date; ToDate: Date) FTE: Decimal
    var
        Contrato: Record 34002109;
        DaysOfMonth: Integer;
        DaysWorked: Integer;
        lFechaInicioContratoAnterior: Date;
        lFechaFinalizacion: Date;
        lStop: Boolean;
        lContador: Integer;
    begin
        //+#269159
        //... Este cálculo sólo tiene en cuenta la existencia de 1 contrato en el periodo indicado.
        /*
        Contrato.SETRANGE("No. empleado", EmployeeNo);
        Contrato.SETFILTER("Fecha inicio", '..%1', ToDate);
        Contrato.SETFILTER("Fecha finalización", '%1..', FromDate);
        IF NOT Contrato.FINDLAST THEN
          Contrato.SETRANGE("Fecha finalización", 0D);
        IF Contrato.FINDLAST THEN BEGIN
          // si no se ha establecido el grado de ocupación, supondremos un 100%
          IF Contrato."Grado ocupacion" = 0 THEN
            Contrato."Grado ocupacion" := 100;
        
          DaysOfMonth := (ToDate - FromDate) + 1;
          DaysWorked := DATE2DMY(ToDate,1) - DATE2DMY(FromDate,1) + 1;
        
          IF Contrato."Fecha inicio" > FromDate THEN
            DaysWorked := DaysWorked - (Contrato."Fecha inicio" - FromDate);
        
          IF (Contrato."Fecha finalización" < ToDate) AND (Contrato."Fecha finalización" <> 0D) THEN
            DaysWorked := DaysWorked - (ToDate - Contrato."Fecha finalización");
        
          FTE := (Contrato."Grado ocupacion" / 100) * (DaysWorked / DaysOfMonth);
        END
        ELSE
          FTE := 0;
        
        */

        //... Se substituirá por el siguiente cálculo:

        FTE := 0;

        Contrato.RESET;
        Contrato.SETRANGE("No. empleado", EmployeeNo);
        Contrato.SETFILTER("Fecha inicio", '..%1', ToDate);
        Contrato.SETFILTER("Fecha finalización", '%1..|%2', FromDate, 0D);

        IF Contrato.FINDLAST THEN BEGIN

            DaysOfMonth := (ToDate - FromDate) + 1;
            lFechaInicioContratoAnterior := 0D;
            lStop := FALSE;
            lContador := 0;

            REPEAT
                //... Viendo la existencia de contratos duplicados y confirmando que no se puede asumir que la fecha de finalizacion de un contrato
                //..  (cuando no se ha indicadosin este valor) deba ser la fecha anterior a la fecha de inicio del contrato siguiente,
                //... abortaremos la lectura de los contratos ante esta situacion.
                //... Es decir, sólo permitiremos que sea el último contrato, el que no tenga fecha de finalización asignada.
                lContador := lContador + 1;
                IF (lContador > 1) AND (Contrato."Fecha finalización" = 0D) THEN
                    lStop := TRUE;

                IF NOT lStop THEN BEGIN
                    lFechaFinalizacion := Contrato."Fecha finalización";
                    IF lFechaFinalizacion = 0D THEN BEGIN
                        IF lFechaInicioContratoAnterior = 0D THEN
                            lFechaFinalizacion := 12319999D
                        ELSE
                            lFechaFinalizacion := lFechaInicioContratoAnterior - 1;
                    END
                    ELSE BEGIN
                        //... La siguiente comprobacion es para asegurarnos que los periodos de los contratos son contiguos y no hay intersecciones,
                        //... más alla del caso que la fecha de finalizacion del contrato no tenga valor.
                        IF lFechaInicioContratoAnterior <> 0D THEN
                            IF lFechaFinalizacion >= lFechaInicioContratoAnterior THEN
                                lFechaFinalizacion := lFechaInicioContratoAnterior - 1;
                    END;

                    lFechaInicioContratoAnterior := Contrato."Fecha inicio";

                    IF lFechaFinalizacion >= FromDate THEN BEGIN
                        DaysWorked := DATE2DMY(ToDate, 1) - DATE2DMY(FromDate, 1) + 1;

                        // si no se ha establecido el grado de ocupación, supondremos un 100%
                        IF Contrato."Grado ocupacion" = 0 THEN
                            Contrato."Grado ocupacion" := 100;

                        IF Contrato."Fecha inicio" > FromDate THEN
                            DaysWorked := DaysWorked - (Contrato."Fecha inicio" - FromDate);

                        IF lFechaFinalizacion < ToDate THEN
                            DaysWorked := DaysWorked - (ToDate - lFechaFinalizacion);

                        FTE := FTE + ((Contrato."Grado ocupacion" / 100) * (DaysWorked / DaysOfMonth));
                    END
                    ELSE
                        lStop := TRUE;
                END;

            UNTIL (Contrato.NEXT(-1) = 0) OR lStop;

            //... Aunque el código este depurado, si por un enlace incorrecto entre contratos se obtuviera un valor mayor que 1 para FTE, aplicamos este factor corrector.
            IF FTE > 1 THEN
                FTE := 1;
        END;

        //-#265159

    end;

    local procedure GetEmployeeFTEOld(EmployeeNo: Code[20]; Fecha: Date) FTE: Decimal
    var
        Contrato: Record 34002109;
        FirstMonthDate: Date;
        LastMonthDate: Date;
        DaysOfMonth: Integer;
        DaysWorked: Integer;
    begin
        Contrato.SETRANGE("No. empleado", EmployeeNo);
        IF Contrato.FINDLAST THEN BEGIN
            IF Contrato."Frecuencia de pago" = Contrato."Frecuencia de pago"::Quincenal THEN BEGIN
                // Dia 1 o día 16
                IF DATE2DMY(Fecha, 1) = 1 THEN
                    FirstMonthDate := CALCDATE('<-1M+15D>', Fecha)
                ELSE
                    FirstMonthDate := CALCDATE('<-CM>', Fecha);
            END
            ELSE
                FirstMonthDate := CALCDATE('<-1M>', Fecha);
            LastMonthDate := CALCDATE('<-1D>', Fecha);
        END;

        Contrato.SETFILTER("Fecha inicio", '..%1', LastMonthDate);
        Contrato.SETFILTER("Fecha finalización", '%1..', FirstMonthDate);
        IF NOT Contrato.FINDLAST THEN
            Contrato.SETRANGE("Fecha finalización", 0D);
        IF Contrato.FINDLAST THEN BEGIN
            // si no se ha establecido el grado de ocupación, supondremos un 100%
            IF Contrato."Grado ocupacion" = 0 THEN
                Contrato."Grado ocupacion" := 100;

            DaysOfMonth := DATE2DMY(CALCDATE('<-1D+CM>', Fecha), 1);
            DaysWorked := DATE2DMY(LastMonthDate, 1) - DATE2DMY(FirstMonthDate, 1) + 1;
            IF Contrato."Fecha inicio" > FirstMonthDate THEN
                DaysWorked := DaysWorked - (Contrato."Fecha inicio" - FirstMonthDate);
            IF (Contrato."Fecha finalización" < LastMonthDate) AND (Contrato."Fecha finalización" <> 0D) THEN
                DaysWorked := DaysWorked - (LastMonthDate - Contrato."Fecha finalización");
            FTE := (Contrato."Grado ocupacion" / 100) * (DaysWorked / DaysOfMonth);
        END
        ELSE
            FTE := 0;
    end;

    procedure CeCoTipoInsert(): Integer
    begin
        EXIT(0);
    end;

    procedure CeCoTipoModify(): Integer
    begin
        EXIT(1);
    end;

    procedure CeCoTipoDelete(): Integer
    begin
        EXIT(2);
    end;

    procedure CeCoTipoRename(): Integer
    begin
        EXIT(3);
    end;

    procedure ConceptoProrrateado(PS: Record 34002115; Periodo: Date) Acumulado: Decimal
    var
        HistLinNom: Record 34002118;
        ConceptosProrr: Record 34002119;
        Fecha: Record 2000000007;
        Empleado: Record 5200;
        ConfNomina: Record 34002103;
        ConfContabilidad: Record 98;
        CalculoFechas: Codeunit 34002104;
        Anos: Integer;
        Meses: Integer;
        Dias: Integer;
        CantEmpl: Integer;
        DiasVacaciones: Decimal;
        MontoVacaciones: Decimal;
        Diastxt: Text[30];
        FIni: Date;
        Acumulado2: Decimal;
        Err001: Label 'Configure %1 to %2 %3';
        Inicial: Date;
        Final: Date;
    begin
        WITH ConceptosProrr DO BEGIN
            Empleado.GET(PS."No. empleado");
            SETRANGE(Código, PS."Concepto salarial");
            ConfNomina.GET;
            Inicial := Periodo;
            Final := Periodo;

            IF FINDSET THEN
                REPEAT
                    Acumulado := 0;
                    CLEAR(HistLinNom);
                    HistLinNom.RESET;
                    HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Período, "Concepto salarial");
                    HistLinNom.SETRANGE("No. empleado", PS."No. empleado");
                    HistLinNom.SETRANGE(Período, Periodo);
                    HistLinNom.SETRANGE("Concepto salarial", Código);
                    IF HistLinNom.FINDSET THEN
                        REPEAT
                            Acumulado += HistLinNom.Total;
                        UNTIL HistLinNom.NEXT = 0;

                    Empleado.Salario := 0;
                    CLEAR(HistLinNom);
                    HistLinNom.RESET;
                    HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Período, "Concepto salarial");
                    HistLinNom.SETRANGE("No. empleado", PS."No. empleado");
                    HistLinNom.SETRANGE(Período, Periodo);
                    HistLinNom.SETRANGE("Concepto salarial", Código);
                    HistLinNom.SETRANGE("Salario Base", TRUE);
                    IF HistLinNom.FINDSET THEN
                        REPEAT
                            Empleado.Salario += HistLinNom.Total;
                        UNTIL HistLinNom.NEXT = 0;

                    Acumulado /= 12;
                    CASE ConfNomina."Nomina de Pais" OF
                        'BO':
                            BEGIN
                                IF Empleado."Employment Date" = 0D THEN
                                    ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

                                CalculoFechas.CalculoEntreFechas(Empleado."Employment Date", Final, Anos, Meses, Dias);

                                IF ConfNomina."Concepto Incentivos" = Código THEN BEGIN
                                    Empleado.Salario := 0;
                                    Acumulado2 := 0;

                                    //Se busca el acumulado de los 3 ultimos meses
                                    FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-3M', Periodo), 2), DATE2DMY(CALCDATE('-3M', Periodo), 3));
                                    CLEAR(HistLinNom);
                                    HistLinNom.RESET;
                                    HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Período, "Concepto salarial");
                                    HistLinNom.SETRANGE("No. empleado", PS."No. empleado");
                                    HistLinNom.SETRANGE(Período, FIni, CALCDATE('-1D', Periodo));
                                    HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                    //        MESSAGE('%1',HistLinNom.GETFILTERS);
                                    IF HistLinNom.FINDSET THEN
                                        REPEAT
                                            Empleado.Salario += HistLinNom.Total;
                                        UNTIL HistLinNom.NEXT = 0;

                                    //Se calculan los dias transcurridos al presente periodo y hasta el mes anterior
                                    IF Empleado."Fecha despues quinquenios" <> 0D THEN BEGIN
                                        DiasVacaciones := Final - Empleado."Fecha despues quinquenios";
                                        Dias := CALCDATE('-1D', Inicial) - Empleado."Fecha despues quinquenios";
                                    END
                                    ELSE BEGIN
                                        DiasVacaciones := Final - Empleado."Employment Date";
                                        Dias := CALCDATE('-1D', Inicial) - Empleado."Employment Date";
                                    END;

                                    //Salario promedio de los ultimos 3 meses
                                    Empleado.Salario /= 3;

                                    //Importe de Indemnización acumulada actual
                                    MontoVacaciones := ROUND((Empleado.Salario * Dias / 365), 0.01);
                                    //        error('%1\ %2\ %3\ %4\ %5',empleado.salario,diasvacaciones,montovacaciones,final,Empleado."Employment Date");
                                    //Importe de Indemnización acumulada mes anterior

                                    FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-2M', Inicial), 2), DATE2DMY(CALCDATE('-2M', Inicial), 3));
                                    CLEAR(HistLinNom);
                                    CLEAR(Empleado.Salario);
                                    HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Período, "Concepto salarial");
                                    HistLinNom.SETRANGE("No. empleado", PS."No. empleado");
                                    HistLinNom.SETRANGE(Período, FIni, Final);
                                    HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                    //        message('%1',histlinnom.getfilters);
                                    IF HistLinNom.FINDSET THEN
                                        REPEAT
                                            Empleado.Salario += HistLinNom.Total;
                                        UNTIL HistLinNom.NEXT = 0;

                                    //Salario promedio de los ultimos 3 meses
                                    Empleado.Salario /= 3;

                                    Acumulado2 := ROUND((Empleado.Salario * DiasVacaciones / 365), 0.01);

                                    Acumulado := ROUND(Acumulado2 - MontoVacaciones, 0.01);
                                    //        ERROR('aa%1 %2 %3 %4',Acumulado,Acumulado2,MontoVacaciones);
                                    //message('Ind %1 %2 %3 %4 %5',acumulado,montovacaciones,acumulado2,DIAS,DIASVACACIONES);
                                END
                                ELSE
                                    IF ConfNomina."Concepto Regalia" = Código THEN BEGIN
                                        Empleado.Salario := 0;
                                        Acumulado2 := 0;

                                        //Se busca el acumulado de los 3 ultimos meses
                                        FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-3M', Periodo), 2), DATE2DMY(CALCDATE('-3M', Periodo), 3));
                                        CLEAR(HistLinNom);
                                        HistLinNom.RESET;
                                        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Período, "Concepto salarial");
                                        HistLinNom.SETRANGE("No. empleado", PS."No. empleado");
                                        HistLinNom.SETRANGE(Período, FIni, CALCDATE('-1D', Periodo));
                                        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                        IF HistLinNom.FINDSET THEN
                                            REPEAT
                                                Empleado.Salario += HistLinNom.Total;
                                            UNTIL HistLinNom.NEXT = 0;

                                        //Se calculan los dias transcurridos al presente periodo y hasta el mes anterior

                                        IF Anos <> 0 THEN BEGIN
                                            DiasVacaciones := Final - DMY2DATE(1, 1, DATE2DMY(Final, 3));
                                            Dias := CALCDATE('-1D', Inicial) - DMY2DATE(1, 1, DATE2DMY(Final, 3));
                                        END
                                        ELSE BEGIN
                                            DiasVacaciones := Final - DMY2DATE(1, DATE2DMY(Empleado."Employment Date", 2), DATE2DMY(Empleado."Employment Date", 3));
                                            Dias := CALCDATE('-1D', Inicial) - DMY2DATE(1, DATE2DMY(Empleado."Employment Date", 2),
                                                              DATE2DMY(Empleado."Employment Date", 3));
                                        END;

                                        //Salario promedio de los ultimos 3 meses
                                        Empleado.Salario /= 3;

                                        //Importe de regalia acumulada actual
                                        MontoVacaciones := ROUND((Empleado.Salario * Dias / 365), 0.01);

                                        //Importe de regalia acumulada mes anterior

                                        FIni := DMY2DATE(1, DATE2DMY(CALCDATE('-2M', Periodo), 2),
                                                          DATE2DMY(CALCDATE('-2M', Periodo), 3));

                                        CLEAR(HistLinNom);
                                        CLEAR(Empleado.Salario);
                                        HistLinNom.SETCURRENTKEY("No. empleado", "Tipo concepto", Período, "Concepto salarial");
                                        HistLinNom.SETRANGE("No. empleado", PS."No. empleado");
                                        HistLinNom.SETRANGE(Período, FIni, Final);
                                        HistLinNom.SETRANGE("Aplica para Regalia", TRUE);
                                        IF HistLinNom.FINDSET THEN
                                            REPEAT
                                                Empleado.Salario += HistLinNom.Total;
                                            UNTIL HistLinNom.NEXT = 0;

                                        //Salario promedio de los ultimos 3 meses
                                        Empleado.Salario /= 3;
                                        Acumulado2 := ROUND((Empleado.Salario * DiasVacaciones / 365), 0.01);

                                        Acumulado := ROUND(Acumulado2 - MontoVacaciones, 0.01);

                                        //        ERROR('bb %1 %2 %3 %4 %5',Acumulado,MontoVacaciones,Acumulado2,Dias,DiasVacaciones);
                                        //        message('reg %1 %2 %3 %4 %5',acumulado,montovacaciones,acumulado2,DIAS,DIASVACACIONES);
                                    END;
                            END;
                        'DO':
                            BEGIN
                                IF ConfNomina."Concepto Vacaciones" = Disponible THEN BEGIN
                                    IF Empleado."Employment Date" = 0D THEN
                                        ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

                                    DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.", DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3), MontoVacaciones, Empleado."Employment Date",
                                                                                         WORKDATE);
                                    Empleado.Salario /= 23.83;
                                    MontoVacaciones := (Empleado.Salario * DiasVacaciones) / 12;
                                    Acumulado := MontoVacaciones;
                                END
                                ELSE
                                    IF ConfNomina."Concepto Bonificacion" = Disponible THEN BEGIN
                                        IF Empleado."Employment Date" = 0D THEN
                                            ERROR(Err001, Empleado.FIELDCAPTION("Employment Date"), Empleado.TABLECAPTION, Empleado."No.");

                                        DiasVacaciones := CalculoFechas.CalculoDiaVacaciones(Empleado."No.", DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3), MontoVacaciones, Empleado."Employment Date",
                                                                                             WORKDATE);
                                        Empleado.Salario /= 23.83;
                                        MontoVacaciones := (Empleado.Salario * DiasVacaciones) / 12;
                                        Acumulado := MontoVacaciones;
                                    END;
                            END;

                        'GT':
                            BEGIN
                                CASE "Tipo provision" OF
                                    0:
                                        ; //Variable
                                    1:
                                        ; //Fijo
                                    2: //Fórmula
                                        BEGIN
                                            PS.VALIDATE("Fórmula cálculo", "Fórmula cálculo");
                                            Acumulado := PS.Importe;
                                        END;
                                END;
                            END;
                        'EC':
                            BEGIN
                                CASE "Tipo provision" OF
                                    0: //Variable
                                        BEGIN
                                            IF Empleado."Fin contrato" <> 0D THEN BEGIN
                                                IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(Periodo, 2)) AND
                                                     (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(Periodo, 3)))) AND
                                                   (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(Periodo, 2)) AND
                                                     (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(Periodo, 3)))) THEN BEGIN
                                                    CalculoFechas.CalculoEntreFechas(Empleado."Employment Date", Empleado."Fin contrato", Anos, Meses, Dias);
                                                    EVALUATE(PS.Importe, "Fórmula cálculo");
                                                    Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                END
                                                ELSE
                                                    IF (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(Periodo, 2)) AND
                                                         (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(Periodo, 3)))) AND
                                                         (Empleado."Fin contrato" <> 0D) THEN BEGIN
                                                        Dias := DATE2DMY(Empleado."Fin contrato", 1);
                                                        IF DATE2DMY(Periodo, 2) = 2 THEN
                                                            Dias := 30 - Dias;

                                                        EVALUATE(PS.Importe, "Fórmula cálculo");
                                                        Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                    END;
                                            END
                                            ELSE
                                                IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(Periodo, 2)) AND
                                                     (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(Periodo, 3)) AND
                                                     (Empleado."Fin contrato" = 0D))) THEN BEGIN
                                                    Dias := DATE2DMY(Empleado."Employment Date", 1);
                                                    IF DATE2DMY(Periodo, 2) = 2 THEN
                                                        Dias := 30 - Dias;

                                                    EVALUATE(PS.Importe, "Fórmula cálculo");
                                                    Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                END;
                                        END;

                                    1: //Fijo
                                        BEGIN
                                            IF Empleado."Fin contrato" <> 0D THEN BEGIN
                                                IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(Periodo, 2)) AND
                                                     (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(Periodo, 3)))) AND
                                                   (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(Periodo, 2)) AND
                                                     (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(Periodo, 3)))) THEN BEGIN
                                                    CalculoFechas.CalculoEntreFechas(Empleado."Employment Date", Empleado."Fin contrato", Anos, Meses, Dias);
                                                    EVALUATE(PS.Importe, "Fórmula cálculo");
                                                    Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                END
                                                ELSE
                                                    IF (((DATE2DMY(Empleado."Fin contrato", 2) = DATE2DMY(Periodo, 2)) AND
                                                         (DATE2DMY(Empleado."Fin contrato", 3) = DATE2DMY(Periodo, 3)))) AND
                                                         (Empleado."Fin contrato" <> 0D) THEN BEGIN
                                                        Dias := DATE2DMY(Empleado."Fin contrato", 1);
                                                        IF DATE2DMY(Periodo, 2) = 2 THEN
                                                            Dias := 30 - Dias + 1;

                                                        EVALUATE(PS.Importe, "Fórmula cálculo");
                                                        Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                    END;
                                            END
                                            ELSE
                                                IF (((DATE2DMY(Empleado."Employment Date", 2) = DATE2DMY(Periodo, 2)) AND
                                                     (DATE2DMY(Empleado."Employment Date", 3) = DATE2DMY(Periodo, 3)) AND
                                                     (Empleado."Fin contrato" = 0D))) THEN BEGIN
                                                    Dias := DATE2DMY(Empleado."Employment Date", 1);
                                                    //             IF DATE2DMY(periodo,2) = 2 THEN
                                                    Dias := 30 - Dias + 1;

                                                    EVALUATE(PS.Importe, "Fórmula cálculo");
                                                    Acumulado := ROUND((PS.Importe / 30) * Dias, ConfContabilidad."Amount Rounding Precision");
                                                END
                                                ELSE BEGIN
                                                    EVALUATE(Acumulado, "Fórmula cálculo");
                                                END;
                                            //            message('%1 %2 %3 %4 %5',dias,Empleado."Employment Date",periodo);
                                        END;
                                    2: //Fórmula
                                        BEGIN
                                            PS.VALIDATE("Fórmula cálculo", "Fórmula cálculo");
                                            Acumulado := PS.Importe;
                                        END;
                                END;
                            END;
                        'PY':
                            BEGIN
                                CASE "Tipo provision" OF
                                    0:
                                        ; //Variable
                                    1:
                                        ; //Fijo
                                    2: //Fórmula
                                        BEGIN
                                            PS.VALIDATE("Fórmula cálculo", "Fórmula cálculo");
                                            Acumulado := PS.Importe;
                                        END;
                                END;
                            END;
                        'HN':
                            BEGIN
                                CASE "Tipo provision" OF
                                    0:
                                        ; //Variable
                                    1:
                                        ; //Fijo
                                    2: //Fórmula
                                        BEGIN
                                            PS.VALIDATE("Fórmula cálculo", "Fórmula cálculo");
                                            Acumulado := PS.Importe;
                                        END;
                                END;
                            END;
                    END;

                UNTIL NEXT = 0;
        END;
    end;

    trigger XmlDoc::NodeInserting(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeInserted(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeRemoving(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeRemoved(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeChanging(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;

    trigger XmlDoc::NodeChanged(sender: Variant; e: DotNet XmlNodeChangedEventArgs)
    begin
    end;
}

