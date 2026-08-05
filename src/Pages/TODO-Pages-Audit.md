# Pages TODO Audit

Read-only audit of comments matching `//TODO: Ver` under `src/Pages`. No AL source files were changed and the project was not compiled.

- Total TODO entries: **774**
- Generated: **2026-07-27**
- Symbol validation: `al_symbolsearch` confirmed dependency symbols for Approval Entries, Approvals Mgmt., Default Dimensions, Sales Comment Sheet, Sales Credit Memo Stats., Sales Invoice Stats., Sales Order Stats., Release Sales Document, Document-Print, Mail, Period Form Management, and Online Map Management.
- Scope note: classifications are audit recommendations, not authorization to change code. Medium- and Low-confidence entries require manual review.

## Summary

### By classification

- Custom dependency: **251**
- Deterministic AL syntax issue: **1**
- Functional ambiguity: **284**
- Missing page property: **76**
- Obsolete Business Central API: **10**
- Renamed standard object, field, method, enum, or property: **130**
- SaaS incompatibility: **22**

### By confidence

- High: **242**
- Low: **284**
- Medium: **248**

## TODO 0001

- File path: `src/Pages/Page 34002104 - Ficha Empleados.al`
- Object type: Page
- Object ID: 34002104
- Object name: `Ficha Empleados`
- Line number: 392
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   390:         area(factboxes)
   391:         {
   392:             //TODO: Ver
   393:             /*
   394:             part(PartPage; 5202)
~~~

## TODO 0002

- File path: `src/Pages/Page 34002104 - Ficha Empleados.al`
- Object type: Page
- Object ID: 34002104
- Object name: `Ficha Empleados`
- Line number: 428
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   426:     }
   427: 
   428:     //TODO: Ver
   429:     /*
   430:     actions
~~~

## TODO 0003

- File path: `src/Pages/Page 34002104 - Ficha Empleados.al`
- Object type: Page
- Object ID: 34002104
- Object name: `Ficha Empleados`
- Line number: 873
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   871:         fecha: Date;
   872:         Mail: Codeunit 397;
   873:         //TODO: Ver FuncionesNomina: Codeunit 34002104;
   874:         FechaIni: Date;
   875:         FechaFin: Date;
~~~

## TODO 0004

- File path: `src/Pages/Page 34002110 - Conceptos salariales.al`
- Object type: Page
- Object ID: 34002110
- Object name: `Conceptos salariales`
- Line number: 215
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   213:                     PromotedCategory = Process;
   214:                     PromotedIsBig = true;
   215:                     //TODO: Ver 
   216:                     /*
   217:                     RunObject = Page "Default Dimensions";
~~~

## TODO 0005

- File path: `src/Pages/Page 34002111 - Lista Acciones de personal.al`
- Object type: Page
- Object ID: 34002111
- Object name: `Lista Acciones de personal`
- Line number: 125
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   123:                 {
   124:                     Caption = 'C&omentarios';
   125:                     //TODO: Ver RunObject = Page 34002156;
   126:                 }
   127:             }
~~~

## TODO 0006

- File path: `src/Pages/Page 34002113 - Lista de conceptos salariales.al`
- Object type: Page
- Object ID: 34002113
- Object name: `Lista de conceptos salariales`
- Line number: 72
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    70:                 Promoted = true;
    71:                 PromotedCategory = Process;
    72:                 //TODO: Ver RunObject = Report 34002102;
    73:                 Visible = false;
    74:             }
~~~

## TODO 0007

- File path: `src/Pages/Page 34002114 - Historico Cab. Nóminas.al`
- Object type: Page
- Object ID: 34002114
- Object name: `Historico Cab. Nominas`
- Line number: 152
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   150:                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
   151:                     //PromotedCategory = Process;
   152:                     //TODO: Ver RunObject = Report 34002123;
   153: 
   154:                     trigger OnAction()
~~~

## TODO 0008

- File path: `src/Pages/Page 34002114 - Historico Cab. Nóminas.al`
- Object type: Page
- Object ID: 34002114
- Object name: `Historico Cab. Nominas`
- Line number: 180
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   178:                 Promoted = true;
   179:                 PromotedCategory = "Report";
   180:                 //TODO: Ver RunObject = Codeunit 34002103;
   181:             }
   182:         }
~~~

## TODO 0009

- File path: `src/Pages/Page 34002115 - Ficha Acciones de personal.al`
- Object type: Page
- Object ID: 34002115
- Object name: `Ficha Acciones de personal`
- Line number: 352
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   350:                         TESTFIELD("Revisado por");
   351:                         CurrPage.SETSELECTIONFILTER(AP);
   352:                         //TODO: Ver REPORT.RUN(REPORT::"Acciones de personal", TRUE, TRUE, AP);
   353:                     end;
   354:                 }
~~~

## TODO 0010

- File path: `src/Pages/Page 34002115 - Ficha Acciones de personal.al`
- Object type: Page
- Object ID: 34002115
- Object name: `Ficha Acciones de personal`
- Line number: 424
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   422:         Beneficiosempleados: Record 34002153;
   423:         Miembroscooperativa: Record 34002195;
   424:         //TODO: Ver FuncionesNom: Codeunit 34002104;
   425:         NoSeriesMgt: Codeunit "No. Series";
   426:         [InDataSet]
~~~

## TODO 0011

- File path: `src/Pages/Page 34002115 - Ficha Acciones de personal.al`
- Object type: Page
- Object ID: 34002115
- Object name: `Ficha Acciones de personal`
- Line number: 768
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   766:     begin
   767:         TESTFIELD("Empresa nueva");
   768:         //TODO: Ver FuncionesNom.TraspasaEmpleados("Empresa nueva", Rec);
   769:         //TraspasaEmpleados("Empresa nueva");
   770:         HistAccionesdepersonal.TRANSFERFIELDS(Rec);
~~~

## TODO 0012

- File path: `src/Pages/Page 34002118 - Niveles - Grados RH.al`
- Object type: Page
- Object ID: 34002118
- Object name: `Niveles - Grados RH`
- Line number: 6
- Classification: Deterministic AL syntax issue
- Proposed correction: Quote the hyphenated enum or option value inside CONST while preserving the existing filter value, then compile to confirm the source-table field type.
- Compile risk: Low
- Functional risk: Low
- Confidence: High
- Surrounding code:

~~~al
     4:     PageType = List;
     5:     SourceTable = 34002151;
     6:     //TODO: Ver SourceTableView = WHERE("Tipo registro"=CONST(Niveles-Grados));
     7: 
     8:     layout
~~~

## TODO 0013

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 232
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   230:                     trigger OnAction()
   231:                     begin
   232:                         //TODO: Ver FuncNominas.ProcesaDatosPonchadorManual;
   233:                     end;
   234:                 }
~~~

## TODO 0014

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 245
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   243:                     trigger OnAction()
   244:                     var
   245:                     //TODO: Ver AdoConn: Codeunit 34002124;
   246:                     begin
   247:                         //AdoConn.ReadEmp;
~~~

## TODO 0015

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 248
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   246:                     begin
   247:                         //AdoConn.ReadEmp;
   248:                         //TODO: Ver FuncNominas.ProcesaDatosPonchador;
   249:                     end;
   250:                 }
~~~

## TODO 0016

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 271
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   269:                         DCA.SETRANGE("Fecha registro", "Fecha registro");
   270:                         DCA.SETRANGE("Hora registro", "Hora registro");
   271:                         //TODO: Ver DistribAsistencia.SETTABLEVIEW(DCA);
   272:                         //TODO: Ver DistribAsistencia.RUNMODAL();
   273:                         //TODO: Ver CLEAR(DistribAsistencia);
~~~

## TODO 0017

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 272
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   270:                         DCA.SETRANGE("Hora registro", "Hora registro");
   271:                         //TODO: Ver DistribAsistencia.SETTABLEVIEW(DCA);
   272:                         //TODO: Ver DistribAsistencia.RUNMODAL();
   273:                         //TODO: Ver CLEAR(DistribAsistencia);
   274:                     end;
~~~

## TODO 0018

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 273
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   271:                         //TODO: Ver DistribAsistencia.SETTABLEVIEW(DCA);
   272:                         //TODO: Ver DistribAsistencia.RUNMODAL();
   273:                         //TODO: Ver CLEAR(DistribAsistencia);
   274:                     end;
   275:                 }
~~~

## TODO 0019

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 294
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   292:                     PromotedCategory = Process;
   293:                     PromotedIsBig = true;
   294:                     //TODO: Ver RunObject = Report 34002146;
   295: 
   296:                     trigger OnAction()
~~~

## TODO 0020

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 298
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   296:                     trigger OnAction()
   297:                     var
   298:                     //TODO: Ver FuncNom: Codeunit 34002104;
   299:                     begin
   300:                     end;
~~~

## TODO 0021

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 312
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   310:                     trigger OnAction()
   311:                     begin
   312:                         //TODO: Ver FuncNominas.ProcesaDatosPonchador;
   313:                     end;
   314:                 }
~~~

## TODO 0022

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 345
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   343:     var
   344:         ConfNom: Record 34002103;
   345:         //TODO: Ver DistribAsistencia: Page 34002107;
   346:         //TODO: Ver FuncNominas: Codeunit 34002104;
   347:         [InDataSet]
~~~

## TODO 0023

- File path: `src/Pages/Page 34002122 - Control de asistencia.al`
- Object type: Page
- Object ID: 34002122
- Object name: `Control de asistencia`
- Line number: 346
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   344:         ConfNom: Record 34002103;
   345:         //TODO: Ver DistribAsistencia: Page 34002107;
   346:         //TODO: Ver FuncNominas: Codeunit 34002104;
   347:         [InDataSet]
   348: 
~~~

## TODO 0024

- File path: `src/Pages/Page 34002123 - Lista historico nóminas.al`
- Object type: Page
- Object ID: 34002123
- Object name: `Lista historico nominas`
- Line number: 68
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    66:                     PromotedCategory = Process;
    67:                     PromotedIsBig = true;
    68:                     //TODO: Ver RunObject = Report 34002124;
    69: 
    70:                     trigger OnAction()
~~~

## TODO 0025

- File path: `src/Pages/Page 34002123 - Lista historico nóminas.al`
- Object type: Page
- Object ID: 34002123
- Object name: `Lista historico nominas`
- Line number: 83
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    81:                     PromotedCategory = Process;
    82:                     PromotedIsBig = true;
    83:                     //TODO: Ver RunObject = Report 34002106;
    84:                 }
    85: 
~~~

## TODO 0026

- File path: `src/Pages/Page 34002123 - Lista historico nóminas.al`
- Object type: Page
- Object ID: 34002123
- Object name: `Lista historico nominas`
- Line number: 115
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   113:                 trigger OnAction()
   114:                 begin
   115:                     //TODO: Ver Modelorecibsalario.RUN(Rec);
   116:                 end;
   117:             }
~~~

## TODO 0027

- File path: `src/Pages/Page 34002123 - Lista historico nóminas.al`
- Object type: Page
- Object ID: 34002123
- Object name: `Lista historico nominas`
- Line number: 129
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   127:     var
   128:         Emp: Record 5200;
   129:     //TODO: Ver Modelorecibsalario: Codeunit 34002103;
   130: }
   131: 
~~~

## TODO 0028

- File path: `src/Pages/Page 34002125 - Estadisticas Empleados.al`
- Object type: Page
- Object ID: 34002125
- Object name: `Estadisticas Empleados`
- Line number: 49
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    47: 
    48:     var
    49:     //TODO: Ver FuncNom: Codeunit 34002104;
    50: }
    51: 
~~~

## TODO 0029

- File path: `src/Pages/Page 34002126 - Visualizar nómina histórico.al`
- Object type: Page
- Object ID: 34002126
- Object name: `Visualizar nomina historico`
- Line number: 13
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    11:             group(GeneralGroup)
    12:             {
    13:                 //TODO: Ver 
    14:                 /*
    15:                 field(TotDevengTotDeducc; TotDeveng + TotDeducc)
~~~

## TODO 0030

- File path: `src/Pages/Page 34002126 - Visualizar nómina histórico.al`
- Object type: Page
- Object ID: 34002126
- Object name: `Visualizar nomina historico`
- Line number: 30
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    28:                         //The GridLayout property is only supported on controls of type Grid
    29:                         //GridLayout = Columns;
    30:                         //TODO: Ver 
    31:                         /*
    32:                         group(GeneralGroup2)
~~~


## TODO 0031

- File path: `src/Pages/Page 34002126 - Visualizar nómina histórico.al`
- Object type: Page
- Object ID: 34002126
- Object name: `Visualizar nomina historico`
- Line number: 129
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   127:                         }*/
   128:                     }
   129:                     //TODO: Ver 
   130:                     /*
   131:                     field(TotDeveng; TotDeveng)
~~~

## TODO 0032

- File path: `src/Pages/Page 34002131 - Líneas cobros empleado.al`
- Object type: Page
- Object ID: 34002131
- Object name: `Lineas cobros empleado`
- Line number: 57
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    55:     trigger OnFindRecord(Which: Text): Boolean
    56:     begin
    57:         //TODO: Ver EXIT(GestionFormPeriodo.FindDate(Which, Rec, LongPeriodoClie));
    58:     end;
    59: 
~~~

## TODO 0033

- File path: `src/Pages/Page 34002131 - Líneas cobros empleado.al`
- Object type: Page
- Object ID: 34002131
- Object name: `Lineas cobros empleado`
- Line number: 62
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    60:     trigger OnNextRecord(Steps: Integer): Integer
    61:     begin
    62:         //TODO: Ver EXIT(GestionFormPeriodo.NextDate(Steps, Rec, LongPeriodoClie));
    63:     end;
    64: 
~~~

## TODO 0034

- File path: `src/Pages/Page 34002131 - Líneas cobros empleado.al`
- Object type: Page
- Object ID: 34002131
- Object name: `Lineas cobros empleado`
- Line number: 73
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    71:         Trab: Record 5200;
    72:         LinsNom: Record 34002118;
    73:         //TODO: Ver GestionFormPeriodo: Codeunit 359;
    74:         LongPeriodoClie: Option "Dia",Semana,Mes,Trimestre,"Año",Periodo;
    75:         TipImporte: Option "Saldo en el periodo","Saldo acumulado a la fecha";
~~~

## TODO 0035

- File path: `src/Pages/Page 34002133 - CxC Empleados.al`
- Object type: Page
- Object ID: 34002133
- Object name: `CxC Empleados`
- Line number: 78
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    76:                 {
    77:                     Caption = '&Movimientos CxC Empleados';
    78:                     //TODO: Ver RunObject = Page 58100;
    79:                     //TODO: Ver RunPageLink = Field1 = FIELD("No. Prestamo");
    80:                     Visible = false;
~~~

## TODO 0036

- File path: `src/Pages/Page 34002133 - CxC Empleados.al`
- Object type: Page
- Object ID: 34002133
- Object name: `CxC Empleados`
- Line number: 79
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    77:                     Caption = '&Movimientos CxC Empleados';
    78:                     //TODO: Ver RunObject = Page 58100;
    79:                     //TODO: Ver RunPageLink = Field1 = FIELD("No. Prestamo");
    80:                     Visible = false;
    81:                 }
~~~

## TODO 0037

- File path: `src/Pages/Page 34002134 - Histórico Prestamos.al`
- Object type: Page
- Object ID: 34002134
- Object name: `Historico Prestamos`
- Line number: 83
- Classification: Custom dependency
- Proposed correction: Verify the referenced part page and its source-table relationship, then restore the part declaration together with its complete SubPageLink block.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    81:                 }
    82:             }
    83:             //TODO: Ver part(PartPage; 34002135)
    84:             //TODO: Ver {
    85:             //TODO: Ver     SubPageLink = "No. Prestamo" = FIELD("No. Prestamo");
~~~

## TODO 0038

- File path: `src/Pages/Page 34002134 - Histórico Prestamos.al`
- Object type: Page
- Object ID: 34002134
- Object name: `Historico Prestamos`
- Line number: 84
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    82:             }
    83:             //TODO: Ver part(PartPage; 34002135)
    84:             //TODO: Ver {
    85:             //TODO: Ver     SubPageLink = "No. Prestamo" = FIELD("No. Prestamo");
    86:             //TODO: Ver }
~~~

## TODO 0039

- File path: `src/Pages/Page 34002134 - Histórico Prestamos.al`
- Object type: Page
- Object ID: 34002134
- Object name: `Historico Prestamos`
- Line number: 85
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    83:             //TODO: Ver part(PartPage; 34002135)
    84:             //TODO: Ver {
    85:             //TODO: Ver     SubPageLink = "No. Prestamo" = FIELD("No. Prestamo");
    86:             //TODO: Ver }
    87:         }
~~~

## TODO 0040

- File path: `src/Pages/Page 34002134 - Histórico Prestamos.al`
- Object type: Page
- Object ID: 34002134
- Object name: `Historico Prestamos`
- Line number: 86
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    84:             //TODO: Ver {
    85:             //TODO: Ver     SubPageLink = "No. Prestamo" = FIELD("No. Prestamo");
    86:             //TODO: Ver }
    87:         }
    88:     }
~~~

## TODO 0041

- File path: `src/Pages/Page 34002134 - Histórico Prestamos.al`
- Object type: Page
- Object ID: 34002134
- Object name: `Historico Prestamos`
- Line number: 104
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   102:                 begin
   103:                     CurrPage.SETSELECTIONFILTER(rPrestamo);
   104:                     //TODO: Ver REPORT.RUN(REPORT::"Lista Mov. CxC Empl.", TRUE, TRUE, rPrestamo);
   105:                 end;
   106:             }
~~~

## TODO 0042

- File path: `src/Pages/Page 34002134 - Histórico Prestamos.al`
- Object type: Page
- Object ID: 34002134
- Object name: `Historico Prestamos`
- Line number: 112
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   110:     var
   111:         rPrestamo: Record 34002146;
   112:     //TODO: Ver ImprInfor: Codeunit 228;
   113: }
   114: 
~~~

## TODO 0043

- File path: `src/Pages/Page 34002138 - Lista Mov. CxC Empleados.al`
- Object type: Page
- Object ID: 34002138
- Object name: `Lista Mov. CxC Empleados`
- Line number: 103
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   101:                     trigger OnAction()
   102:                     var
   103:                         //TODO: Ver CierraPrestamo: Report 34002142;
   104:                         HCP: Record 34002146;
   105:                     begin
~~~

## TODO 0044

- File path: `src/Pages/Page 34002138 - Lista Mov. CxC Empleados.al`
- Object type: Page
- Object ID: 34002138
- Object name: `Lista Mov. CxC Empleados`
- Line number: 107
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   105:                     begin
   106:                         CurrPage.SETSELECTIONFILTER(HCP);
   107:                         //TODO: Ver REPORT.RUN(REPORT::"Cierra Prestamos", TRUE, FALSE, HCP);
   108:                     end;
   109:                 }
~~~

## TODO 0045

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 98
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    96:                     trigger OnAction()
    97:                     begin
    98:                         //TODO: Ver FuncionesNomina.InicializaConceptosSalariales;
    99:                     end;
   100:                 }
~~~


## TODO 0046

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 109
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   107:                     PromotedCategory = Process;
   108:                     PromotedIsBig = true;
   109:                     //TODO: Ver RunObject = Report 34002182;
   110:                 }
   111:                 action("Import Expenses from G/L")
~~~

## TODO 0047

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 118
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   116:                     PromotedCategory = Process;
   117:                     PromotedIsBig = true;
   118:                     //TODO: Ver RunObject = Report 34002139;
   119:                 }
   120:                 action("Calculate payroll")
~~~

## TODO 0048

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 127
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   125:                     PromotedCategory = Process;
   126:                     PromotedIsBig = true;
   127:                     //TODO: Ver RunObject = Report 34002124;
   128:                 }
   129:                 action("Init Wedge")
~~~

## TODO 0049

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 135
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   133:                     Promoted = true;
   134:                     PromotedCategory = Process;
   135:                     //TODO: Ver RunObject = Report 34002130;
   136:                 }
   137: 
~~~

## TODO 0050

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 144
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   142:                     Promoted = true;
   143:                     PromotedCategory = Process;
   144:                     //TODO: Ver RunObject = Report 50211;
   145:                 }
   146:                 group(Reports)
~~~

## TODO 0051

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 156
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   154:                     Promoted = true;
   155:                     PromotedCategory = "Report";
   156:                     //TODO: Ver RunObject = Report 34002168;
   157:                 }
   158:                 action(Prestamos)
~~~

## TODO 0052

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 164
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   162:                     Promoted = true;
   163:                     PromotedCategory = "Report";
   164:                     //TODO: Ver RunObject = Report 34002120;
   165:                 }
   166:                 action(Vacaciones)
~~~

## TODO 0053

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 172
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   170:                     Promoted = true;
   171:                     PromotedCategory = "Report";
   172:                     //TODO: Ver RunObject = Report 34002125;
   173:                 }
   174:                 action("ListNomxDepto8.5")
~~~

## TODO 0054

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 224
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   222:                     Caption = 'Absence Registration';
   223:                     Image = Absence;
   224:                     //TODO: Ver RunObject = Page 5211;
   225:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No."),
   226:                     //TODO: Ver               Closed = CONST(false);
~~~

## TODO 0055

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 225
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   223:                     Image = Absence;
   224:                     //TODO: Ver RunObject = Page 5211;
   225:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No."),
   226:                     //TODO: Ver               Closed = CONST(false);
   227:                 }
~~~

## TODO 0056

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 226
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   224:                     //TODO: Ver RunObject = Page 5211;
   225:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No."),
   226:                     //TODO: Ver               Closed = CONST(false);
   227:                 }
   228:             }
~~~

## TODO 0057

- File path: `src/Pages/Page 34002144 - Diario Nominas.al`
- Object type: Page
- Object ID: 34002144
- Object name: `Diario Nominas`
- Line number: 257
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   255:         CabHistorico: Record 34002117;
   256:         ConfNominas: Record 34002103;
   257:         //TODO: Ver FuncionesNomina: Codeunit 34002104;
   258:         StatusEmpl: Boolean;
   259:         TipoConcepto: Option Ingresos,Deducciones,Ambos;
~~~

## TODO 0058

- File path: `src/Pages/Page 34002162 - Calendario Anual.al`
- Object type: Page
- Object ID: 34002162
- Object name: `Calendario Anual`
- Line number: 59
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    57:                     PromotedCategory = Process;
    58:                     PromotedIsBig = true;
    59:                     //TODO: Ver RunObject = Report 34002147;
    60:                 }
    61:                 action(Hollydays)
~~~

## TODO 0059

- File path: `src/Pages/Page 34002170 - Hist. acciones de personal.al`
- Object type: Page
- Object ID: 34002170
- Object name: `Hist. acciones de personal`
- Line number: 210
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   208:                     var
   209:                         Acciones: Record 34002159;
   210:                     //TODO: Ver RepAcciones: Report 34002161;
   211:                     begin
   212:                         CurrPage.SETSELECTIONFILTER(Acciones);
~~~

## TODO 0060

- File path: `src/Pages/Page 34002170 - Hist. acciones de personal.al`
- Object type: Page
- Object ID: 34002170
- Object name: `Hist. acciones de personal`
- Line number: 213
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   211:                     begin
   212:                         CurrPage.SETSELECTIONFILTER(Acciones);
   213:                         //TODO: Ver REPORT.RUN(REPORT::"Hist Acciones de personal", TRUE, TRUE, Acciones);
   214:                     end;
   215:                 }
~~~


## TODO 0061

- File path: `src/Pages/Page 34002175 - Employee Info FactBox.al`
- Object type: Page
- Object ID: 34002175
- Object name: `Employee Info FactBox`
- Line number: 11
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     9:         area(content)
    10:         {
    11:             //TODO: Ver 
    12:             /*
    13:             field("Busca Nov"; STRSUBSTNO('(%1)', CUNomina.BuscaNovedades(Rec)))
~~~

## TODO 0062

- File path: `src/Pages/Page 34002175 - Employee Info FactBox.al`
- Object type: Page
- Object ID: 34002175
- Object name: `Employee Info FactBox`
- Line number: 78
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    76: 
    77:     var
    78:     //TODO: Ver CUNomina: Codeunit 34002104;
    79: }
    80: 
~~~

## TODO 0063

- File path: `src/Pages/Page 34002176 - Payroll Information FactBox.al`
- Object type: Page
- Object ID: 34002176
- Object name: `Payroll Information FactBox`
- Line number: 11
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     9:         area(content)
    10:         {
    11:             //TODO: Ver 
    12:             /*
    13:             field(STRSUBSTNO('(%1)',CUNomina.BuscaNominas(Rec));STRSUBSTNO('(%1)',CUNomina.BuscaNominas(Rec)))
~~~

## TODO 0064

- File path: `src/Pages/Page 34002176 - Payroll Information FactBox.al`
- Object type: Page
- Object ID: 34002176
- Object name: `Payroll Information FactBox`
- Line number: 46
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    44: 
    45:     var
    46:     //TODO: Ver CUNomina: Codeunit 34002104;
    47: }
    48: 
~~~

## TODO 0065

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 255
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   253:                     Caption = 'Co&mments';
   254:                     Image = ViewComments;
   255:                     //TODO: Ver RunObject = Page 5222;
   256:                     //TODO: Ver RunPageLink = "Table Name" = CONST(Employee),
   257:                     //TODO: Ver              "No." = FIELD("No.");
~~~

## TODO 0066

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 256
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   254:                     Image = ViewComments;
   255:                     //TODO: Ver RunObject = Page 5222;
   256:                     //TODO: Ver RunPageLink = "Table Name" = CONST(Employee),
   257:                     //TODO: Ver              "No." = FIELD("No.");
   258:                 }
~~~

## TODO 0067

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 257
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   255:                     //TODO: Ver RunObject = Page 5222;
   256:                     //TODO: Ver RunPageLink = "Table Name" = CONST(Employee),
   257:                     //TODO: Ver              "No." = FIELD("No.");
   258:                 }
   259:                 action(DimensionsA)
~~~

## TODO 0068

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 263
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   261:                     Caption = 'Dimensions';
   262:                     Image = Dimensions;
   263:                     //TODO: Ver RunObject = Page "Default Dimensions";
   264:                     //TODO: Ver RunPageLink = "Table ID" = CONST(5200),
   265:                     //TODO: Ver              "No." = FIELD("No.");
~~~

## TODO 0069

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 264
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   262:                     Image = Dimensions;
   263:                     //TODO: Ver RunObject = Page "Default Dimensions";
   264:                     //TODO: Ver RunPageLink = "Table ID" = CONST(5200),
   265:                     //TODO: Ver              "No." = FIELD("No.");
   266:                     ShortCutKey = 'Shift+Ctrl+D';
~~~

## TODO 0070

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 265
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   263:                     //TODO: Ver RunObject = Page "Default Dimensions";
   264:                     //TODO: Ver RunPageLink = "Table ID" = CONST(5200),
   265:                     //TODO: Ver              "No." = FIELD("No.");
   266:                     ShortCutKey = 'Shift+Ctrl+D';
   267:                 }
~~~

## TODO 0071

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 271
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   269:                 {
   270:                     Caption = '&Picture';
   271:                     //TODO: Ver RunObject = Page 5202;
   272:                     //TODO: Ver RunPageLink = "No." = FIELD("No.");
   273:                 }
~~~

## TODO 0072

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 272
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   270:                     Caption = '&Picture';
   271:                     //TODO: Ver RunObject = Page 5202;
   272:                     //TODO: Ver RunPageLink = "No." = FIELD("No.");
   273:                 }
   274:                 action("&Alternative Addresses")
~~~

## TODO 0073

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 277
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   275:                 {
   276:                     Caption = '&Alternative Addresses';
   277:                     //TODO: Ver RunObject = Page 5203;
   278:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   279:                 }
~~~

## TODO 0074

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 278
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   276:                     Caption = '&Alternative Addresses';
   277:                     //TODO: Ver RunObject = Page 5203;
   278:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   279:                 }
   280:                 action("Relati&ves")
~~~

## TODO 0075

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 283
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   281:                 {
   282:                     Caption = 'Relati&ves';
   283:                     //TODO: Ver RunObject = Page 5209;
   284:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   285:                 }
~~~


## TODO 0076

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 284
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   282:                     Caption = 'Relati&ves';
   283:                     //TODO: Ver RunObject = Page 5209;
   284:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   285:                 }
   286:                 action("Mi&sc. Article Information")
~~~

## TODO 0077

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 289
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   287:                 {
   288:                     Caption = 'Mi&sc. Article Information';
   289:                     //TODO: Ver RunObject = Page 5219;
   290:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   291:                 }
~~~

## TODO 0078

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 290
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   288:                     Caption = 'Mi&sc. Article Information';
   289:                     //TODO: Ver RunObject = Page 5219;
   290:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   291:                 }
   292:                 action("Con&fidential Information")
~~~

## TODO 0079

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 295
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   293:                 {
   294:                     Caption = 'Con&fidential Information';
   295:                     //TODO: Ver RunObject = Page 5221;
   296:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   297:                 }
~~~

## TODO 0080

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 296
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   294:                     Caption = 'Con&fidential Information';
   295:                     //TODO: Ver RunObject = Page 5221;
   296:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   297:                 }
   298:                 action("Q&ualifications")
~~~

## TODO 0081

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 301
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   299:                 {
   300:                     Caption = 'Q&ualifications';
   301:                     //TODO: Ver RunObject = Page 5206;
   302:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   303:                 }
~~~

## TODO 0082

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 302
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   300:                     Caption = 'Q&ualifications';
   301:                     //TODO: Ver RunObject = Page 5206;
   302:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   303:                 }
   304:                 action("A&bsences")
~~~

## TODO 0083

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 307
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   305:                 {
   306:                     Caption = 'A&bsences';
   307:                     //TODO: Ver RunObject = Page 5211;
   308:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   309:                 }
~~~

## TODO 0084

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 308
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   306:                     Caption = 'A&bsences';
   307:                     //TODO: Ver RunObject = Page 5211;
   308:                     //TODO: Ver RunPageLink = "Employee No." = FIELD("No.");
   309:                 }
   310: 
~~~

## TODO 0085

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 314
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   312:                 {
   313:                     Caption = '&Related Companies';
   314:                     //TODO: Ver RunObject = Page 34002157;
   315:                     //TODO: Ver RunPageLink = "Cod. Empleado" = FIELD("No.");
   316:                 }
~~~

## TODO 0086

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 315
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   313:                     Caption = '&Related Companies';
   314:                     //TODO: Ver RunObject = Page 34002157;
   315:                     //TODO: Ver RunPageLink = "Cod. Empleado" = FIELD("No.");
   316:                 }
   317: 
~~~

## TODO 0087

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 321
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   319:                 {
   320:                     Caption = 'Absences b&y Categories';
   321:                     //TODO: Ver RunObject = Page 5226;
   322:                     //TODO: Ver RunPageLink = "No." = FIELD("No."),
   323:                     //TODO: Ver               "Employee No. Filter" = FIELD("No.");
~~~

## TODO 0088

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 322
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   320:                     Caption = 'Absences b&y Categories';
   321:                     //TODO: Ver RunObject = Page 5226;
   322:                     //TODO: Ver RunPageLink = "No." = FIELD("No."),
   323:                     //TODO: Ver               "Employee No. Filter" = FIELD("No.");
   324:                 }
~~~

## TODO 0089

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 323
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   321:                     //TODO: Ver RunObject = Page 5226;
   322:                     //TODO: Ver RunPageLink = "No." = FIELD("No."),
   323:                     //TODO: Ver               "Employee No. Filter" = FIELD("No.");
   324:                 }
   325:                 action("Misc. Articles &Overview")
~~~

## TODO 0090

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 328
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   326:                 {
   327:                     Caption = 'Misc. Articles &Overview';
   328:                     //TODO: Ver RunObject = Page 5228;
   329:                 }
   330:                 action("Confidential Info. Overvie&w")
~~~


## TODO 0091

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 333
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   331:                 {
   332:                     Caption = 'Confidential Info. Overvie&w';
   333:                     //TODO: Ver RunObject = Page 5229;
   334:                 }
   335: 
~~~

## TODO 0092

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 374
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   372:                 trigger OnAction()
   373:                 begin
   374:                     //TODO: Ver CUNomina.MuestraNominas(Rec);
   375:                 end;
   376:             }
~~~

## TODO 0093

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 386
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   384:                 trigger OnAction()
   385:                 begin
   386:                     //TODO: Ver CUNomina.MuestraDimensiones("No.");
   387:                 end;
   388:             }
~~~

## TODO 0094

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 397
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   395:                 trigger OnAction()
   396:                 begin
   397:                     //TODO: Ver CUNomina.MuestraCualificaciones("No.");
   398:                 end;
   399:             }
~~~

## TODO 0095

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 408
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   406:                 trigger OnAction()
   407:                 begin
   408:                     //TODO: Ver CUNomina.MuestraNovedades(Rec);
   409:                 end;
   410:             }
~~~

## TODO 0096

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 430
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   428:     trigger OnOpenPage()
   429:     var
   430:     //TODO: Ver MapMgt: Codeunit 802;
   431:     begin
   432:         //TODO: Ver IF NOT MapMgt.TestSetup THEN
~~~

## TODO 0097

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 432
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   430:     //TODO: Ver MapMgt: Codeunit 802;
   431:     begin
   432:         //TODO: Ver IF NOT MapMgt.TestSetup THEN
   433:         //TODO: Ver     MapPointVisible := FALSE;
   434:     end;
~~~

## TODO 0098

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 433
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   431:     begin
   432:         //TODO: Ver IF NOT MapMgt.TestSetup THEN
   433:         //TODO: Ver     MapPointVisible := FALSE;
   434:     end;
   435: 
~~~

## TODO 0099

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 437
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   435: 
   436:     var
   437:         //TODO: Ver Mail: Codeunit 397;
   438:         //TODO: Ver CUNomina: Codeunit 34002104;
   439:         FechaIni: Date;
~~~

## TODO 0100

- File path: `src/Pages/Page 34002180 - Datos empleados moviles OJO.al`
- Object type: Page
- Object ID: 34002180
- Object name: `Datos empleados moviles OJO`
- Line number: 438
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   436:     var
   437:         //TODO: Ver Mail: Codeunit 397;
   438:         //TODO: Ver CUNomina: Codeunit 34002104;
   439:         FechaIni: Date;
   440:         FechaFin: Date;
~~~

## TODO 0101

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 91
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    89:             {
    90:                 Caption = 'Employee Information';
    91:                 //TODO: Ver 
    92:                 /*
    93:                 field(STRSUBSTNO('(%1)',CUNomina.BuscaNovedades(Rec));STRSUBSTNO('(%1)',CUNomina.BuscaNovedades(Rec)))
~~~

## TODO 0102

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 108
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   106:             group(NomInfoPanel)
   107:             {
   108:                 //TODO: Ver 
   109:                 /*
   110:                 Caption = 'Payroll Information';
~~~

## TODO 0103

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 310
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   308:                 {
   309:                     Caption = '&Related Companies';
   310:                     //TODO: Ver RunObject = Page 34002157;
   311:                     //TODO: Ver RunPageLink = "Cod. Empleado" = FIELD("No.");
   312:                 }
~~~

## TODO 0104

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 311
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   309:                     Caption = '&Related Companies';
   310:                     //TODO: Ver RunObject = Page 34002157;
   311:                     //TODO: Ver RunPageLink = "Cod. Empleado" = FIELD("No.");
   312:                 }
   313: 
~~~

## TODO 0105

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 377
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   375:                 trigger OnAction()
   376:                 begin
   377:                     //TODO: Ver CUNomina.MuestraNominas(Rec);
   378:                 end;
   379:             }
~~~


## TODO 0106

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 389
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   387:                 trigger OnAction()
   388:                 begin
   389:                     //TODO: Ver CUNomina.MuestraDimensiones("No.");
   390:                 end;
   391:             }
~~~

## TODO 0107

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 400
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   398:                 trigger OnAction()
   399:                 begin
   400:                     //TODO: Ver CUNomina.MuestraCualificaciones("No.");
   401:                 end;
   402:             }
~~~

## TODO 0108

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 411
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   409:                 trigger OnAction()
   410:                 begin
   411:                     //TODO: Ver CUNomina.MuestraNovedades(Rec);
   412:                 end;
   413:             }
~~~

## TODO 0109

- File path: `src/Pages/Page 34002181 - Temporary Employee Card OJO.al`
- Object type: Page
- Object ID: 34002181
- Object name: `Temporary Employee Card OJO`
- Line number: 441
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   439:     var
   440:         Mail: Codeunit 397;
   441:         //TODO: Ver CUNomina: Codeunit 34002104;
   442:         FechaIni: Date;
   443:         FechaFin: Date;
~~~

## TODO 0110

- File path: `src/Pages/Page 34002182 - Informacion del empleado.al`
- Object type: Page
- Object ID: 34002182
- Object name: `Informacion del empleado`
- Line number: 11
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     9:         area(content)
    10:         {
    11:             //TODO: Ver 
    12:             /*
    13:             field(Picture; Picture)
~~~

## TODO 0111

- File path: `src/Pages/Page 34002182 - Informacion del empleado.al`
- Object type: Page
- Object ID: 34002182
- Object name: `Informacion del empleado`
- Line number: 40
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    38: 
    39:     var
    40:     //TODO: Ver CUNomina: Codeunit 34002104;
    41: }
    42: 
~~~

## TODO 0112

- File path: `src/Pages/Page 34002183 - Informacion de nominas.al`
- Object type: Page
- Object ID: 34002183
- Object name: `Informacion de nominas`
- Line number: 11
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     9:         area(content)
    10:         {
    11:             //TODO: Ver 
    12:             /*
    13:             field(Novedades; STRSUBSTNO('(%1)', CUNomina.BuscaNominas(Rec)))
~~~

## TODO 0113

- File path: `src/Pages/Page 34002183 - Informacion de nominas.al`
- Object type: Page
- Object ID: 34002183
- Object name: `Informacion de nominas`
- Line number: 25
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    23: 
    24:     var
    25:     //TODO: Ver  CUNomina: Codeunit 34002104;
    26: }
    27: 
~~~

## TODO 0114

- File path: `src/Pages/Page 34002188 - DSNOM Activities.al`
- Object type: Page
- Object ID: 34002188
- Object name: `DSNOM Activities`
- Line number: 46
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    44:             {
    45:                 Caption = 'Vacation';
    46:                 //TODO: Ver 
    47:                 /*
    48:                 field(FuncionesNomVacacionesporVencer;
~~~

## TODO 0115

- File path: `src/Pages/Page 34002188 - DSNOM Activities.al`
- Object type: Page
- Object ID: 34002188
- Object name: `DSNOM Activities`
- Line number: 52
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    50:                 {
    51:                     Caption = 'vacation to expire';
    52:                     //TODO: Ver DecimalPlaces = 0 : 2;
    53:                     Image = Calendar;
    54: 
~~~

## TODO 0116

- File path: `src/Pages/Page 34002188 - DSNOM Activities.al`
- Object type: Page
- Object ID: 34002188
- Object name: `DSNOM Activities`
- Line number: 123
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   121: 
   122:     var
   123:         //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
   124:         Fecha: Record 2000000007;
   125: }
~~~

## TODO 0117

- File path: `src/Pages/Page 34002188 - DSNOM Activities.al`
- Object type: Page
- Object ID: 34002188
- Object name: `DSNOM Activities`
- Line number: 123
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   121: 
   122:     var
   123:         //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
   124:         Fecha: Record 2000000007;
   125: }
~~~

## TODO 0118

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 115
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   113:                         Caption = 'Post Payroll';
   114:                         Image = Post;
   115:                         //TODO: Ver RunObject = Report 34002124;
   116:                     }
   117:                     action("Send Payroll slip")
~~~

## TODO 0119

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 121
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   119:                         Caption = 'Send Payroll slip';
   120:                         Image = SendTo;
   121:                         //TODO: Ver RunObject = Report 34002114;
   122:                     }
   123:                     action("Generate Bank's file")
~~~

## TODO 0120

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 127
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   125:                         Caption = 'Generate Bank''s file';
   126:                         Image = TransferFunds;
   127:                         //TODO: Ver RunObject = Report 34002121;
   128:                     }
   129:                     action("Post Payroll to G/L")
~~~


## TODO 0121

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 133
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   131:                         Caption = 'Post Payroll to G/L';
   132:                         Image = PostInventoryToGL;
   133:                         //TODO: Ver RunObject = Report 34002106;
   134:                     }
   135:                 }
~~~

## TODO 0122

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 184
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   182:                         Caption = 'Assign formula to wages';
   183:                         Image = MapSetup;
   184:                         //TODO: Ver RunObject = Report 34002181;
   185:                     }
   186:                     action(PromoSal)
~~~

## TODO 0123

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 196
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   194:                         Caption = 'Payroll check''s report';
   195:                         Image = Payment;
   196:                         //TODO: Ver RunObject = Report 34002116;
   197:                     }
   198:                     action(cierraprest)
~~~

## TODO 0124

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 202
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   200:                         Caption = 'Finish loans';
   201:                         Image = Loaner;
   202:                         //TODO: Ver RunObject = Report 34002142;
   203:                     }
   204:                     action("Envio IRM")
~~~

## TODO 0125

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 207
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   205:                     {
   206:                         Image = "Report";
   207:                         //TODO: Ver RunObject = Report 55353;
   208:                     }
   209:                 }
~~~

## TODO 0126

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 224
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   222:                         Promoted = true;
   223:                         PromotedCategory = "Report";
   224:                         //TODO: Ver RunObject = Report 34002102;
   225:                     }
   226:                     action(ListadoNomxDepto)
~~~

## TODO 0127

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 232
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   230:                         Promoted = true;
   231:                         PromotedCategory = "Report";
   232:                         //TODO: Ver RunObject = Report 34002103;
   233:                     }
   234:                     action(ValidaNom)
~~~

## TODO 0128

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 238
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   236:                         Caption = 'Validate payroll by wage';
   237:                         Image = Print;
   238:                         //TODO: Ver RunObject = Report 34002167;
   239:                     }
   240:                     action(exporttoexcel)
~~~

## TODO 0129

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 244
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   242:                         Caption = 'Export Payroll To Excel';
   243:                         Image = Excel;
   244:                         //TODO: Ver RunObject = Report 34002168;
   245:                     }
   246:                     action(LlenaAutodet)
~~~

## TODO 0130

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 250
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   248:                         Caption = 'Fill SS template';
   249:                         Image = Excel;
   250:                         //TODO: Ver RunObject = Report 34002131;
   251:                     }
   252:                     action(LlenaDGT)
~~~

## TODO 0131

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 256
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   254:                         Caption = 'Fill DGT3-4 template';
   255:                         Image = Excel;
   256:                         //TODO: Ver RunObject = Report 34002160;
   257:                     }
   258:                     group(Yearly)
~~~

## TODO 0132

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 266
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   264:                             Caption = 'Christmas salary report';
   265:                             Image = "Report";
   266:                             //TODO: Ver RunObject = Report 34002119;
   267:                         }
   268:                         action(ListaBonif)
~~~

## TODO 0133

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 272
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   270:                             Caption = 'Bonus report';
   271:                             Image = "Report";
   272:                             //TODO: Ver RunObject = Report 34002126;
   273:                         }
   274:                     }
~~~

## TODO 0134

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 283
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   281:                     {
   282:                         Caption = 'Employee - Labels';
   283:                         //TODO: Ver RunObject = Report 5200;
   284:                         ToolTip = 'View a list of employees'' mailing labels.';
   285:                     }
~~~

## TODO 0135

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 289
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   287:                     {
   288:                         Caption = 'Employee - List';
   289:                         //TODO: Ver RunObject = Report 5201;
   290:                         ToolTip = 'View a list of all employees.';
   291:                     }
~~~


## TODO 0136

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 295
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   293:                     {
   294:                         Caption = 'Employee - Misc. Article Info.';
   295:                         //TODO: Ver RunObject = Report 5202;
   296:                         ToolTip = 'View a list of employees'' miscellaneous articles.';
   297:                     }
~~~

## TODO 0137

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 301
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   299:                     {
   300:                         Caption = 'Employee - Confidential Info.';
   301:                         //TODO: Ver RunObject = Report 5203;
   302:                         ToolTip = 'View a list of employees'' confidential information.';
   303:                     }
~~~

## TODO 0138

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 307
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   305:                     {
   306:                         Caption = 'Employee - Staff Absences';
   307:                         //TODO: Ver RunObject = Report 5204;
   308:                         ToolTip = 'View a list of employee absences by date. The list includes the cause of each employee absence.';
   309:                     }
~~~

## TODO 0139

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 313
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   311:                     {
   312:                         Caption = 'Employee - Absences by Causes';
   313:                         //TODO: Ver RunObject = Report 5205;
   314:                         ToolTip = 'View a list of all employees'' absences categorized by absence code.';
   315:                     }
~~~

## TODO 0140

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 319
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   317:                     {
   318:                         Caption = 'Employee - Qualifications';
   319:                         //TODO: Ver RunObject = Report 5206;
   320:                         ToolTip = 'View a list of employees'' qualifications.';
   321:                     }
~~~

## TODO 0141

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 325
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   323:                     {
   324:                         Caption = 'Employee - Addresses';
   325:                         //TODO: Ver RunObject = Report 5207;
   326:                         ToolTip = 'View a list of employees'' addresses.';
   327:                     }
~~~

## TODO 0142

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 331
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   329:                     {
   330:                         Caption = 'Employee - Relatives';
   331:                         //TODO: Ver RunObject = Report 5208;
   332:                         ToolTip = 'View a list of employees'' relatives.';
   333:                     }
~~~

## TODO 0143

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 337
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   335:                     {
   336:                         Caption = 'Employee - Birthdays';
   337:                         //TODO: Ver RunObject = Report 5209;
   338:                         ToolTip = 'View a list of employees'' birthdays.';
   339:                     }
~~~

## TODO 0144

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 343
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   341:                     {
   342:                         Caption = 'Employee - Phone Nos.';
   343:                         //TODO: Ver RunObject = Report 5210;
   344:                         ToolTip = 'View a list of employees'' phone numbers.';
   345:                     }
~~~

## TODO 0145

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 349
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   347:                     {
   348:                         Caption = 'Employee - Unions';
   349:                         //TODO: Ver RunObject = Report 5211;
   350:                         ToolTip = 'View a list of employees'' union memberships.';
   351:                     }
~~~

## TODO 0146

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 355
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   353:                     {
   354:                         Caption = 'Employee - Contracts';
   355:                         //TODO: Ver RunObject = Report 5212;
   356:                         ToolTip = 'View all employee contracts.';
   357:                     }
~~~

## TODO 0147

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 361
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   359:                     {
   360:                         Caption = 'Employee - Alt. Addresses';
   361:                         //TODO: Ver RunObject = Report 5213;
   362:                         ToolTip = 'View a list of employees'' alternate addresses.';
   363:                     }
~~~

## TODO 0148

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 524
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   522:                     ApplicationArea = BasicHR;
   523:                     Caption = 'Disabilities';
   524:                     //TODO: Ver RunObject = Page 34002171;
   525:                 }
   526:                 action(AgrupaPuestos)
~~~

## TODO 0149

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 592
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   590:                     ApplicationArea = BasicHR;
   591:                     Caption = 'Reports Configuration';
   592:                     //TODO: Ver RunObject = Page 34002120;
   593:                 }
   594:                 action(DimContab)
~~~

## TODO 0150

- File path: `src/Pages/Page 34002189 - DSNOM Payroll Role Center.al`
- Object type: Page
- Object ID: 34002189
- Object name: `DSNOM Payroll Role Center`
- Line number: 602
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   600:                 {
   601:                     Caption = 'Init wage concepts';
   602:                     //TODO: Ver RunObject = Page 34002150;
   603:                 }
   604:                 action(ControlAsistencia)
~~~


## TODO 0151

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 23
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    21:                 begin
    22:                     CurrPage.SAVERECORD;
    23:                     //TODO: Ver JobJnlManagement.LookupName(CurrentJnlBatchName, Rec);
    24:                     CurrPage.UPDATE(FALSE);
    25:                 end;
~~~

## TODO 0152

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 57
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    55:                     trigger OnValidate()
    56:                     begin
    57:                         //TODO: Ver JobJnlManagement.GetNames(Rec, JobDescription, AccName);
    58:                         //ShowShortcutDimCode(ShortcutDimCode);
    59:                     end;
~~~

## TODO 0153

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 247
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   245:                         PJL.SETRANGE("Journal Template Name", "Journal Template Name");
   246:                         PJL.SETRANGE("Journal Batch Name", "Journal Batch Name");
   247:                         //TODO: Ver REPORT.RUN(REPORT::"Valida Diario Nom. - Proyectos", TRUE, TRUE, PJL);
   248:                     end;
   249:                 }
~~~

## TODO 0154

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 261
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   259:                     trigger OnAction()
   260:                     begin
   261:                         //TODO: Ver CODEUNIT.RUN(CODEUNIT::"Post Payroll - Job Journal", Rec);
   262:                         CurrPage.UPDATE(FALSE);
   263:                     end;
~~~

## TODO 0155

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 300
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   298:         IF OpenedFromBatch THEN BEGIN
   299:             CurrentJnlBatchName := "Journal Batch Name";
   300:             //TODO: Ver JobJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
   301:             EXIT;
   302:         END;
~~~

## TODO 0156

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 303
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   301:             EXIT;
   302:         END;
   303:         //TODO: Ver JobJnlManagement.TemplateSelection(PAGE::"Payroll - Job Journal Batches", FALSE, Rec, JnlSelected);
   304:         IF NOT JnlSelected THEN
   305:             ERROR('');
~~~

## TODO 0157

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 306
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   304:         IF NOT JnlSelected THEN
   305:             ERROR('');
   306:         //TODO: Ver JobJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
   307:     end;
   308: 
~~~

## TODO 0158

- File path: `src/Pages/Page 34002193 - Payroll - Job Journal.al`
- Object type: Page
- Object ID: 34002193
- Object name: `Payroll - Job Journal`
- Line number: 310
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   308: 
   309:     var
   310:         //TODO: Ver JobJnlManagement: Codeunit 34002120;
   311:         JobDescription: Text[50];
   312:         AccName: Text[50];
~~~

## TODO 0159

- File path: `src/Pages/Page 34002195 - Payroll - Job Journal Batches.al`
- Object type: Page
- Object ID: 34002195
- Object name: `Payroll - Job Journal Batches`
- Line number: 52
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    50:                 trigger OnAction()
    51:                 begin
    52:                     //TODO: Ver JobJnlMgt.TemplateSelectionFromBatch(Rec);
    53:                 end;
    54:             }
~~~

## TODO 0160

- File path: `src/Pages/Page 34002195 - Payroll - Job Journal Batches.al`
- Object type: Page
- Object ID: 34002195
- Object name: `Payroll - Job Journal Batches`
- Line number: 105
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   103:     trigger OnOpenPage()
   104:     begin
   105:         //TODO: Ver JobJnlMgt.OpenJnlBatch(Rec);
   106:     end;
   107: 
~~~

## TODO 0161

- File path: `src/Pages/Page 34002195 - Payroll - Job Journal Batches.al`
- Object type: Page
- Object ID: 34002195
- Object name: `Payroll - Job Journal Batches`
- Line number: 110
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   108:     var
   109:         ReportPrint: Codeunit 228;
   110:     //TODO: Ver JobJnlMgt: Codeunit 34002120;
   111: 
   112:     local procedure DataCaption(): Text[250]
~~~

## TODO 0162

- File path: `src/Pages/Page 34002199 - Datos Ponchador.al`
- Object type: Page
- Object ID: 34002199
- Object name: `Datos Ponchador`
- Line number: 65
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    63:                     trigger OnAction()
    64:                     var
    65:                     //TODO: Ver AdoConn: Codeunit 34002124;
    66:                     begin
    67:                         //TODO: Ver AdoConn.ReadEmp
~~~

## TODO 0163

- File path: `src/Pages/Page 34002199 - Datos Ponchador.al`
- Object type: Page
- Object ID: 34002199
- Object name: `Datos Ponchador`
- Line number: 67
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    65:                     //TODO: Ver AdoConn: Codeunit 34002124;
    66:                     begin
    67:                         //TODO: Ver AdoConn.ReadEmp
    68:                     end;
    69:                 }
~~~

## TODO 0164

- File path: `src/Pages/Page 34002211 - Conf. Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002211
- Object name: `Conf. Cuest. Evaluacion`
- Line number: 177
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   175:                         ProfileQuestnHeader.GET(CurrentQuestionsChecklistCode);
   176:                         ProfileQuestnHeader.SETRECFILTER;
   177:                         //TODO: Ver REPORT.RUN(REPORT::"Update Employee Classification", TRUE, FALSE, ProfileQuestnHeader);
   178:                     end;
   179:                 }
~~~

## TODO 0165

- File path: `src/Pages/Page 34002211 - Conf. Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002211
- Object name: `Conf. Cuest. Evaluacion`
- Line number: 222
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   220:                     begin
   221:                         ProfileQuestnHeader.SETRANGE(Code, CurrentQuestionsChecklistCode);
   222:                         //TODO: Ver REPORT.RUN(REPORT::"Recibo Nomina sin copia - coop", TRUE, FALSE, ProfileQuestnHeader);
   223:                     end;
   224:                 }
~~~


## TODO 0166

- File path: `src/Pages/Page 34002211 - Conf. Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002211
- Object name: `Conf. Cuest. Evaluacion`
- Line number: 237
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   235:                     begin
   236:                         ProfileQuestnHeader.SETRANGE(Code, CurrentQuestionsChecklistCode);
   237:                         //TODO: Ver REPORT.RUN(REPORT::"Nominas por departamentos A4", TRUE, FALSE, ProfileQuestnHeader);
   238:                     end;
   239:                 }
~~~

## TODO 0167

- File path: `src/Pages/Page 34002211 - Conf. Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002211
- Object name: `Conf. Cuest. Evaluacion`
- Line number: 280
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   278:         END;
   279: 
   280:         //TODO: Ver IF CurrentQuestionsChecklistCode = '' THEN
   281:         //TODO: Ver     CurrentQuestionsChecklistCode := ProfileManagement.GetQuestionnaire;
   282: 
~~~

## TODO 0168

- File path: `src/Pages/Page 34002211 - Conf. Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002211
- Object name: `Conf. Cuest. Evaluacion`
- Line number: 281
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   279: 
   280:         //TODO: Ver IF CurrentQuestionsChecklistCode = '' THEN
   281:         //TODO: Ver     CurrentQuestionsChecklistCode := ProfileManagement.GetQuestionnaire;
   282: 
   283:         //001 ProfileManagement.SetName(CurrentQuestionsChecklistCode,Rec,0);
~~~

## TODO 0169

- File path: `src/Pages/Page 34002211 - Conf. Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002211
- Object name: `Conf. Cuest. Evaluacion`
- Line number: 292
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   290:         Text000: Label 'Details only available for questions.';
   291:         ProfileQuestnHeader: Record 34002184;
   292:         //TODO: Ver ProfileManagement: Codeunit 34002123;
   293:         CurrentQuestionsChecklistCode: Code[20];
   294:         Text001: Label 'Where-Used only available for answers.';
~~~

## TODO 0170

- File path: `src/Pages/Page 34002212 - Preguntas Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002212
- Object name: `Preguntas Cuest. Evaluacion`
- Line number: 25
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    23:                 begin
    24:                     CurrPage.SAVERECORD;
    25:                     //TODO: Ver ProfileManagement.LookupName(CurrentQuestionsChecklistCode, Rec, Emp);
    26:                     CurrPage.UPDATE(FALSE);
    27:                 end;
~~~

## TODO 0171

- File path: `src/Pages/Page 34002212 - Preguntas Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002212
- Object name: `Preguntas Cuest. Evaluacion`
- Line number: 31
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    29:                 trigger OnValidate()
    30:                 begin
    31:                     //TODO: Ver ProfileManagement.CheckName(CurrentQuestionsChecklistCode, Emp);
    32:                     CurrentQuestionsChecklistCodeO;
    33:                 end;
~~~

## TODO 0172

- File path: `src/Pages/Page 34002212 - Preguntas Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002212
- Object name: `Preguntas Cuest. Evaluacion`
- Line number: 173
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   171:     trigger OnOpenPage()
   172:     begin
   173:         //TODO: Ver 
   174:         /*
   175:         IF EmpProfileAnswerCode = '' THEN
~~~

## TODO 0173

- File path: `src/Pages/Page 34002212 - Preguntas Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002212
- Object name: `Preguntas Cuest. Evaluacion`
- Line number: 198
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   196:         ProfileQuestionnaireLine2: Record 34002185;
   197:         ProfileQuestLineQuestion: Record 34002185;
   198:         //TODO: Ver ProfileManagement: Codeunit 34002122;
   199:         CurrentQuestionsChecklistCode: Code[20];
   200:         EmpProfileAnswerCode: Code[20];
~~~

## TODO 0174

- File path: `src/Pages/Page 34002212 - Preguntas Cuest. Evaluacion.al`
- Object type: Page
- Object ID: 34002212
- Object name: `Preguntas Cuest. Evaluacion`
- Line number: 253
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   251:     begin
   252:         CurrPage.SAVERECORD;
   253:         //TODO: Ver ProfileManagement.SetName(CurrentQuestionsChecklistCode, Rec, 0);
   254:         CurrPage.UPDATE(FALSE);
   255:     end;
~~~

## TODO 0175

- File path: `src/Pages/Page 34002214 - Planificacion de vacaciones.al`
- Object type: Page
- Object ID: 34002214
- Object name: `Planificacion de vacaciones`
- Line number: 53
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    51:                     trigger OnAction()
    52:                     begin
    53:                         //TODO: Ver REPORT.RUNMODAL(REPORT::"Proceso proponer vacaciones", TRUE, FALSE);
    54:                     end;
    55:                 }
~~~

## TODO 0176

- File path: `src/Pages/Page 34002217 - Ficha Miembros Coop..al`
- Object type: Page
- Object ID: 34002217
- Object name: `Ficha Miembros Coop.`
- Line number: 114
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   112:                         */
   113: 
   114:                         //TODO: Ver Funcionescooperativa.ActivarMiembro(Rec);
   115: 
   116:                     end;
~~~

## TODO 0177

- File path: `src/Pages/Page 34002217 - Ficha Miembros Coop..al`
- Object type: Page
- Object ID: 34002217
- Object name: `Ficha Miembros Coop.`
- Line number: 147
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   145:                         MESSAGE(Msg002);
   146:                         */
   147:                         //TODO: Ver Funcionescooperativa.InActivarMiembro(Rec);
   148: 
   149:                     end;
~~~

## TODO 0178

- File path: `src/Pages/Page 34002217 - Ficha Miembros Coop..al`
- Object type: Page
- Object ID: 34002217
- Object name: `Ficha Miembros Coop.`
- Line number: 165
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   163:                         PerfilSal: Record 34002115;
   164:                     begin
   165:                         //TODO: Ver Funcionescooperativa.RetirarMiembro(Rec);
   166:                     end;
   167:                 }
~~~

## TODO 0179

- File path: `src/Pages/Page 34002217 - Ficha Miembros Coop..al`
- Object type: Page
- Object ID: 34002217
- Object name: `Ficha Miembros Coop.`
- Line number: 182
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   180:         Msg001: Label 'Successful employee activation';
   181:         Msg002: Label 'Successful employee inactivation';
   182:         //TODO: Ver Funcionescooperativa: Codeunit 34002110;
   183:         [InDataSet]
   184:         Editar: Boolean;
~~~

## TODO 0180

- File path: `src/Pages/Page 34002220 - Cab. prestamos cooperativa.al`
- Object type: Page
- Object ID: 34002220
- Object name: `Cab. prestamos cooperativa`
- Line number: 90
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    88:                     trigger OnAction()
    89:                     begin
    90:                         //TODO: Ver FuncCoop.CrearCuotasCoop(Rec);
    91:                     end;
    92:                 }
~~~


## TODO 0181

- File path: `src/Pages/Page 34002220 - Cab. prestamos cooperativa.al`
- Object type: Page
- Object ID: 34002220
- Object name: `Cab. prestamos cooperativa`
- Line number: 105
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   103:                     trigger OnAction()
   104:                     begin
   105:                         //TODO: Ver FuncCoop.RegistrarPrestCoop(Rec);
   106:                     end;
   107:                 }
~~~

## TODO 0182

- File path: `src/Pages/Page 34002220 - Cab. prestamos cooperativa.al`
- Object type: Page
- Object ID: 34002220
- Object name: `Cab. prestamos cooperativa`
- Line number: 113
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   111: 
   112:     var
   113:     //TODO: Ver FuncCoop: Codeunit 34002110;
   114: }
   115: 
~~~

## TODO 0183

- File path: `src/Pages/Page 34002233 - Asistentes entrenamientos.al`
- Object type: Page
- Object ID: 34002233
- Object name: `Asistentes entrenamientos`
- Line number: 112
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   110:                     trigger OnAction()
   111:                     begin
   112:                         //TODO: Ver FuncEnt.EnviarNotificacion(Rec);
   113:                     end;
   114:                 }
~~~

## TODO 0184

- File path: `src/Pages/Page 34002233 - Asistentes entrenamientos.al`
- Object type: Page
- Object ID: 34002233
- Object name: `Asistentes entrenamientos`
- Line number: 158
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   156:         CabEntrenamiento: Record 34002204;
   157:         Asistentesentrenamientos: Record 34002206;
   158:         //TODO: Ver FuncEnt: Codeunit 34002145;
   159:         TotalInscritos: Integer;
   160:         TotalAsistentes: Integer;
~~~

## TODO 0185

- File path: `src/Pages/Page 34002235 - DSNOM Activities - RH.al`
- Object type: Page
- Object ID: 34002235
- Object name: `DSNOM Activities - RH`
- Line number: 20
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    18:                 {
    19:                 }
    20:                 //TODO: Ver 
    21:                 /*
    22:                 field(FuncionesNomAniversarioEmpleados;
~~~

## TODO 0186

- File path: `src/Pages/Page 34002235 - DSNOM Activities - RH.al`
- Object type: Page
- Object ID: 34002235
- Object name: `DSNOM Activities - RH`
- Line number: 26
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    24:                 {
    25:                     Caption = 'Empl. anniversary';
    26:                     //TODO: Ver DecimalPlaces = 0 : 2;
    27:                     Image = Time;
    28:                     Style = Attention;
~~~

## TODO 0187

- File path: `src/Pages/Page 34002235 - DSNOM Activities - RH.al`
- Object type: Page
- Object ID: 34002235
- Object name: `DSNOM Activities - RH`
- Line number: 63
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    61:             {
    62:                 Caption = 'Vacation';
    63:                 //TODO: Ver 
    64:                 /*
    65:                 field(FuncionesNomVacacionesporVencer;
~~~

## TODO 0188

- File path: `src/Pages/Page 34002235 - DSNOM Activities - RH.al`
- Object type: Page
- Object ID: 34002235
- Object name: `DSNOM Activities - RH`
- Line number: 69
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    67:                 {
    68:                     Caption = 'vacation to expire';
    69:                     //TODO: Ver DecimalPlaces = 0 : 2;
    70:                     Image = Calendar;
    71: 
~~~

## TODO 0189

- File path: `src/Pages/Page 34002235 - DSNOM Activities - RH.al`
- Object type: Page
- Object ID: 34002235
- Object name: `DSNOM Activities - RH`
- Line number: 140
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   138: 
   139:     var
   140:         //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
   141:         Fecha: Record 2000000007;
   142: }
~~~

## TODO 0190

- File path: `src/Pages/Page 34002235 - DSNOM Activities - RH.al`
- Object type: Page
- Object ID: 34002235
- Object name: `DSNOM Activities - RH`
- Line number: 140
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   138: 
   139:     var
   140:         //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
   141:         Fecha: Record 2000000007;
   142: }
~~~

## TODO 0191

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 72
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    70:                 Caption = 'Employee - Labels';
    71:                 Image = "Report";
    72:                 //TODO: Ver RunObject = Report 5200;
    73:                 ToolTip = 'View a list of employees'' mailing labels.';
    74:             }
~~~

## TODO 0192

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 79
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    77:                 Caption = 'Employee - List';
    78:                 Image = "Report";
    79:                 //TODO: Ver RunObject = Report 5201;
    80:                 ToolTip = 'View a list of all employees.';
    81:             }
~~~

## TODO 0193

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 86
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    84:                 Caption = 'Employee - Misc. Article Info.';
    85:                 Image = "Report";
    86:                 //TODO: Ver RunObject = Report 5202;
    87:                 ToolTip = 'View a list of employees'' miscellaneous articles.';
    88:             }
~~~

## TODO 0194

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 93
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    91:                 Caption = 'Employee - Confidential Info.';
    92:                 Image = "Report";
    93:                 //TODO: Ver RunObject = Report 5203;
    94:                 ToolTip = 'View a list of employees'' confidential information.';
    95:             }
~~~

## TODO 0195

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 100
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    98:                 Caption = 'Employee - Staff Absences';
    99:                 Image = "Report";
   100:                 //TODO: Ver RunObject = Report 5204;
   101:                 ToolTip = 'View a list of employee absences by date. The list includes the cause of each employee absence.';
   102:             }
~~~


## TODO 0196

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 107
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   105:                 Caption = 'Employee - Absences by Causes';
   106:                 Image = "Report";
   107:                 //TODO: Ver RunObject = Report 5205;
   108:                 ToolTip = 'View a list of all employees'' absences categorized by absence code.';
   109:             }
~~~

## TODO 0197

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 114
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   112:                 Caption = 'Employee - Qualifications';
   113:                 Image = "Report";
   114:                 //TODO: Ver RunObject = Report 5206;
   115:                 ToolTip = 'View a list of employees'' qualifications.';
   116:             }
~~~

## TODO 0198

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 121
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   119:                 Caption = 'Employee - Addresses';
   120:                 Image = "Report";
   121:                 //TODO: Ver RunObject = Report 5207;
   122:                 ToolTip = 'View a list of employees'' addresses.';
   123:             }
~~~

## TODO 0199

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 128
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   126:                 Caption = 'Employee - Relatives';
   127:                 Image = "Report";
   128:                 //TODO: Ver RunObject = Report 5208;
   129:                 ToolTip = 'View a list of employees'' relatives.';
   130:             }
~~~

## TODO 0200

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 135
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   133:                 Caption = 'Employee - Birthdays';
   134:                 Image = "Report";
   135:                 //TODO: Ver RunObject = Report 5209;
   136:                 ToolTip = 'View a list of employees'' birthdays.';
   137:             }
~~~

## TODO 0201

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 142
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   140:                 Caption = 'Employee - Phone Nos.';
   141:                 Image = "Report";
   142:                 //TODO: Ver RunObject = Report 5210;
   143:                 ToolTip = 'View a list of employees'' phone numbers.';
   144:             }
~~~

## TODO 0202

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 149
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   147:                 Caption = 'Employee - Unions';
   148:                 Image = "Report";
   149:                 //TODO: Ver RunObject = Report 5211;
   150:                 ToolTip = 'View a list of employees'' union memberships.';
   151:             }
~~~

## TODO 0203

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 156
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   154:                 Caption = 'Employee - Contracts';
   155:                 Image = "Report";
   156:                 //TODO: Ver RunObject = Report 5212;
   157:                 ToolTip = 'View all employee contracts.';
   158:             }
~~~

## TODO 0204

- File path: `src/Pages/Page 34002236 - DSNOM HR Role Center.al`
- Object type: Page
- Object ID: 34002236
- Object name: `DSNOM HR Role Center`
- Line number: 163
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   161:                 Caption = 'Employee - Alt. Addresses';
   162:                 Image = "Report";
   163:                 //TODO: Ver RunObject = Report 5213;
   164:                 ToolTip = 'View a list of employees'' alternate addresses.';
   165:             }
~~~

## TODO 0205

- File path: `src/Pages/Page 34002237 - DSNOM HR Activities.al`
- Object type: Page
- Object ID: 34002237
- Object name: `DSNOM HR Activities`
- Line number: 22
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    20:                     Image = People;
    21:                 }
    22:                 //TODO: Ver 
    23:                 /*
    24:                 field(FuncionesNom.AniversarioEmpleados;
~~~

## TODO 0206

- File path: `src/Pages/Page 34002237 - DSNOM HR Activities.al`
- Object type: Page
- Object ID: 34002237
- Object name: `DSNOM HR Activities`
- Line number: 78
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    76: 
    77:     var
    78:         //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
    79:         Fecha: Record 2000000007;
    80: }
~~~

## TODO 0207

- File path: `src/Pages/Page 34002237 - DSNOM HR Activities.al`
- Object type: Page
- Object ID: 34002237
- Object name: `DSNOM HR Activities`
- Line number: 78
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    76: 
    77:     var
    78:         //TODO: Ver //TODO: Ver FuncionesNom: Codeunit 34002104;
    79:         Fecha: Record 2000000007;
    80: }
~~~

## TODO 0208

- File path: `src/Pages/Page 34002238 - DSNOM Employees Activities.al`
- Object type: Page
- Object ID: 34002238
- Object name: `DSNOM Employees Activities`
- Line number: 53
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    51: 
    52:     var
    53:         //TODO: Ver  //TODO: Ver FuncionesNom: Codeunit 34002104;
    54:         Fecha: Record 2000000007;
    55: }
~~~

## TODO 0209

- File path: `src/Pages/Page 34002238 - DSNOM Employees Activities.al`
- Object type: Page
- Object ID: 34002238
- Object name: `DSNOM Employees Activities`
- Line number: 53
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    51: 
    52:     var
    53:         //TODO: Ver  //TODO: Ver FuncionesNom: Codeunit 34002104;
    54:         Fecha: Record 2000000007;
    55: }
~~~

## TODO 0210

- File path: `src/Pages/Page 34002239 - DSNOM Vacaciones Activities.al`
- Object type: Page
- Object ID: 34002239
- Object name: `DSNOM Vacaciones Activities`
- Line number: 14
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    12:             {
    13:                 Caption = 'Vacation';
    14:                 //TODO: Ver 
    15:                 /*
    16:                 field(FuncionesNom.VacacionesporVencer;
~~~


## TODO 0211

- File path: `src/Pages/Page 34002239 - DSNOM Vacaciones Activities.al`
- Object type: Page
- Object ID: 34002239
- Object name: `DSNOM Vacaciones Activities`
- Line number: 62
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    60: 
    61:     var
    62:         //TODO: Ver FuncionesNom: Codeunit 34002104;
    63:         Fecha: Record 2000000007;
    64: }
~~~

## TODO 0212

- File path: `src/Pages/Page 34002240 - DSNOM Nomina Activities.al`
- Object type: Page
- Object ID: 34002240
- Object name: `DSNOM Nomina Activities`
- Line number: 52
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    50: 
    51:     var
    52:         //TODO: Ver FuncionesNom: Codeunit 34002104;
    53:         Fecha: Record 2000000007;
    54: }
~~~

## TODO 0213

- File path: `src/Pages/Page 34002241 - DSNOM Cooperativa Activities.al`
- Object type: Page
- Object ID: 34002241
- Object name: `DSNOM Cooperativa Activities`
- Line number: 56
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    54: 
    55:     var
    56:         //TODO: Ver FuncionesNom: Codeunit 34002104;
    57:         Fecha: Record 2000000007;
    58: }
~~~

## TODO 0214

- File path: `src/Pages/Page 34002242 - DSNOM HR Chart.al`
- Object type: Page
- Object ID: 34002242
- Object name: `DSNOM HR Chart`
- Line number: 22
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    20:             {
    21:                 ApplicationArea = Basic, Suite;
    22:                 //TODO: Ver
    23:                 /*
    24: 
~~~

## TODO 0215

- File path: `src/Pages/Page 34002242 - DSNOM HR Chart.al`
- Object type: Page
- Object ID: 34002242
- Object name: `DSNOM HR Chart`
- Line number: 285
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   283:     trigger OnFindRecord(Which: Text): Boolean
   284:     begin
   285:         //TODO: Ver UpdateChart;
   286:         IsChartDataReady := TRUE;
   287: 
~~~

## TODO 0216

- File path: `src/Pages/Page 34002242 - DSNOM HR Chart.al`
- Object type: Page
- Object ID: 34002242
- Object name: `DSNOM HR Chart`
- Line number: 341
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   339:             EXIT;
   340:         TrailingSalesOrdersMgt.UpdateData(Rec);
   341:         //TODO: Ver Update(CurrPage.BusinessChart);
   342:         UpdateStatus;
   343:         NeedsUpdate := FALSE;
~~~

## TODO 0217

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 42
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    40:                 Caption = 'Employee - Labels';
    41:                 Image = "Report";
    42:                 //TODO: Ver RunObject = Report 5200;
    43:                 ToolTip = 'View a list of employees'' mailing labels.';
    44:             }
~~~

## TODO 0218

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 49
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    47:                 Caption = 'Employee - List';
    48:                 Image = "Report";
    49:                 //TODO: Ver RunObject = Report 5201;
    50:                 ToolTip = 'View a list of all employees.';
    51:             }
~~~

## TODO 0219

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 56
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    54:                 Caption = 'Employee - Misc. Article Info.';
    55:                 Image = "Report";
    56:                 //TODO: Ver RunObject = Report 5202;
    57:                 ToolTip = 'View a list of employees'' miscellaneous articles.';
    58:             }
~~~

## TODO 0220

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 63
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    61:                 Caption = 'Employee - Confidential Info.';
    62:                 Image = "Report";
    63:                 //TODO: Ver RunObject = Report 5203;
    64:                 ToolTip = 'View a list of employees'' confidential information.';
    65:             }
~~~

## TODO 0221

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 70
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    68:                 Caption = 'Employee - Staff Absences';
    69:                 Image = "Report";
    70:                 //TODO: Ver RunObject = Report 5204;
    71:                 ToolTip = 'View a list of employee absences by date. The list includes the cause of each employee absence.';
    72:             }
~~~

## TODO 0222

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 77
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    75:                 Caption = 'Employee - Absences by Causes';
    76:                 Image = "Report";
    77:                 //TODO: Ver RunObject = Report 5205;
    78:                 ToolTip = 'View a list of all employees'' absences categorized by absence code.';
    79:             }
~~~

## TODO 0223

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 84
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    82:                 Caption = 'Employee - Qualifications';
    83:                 Image = "Report";
    84:                 //TODO: Ver RunObject = Report 5206;
    85:                 ToolTip = 'View a list of employees'' qualifications.';
    86:             }
~~~

## TODO 0224

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 91
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    89:                 Caption = 'Employee - Addresses';
    90:                 Image = "Report";
    91:                 //TODO: Ver RunObject = Report 5207;
    92:                 ToolTip = 'View a list of employees'' addresses.';
    93:             }
~~~

## TODO 0225

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 98
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    96:                 Caption = 'Employee - Relatives';
    97:                 Image = "Report";
    98:                 //TODO: Ver RunObject = Report 5208;
    99:                 ToolTip = 'View a list of employees'' relatives.';
   100:             }
~~~


## TODO 0226

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 105
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   103:                 Caption = 'Employee - Birthdays';
   104:                 Image = "Report";
   105:                 //TODO: Ver RunObject = Report 5209;
   106:                 ToolTip = 'View a list of employees'' birthdays.';
   107:             }
~~~

## TODO 0227

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 112
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   110:                 Caption = 'Employee - Phone Nos.';
   111:                 Image = "Report";
   112:                 //TODO: Ver RunObject = Report 5210;
   113:                 ToolTip = 'View a list of employees'' phone numbers.';
   114:             }
~~~

## TODO 0228

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 119
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   117:                 Caption = 'Employee - Unions';
   118:                 Image = "Report";
   119:                 //TODO: Ver RunObject = Report 5211;
   120:                 ToolTip = 'View a list of employees'' union memberships.';
   121:             }
~~~

## TODO 0229

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 126
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   124:                 Caption = 'Employee - Contracts';
   125:                 Image = "Report";
   126:                 //TODO: Ver RunObject = Report 5212;
   127:                 ToolTip = 'View all employee contracts.';
   128:             }
~~~

## TODO 0230

- File path: `src/Pages/Page 34002248 - DSNOM HR  Employee Self Serv..al`
- Object type: Page
- Object ID: 34002248
- Object name: `DSNOM HR  Employee Self Serv.`
- Line number: 133
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   131:                 Caption = 'Employee - Alt. Addresses';
   132:                 Image = "Report";
   133:                 //TODO: Ver RunObject = Report 5213;
   134:                 ToolTip = 'View a list of employees'' alternate addresses.';
   135:             }
~~~

## TODO 0231

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 26
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    24:                 trigger AddInReady()
    25:                 begin
    26:                     //TODO: Ver //TODO: Ver UpdateChart(Period::" ");
    27:                 end;
    28: 
~~~

## TODO 0232

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 26
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    24:                 trigger AddInReady()
    25:                 begin
    26:                     //TODO: Ver //TODO: Ver UpdateChart(Period::" ");
    27:                 end;
    28: 
~~~

## TODO 0233

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 32
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    30:                 begin
    31:                     InitializePeriodFilter(0D, 0D);
    32:                     //TODO: Ver //TODO: Ver UpdateChart(Period::" ");
    33:                 end;
    34:             }
~~~

## TODO 0234

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 32
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    30:                 begin
    31:                     InitializePeriodFilter(0D, 0D);
    32:                     //TODO: Ver //TODO: Ver UpdateChart(Period::" ");
    33:                 end;
    34:             }
~~~

## TODO 0235

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 51
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    49:                 trigger OnAction()
    50:                 begin
    51:                     //TODO: Ver IF AnalysisReportChartMgt.SelectChart(AnalysisReportChartSetup, Rec) THEN
    52:                     //TODO: Ver UpdateChart(Period::" ");
    53:                 end;
~~~

## TODO 0236

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 52
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    50:                 begin
    51:                     //TODO: Ver IF AnalysisReportChartMgt.SelectChart(AnalysisReportChartSetup, Rec) THEN
    52:                     //TODO: Ver UpdateChart(Period::" ");
    53:                 end;
    54:             }
~~~

## TODO 0237

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 69
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    67:                     begin
    68:                         AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Day);
    69:                         //TODO: Ver UpdateChart(Period::" ");
    70:                     end;
    71:                 }
~~~

## TODO 0238

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 81
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    79:                     begin
    80:                         AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Week);
    81:                         //TODO: Ver UpdateChart(Period::" ");
    82:                     end;
    83:                 }
~~~

## TODO 0239

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 93
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    91:                     begin
    92:                         AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Month);
    93:                         //TODO: Ver UpdateChart(Period::" ");
    94:                     end;
    95:                 }
~~~

## TODO 0240

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 105
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   103:                     begin
   104:                         AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Quarter);
   105:                         //TODO: Ver UpdateChart(Period::" ");
   106:                     end;
   107:                 }
~~~


## TODO 0241

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 117
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   115:                     begin
   116:                         AnalysisReportChartSetup.SetPeriodLength(AnalysisReportChartSetup."Period Length"::Year);
   117:                         //TODO: Ver UpdateChart(Period::" ");
   118:                     end;
   119:                 }
~~~

## TODO 0242

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 130
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   128:                 trigger OnAction()
   129:                 begin
   130:                     //TODO: Ver UpdateChart(Period::Previous);
   131:                 end;
   132:             }
~~~

## TODO 0243

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 142
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   140:                 trigger OnAction()
   141:                 begin
   142:                     //TODO: Ver UpdateChart(Period::Next);
   143:                 end;
   144:             }
~~~

## TODO 0244

- File path: `src/Pages/Page 34002249 - Payroll Charts.al`
- Object type: Page
- Object ID: 34002249
- Object name: `Payroll Charts`
- Line number: 158
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   156:         AnalysisReportChartMgt.UpdateChart(
   157:           Period, AnalysisReportChartSetup, AnalysisReportChartSetup."Analysis Area"::Sales, Rec, StatusText);
   158:         //TODO: Ver Update(CurrPage.BusinessChart);
   159:     end;
   160: }
~~~

## TODO 0245

- File path: `src/Pages/Page 34002250 - Employee Capacity.al`
- Object type: Page
- Object ID: 34002250
- Object name: `Employee Capacity`
- Line number: 30
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    28:                     trigger OnValidate()
    29:                     begin
    30:                         //TODO: Ver SetColumns(SetWanted::Initial);
    31:                         UpdateMatrixSubform;
    32:                     end;
~~~

## TODO 0246

- File path: `src/Pages/Page 34002250 - Employee Capacity.al`
- Object type: Page
- Object ID: 34002250
- Object name: `Employee Capacity`
- Line number: 70
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    68:                 trigger OnAction()
    69:                 begin
    70:                     //TODO: Ver SetColumns(SetWanted::Previous);
    71:                     UpdateMatrixSubform;
    72:                 end;
~~~

## TODO 0247

- File path: `src/Pages/Page 34002250 - Employee Capacity.al`
- Object type: Page
- Object ID: 34002250
- Object name: `Employee Capacity`
- Line number: 86
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    84:                 trigger OnAction()
    85:                 begin
    86:                     //TODO: Ver SetColumns(SetWanted::PreviousColumn);
    87:                     UpdateMatrixSubform;
    88:                 end;
~~~

## TODO 0248

- File path: `src/Pages/Page 34002250 - Employee Capacity.al`
- Object type: Page
- Object ID: 34002250
- Object name: `Employee Capacity`
- Line number: 102
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   100:                 trigger OnAction()
   101:                 begin
   102:                     //TODO: Ver SetColumns(SetWanted::NextColumn);
   103:                     UpdateMatrixSubform;
   104:                 end;
~~~

## TODO 0249

- File path: `src/Pages/Page 34002250 - Employee Capacity.al`
- Object type: Page
- Object ID: 34002250
- Object name: `Employee Capacity`
- Line number: 118
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   116:                 trigger OnAction()
   117:                 begin
   118:                     //TODO: Ver SetColumns(SetWanted::Next);
   119:                     UpdateMatrixSubform;
   120:                 end;
~~~

## TODO 0250

- File path: `src/Pages/Page 34002250 - Employee Capacity.al`
- Object type: Page
- Object ID: 34002250
- Object name: `Employee Capacity`
- Line number: 127
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   125:     trigger OnOpenPage()
   126:     begin
   127:         //TODO: Ver SetColumns(SetWanted::Initial);
   128:         UpdateMatrixSubform;
   129:     end;
~~~

## TODO 0251

- File path: `src/Pages/Page 34002250 - Employee Capacity.al`
- Object type: Page
- Object ID: 34002250
- Object name: `Employee Capacity`
- Line number: 152
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   150:     local procedure UpdateMatrixSubform()
   151:     begin
   152:         //TODO: Ver CurrPage.MatrixForm.PAGE.Load(QtyType, MatrixColumnCaptions, MatrixRecords, CurrSetLength);
   153:         CurrPage.UPDATE(FALSE);
   154:     end;
~~~

## TODO 0252

- File path: `src/Pages/Page 34002253 - DSNOM Training Activities.al`
- Object type: Page
- Object ID: 34002253
- Object name: `DSNOM Training Activities`
- Line number: 48
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    46: 
    47:     var
    48:         //TODO: Ver FuncionesNom: Codeunit 34002104;
    49:         Fecha: Record 2000000007;
    50: }
~~~

## TODO 0253

- File path: `src/Pages/Page 34002260 - Headline RC Payroll.al`
- Object type: Page
- Object ID: 34002260
- Object name: `Headline RC Payroll`
- Line number: 91
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    89:             "Workdate for computations" := WORKDATE;
    90:             MODIFY;
    91:             //TODO: Ver HeadlineManagement.ScheduleTask(CODEUNIT::"Headline RC Payroll");
    92:         END;
    93: 
~~~

## TODO 0254

- File path: `src/Pages/Page 34002260 - Headline RC Payroll.al`
- Object type: Page
- Object ID: 34002260
- Object name: `Headline RC Payroll`
- Line number: 94
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    92:         END;
    93: 
    94:         //TODO: Ver HeadlineManagement.GetUserGreetingText(GreetingText);
    95:         DocumentationText := STRSUBSTNO(DocumentationTxt, PRODUCTNAME.SHORT);
    96: 
~~~

## TODO 0255

- File path: `src/Pages/Page 34002260 - Headline RC Payroll.al`
- Object type: Page
- Object ID: 34002260
- Object name: `Headline RC Payroll`
- Line number: 97
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    95:         DocumentationText := STRSUBSTNO(DocumentationTxt, PRODUCTNAME.SHORT);
    96: 
    97:         //TODO: Ver FuncionesNom.GetBirthdays(ListaCumpleanos);
    98:         NewsText := COPYSTR(STRSUBSTNO(NewsTxt, ListaCumpleanos), 1, MAXSTRLEN(NewsText));
    99: 
~~~


## TODO 0256

- File path: `src/Pages/Page 34002260 - Headline RC Payroll.al`
- Object type: Page
- Object ID: 34002260
- Object name: `Headline RC Payroll`
- Line number: 111
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   109:         EmplList: Page 5201;
   110:         HeadlineManagement: Codeunit 1439;
   111:         //TODO: Ver FuncionesNom: Codeunit 34002104;
   112:         DefaultFieldsVisible: Boolean;
   113:         DocumentationTxt: Label 'Want to learn more about %1?', Comment = '%1 is the NAV short product name.';
~~~

## TODO 0257

- File path: `src/Pages/Page 34002500 - Configuracion General DSPoS.al`
- Object type: Page
- Object ID: 34002500
- Object name: `Configuracion General DSPoS`
- Line number: 41
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    39:     trigger OnInit()
    40:     var
    41:     //TODO: Ver cfComunes: Codeunit 34002503;
    42:     begin
    43: 
~~~

## TODO 0258

- File path: `src/Pages/Page 34002500 - Configuracion General DSPoS.al`
- Object type: Page
- Object ID: 34002500
- Object name: `Configuracion General DSPoS`
- Line number: 44
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    42:     begin
    43: 
    44:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    45:         ERROR(error001);
    46:     end;
~~~

## TODO 0259

- File path: `src/Pages/Page 34002500 - Configuracion General DSPoS.al`
- Object type: Page
- Object ID: 34002500
- Object name: `Configuracion General DSPoS`
- Line number: 44
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    42:     begin
    43: 
    44:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    45:         ERROR(error001);
    46:     end;
~~~

## TODO 0260

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 229
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   227:                 begin
   228: 
   229:                     //TODO: Ver "Usuario windows" := cfAdd.TraerUsuarioWindows();
   230:                     MODIFY(FALSE);
   231:                 end;
~~~

## TODO 0261

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 246
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   244:     begin
   245: 
   246:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
   247:         ERROR(Error001);
   248:     end;
~~~

## TODO 0262

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 246
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   244:     begin
   245: 
   246:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
   247:         ERROR(Error001);
   248:     end;
~~~

## TODO 0263

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 253
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   251:     var
   252:         rConf: Record 34002500;
   253:     //TODO: Ver lcGuatemala: Codeunit 34002508;
   254:     begin
   255:         ActivarPais;
~~~

## TODO 0264

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 277
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   275:         wAnulaciones: Boolean;
   276:         wEcuador: Boolean;
   277:         //TODO: Ver cfComunes: Codeunit 34002503;
   278:         //TODO: Ver cfAdd: Codeunit 34002502;
   279:         wGuatemala: Boolean;
~~~

## TODO 0265

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 278
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   276:         wEcuador: Boolean;
   277:         //TODO: Ver cfComunes: Codeunit 34002503;
   278:         //TODO: Ver cfAdd: Codeunit 34002502;
   279:         wGuatemala: Boolean;
   280:         wSalvador: Boolean;
~~~

## TODO 0266

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 315
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   313:     begin
   314: 
   315:         //TODO: Ver  IF Tienda <> '' THEN
   316:         //TODO: Ver     wAnulaciones := cfComunes.PermiteAnulaciones(Tienda);
   317:     end;
~~~

## TODO 0267

- File path: `src/Pages/Page 34002501 - Ficha TPV.al`
- Object type: Page
- Object ID: 34002501
- Object name: `Ficha TPV`
- Line number: 316
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   314: 
   315:         //TODO: Ver  IF Tienda <> '' THEN
   316:         //TODO: Ver     wAnulaciones := cfComunes.PermiteAnulaciones(Tienda);
   317:     end;
   318: }
~~~

## TODO 0268

- File path: `src/Pages/Page 34002502 - Lista TPVs.al`
- Object type: Page
- Object ID: 34002502
- Object name: `Lista TPVs`
- Line number: 38
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    36:     trigger OnInit()
    37:     var
    38:         //TODO: Ver cfComunes: Codeunit 34002503;
    39:         Error001: Label 'Funcion Solo Disponible en Servidor Central';
    40:     begin
~~~

## TODO 0269

- File path: `src/Pages/Page 34002502 - Lista TPVs.al`
- Object type: Page
- Object ID: 34002502
- Object name: `Lista TPVs`
- Line number: 42
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    40:     begin
    41: 
    42:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    43:         ERROR(Error001);
    44:     end;
~~~

## TODO 0270

- File path: `src/Pages/Page 34002502 - Lista TPVs.al`
- Object type: Page
- Object ID: 34002502
- Object name: `Lista TPVs`
- Line number: 42
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    40:     begin
    41: 
    42:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    43:         ERROR(Error001);
    44:     end;
~~~


## TODO 0271

- File path: `src/Pages/Page 34002503 - Ficha Tienda.al`
- Object type: Page
- Object ID: 34002503
- Object name: `Ficha Tienda`
- Line number: 178
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   176:     trigger OnInit()
   177:     var
   178:     //TODO: Ver cfComunes: Codeunit 34002503;
   179:     begin
   180: 
~~~

## TODO 0272

- File path: `src/Pages/Page 34002503 - Ficha Tienda.al`
- Object type: Page
- Object ID: 34002503
- Object name: `Ficha Tienda`
- Line number: 181
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   179:     begin
   180: 
   181:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
   182:         ERROR(Error001);
   183:     end;
~~~

## TODO 0273

- File path: `src/Pages/Page 34002503 - Ficha Tienda.al`
- Object type: Page
- Object ID: 34002503
- Object name: `Ficha Tienda`
- Line number: 181
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   179:     begin
   180: 
   181:         //TODO: Ver //TODO: VerIF NOT (cfComunes.EsCentral) THEN
   182:         ERROR(Error001);
   183:     end;
~~~

## TODO 0274

- File path: `src/Pages/Page 34002504 - Lista Tiendas.al`
- Object type: Page
- Object ID: 34002504
- Object name: `Lista Tiendas`
- Line number: 39
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    37:     begin
    38: 
    39:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    40:         ERROR(Error001);
    41:     end;
~~~

## TODO 0275

- File path: `src/Pages/Page 34002505 - Ficha Cajero.al`
- Object type: Page
- Object ID: 34002505
- Object name: `Ficha Cajero`
- Line number: 46
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    44:     begin
    45: 
    46:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    47:         ERROR(Error001);
    48:     end;
~~~

## TODO 0276

- File path: `src/Pages/Page 34002506 - Lista Cajeros.al`
- Object type: Page
- Object ID: 34002506
- Object name: `Lista Cajeros`
- Line number: 45
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    43:     begin
    44: 
    45:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    46:         ERROR(Error001);
    47:     end;
~~~

## TODO 0277

- File path: `src/Pages/Page 34002507 - Ficha Grupo Cajeros.al`
- Object type: Page
- Object ID: 34002507
- Object name: `Ficha Grupo Cajeros`
- Line number: 39
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    37:     begin
    38: 
    39:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    40:         ERROR(Error001);
    41:     end;
~~~

## TODO 0278

- File path: `src/Pages/Page 34002508 - Lista Grupo Cajeros.al`
- Object type: Page
- Object ID: 34002508
- Object name: `Lista Grupo Cajeros`
- Line number: 43
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    41:     begin
    42: 
    43:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    44:         ERROR(Error001);
    45:     end;
~~~

## TODO 0279

- File path: `src/Pages/Page 34002509 - Lista Menus TPV.al`
- Object type: Page
- Object ID: 34002509
- Object name: `Lista Menus TPV`
- Line number: 43
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    41:     begin
    42: 
    43:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    44:         ERROR(Error001);
    45:     end;
~~~

## TODO 0280

- File path: `src/Pages/Page 34002510 - Ficha Menu TPV.al`
- Object type: Page
- Object ID: 34002510
- Object name: `Ficha Menu TPV`
- Line number: 61
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    59:     begin
    60: 
    61:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    62:         ERROR(Error001);
    63:     end;
~~~

## TODO 0281

- File path: `src/Pages/Page 34002511 - SubLista - Botones Menu TPV.al`
- Object type: Page
- Object ID: 34002511
- Object name: `SubLista - Botones Menu TPV`
- Line number: 29
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    27:                     Editable = false;
    28: 
    29:                     //TODO: Ver 
    30:                     /*
    31:                     trigger OnAssistEdit()
~~~

## TODO 0282

- File path: `src/Pages/Page 34002512 - Lista Acciones.al`
- Object type: Page
- Object ID: 34002512
- Object name: `Lista Acciones`
- Line number: 37
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    35:                 field("Literal Pedir Datos"; "Literal Pedir Datos")
    36:                 {
    37:                     //TODO: Ver BlankZero = true;
    38:                 }
    39:             }
~~~

## TODO 0283

- File path: `src/Pages/Page 34002512 - Lista Acciones.al`
- Object type: Page
- Object ID: 34002512
- Object name: `Lista Acciones`
- Line number: 53
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    51:     begin
    52: 
    53:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    54:         ERROR(Error001);
    55:     end;
~~~

## TODO 0284

- File path: `src/Pages/Page 34002513 - Ficha Formas de Pago.al`
- Object type: Page
- Object ID: 34002513
- Object name: `Ficha Formas de Pago`
- Line number: 57
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    55:     begin
    56: 
    57:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    58:         ERROR(Error001);
    59:     end;
~~~

## TODO 0285

- File path: `src/Pages/Page 34002514 - Lista Formas de Pago.al`
- Object type: Page
- Object ID: 34002514
- Object name: `Lista Formas de Pago`
- Line number: 37
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    35:     begin
    36: 
    37:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    38:         ERROR(Error001);
    39:     end;
~~~


## TODO 0286

- File path: `src/Pages/Page 34002515 - Ficha Tipos de Tajerta.al`
- Object type: Page
- Object ID: 34002515
- Object name: `Ficha Tipos de Tajerta`
- Line number: 32
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    30:     begin
    31: 
    32:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    33:         ERROR(Error001);
    34:     end;
~~~

## TODO 0287

- File path: `src/Pages/Page 34002516 - Lista Tipos de Tarjeta.al`
- Object type: Page
- Object ID: 34002516
- Object name: `Lista Tipos de Tarjeta`
- Line number: 34
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    32:     begin
    33: 
    34:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    35:         ERROR(Error001);
    36:     end;
~~~

## TODO 0288

- File path: `src/Pages/Page 34002517 - Ficha Vendedor.al`
- Object type: Page
- Object ID: 34002517
- Object name: `Ficha Vendedor`
- Line number: 35
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    33:     begin
    34: 
    35:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    36:         ERROR(Error001);
    37:     end;
~~~

## TODO 0289

- File path: `src/Pages/Page 34002518 - Lista Vendedores.al`
- Object type: Page
- Object ID: 34002518
- Object name: `Lista Vendedores`
- Line number: 39
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    37:     begin
    38: 
    39:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    40:         ERROR(Error001);
    41:     end;
~~~

## TODO 0290

- File path: `src/Pages/Page 34002521 - Lista Pagos TPV.al`
- Object type: Page
- Object ID: 34002521
- Object name: `Lista Pagos TPV`
- Line number: 62
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    60:     begin
    61: 
    62:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    63:         ERROR(Error001);
    64:     end;
~~~

## TODO 0291

- File path: `src/Pages/Page 34002522 - Lista Almacenes TPV.al`
- Object type: Page
- Object ID: 34002522
- Object name: `Lista Almacenes TPV`
- Line number: 77
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    75:                 Promoted = true;
    76:                 PromotedCategory = Process;
    77:                 //TODO: Ver RunObject = Report 5756;
    78:             }
    79:         }
~~~

## TODO 0292

- File path: `src/Pages/Page 34002522 - Lista Almacenes TPV.al`
- Object type: Page
- Object ID: 34002522
- Object name: `Lista Almacenes TPV`
- Line number: 88
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    86:     begin
    87: 
    88:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    89:         ERROR(Error001);
    90:     end;
~~~

## TODO 0293

- File path: `src/Pages/Page 34002525 - Solicitud de etiquetas.al`
- Object type: Page
- Object ID: 34002525
- Object name: `Solicitud de etiquetas`
- Line number: 55
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    53: 
    54:     var
    55:     //TODO: Ver rObject: Record 2000000001;
    56:     //TODO: Ver cFDsPOS: Codeunit 34002503;
    57: }
~~~

## TODO 0294

- File path: `src/Pages/Page 34002525 - Solicitud de etiquetas.al`
- Object type: Page
- Object ID: 34002525
- Object name: `Solicitud de etiquetas`
- Line number: 56
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    54:     var
    55:     //TODO: Ver rObject: Record 2000000001;
    56:     //TODO: Ver cFDsPOS: Codeunit 34002503;
    57: }
    58: 
~~~

## TODO 0295

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 385
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   383:                     Visible = ESACC_F18_Visible;
   384:                 }
   385:                 //TODO: Ver 
   386:                 /*
   387:                 field("Ship-to UPS Zone"; "Ship-to UPS Zone")
~~~

## TODO 0296

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 570
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   568:                         CalcInvDiscForHeader;
   569:                         COMMIT;
   570:                         //TODO: Ver 
   571:                         /*
   572:                         IF "Tax Area Code" = '' THEN
~~~

## TODO 0297

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 597
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   595:                     Enabled = ESACC_C60_Enabled;
   596:                     Image = Customer;
   597:                     //TODO: Ver 
   598:                     /*
   599:                     RunObject = Page 21;
~~~

## TODO 0298

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 613
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   611:                     trigger OnAction()
   612:                     var
   613:                     //TODO: Ver ApprovalEntries: Page "Approval Entries";
   614:                     begin
   615:                         //TODO: Ver ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
~~~

## TODO 0299

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 615
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   613:                     //TODO: Ver ApprovalEntries: Page "Approval Entries";
   614:                     begin
   615:                         //TODO: Ver ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
   616:                         //TODO: Ver ApprovalEntries.RUN;
   617:                     end;
~~~

## TODO 0300

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 616
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   614:                     begin
   615:                         //TODO: Ver ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
   616:                         //TODO: Ver ApprovalEntries.RUN;
   617:                     end;
   618:                 }
~~~


## TODO 0301

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 624
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   622:                     Enabled = ESACC_C61_Enabled;
   623:                     Image = ViewComments;
   624:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   625:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   626:                     //TODO: Ver               "No." = FIELD("No."),
~~~

## TODO 0302

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 625
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   623:                     Image = ViewComments;
   624:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   625:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   626:                     //TODO: Ver               "No." = FIELD("No."),
   627:                     //TODO: Ver               "Document Line No." = CONST(0);
~~~

## TODO 0303

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 626
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   624:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   625:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   626:                     //TODO: Ver               "No." = FIELD("No."),
   627:                     //TODO: Ver               "Document Line No." = CONST(0);
   628:                     Visible = ESACC_C61_Visible;
~~~

## TODO 0304

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 627
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   625:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   626:                     //TODO: Ver               "No." = FIELD("No."),
   627:                     //TODO: Ver               "Document Line No." = CONST(0);
   628:                     Visible = ESACC_C61_Visible;
   629:                 }
~~~

## TODO 0305

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 641
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   639:                     Enabled = ESACC_C172_Enabled;
   640:                     Image = CreditCardLog;
   641:                     //TODO: Ver RunObject = Page 829;
   642:                     Visible = ESACC_C172_Visible;
   643:                 }
~~~

## TODO 0306

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 918
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   916: 
   917:     var
   918:         //TODO: Ver ESACC_ESFLADSMgt: Codeunit 14123801;
   919:         [InDataSet]
   920:         ESACC_C3_Visible: Boolean;
~~~

## TODO 0307

- File path: `src/Pages/Page 34002526 - Facturas comprimidas.al`
- Object type: Page
- Object ID: 34002526
- Object name: `Facturas comprimidas`
- Line number: 1382
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
  1380:         TempBoolean: Boolean;
  1381:     begin
  1382:         //TODO: Ver
  1383:         /*
  1384:         IF OpenObject THEN BEGIN
~~~

## TODO 0308

- File path: `src/Pages/Page 34002530 - Menu Inicial TPV.al`
- Object type: Page
- Object ID: 34002530
- Object name: `Menu Inicial TPV`
- Line number: 23
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    21:         area(content)
    22:         {
    23:             //TODO: Ver usercontrol(DSPoS; "DSPoS")
    24:             //TODO: Ver {
    25:             //TODO: Ver }
~~~

## TODO 0309

- File path: `src/Pages/Page 34002530 - Menu Inicial TPV.al`
- Object type: Page
- Object ID: 34002530
- Object name: `Menu Inicial TPV`
- Line number: 24
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    22:         {
    23:             //TODO: Ver usercontrol(DSPoS; "DSPoS")
    24:             //TODO: Ver {
    25:             //TODO: Ver }
    26:         }
~~~

## TODO 0310

- File path: `src/Pages/Page 34002530 - Menu Inicial TPV.al`
- Object type: Page
- Object ID: 34002530
- Object name: `Menu Inicial TPV`
- Line number: 25
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    23:             //TODO: Ver usercontrol(DSPoS; "DSPoS")
    24:             //TODO: Ver {
    25:             //TODO: Ver }
    26:         }
    27:     }
~~~

## TODO 0311

- File path: `src/Pages/Page 34002530 - Menu Inicial TPV.al`
- Object type: Page
- Object ID: 34002530
- Object name: `Menu Inicial TPV`
- Line number: 43
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    41: 
    42:         AddInData := text001;
    43:         //TODO: Ver cFuncDS.Comprobaciones_Iniciales;
    44:     end;
    45: 
~~~

## TODO 0312

- File path: `src/Pages/Page 34002530 - Menu Inicial TPV.al`
- Object type: Page
- Object ID: 34002530
- Object name: `Menu Inicial TPV`
- Line number: 49
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    47:         AddInData: Text[1024];
    48:         Err001: Label 'No puede cerrar esta página con el DSPoS iniciado';
    49:         //TODO: Ver cFuncDS: Codeunit 34002502;
    50:         text001: Label 'Copyright: DynaSoft Spain';
    51: }
~~~

## TODO 0313

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 101
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    99:                 var
   100:                     Text001: Label '¿Desea cerrar el turno?';
   101:                 //TODO: Ver cduControl: Codeunit 34002521;
   102:                 begin
   103:                     //TODO: Ver IF NOT ISEMPTY THEN
~~~

## TODO 0314

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 103
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   101:                 //TODO: Ver cduControl: Codeunit 34002521;
   102:                 begin
   103:                     //TODO: Ver IF NOT ISEMPTY THEN
   104:                     //TODO: Ver     IF CONFIRM(Text001, FALSE) THEN BEGIN
   105:                     //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
~~~

## TODO 0315

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 104
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   102:                 begin
   103:                     //TODO: Ver IF NOT ISEMPTY THEN
   104:                     //TODO: Ver     IF CONFIRM(Text001, FALSE) THEN BEGIN
   105:                     //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
   106:                     //TODO: Ver             CurrPage.CLOSE;
~~~


## TODO 0316

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 105
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   103:                     //TODO: Ver IF NOT ISEMPTY THEN
   104:                     //TODO: Ver     IF CONFIRM(Text001, FALSE) THEN BEGIN
   105:                     //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
   106:                     //TODO: Ver             CurrPage.CLOSE;
   107:                     //TODO: Ver    END;
~~~

## TODO 0317

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 106
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   104:                     //TODO: Ver     IF CONFIRM(Text001, FALSE) THEN BEGIN
   105:                     //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
   106:                     //TODO: Ver             CurrPage.CLOSE;
   107:                     //TODO: Ver    END;
   108:                 end;
~~~

## TODO 0318

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 107
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   105:                     //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
   106:                     //TODO: Ver             CurrPage.CLOSE;
   107:                     //TODO: Ver    END;
   108:                 end;
   109:             }
~~~

## TODO 0319

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 120
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   118:                 trigger OnAction()
   119:                 var
   120:                     //TODO: Ver cduControl: Codeunit 34002521;
   121:                     decFondoCaja: Decimal;
   122:                     Text001: Label 'Esta accion la debe realizar un supervisor.';
~~~

## TODO 0320

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 124
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   122:                     Text001: Label 'Esta accion la debe realizar un supervisor.';
   123:                 begin
   124:                     //TODO: Ver IF cduControl.UsuarioSuper("No. tienda", codUsuario) THEN BEGIN
   125:                     CALCFIELDS("Fondo de caja");
   126:                     decFondoCaja := "Fondo de caja";
~~~

## TODO 0321

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 127
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   125:                     CALCFIELDS("Fondo de caja");
   126:                     decFondoCaja := "Fondo de caja";
   127:                     //TODO: Ver cduControl.PedirFondoDeCaja(decFondoCaja);
   128:                     ActualizarFondoCaja(codUsuario, decFondoCaja);
   129:                     CurrPage.UPDATE;
~~~

## TODO 0322

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 130
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   128:                     ActualizarFondoCaja(codUsuario, decFondoCaja);
   129:                     CurrPage.UPDATE;
   130:                     //TODO: Ver END
   131:                     //TODO: Ver ELSE
   132:                     ERROR(Text001);
~~~

## TODO 0323

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 131
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   129:                     CurrPage.UPDATE;
   130:                     //TODO: Ver END
   131:                     //TODO: Ver ELSE
   132:                     ERROR(Text001);
   133:                 end;
~~~

## TODO 0324

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 150
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   148:                 var
   149:                     recTurno: Record 34002529;
   150:                 //TODO: Ver repCuadre: Report 34002503;
   151:                 begin
   152:                     recTurno.RESET;
~~~

## TODO 0325

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 157
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   155:                     recTurno.SETRANGE(Fecha, Fecha);
   156:                     recTurno.SETRANGE("No. turno", "No. turno");
   157:                     //TODO: Ver repCuadre.SETTABLEVIEW(recTurno);
   158:                     //TODO: Ver repCuadre.RUNMODAL;
   159:                 end;
~~~

## TODO 0326

- File path: `src/Pages/Page 34002533 - Declaracion de caja.al`
- Object type: Page
- Object ID: 34002533
- Object name: `Declaracion de caja`
- Line number: 158
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   156:                     recTurno.SETRANGE("No. turno", "No. turno");
   157:                     //TODO: Ver repCuadre.SETTABLEVIEW(recTurno);
   158:                     //TODO: Ver repCuadre.RUNMODAL;
   159:                 end;
   160:             }
~~~

## TODO 0327

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 148
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   146:                 trigger OnAction()
   147:                 var
   148:                     //TODO: Ver cduControl: Codeunit 34002521;
   149:                     Error001: Label 'Debe seleccionar tienda y TPV.';
   150:                 begin
~~~

## TODO 0328

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 155
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   153:                         ERROR(Error001);
   154: 
   155:                     //TODO: Ver cduControl.AbrirDia(codTienda, codTPV, WORKDATE, codUsuario);
   156: 
   157:                     IF FINDFIRST THEN;
~~~

## TODO 0329

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 170
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   168:                 trigger OnAction()
   169:                 var
   170:                     //TODO: Ver cduControl: Codeunit 34002521;
   171:                     Text001: Label '¿Desea cerrar el dia %1?';
   172:                 begin
~~~

## TODO 0330

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 173
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   171:                     Text001: Label '¿Desea cerrar el dia %1?';
   172:                 begin
   173:                     //TODO: Ver IF NOT ISEMPTY THEN
   174:                     //TODO: Ver IF CONFIRM(Text001, FALSE, Fecha) THEN
   175:                     //TODO: Ver cduControl.CerrarDia(Rec, codUsuario);
~~~


## TODO 0331

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 174
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   172:                 begin
   173:                     //TODO: Ver IF NOT ISEMPTY THEN
   174:                     //TODO: Ver IF CONFIRM(Text001, FALSE, Fecha) THEN
   175:                     //TODO: Ver cduControl.CerrarDia(Rec, codUsuario);
   176:                 end;
~~~

## TODO 0332

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 175
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   173:                     //TODO: Ver IF NOT ISEMPTY THEN
   174:                     //TODO: Ver IF CONFIRM(Text001, FALSE, Fecha) THEN
   175:                     //TODO: Ver cduControl.CerrarDia(Rec, codUsuario);
   176:                 end;
   177:             }
~~~

## TODO 0333

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 193
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   191:                 var
   192:                     recDia: Record 34002524;
   193:                 //TODO: Ver repResumen: Report 34002505;
   194:                 begin
   195: 
~~~

## TODO 0334

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 200
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   198:                     recDia.SETRANGE("No. TPV", "No. TPV");
   199:                     recDia.SETRANGE(Fecha, Fecha);
   200:                     //TODO: Ver repResumen.SETTABLEVIEW(recDia);
   201:                     //TODO: Ver repResumen.RUNMODAL;
   202:                 end;
~~~

## TODO 0335

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 201
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   199:                     recDia.SETRANGE(Fecha, Fecha);
   200:                     //TODO: Ver repResumen.SETTABLEVIEW(recDia);
   201:                     //TODO: Ver repResumen.RUNMODAL;
   202:                 end;
   203:             }
~~~

## TODO 0336

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 222
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   220:         IF FiltrarUsuarioTPV THEN BEGIN
   221:             blnEditable := FALSE;
   222:             //TODO: Ver IF cduControl.LoginCajero(codTienda, codUsuario) THEN BEGIN
   223:             CurrPage.Turnos.PAGE.PasarDatos(codTienda, codUsuario);
   224:             CurrPage.Permisos.PAGE.PasarDatos(codTienda, codUsuario);
~~~

## TODO 0337

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 225
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   223:             CurrPage.Turnos.PAGE.PasarDatos(codTienda, codUsuario);
   224:             CurrPage.Permisos.PAGE.PasarDatos(codTienda, codUsuario);
   225:             //TODO: Ver END
   226:             //TODO: Ver ELSE
   227:             ERROR('');
~~~

## TODO 0338

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 226
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   224:             CurrPage.Permisos.PAGE.PasarDatos(codTienda, codUsuario);
   225:             //TODO: Ver END
   226:             //TODO: Ver ELSE
   227:             ERROR('');
   228:         END;
~~~

## TODO 0339

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 234
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   232: 
   233:     var
   234:         //TODO: Ver cduControl: Codeunit 34002521;
   235:         texEstilo: Text;
   236:         codTienda: Code[20];
~~~

## TODO 0340

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 257
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   255:     procedure CerrarTPV()
   256:     var
   257:         //TODO: Ver cduControl: Codeunit 34002521;
   258:         Text001: Label '¿Desea cerrar el TPV %1 de la tienda %2?';
   259:     begin
~~~

## TODO 0341

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 260
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   258:         Text001: Label '¿Desea cerrar el TPV %1 de la tienda %2?';
   259:     begin
   260:         //TODO: Ver IF CONFIRM(Text001, FALSE, "No. TPV", "No. tienda") THEN
   261:         //TODO: Ver cduControl.CerrarDia(Rec, codUsuario);
   262:     end;
~~~

## TODO 0342

- File path: `src/Pages/Page 34002534 - Control TPV.al`
- Object type: Page
- Object ID: 34002534
- Object name: `Control TPV`
- Line number: 261
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   259:     begin
   260:         //TODO: Ver IF CONFIRM(Text001, FALSE, "No. TPV", "No. tienda") THEN
   261:         //TODO: Ver cduControl.CerrarDia(Rec, codUsuario);
   262:     end;
   263: 
~~~

## TODO 0343

- File path: `src/Pages/Page 34002536 - Subform turnos TPV.al`
- Object type: Page
- Object ID: 34002536
- Object name: `Subform turnos TPV`
- Line number: 91
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    89:                 trigger OnAction()
    90:                 var
    91:                 //TODO: Ver cduControl: Codeunit 34002521;
    92:                 begin
    93:                     //TODO: Ver  cduControl.AbrirTurno("No. tienda", "No. TPV", Fecha, codUsuario);
~~~

## TODO 0344

- File path: `src/Pages/Page 34002536 - Subform turnos TPV.al`
- Object type: Page
- Object ID: 34002536
- Object name: `Subform turnos TPV`
- Line number: 93
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    91:                 //TODO: Ver cduControl: Codeunit 34002521;
    92:                 begin
    93:                     //TODO: Ver  cduControl.AbrirTurno("No. tienda", "No. TPV", Fecha, codUsuario);
    94:                 end;
    95:             }
~~~

## TODO 0345

- File path: `src/Pages/Page 34002536 - Subform turnos TPV.al`
- Object type: Page
- Object ID: 34002536
- Object name: `Subform turnos TPV`
- Line number: 104
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   102:                 var
   103:                     Text001: Label '¿Desea cerrar el turno %1?';
   104:                 //TODO: Ver cduControl: Codeunit 34002521;
   105:                 begin
   106:                     IF NOT ISEMPTY THEN
~~~


## TODO 0346

- File path: `src/Pages/Page 34002536 - Subform turnos TPV.al`
- Object type: Page
- Object ID: 34002536
- Object name: `Subform turnos TPV`
- Line number: 108
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   106:                     IF NOT ISEMPTY THEN
   107:                         IF CONFIRM(Text001, FALSE, "No. turno") THEN BEGIN
   108:                             //TODO: Ver IF cduControl.CerrarTurno(Rec, codUsuario) THEN
   109:                             CurrPage.CLOSE;
   110:                         END;
~~~

## TODO 0347

- File path: `src/Pages/Page 34002536 - Subform turnos TPV.al`
- Object type: Page
- Object ID: 34002536
- Object name: `Subform turnos TPV`
- Line number: 141
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   139:                 var
   140:                     recTurno: Record 34002529;
   141:                 //TODO: Ver repResumen: Report 34002504;
   142:                 begin
   143:                     recTurno.RESET;
~~~

## TODO 0348

- File path: `src/Pages/Page 34002536 - Subform turnos TPV.al`
- Object type: Page
- Object ID: 34002536
- Object name: `Subform turnos TPV`
- Line number: 148
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   146:                     recTurno.SETRANGE(Fecha, Fecha);
   147:                     recTurno.SETRANGE("No. turno", "No. turno");
   148:                     //TODO: Ver repResumen.SETTABLEVIEW(recTurno);
   149:                     //TODO: Ver repResumen.RUNMODAL;
   150:                 end;
~~~

## TODO 0349

- File path: `src/Pages/Page 34002536 - Subform turnos TPV.al`
- Object type: Page
- Object ID: 34002536
- Object name: `Subform turnos TPV`
- Line number: 149
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   147:                     recTurno.SETRANGE("No. turno", "No. turno");
   148:                     //TODO: Ver repResumen.SETTABLEVIEW(recTurno);
   149:                     //TODO: Ver repResumen.RUNMODAL;
   150:                 end;
   151:             }
~~~

## TODO 0350

- File path: `src/Pages/Page 34002537 - Config. arqueo de caja.al`
- Object type: Page
- Object ID: 34002537
- Object name: `Config. arqueo de caja`
- Line number: 35
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    33:     begin
    34: 
    35:         //TODO: VerIF NOT (cfComunes.EsCentral) THEN
    36:         ERROR(Error001);
    37:     end;
~~~

## TODO 0351

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 204
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   202:                         IF "Tax Area Code" = '' THEN
   203:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   204:                         //TODO: Ver ELSE
   205:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   206:                     end;
~~~

## TODO 0352

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 205
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   203:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   204:                         //TODO: Ver ELSE
   205:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   206:                     end;
   207:                 }
~~~

## TODO 0353

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 243
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   241:                         ApprovalEntries: Page 658;
   242:                     begin
   243:                         //TODO: Ver ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
   244:                         ApprovalEntries.RUN;
   245:                     end;
~~~

## TODO 0354

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 265
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   263:                     trigger OnAction()
   264:                     var
   265:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   266:                     begin
   267:                         //TODO: Ver ReleaseSalesDoc.PerformManualRelease(Rec);
~~~

## TODO 0355

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 267
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   265:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   266:                     begin
   267:                         //TODO: Ver ReleaseSalesDoc.PerformManualRelease(Rec);
   268:                     end;
   269:                 }
~~~

## TODO 0356

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 279
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   277:                     trigger OnAction()
   278:                     var
   279:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   280:                     begin
   281:                         //TODO: Ver ReleaseSalesDoc.PerformManualReopen(Rec);
~~~

## TODO 0357

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 281
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   279:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   280:                     begin
   281:                         //TODO: Ver ReleaseSalesDoc.PerformManualReopen(Rec);
   282:                     end;
   283:                 }
~~~

## TODO 0358

- File path: `src/Pages/Page 34002546 - Lista de facturas TPV.al`
- Object type: Page
- Object ID: 34002546
- Object name: `Lista de facturas TPV`
- Line number: 409
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   407: 
   408:     var
   409:         //TODO: Ver ESACC_ESFLADSMgt: Codeunit 14123801;
   410:         [InDataSet]
   411:         ESACC_C5_Visible: Boolean;
~~~

## TODO 0359

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 128
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   126:                     Visible = true;
   127:                 }
   128:                 //TODO: Ver 
   129:                 /*
   130:                 field("Electronic Document Status"; "Electronic Document Status")
~~~

## TODO 0360

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 226
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   224:                         IF "Tax Area Code" = '' THEN
   225:                             PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, "No.")
   226:                         //TODO: Ver ELSE
   227:                         //TODO: Ver    PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, "No.");
   228:                     end;
~~~


## TODO 0361

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 227
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   225:                             PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, "No.")
   226:                         //TODO: Ver ELSE
   227:                         //TODO: Ver    PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, "No.");
   228:                     end;
   229:                 }
~~~

## TODO 0362

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 234
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   232:                     Caption = 'Co&mments';
   233:                     Image = ViewComments;
   234:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   235:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
   236:                     //TODO: Ver               "No." = FIELD("No.");
~~~

## TODO 0363

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 235
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   233:                     Image = ViewComments;
   234:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   235:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
   236:                     //TODO: Ver               "No." = FIELD("No.");
   237:                 }
~~~

## TODO 0364

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 236
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   234:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   235:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
   236:                     //TODO: Ver               "No." = FIELD("No.");
   237:                 }
   238:                 action(Dimensions)
~~~

## TODO 0365

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 264
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   262:                     trigger OnAction()
   263:                     begin
   264:                         //TODO: Ver RequestStampEDocument;
   265:                     end;
   266:                 }
~~~

## TODO 0366

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 274
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   272:                     trigger OnAction()
   273:                     begin
   274:                         //TODO: Ver ExportEDocument;
   275:                     end;
   276:                 }
~~~

## TODO 0367

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 284
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   282:                     trigger OnAction()
   283:                     begin
   284:                         //TODO: Ver CancelEDocument;
   285:                     end;
   286:                 }
~~~

## TODO 0368

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 323
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   321:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
   322:                 //PromotedCategory = Process;
   323:                 //TODO: Ver RunObject = Report 10074;
   324:             }
   325:         }
~~~

## TODO 0369

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 335
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   333:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
   334:                 //PromotedCategory = "Report";
   335:                 //TODO: Ver RunObject = Report 10055;
   336:             }
   337:             action("Outstanding Sales Order Status")
~~~

## TODO 0370

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 343
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   341:                 Promoted = true;
   342:                 PromotedCategory = "Report";
   343:                 //TODO: Ver RunObject = Report 10056;
   344:             }
   345:             action("Daily Invoicing Report")
~~~

## TODO 0371

- File path: `src/Pages/Page 34002547 - Lista facturas registradas TPV.al`
- Object type: Page
- Object ID: 34002547
- Object name: `Lista facturas registradas TPV`
- Line number: 352
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   350:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
   351:                 //PromotedCategory = "Report";
   352:                 //TODO: Ver RunObject = Report 10050;
   353:             }
   354:         }
~~~

## TODO 0372

- File path: `src/Pages/Page 34002548 - Sub - Aturozicaciones TPV BOL.al`
- Object type: Page
- Object ID: 34002548
- Object name: `Sub - Aturozicaciones TPV BOL`
- Line number: 48
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    46:     trigger OnOpenPage()
    47:     var
    48:         //TODO: Ver cfBol: Codeunit 34002505;
    49:         rConf: Record 34002500;
    50:     begin
~~~

## TODO 0373

- File path: `src/Pages/Page 34002548 - Sub - Aturozicaciones TPV BOL.al`
- Object type: Page
- Object ID: 34002548
- Object name: `Sub - Aturozicaciones TPV BOL`
- Line number: 55
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    53: 
    54:         rConf.GET();
    55:         //TODO: Ver IF rConf.Pais = rConf.Pais::Bolivia THEN
    56:         //TODO: Ver cfBol.ActualizaAutorizaciones(wTienda);
    57:     end;
~~~

## TODO 0374

- File path: `src/Pages/Page 34002548 - Sub - Aturozicaciones TPV BOL.al`
- Object type: Page
- Object ID: 34002548
- Object name: `Sub - Aturozicaciones TPV BOL`
- Line number: 56
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    54:         rConf.GET();
    55:         //TODO: Ver IF rConf.Pais = rConf.Pais::Bolivia THEN
    56:         //TODO: Ver cfBol.ActualizaAutorizaciones(wTienda);
    57:     end;
    58: 
~~~

## TODO 0375

- File path: `src/Pages/Page 34002553 - Facturas Venta Regis POS.al`
- Object type: Page
- Object ID: 34002553
- Object name: `Facturas Venta Regis POS`
- Line number: 154
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   152:                         IF "Tax Area Code" = '' THEN
   153:                             PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, "No.")
   154:                         //TODO: Ver ELSE
   155:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, "No.");
   156:                     end;
~~~


## TODO 0376

- File path: `src/Pages/Page 34002553 - Facturas Venta Regis POS.al`
- Object type: Page
- Object ID: 34002553
- Object name: `Facturas Venta Regis POS`
- Line number: 155
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   153:                             PAGE.RUNMODAL(PAGE::"Sales Invoice Statistics", Rec, "No.")
   154:                         //TODO: Ver ELSE
   155:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Invoice Stats.", Rec, "No.");
   156:                     end;
   157:                 }
~~~

## TODO 0377

- File path: `src/Pages/Page 34002553 - Facturas Venta Regis POS.al`
- Object type: Page
- Object ID: 34002553
- Object name: `Facturas Venta Regis POS`
- Line number: 162
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   160:                     Caption = 'Co&mments';
   161:                     Image = ViewComments;
   162:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   163:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
   164:                     //TODO: Ver               "No." = FIELD("No.");
~~~

## TODO 0378

- File path: `src/Pages/Page 34002553 - Facturas Venta Regis POS.al`
- Object type: Page
- Object ID: 34002553
- Object name: `Facturas Venta Regis POS`
- Line number: 163
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   161:                     Image = ViewComments;
   162:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   163:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
   164:                     //TODO: Ver               "No." = FIELD("No.");
   165:                 }
~~~

## TODO 0379

- File path: `src/Pages/Page 34002553 - Facturas Venta Regis POS.al`
- Object type: Page
- Object ID: 34002553
- Object name: `Facturas Venta Regis POS`
- Line number: 164
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   162:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   163:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Invoice"),
   164:                     //TODO: Ver               "No." = FIELD("No.");
   165:                 }
   166:                 action(Dimensions)
~~~

## TODO 0380

- File path: `src/Pages/Page 34002553 - Facturas Venta Regis POS.al`
- Object type: Page
- Object ID: 34002553
- Object name: `Facturas Venta Regis POS`
- Line number: 193
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   191:                 begin
   192:                     //SalesPost.RegistrarCobrosTPVManual(Rec."No."); //001+ Version dspos-sic
   193:                     //TODO: Ver RegistrarCobrosDsPos.RegistrarCobrosFacturaTPVManual(Rec); //002+-
   194: 
   195:                     //001+ Comentada version dspos anterior
~~~

## TODO 0381

- File path: `src/Pages/Page 34002553 - Facturas Venta Regis POS.al`
- Object type: Page
- Object ID: 34002553
- Object name: `Facturas Venta Regis POS`
- Line number: 221
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   219:         gtCAEC: Text[160];
   220:         gtRespuesta: Text[100];
   221:     //TODO: Ver RegistrarCobrosDsPos: Codeunit 55115;
   222: }
   223: 
~~~

## TODO 0382

- File path: `src/Pages/Page 34002554 - Notas Credito Venta Regis POS.al`
- Object type: Page
- Object ID: 34002554
- Object name: `Notas Credito Venta Regis POS`
- Line number: 177
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   175:                         IF "Tax Area Code" = '' THEN
   176:                             PAGE.RUNMODAL(PAGE::"Sales Credit Memo Statistics", Rec, "No.")
   177:                         //TODO: Ver ELSE
   178:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Credit Memo Stats.", Rec, "No.");
   179:                     end;
~~~

## TODO 0383

- File path: `src/Pages/Page 34002554 - Notas Credito Venta Regis POS.al`
- Object type: Page
- Object ID: 34002554
- Object name: `Notas Credito Venta Regis POS`
- Line number: 178
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   176:                             PAGE.RUNMODAL(PAGE::"Sales Credit Memo Statistics", Rec, "No.")
   177:                         //TODO: Ver ELSE
   178:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Credit Memo Stats.", Rec, "No.");
   179:                     end;
   180:                 }
~~~

## TODO 0384

- File path: `src/Pages/Page 34002554 - Notas Credito Venta Regis POS.al`
- Object type: Page
- Object ID: 34002554
- Object name: `Notas Credito Venta Regis POS`
- Line number: 185
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   183:                     Caption = 'Co&mments';
   184:                     Image = ViewComments;
   185:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   186:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Credit Memo"),
   187:                     //TODO: Ver "No." = FIELD("No.");
~~~

## TODO 0385

- File path: `src/Pages/Page 34002554 - Notas Credito Venta Regis POS.al`
- Object type: Page
- Object ID: 34002554
- Object name: `Notas Credito Venta Regis POS`
- Line number: 186
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   184:                     Image = ViewComments;
   185:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   186:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Credit Memo"),
   187:                     //TODO: Ver "No." = FIELD("No.");
   188:                 }
~~~

## TODO 0386

- File path: `src/Pages/Page 34002554 - Notas Credito Venta Regis POS.al`
- Object type: Page
- Object ID: 34002554
- Object name: `Notas Credito Venta Regis POS`
- Line number: 187
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   185:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   186:                     //TODO: Ver RunPageLink = "Document Type" = CONST("Posted Credit Memo"),
   187:                     //TODO: Ver "No." = FIELD("No.");
   188:                 }
   189:                 action(Dimensions)
~~~

## TODO 0387

- File path: `src/Pages/Page 34002554 - Notas Credito Venta Regis POS.al`
- Object type: Page
- Object ID: 34002554
- Object name: `Notas Credito Venta Regis POS`
- Line number: 216
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   214:                 begin
   215:                     //SalesPost.RegistrarCobrosTPVManual(Rec."No."); //001+ Version dspos-sic
   216:                     //TODO: Ver RegistrarCobrosDsPos.RegistrarCobrosNotaCreditoTPVManual(Rec);//002+-
   217:                     //001+ Comentada version dspos anterior
   218:                     /*
~~~

## TODO 0388

- File path: `src/Pages/Page 34002554 - Notas Credito Venta Regis POS.al`
- Object type: Page
- Object ID: 34002554
- Object name: `Notas Credito Venta Regis POS`
- Line number: 241
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   239:         gtCAEC: Text[160];
   240:         gtRespuesta: Text[100];
   241:     //TODO: Ver RegistrarCobrosDsPos: Codeunit 55115;
   242: }
   243: 
~~~

## TODO 0389

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 196
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   194:                         IF "Tax Area Code" = '' THEN
   195:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   196:                         //TODO: Ver ELSE
   197:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   198:                     end;
~~~

## TODO 0390

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 197
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   195:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   196:                         //TODO: Ver ELSE
   197:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   198:                     end;
   199:                 }
~~~


## TODO 0391

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 204
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   202:                     Caption = 'Co&mments';
   203:                     Image = ViewComments;
   204:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   205:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   206:                     //TODO: Ver              "No." = FIELD("No."),
~~~

## TODO 0392

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 205
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   203:                     Image = ViewComments;
   204:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   205:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   206:                     //TODO: Ver              "No." = FIELD("No."),
   207:                     //TODO: Ver              "Document Line No." = CONST(0);
~~~

## TODO 0393

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 206
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   204:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   205:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   206:                     //TODO: Ver              "No." = FIELD("No."),
   207:                     //TODO: Ver              "Document Line No." = CONST(0);
   208:                 }
~~~

## TODO 0394

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 207
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   205:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   206:                     //TODO: Ver              "No." = FIELD("No."),
   207:                     //TODO: Ver              "Document Line No." = CONST(0);
   208:                 }
   209:                 action(Dimensions)
~~~

## TODO 0395

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 236
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   234:                     trigger OnAction()
   235:                     var
   236:                     //TODO: Ver Utilitarioparacorregircosas: Codeunit 55201;
   237:                     begin
   238:                         //TODO: Ver Utilitarioparacorregircosas.TransferLineaActualizada2(Rec."No. Fiscal TPV", Rec."Location Code");
~~~

## TODO 0396

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 238
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   236:                     //TODO: Ver Utilitarioparacorregircosas: Codeunit 55201;
   237:                     begin
   238:                         //TODO: Ver Utilitarioparacorregircosas.TransferLineaActualizada2(Rec."No. Fiscal TPV", Rec."Location Code");
   239:                     end;
   240:                 }
~~~

## TODO 0397

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 262
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   260:                     trigger OnAction()
   261:                     var
   262:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   263:                     begin
   264:                         //TODO: Ver ReleaseSalesDoc.PerformManualRelease(Rec);
~~~

## TODO 0398

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 264
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   262:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   263:                     begin
   264:                         //TODO: Ver ReleaseSalesDoc.PerformManualRelease(Rec);
   265:                     end;
   266:                 }
~~~

## TODO 0399

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 279
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   277:                     trigger OnAction()
   278:                     var
   279:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   280:                     begin
   281:                         //TODO: Ver  ReleaseSalesDoc.PerformManualReopen(Rec);
~~~

## TODO 0400

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 281
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   279:                     //TODO: Ver ReleaseSalesDoc: Codeunit 414;
   280:                     begin
   281:                         //TODO: Ver  ReleaseSalesDoc.PerformManualReopen(Rec);
   282:                     end;
   283:                 }
~~~

## TODO 0401

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 291
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   289:                     trigger OnAction()
   290:                     begin
   291:                         //TODO: Ver Registrar.RegistraFacturaManual();
   292:                     end;
   293:                 }
~~~

## TODO 0402

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 301
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   299:                     trigger OnAction()
   300:                     begin
   301:                         //TODO: Ver Transfer_SIC.RUN();//001+-
   302:                     end;
   303:                 }
~~~

## TODO 0403

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 311
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   309:     var
   310:         SalesSetup: Record 311;
   311:     //TODO: Ver lcfComunes: Codeunit 34002503;
   312:     begin
   313:         SetSecurityFilterOnRespCenter;
~~~

## TODO 0404

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 318
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   316:         //+#217374
   317:         wCostaRica := FALSE;
   318:         //TODO: Ver CASE lcFComunes.Pais OF
   319:         //TODO: Ver     9:
   320:         //TODO: Ver         wCostaRica := TRUE;
~~~

## TODO 0405

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 319
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   317:         wCostaRica := FALSE;
   318:         //TODO: Ver CASE lcFComunes.Pais OF
   319:         //TODO: Ver     9:
   320:         //TODO: Ver         wCostaRica := TRUE;
   321:         //TODO: Ver END;
~~~


## TODO 0406

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 320
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   318:         //TODO: Ver CASE lcFComunes.Pais OF
   319:         //TODO: Ver     9:
   320:         //TODO: Ver         wCostaRica := TRUE;
   321:         //TODO: Ver END;
   322:         //-#217374
~~~

## TODO 0407

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 321
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   319:         //TODO: Ver     9:
   320:         //TODO: Ver         wCostaRica := TRUE;
   321:         //TODO: Ver END;
   322:         //-#217374
   323:     end;
~~~

## TODO 0408

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 330
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   328:         JobQueueActive: Boolean;
   329:         wCostaRica: Boolean;
   330:     //TODO: Ver Registrar: Codeunit 55111;
   331:     //TODO: Ver  Transfer_SIC: Codeunit 55110;
   332: }
~~~

## TODO 0409

- File path: `src/Pages/Page 34002555 - Lista Facturas Pendientes POS.al`
- Object type: Page
- Object ID: 34002555
- Object name: `Lista Facturas Pendientes POS`
- Line number: 331
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   329:         wCostaRica: Boolean;
   330:     //TODO: Ver Registrar: Codeunit 55111;
   331:     //TODO: Ver  Transfer_SIC: Codeunit 55110;
   332: }
   333: 
~~~

## TODO 0410

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 481
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   479:                     Visible = ESACC_F18_Visible;
   480:                 }
   481:                 //TODO: Ver 
   482:                 /*
   483:                 field("Ship-to UPS Zone"; "Ship-to UPS Zone")
~~~

## TODO 0411

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 668
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   666:                         IF "Tax Area Code" = '' THEN
   667:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   668:                         //TODO: Ver ELSE
   669:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   670:                     end;
~~~

## TODO 0412

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 669
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   667:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   668:                         //TODO: Ver ELSE
   669:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   670:                     end;
   671:                 }
~~~

## TODO 0413

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 691
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   689:                     Enabled = ESACC_C60_Enabled;
   690:                     Image = Customer;
   691:                     //TODO: Ver RunObject = Page 21;
   692:                     //TODO: Ver RunPageLink = "No." = FIELD("Sell-to Customer No.");
   693:                     ShortCutKey = 'Shift+F7';
~~~

## TODO 0414

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 692
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   690:                     Image = Customer;
   691:                     //TODO: Ver RunObject = Page 21;
   692:                     //TODO: Ver RunPageLink = "No." = FIELD("Sell-to Customer No.");
   693:                     ShortCutKey = 'Shift+F7';
   694:                     Visible = ESACC_C60_Visible;
~~~

## TODO 0415

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 701
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   699:                     Enabled = ESACC_C61_Enabled;
   700:                     Image = ViewComments;
   701:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   702:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   703:                     //TODO: Ver               "No." = FIELD("No."),
~~~

## TODO 0416

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 702
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   700:                     Image = ViewComments;
   701:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   702:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   703:                     //TODO: Ver               "No." = FIELD("No."),
   704:                     //TODO: Ver               "Document Line No." = CONST(0);
~~~

## TODO 0417

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 703
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   701:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   702:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   703:                     //TODO: Ver               "No." = FIELD("No."),
   704:                     //TODO: Ver               "Document Line No." = CONST(0);
   705:                     Visible = ESACC_C61_Visible;
~~~

## TODO 0418

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 704
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   702:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   703:                     //TODO: Ver               "No." = FIELD("No."),
   704:                     //TODO: Ver               "Document Line No." = CONST(0);
   705:                     Visible = ESACC_C61_Visible;
   706:                 }
~~~

## TODO 0419

- File path: `src/Pages/Page 34002556 - Ficha Facturas Pdtes POS.al`
- Object type: Page
- Object ID: 34002556
- Object name: `Ficha Facturas Pdtes POS`
- Line number: 779
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   777: 
   778:     var
   779:         //TODO: Ver ESACC_ESFLADSMgt: Codeunit 14123801;
   780:         [InDataSet]
   781:         ESACC_C59_Visible: Boolean;
~~~

## TODO 0420

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 241
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   239:                         IF "Tax Area Code" = '' THEN
   240:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   241:                         //TODO: Ver ELSE
   242:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   243:                     end;
~~~


## TODO 0421

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 242
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   240:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   241:                         //TODO: Ver ELSE
   242:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   243:                     end;
   244:                 }
~~~

## TODO 0422

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 250
- Classification: Missing page property
- Proposed correction: The referenced standard object name is present in dependency symbols. Restore the RunObject property only after confirming its adjacent RunPageLink and action behavior.
- Compile risk: Low
- Functional risk: Medium
- Confidence: High
- Surrounding code:

~~~al
   248:                     Enabled = ESACC_C1102601023_Enabled;
   249:                     Image = ViewComments;
   250:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   251:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   252:                     //TODO: Ver               "No." = FIELD("No."),
~~~

## TODO 0423

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 251
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   249:                     Image = ViewComments;
   250:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   251:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   252:                     //TODO: Ver               "No." = FIELD("No."),
   253:                     //TODO: Ver               "Document Line No." = CONST(0);
~~~

## TODO 0424

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 252
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   250:                     //TODO: Ver RunObject = Page "Sales Comment Sheet";
   251:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   252:                     //TODO: Ver               "No." = FIELD("No."),
   253:                     //TODO: Ver               "Document Line No." = CONST(0);
   254:                     Visible = ESACC_C1102601023_Visible;
~~~

## TODO 0425

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 253
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   251:                     //TODO: Ver RunPageLink = "Document Type" = FIELD("Document Type"),
   252:                     //TODO: Ver               "No." = FIELD("No."),
   253:                     //TODO: Ver               "Document Line No." = CONST(0);
   254:                     Visible = ESACC_C1102601023_Visible;
   255:                 }
~~~

## TODO 0426

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 278
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   276:                     trigger OnAction()
   277:                     var
   278:                     //TODO: Ver ApprovalEntries: Page "Approval Entries";
   279:                     begin
   280:                         //TODO: Ver  ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
~~~

## TODO 0427

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 280
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   278:                     //TODO: Ver ApprovalEntries: Page "Approval Entries";
   279:                     begin
   280:                         //TODO: Ver  ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
   281:                         //TODO: Ver ApprovalEntries.RUN;
   282:                     end;
~~~

## TODO 0428

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 281
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   279:                     begin
   280:                         //TODO: Ver  ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
   281:                         //TODO: Ver ApprovalEntries.RUN;
   282:                     end;
   283:                 }
~~~

## TODO 0429

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 455
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   453:                     trigger OnAction()
   454:                     begin
   455:                         //TODO: Ver Registrar.RegistraFacturaManual();
   456:                     end;
   457:                 }
~~~

## TODO 0430

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 465
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   463:                     trigger OnAction()
   464:                     begin
   465:                         //TODO: Ver Transfer_SIC.RUN();//001+-
   466:                     end;
   467:                 }
~~~

## TODO 0431

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 475
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   473:     var
   474:         SalesSetup: Record 311;
   475:     //TODO: Ver lcfComunes: Codeunit 34002503;
   476:     begin
   477:         SetSecurityFilterOnRespCenter;
~~~

## TODO 0432

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 482
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   480:         //+#217374
   481:         wCostaRica := FALSE;
   482:         //TODO: Ver CASE lcFComunes.Pais OF
   483:         //TODO: Ver     9:
   484:         //TODO: Ver        wCostaRica := TRUE;
~~~

## TODO 0433

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 483
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   481:         wCostaRica := FALSE;
   482:         //TODO: Ver CASE lcFComunes.Pais OF
   483:         //TODO: Ver     9:
   484:         //TODO: Ver        wCostaRica := TRUE;
   485:         //TODO: Ver END;
~~~

## TODO 0434

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 484
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   482:         //TODO: Ver CASE lcFComunes.Pais OF
   483:         //TODO: Ver     9:
   484:         //TODO: Ver        wCostaRica := TRUE;
   485:         //TODO: Ver END;
   486:         //-#217374
~~~

## TODO 0435

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 485
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   483:         //TODO: Ver     9:
   484:         //TODO: Ver        wCostaRica := TRUE;
   485:         //TODO: Ver END;
   486:         //-#217374
   487:     end;
~~~


## TODO 0436

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 490
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   488: 
   489:     var
   490:         //TODO: Ver ESACC_ESFLADSMgt: Codeunit 14123801;
   491:         [InDataSet]
   492:         ESACC_C3_Visible: Boolean;
~~~

## TODO 0437

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 703
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   701:         JobQueueActive: Boolean;
   702:         wCostaRica: Boolean;
   703:     //TODO: Ver Registrar: Codeunit 55111;
   704:     //TODO: Ver Transfer_SIC: Codeunit 55110;
   705: }
~~~

## TODO 0438

- File path: `src/Pages/Page 34002557 - Lista Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002557
- Object name: `Lista Notas Credito Pdtes POS`
- Line number: 704
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   702:         wCostaRica: Boolean;
   703:     //TODO: Ver Registrar: Codeunit 55111;
   704:     //TODO: Ver Transfer_SIC: Codeunit 55110;
   705: }
   706: 
~~~

## TODO 0439

- File path: `src/Pages/Page 34002558 - Ficha Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002558
- Object name: `Ficha Notas Credito Pdtes POS`
- Line number: 393
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   391:                     Visible = ESACC_F18_Visible;
   392:                 }
   393:                 //TODO: Ver 
   394:                 /*
   395:                 field("Ship-to UPS Zone"; "Ship-to UPS Zone")
~~~

## TODO 0440

- File path: `src/Pages/Page 34002558 - Ficha Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002558
- Object name: `Ficha Notas Credito Pdtes POS`
- Line number: 555
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   553:                         IF "Tax Area Code" = '' THEN
   554:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   555:                         //TODO: Ver ELSE
   556:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   557:                     end;
~~~

## TODO 0441

- File path: `src/Pages/Page 34002558 - Ficha Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002558
- Object name: `Ficha Notas Credito Pdtes POS`
- Line number: 556
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   554:                             PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec)
   555:                         //TODO: Ver ELSE
   556:                         //TODO: Ver PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   557:                     end;
   558:                 }
~~~

## TODO 0442

- File path: `src/Pages/Page 34002558 - Ficha Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002558
- Object name: `Ficha Notas Credito Pdtes POS`
- Line number: 605
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   603:                         ApprovalEntries: Page "Approval Entries";
   604:                     begin
   605:                         //TODO: Ver ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
   606:                         ApprovalEntries.RUN;
   607:                     end;
~~~

## TODO 0443

- File path: `src/Pages/Page 34002558 - Ficha Notas Credito Pdtes POS.al`
- Object type: Page
- Object ID: 34002558
- Object name: `Ficha Notas Credito Pdtes POS`
- Line number: 639
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   637: 
   638:     var
   639:         //TODO: Ver ESACC_ESFLADSMgt: Codeunit 14123801;
   640:         [InDataSet]
   641:         ESACC_C51_Visible: Boolean;
~~~

## TODO 0444

- File path: `src/Pages/Page 34003004 - Archivo Transferencia ITBIS.al`
- Object type: Page
- Object ID: 34003004
- Object name: `Archivo Transferencia ITBIS`
- Line number: 328
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   326:                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
   327:                     //PromotedIsBig = true;
   328:                     //TODO: Ver RunObject = Report 34003006;
   329:                 }
   330:                 action(AbrirDocumento)
~~~

## TODO 0445

- File path: `src/Pages/Page 34003015 - Pre Sales List.al`
- Object type: Page
- Object ID: 34003015
- Object name: `Pre Sales List`
- Line number: 197
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   195:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
   196:                 //PromotedCategory = "Report";
   197:                 //TODO: Ver RunObject = Report 209;
   198:             }
   199:         }
~~~

## TODO 0446

- File path: `src/Pages/Page 34003015 - Pre Sales List.al`
- Object type: Page
- Object ID: 34003015
- Object name: `Pre Sales List`
- Line number: 204
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   202:     local procedure GetPageId(PageId: Integer): Integer
   203:     var
   204:     //TODO: Ver MiniPagesMapping: Record 1305;
   205:     begin
   206:         //TODO: Ver 
~~~

## TODO 0447

- File path: `src/Pages/Page 34003015 - Pre Sales List.al`
- Object type: Page
- Object ID: 34003015
- Object name: `Pre Sales List`
- Line number: 206
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   204:     //TODO: Ver MiniPagesMapping: Record 1305;
   205:     begin
   206:         //TODO: Ver 
   207:         /*
   208:         IF MiniPagesMapping.READPERMISSION THEN
~~~

## TODO 0448

- File path: `src/Pages/Page 34003028 - Listado RNC DGII.al`
- Object type: Page
- Object ID: 34003028
- Object name: `Listado RNC DGII`
- Line number: 52
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    50:                 trigger OnAction()
    51:                 var
    52:                 //TODO: Ver ConsultasDGII: Codeunit 34003003;
    53:                 begin
    54:                     //TODO: Ver ConsultasDGII.DescargarListadoRNC;
~~~

## TODO 0449

- File path: `src/Pages/Page 34003028 - Listado RNC DGII.al`
- Object type: Page
- Object ID: 34003028
- Object name: `Listado RNC DGII`
- Line number: 54
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    52:                 //TODO: Ver ConsultasDGII: Codeunit 34003003;
    53:                 begin
    54:                     //TODO: Ver ConsultasDGII.DescargarListadoRNC;
    55:                     CurrPage.UPDATE;
    56:                 end;
~~~

## TODO 0450

- File path: `src/Pages/Page 55000 - Pantalla Scanner manual.al`
- Object type: Page
- Object ID: 55000
- Object name: `Pantalla Scanner manual`
- Line number: 9
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     7:         area(content)
     8:         {
     9:             //TODO: Ver 
    10:             /*
    11:             group(General)
~~~


## TODO 0451

- File path: `src/Pages/Page 55000 - Pantalla Scanner manual.al`
- Object type: Page
- Object ID: 55000
- Object name: `Pantalla Scanner manual`
- Line number: 65
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    63:                 trigger OnAction()
    64:                 begin
    65:                     //TODO: Ver BuscarEnPedido;
    66:                 end;
    67:             }
~~~

## TODO 0452

- File path: `src/Pages/Page 55000 - Pantalla Scanner manual.al`
- Object type: Page
- Object ID: 55000
- Object name: `Pantalla Scanner manual`
- Line number: 90
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    88:     end;
    89: 
    90:     //TODO: Ver 
    91:     /*
    92:     procedure BuscarEnPedido()
~~~

## TODO 0453

- File path: `src/Pages/Page 55037 - ListaDescuentoProntoPago.al`
- Object type: Page
- Object ID: 55037
- Object name: `ListaDescuentoProntoPago`
- Line number: 13
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    11:     Permissions = TableData 21 = r;
    12:     SourceTable = 21;
    13:     //TODO: Ver 
    14:     /*
    15:     SourceTableView = SORTING("Closed by Entry No.")
~~~

## TODO 0454

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 77
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    75:                     CALCFIELDS("Doc SF  XML");
    76:                     IF "Doc SF  XML".HASVALUE THEN BEGIN
    77:                         //TODO: Ver 
    78:                         /*
    79:                             TempBlob.INIT;
~~~

## TODO 0455

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 101
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    99:                     CALCFIELDS("Doc Firmado  XML");
   100:                     IF "Doc Firmado  XML".HASVALUE THEN BEGIN
   101:                         //TODO: Ver 
   102:                         /*
   103:                             TempBlob.INIT;
~~~

## TODO 0456

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 125
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   123:                     CALCFIELDS("Doc Json envio  XML");
   124:                     IF "Doc Json envio  XML".HASVALUE THEN BEGIN
   125:                         //TODO: Ver 
   126:                         /*
   127:                             TempBlob.INIT;
~~~

## TODO 0457

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 149
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   147:                     CALCFIELDS("Doc Json Respuesta  XML");
   148:                     IF "Doc Json Respuesta  XML".HASVALUE THEN BEGIN
   149:                         //TODO: Ver TempBlob.INIT;
   150:                         //TODO: Ver TempBlob.Blob := "Doc Json Respuesta  XML";
   151:                         //TODO: Ver TempBlob.INSERT;
~~~

## TODO 0458

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 150
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   148:                     IF "Doc Json Respuesta  XML".HASVALUE THEN BEGIN
   149:                         //TODO: Ver TempBlob.INIT;
   150:                         //TODO: Ver TempBlob.Blob := "Doc Json Respuesta  XML";
   151:                         //TODO: Ver TempBlob.INSERT;
   152:                         //ODO: Ver FileManagment.BLOBExport(TempBlob, 'Documento Json Recibido.txt', TRUE);
~~~

## TODO 0459

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 151
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   149:                         //TODO: Ver TempBlob.INIT;
   150:                         //TODO: Ver TempBlob.Blob := "Doc Json Respuesta  XML";
   151:                         //TODO: Ver TempBlob.INSERT;
   152:                         //ODO: Ver FileManagment.BLOBExport(TempBlob, 'Documento Json Recibido.txt', TRUE);
   153:                         //TODO: Ver TempBlob.DELETEALL;
~~~

## TODO 0460

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 153
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   151:                         //TODO: Ver TempBlob.INSERT;
   152:                         //ODO: Ver FileManagment.BLOBExport(TempBlob, 'Documento Json Recibido.txt', TRUE);
   153:                         //TODO: Ver TempBlob.DELETEALL;
   154:                     END;
   155:                 end;
~~~

## TODO 0461

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 171
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   169:                     CALCFIELDS("Doc Respuesta  XML");
   170:                     IF "Doc Respuesta  XML".HASVALUE THEN BEGIN
   171:                         //TODO: Ver TempBlob.INIT;
   172:                         //TODO: Ver TempBlob.Blob := "Doc Respuesta  XML";
   173:                         //TODO: Ver TempBlob.INSERT;
~~~

## TODO 0462

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 172
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   170:                     IF "Doc Respuesta  XML".HASVALUE THEN BEGIN
   171:                         //TODO: Ver TempBlob.INIT;
   172:                         //TODO: Ver TempBlob.Blob := "Doc Respuesta  XML";
   173:                         //TODO: Ver TempBlob.INSERT;
   174:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, 'Documento Xml Respuesta.xml', TRUE);
~~~

## TODO 0463

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 173
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   171:                         //TODO: Ver TempBlob.INIT;
   172:                         //TODO: Ver TempBlob.Blob := "Doc Respuesta  XML";
   173:                         //TODO: Ver TempBlob.INSERT;
   174:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, 'Documento Xml Respuesta.xml', TRUE);
   175:                         //TODO: Ver TempBlob.DELETEALL;
~~~

## TODO 0464

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 174
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   172:                         //TODO: Ver TempBlob.Blob := "Doc Respuesta  XML";
   173:                         //TODO: Ver TempBlob.INSERT;
   174:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, 'Documento Xml Respuesta.xml', TRUE);
   175:                         //TODO: Ver TempBlob.DELETEALL;
   176:                     END;
~~~

## TODO 0465

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 175
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   173:                         //TODO: Ver TempBlob.INSERT;
   174:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, 'Documento Xml Respuesta.xml', TRUE);
   175:                         //TODO: Ver TempBlob.DELETEALL;
   176:                     END;
   177:                 end;
~~~


## TODO 0466

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 193
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   191:                     CALCFIELDS("Doc Pdf Generado");
   192:                     IF "Doc Pdf Generado".HASVALUE THEN BEGIN
   193:                         //TODO: Ver TempBlob.INIT;
   194:                         //TODO: Ver TempBlob.Blob := "Doc Pdf Generado";
   195:                         //TODO: Ver TempBlob.INSERT;
~~~

## TODO 0467

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 194
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   192:                     IF "Doc Pdf Generado".HASVALUE THEN BEGIN
   193:                         //TODO: Ver TempBlob.INIT;
   194:                         //TODO: Ver TempBlob.Blob := "Doc Pdf Generado";
   195:                         //TODO: Ver TempBlob.INSERT;
   196:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, FORMAT("Tipo Documento") + '-' + "Clave Doc" + '.pdf', TRUE);
~~~

## TODO 0468

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 195
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   193:                         //TODO: Ver TempBlob.INIT;
   194:                         //TODO: Ver TempBlob.Blob := "Doc Pdf Generado";
   195:                         //TODO: Ver TempBlob.INSERT;
   196:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, FORMAT("Tipo Documento") + '-' + "Clave Doc" + '.pdf', TRUE);
   197:                         //TODO: Ver TempBlob.DELETEALL;
~~~

## TODO 0469

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 196
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   194:                         //TODO: Ver TempBlob.Blob := "Doc Pdf Generado";
   195:                         //TODO: Ver TempBlob.INSERT;
   196:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, FORMAT("Tipo Documento") + '-' + "Clave Doc" + '.pdf', TRUE);
   197:                         //TODO: Ver TempBlob.DELETEALL;
   198:                     END;
~~~

## TODO 0470

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 197
- Classification: Obsolete Business Central API
- Proposed correction: Replace the legacy TempBlob or Mail usage with the currently supported standard API confirmed by AL symbol search, preserving the same data and delivery behavior.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   195:                         //TODO: Ver TempBlob.INSERT;
   196:                         //TODO: Ver FileManagment.BLOBExport(TempBlob, FORMAT("Tipo Documento") + '-' + "Clave Doc" + '.pdf', TRUE);
   197:                         //TODO: Ver TempBlob.DELETEALL;
   198:                     END;
   199:                 end;
~~~

## TODO 0471

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 212
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   210:                 trigger OnAction()
   211:                 var
   212:                     //TODO: Ver FE: Codeunit 55202;
   213:                     lrSCMH: Record 114;
   214:                     lrSH: Record 36;
~~~

## TODO 0472

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 218
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   216:                     //+#217374
   217:                     //... Si el documento viene de POS, no debe enviarse por e-mail.
   218:                     //TODO: Ver 
   219:                     /*
   220:                     IF "Tipo Documento" = "Tipo Documento"::TE THEN
~~~

## TODO 0473

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 247
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   245: 
   246:                     // ++ 001-YFC
   247:                     //TODO: Ver FacturacionElectronicaNAV.ComprobarDocumentosElectronicoLOG;
   248:                     MESSAGE(Text001);
   249:                     // -- 001-YFC
~~~

## TODO 0474

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 257
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   255:     var
   256:         FileManagment: Codeunit 419;
   257:         //TODO: Ver TempBlob: Record 99008535 temporary;
   258:         //TODO: Ver FacturacionElectronicaNAV: Codeunit 55202;
   259:         Text001: Label 'Ended process';
~~~

## TODO 0475

- File path: `src/Pages/Page 55199 - Log Facturacion Electronica CR.al`
- Object type: Page
- Object ID: 55199
- Object name: `Log Facturacion Electronica CR`
- Line number: 258
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   256:         FileManagment: Codeunit 419;
   257:         //TODO: Ver TempBlob: Record 99008535 temporary;
   258:         //TODO: Ver FacturacionElectronicaNAV: Codeunit 55202;
   259:         Text001: Label 'Ended process';
   260: }
~~~

## TODO 0476

- File path: `src/Pages/Page 55200 - Recepcion Documento Elect.al`
- Object type: Page
- Object ID: 55200
- Object name: `Recepcion Documento Elect`
- Line number: 64
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    62:     begin
    63:         BEGIN
    64:             //TODO: Ver FE.UploadDocumentoElectronico(Valores);
    65:         END;
    66:         TraerDatos(Valores);
~~~

## TODO 0477

- File path: `src/Pages/Page 55200 - Recepcion Documento Elect.al`
- Object type: Page
- Object ID: 55200
- Object name: `Recepcion Documento Elect`
- Line number: 78
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    76:         IF CloseAction = ACTION::OK THEN BEGIN
    77:             IF CONFIRM(STRSUBSTNO(txt001, FORMAT(Mensaje))) THEN BEGIN
    78:                 //TODO: Ver 
    79:                 /*
    80:                 FE.CreaXmlMensaje(Clave, NumeroCedulaEmisor, FechaEmisionDoc, Mensaje, DetalleMensaje, MontoTotalImpuesto, CodigoActividad, TotalFactura, NumeroCedulaReceptor, NumConsecutivoReceptor, Directorio); // YFC --- #FE-CR1.02
~~~

## TODO 0478

- File path: `src/Pages/Page 55200 - Recepcion Documento Elect.al`
- Object type: Page
- Object ID: 55200
- Object name: `Recepcion Documento Elect`
- Line number: 96
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    94: 
    95:     var
    96:         //TODO: Ver FE: Codeunit 55202;
    97:         Valores: array[10] of Text;
    98:         Modificado: Boolean;
~~~

## TODO 0479

- File path: `src/Pages/Page 55203 - Msj  Facturacion Electronica.al`
- Object type: Page
- Object ID: 55203
- Object name: `Msj  Facturacion Electronica`
- Line number: 47
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    45:     }
    46: 
    47:     //TODO: Ver FE
    48:     /*
    49:     actions
~~~

## TODO 0480

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 39
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    37:                 trigger OnAction()
    38:                 begin
    39:                     //TODO: Ver cuImpFisc.AbrePuerto;
    40:                     //TODO: Ver cuImpFisc.CierreZ('P');
    41:                     //TODO: Ver cuImpFisc.CerrarPrinter;
~~~


## TODO 0481

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 40
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    38:                 begin
    39:                     //TODO: Ver cuImpFisc.AbrePuerto;
    40:                     //TODO: Ver cuImpFisc.CierreZ('P');
    41:                     //TODO: Ver cuImpFisc.CerrarPrinter;
    42:                 end;
~~~

## TODO 0482

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 41
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    39:                     //TODO: Ver cuImpFisc.AbrePuerto;
    40:                     //TODO: Ver cuImpFisc.CierreZ('P');
    41:                     //TODO: Ver cuImpFisc.CerrarPrinter;
    42:                 end;
    43:             }
~~~

## TODO 0483

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 52
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    50:                 trigger OnAction()
    51:                 begin
    52:                     //TODO: Ver cuImpFisc.AbrePuerto;
    53:                     //TODO: Ver cuImpFisc.CierreX('P');
    54:                     //TODO: Ver cuImpFisc.CerrarPrinter;
~~~

## TODO 0484

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 53
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    51:                 begin
    52:                     //TODO: Ver cuImpFisc.AbrePuerto;
    53:                     //TODO: Ver cuImpFisc.CierreX('P');
    54:                     //TODO: Ver cuImpFisc.CerrarPrinter;
    55:                 end;
~~~

## TODO 0485

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 54
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    52:                     //TODO: Ver cuImpFisc.AbrePuerto;
    53:                     //TODO: Ver cuImpFisc.CierreX('P');
    54:                     //TODO: Ver cuImpFisc.CerrarPrinter;
    55:                 end;
    56:             }
~~~

## TODO 0486

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 67
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    65:                 trigger OnAction()
    66:                 begin
    67:                     //TODO: Ver 
    68:                     /*
    69:                     cuImpFisc.AbrePuerto;
~~~

## TODO 0487

- File path: `src/Pages/Page 55221 - Tareas Impresora Fiscal.al`
- Object type: Page
- Object ID: 55221
- Object name: `Tareas Impresora Fiscal`
- Line number: 89
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    87:         UserSetUp: Record 91;
    88:         ConfSant: Record 55226;
    89:         //TODO: Ver cuImpFisc: Codeunit 55221;
    90:         FechaDesde: Date;
    91:         FechaHasta: Date;
~~~

## TODO 0488

- File path: `src/Pages/Page 55222 - InicializaTablas Movs..al`
- Object type: Page
- Object ID: 55222
- Object name: `InicializaTablas Movs.`
- Line number: 25
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    23:                 PromotedCategory = Process;
    24:                 PromotedIsBig = true;
    25:                 //TODO: Ver //TODO: Ver RunObject = Report 53007;
    26:             }
    27:         }
~~~

## TODO 0489

- File path: `src/Pages/Page 55222 - InicializaTablas Movs..al`
- Object type: Page
- Object ID: 55222
- Object name: `InicializaTablas Movs.`
- Line number: 25
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    23:                 PromotedCategory = Process;
    24:                 PromotedIsBig = true;
    25:                 //TODO: Ver //TODO: Ver RunObject = Report 53007;
    26:             }
    27:         }
~~~

## TODO 0490

- File path: `src/Pages/Page 55225 - Packing.al`
- Object type: Page
- Object ID: 55225
- Object name: `Packing`
- Line number: 137
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   135: 
   136:                         IF CONFIRM(txt002, FALSE) THEN BEGIN
   137:                             //TODO: Ver FuncSant.RegistraPacking(Rec);
   138:                             MESSAGE(txt003);
   139:                         END;
~~~

## TODO 0491

- File path: `src/Pages/Page 55225 - Packing.al`
- Object type: Page
- Object ID: 55225
- Object name: `Packing`
- Line number: 171
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   169:     trigger OnInit()
   170:     begin
   171:         //TODO: Ver TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
   172:     end;
   173: 
~~~

## TODO 0492

- File path: `src/Pages/Page 55225 - Packing.al`
- Object type: Page
- Object ID: 55225
- Object name: `Packing`
- Line number: 180
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   178:         ConfSant: Record 55226;
   179:         NoSerMang: Codeunit "No. Series";
   180:         //TODO: Ver FuncSant: Codeunit 55225;
   181:         txt002: Label 'Confirm that you want to post';
   182:         txt003: Label 'The packing was successfully posted';
~~~

## TODO 0493

- File path: `src/Pages/Page 55226 - Lin. Packing.al`
- Object type: Page
- Object ID: 55226
- Object name: `Lin. Packing`
- Line number: 121
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   119:     procedure ReabrirCaja()
   120:     var
   121:     //TODO: Ver FuncSant: Codeunit 55225;
   122:     begin
   123:         //TODO: Ver FuncSant.ReabrirCajaPacking(Rec);
~~~

## TODO 0494

- File path: `src/Pages/Page 55226 - Lin. Packing.al`
- Object type: Page
- Object ID: 55226
- Object name: `Lin. Packing`
- Line number: 123
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   121:     //TODO: Ver FuncSant: Codeunit 55225;
   122:     begin
   123:         //TODO: Ver FuncSant.ReabrirCajaPacking(Rec);
   124:     end;
   125: }
~~~

## TODO 0495

- File path: `src/Pages/Page 55228 - Cajas Packing.al`
- Object type: Page
- Object ID: 55228
- Object name: `Cajas Packing`
- Line number: 94
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    92:     trigger OnInit()
    93:     begin
    94:         //TODO: Ver TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    95:     end;
    96: 
~~~


## TODO 0496

- File path: `src/Pages/Page 55228 - Cajas Packing.al`
- Object type: Page
- Object ID: 55228
- Object name: `Cajas Packing`
- Line number: 102
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   100:         txt002: Label 'Confirm that you want to close the box';
   101:         CCP: Record 55257;
   102:         //TODO: Ver FuncSant: Codeunit 55225;
   103:         [InDataSet]
   104:         TieneGestionAlmacen: Boolean;
~~~

## TODO 0497

- File path: `src/Pages/Page 55229 - Cab. Packing Registrado.al`
- Object type: Page
- Object ID: 55229
- Object name: `Cab. Packing Registrado`
- Line number: 98
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    96:             }
    97: 
    98:             //TODO: Ver 
    99:             /*
   100:             action(ejecuta)
~~~

## TODO 0498

- File path: `src/Pages/Page 55229 - Cab. Packing Registrado.al`
- Object type: Page
- Object ID: 55229
- Object name: `Cab. Packing Registrado`
- Line number: 154
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   152:     trigger OnInit()
   153:     begin
   154:         //TODO: Ver TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
   155:     end;
   156: 
~~~

## TODO 0499

- File path: `src/Pages/Page 55229 - Cab. Packing Registrado.al`
- Object type: Page
- Object ID: 55229
- Object name: `Cab. Packing Registrado`
- Line number: 158
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   156: 
   157:     var
   158:         //TODO: Ver FuncSant: Codeunit 55225;
   159:         [InDataSet]
   160:         TieneGestionAlmacen: Boolean;
~~~

## TODO 0500

- File path: `src/Pages/Page 55234 - Cab. Hoja de Ruta.al`
- Object type: Page
- Object ID: 55234
- Object name: `Cab. Hoja de Ruta`
- Line number: 87
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    85:                     trigger OnAction()
    86:                     begin
    87:                         //TODO: Ver IF CONFIRM(txt001) THEN
    88:                         //TODO: Ver     FunSant.RegHojaEnv(Rec, FALSE);
    89:                     end;
~~~

## TODO 0501

- File path: `src/Pages/Page 55234 - Cab. Hoja de Ruta.al`
- Object type: Page
- Object ID: 55234
- Object name: `Cab. Hoja de Ruta`
- Line number: 88
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    86:                     begin
    87:                         //TODO: Ver IF CONFIRM(txt001) THEN
    88:                         //TODO: Ver     FunSant.RegHojaEnv(Rec, FALSE);
    89:                     end;
    90:                 }
~~~

## TODO 0502

- File path: `src/Pages/Page 55234 - Cab. Hoja de Ruta.al`
- Object type: Page
- Object ID: 55234
- Object name: `Cab. Hoja de Ruta`
- Line number: 102
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   100:                     trigger OnAction()
   101:                     begin
   102:                         //TODO: Ver IF CONFIRM(txt002) THEN
   103:                         //TODO: Ver     FunSant.RegHojaEnv(Rec, TRUE);
   104:                     end;
~~~

## TODO 0503

- File path: `src/Pages/Page 55234 - Cab. Hoja de Ruta.al`
- Object type: Page
- Object ID: 55234
- Object name: `Cab. Hoja de Ruta`
- Line number: 103
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   101:                     begin
   102:                         //TODO: Ver IF CONFIRM(txt002) THEN
   103:                         //TODO: Ver     FunSant.RegHojaEnv(Rec, TRUE);
   104:                     end;
   105:                 }
~~~

## TODO 0504

- File path: `src/Pages/Page 55234 - Cab. Hoja de Ruta.al`
- Object type: Page
- Object ID: 55234
- Object name: `Cab. Hoja de Ruta`
- Line number: 132
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   130:         txt002: Label 'Confirm that you want to Post and Print the Route Sheet';
   131:         LHRR1Record: Record 55248;
   132:         //TODO: Ver FunSant: Codeunit 55225;
   133:         rCHRL: Record 55245;
   134: }
~~~

## TODO 0505

- File path: `src/Pages/Page 55238 - Cab. Packing List.al`
- Object type: Page
- Object ID: 55238
- Object name: `Cab. Packing List`
- Line number: 66
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    64:     trigger OnInit()
    65:     begin
    66:         //TODO: Ver TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    67:     end;
    68: 
~~~

## TODO 0506

- File path: `src/Pages/Page 55238 - Cab. Packing List.al`
- Object type: Page
- Object ID: 55238
- Object name: `Cab. Packing List`
- Line number: 70
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    68: 
    69:     var
    70:         //TODO: Ver FuncSant: Codeunit 55225;
    71:         [InDataSet]
    72:         TieneGestionAlmacen: Boolean;
~~~

## TODO 0507

- File path: `src/Pages/Page 55239 - Cab. Packing Reg. List.al`
- Object type: Page
- Object ID: 55239
- Object name: `Cab. Packing Reg. List`
- Line number: 73
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    71:     trigger OnInit()
    72:     begin
    73:         //TODO: Ver TieneGestionAlmacen := FuncSant.TieneGestionAlmacen;
    74:     end;
    75: 
~~~

## TODO 0508

- File path: `src/Pages/Page 55239 - Cab. Packing Reg. List.al`
- Object type: Page
- Object ID: 55239
- Object name: `Cab. Packing Reg. List`
- Line number: 77
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    75: 
    76:     var
    77:         //TODO: Ver FuncSant: Codeunit 55225;
    78:         [InDataSet]
    79:         TieneGestionAlmacen: Boolean;
~~~

## TODO 0509

- File path: `src/Pages/Page 55249 - BackOrders Sin Disp. Ped. Vta.al`
- Object type: Page
- Object ID: 55249
- Object name: `BackOrders Sin Disp. Ped. Vta`
- Line number: 124
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   122:                     Editable = false;
   123:                 }
   124:                 //TODO: Ver
   125:                 /*
   126:                 field(SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec);
~~~

## TODO 0510

- File path: `src/Pages/Page 55249 - BackOrders Sin Disp. Ped. Vta.al`
- Object type: Page
- Object ID: 55249
- Object name: `BackOrders Sin Disp. Ped. Vta`
- Line number: 306
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   304:             //-$002
   305:             //IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SL) = 0) AND (SL."Cantidad pendiente BO" <> 0) THEN//MOI - 23/02/2015
   306:             //TODO: Ver
   307:             /*
   308:             IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SL) <= 0) AND (SL."Cantidad pendiente BO" <> 0) THEN BEGIN
~~~


## TODO 0511

- File path: `src/Pages/Page 55249 - BackOrders Sin Disp. Ped. Vta.al`
- Object type: Page
- Object ID: 55249
- Object name: `BackOrders Sin Disp. Ped. Vta`
- Line number: 332
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   330:         ReleaseSalesDoc: Codeunit "Release Sales Document";
   331:         salesheader: Record 36;
   332:         //TODO: Ver AppTemp: Record 464;
   333:         //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
   334:         EstatusPed: Option Abierto,Lanzado,"Aprobacion pendiente","Anticipo pendiente";
~~~

## TODO 0512

- File path: `src/Pages/Page 55249 - BackOrders Sin Disp. Ped. Vta.al`
- Object type: Page
- Object ID: 55249
- Object name: `BackOrders Sin Disp. Ped. Vta`
- Line number: 333
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   331:         salesheader: Record 36;
   332:         //TODO: Ver AppTemp: Record 464;
   333:         //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
   334:         EstatusPed: Option Abierto,Lanzado,"Aprobacion pendiente","Anticipo pendiente";
   335:         UserSetup: Record 91;
~~~

## TODO 0513

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 42
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    40:                 {
    41:                     Caption = 'EAN';
    42:                     //TODO: Ver TableRelation = "Item Cross Reference"."Cross-Reference No.";
    43: 
    44:                     trigger OnValidate()
~~~

## TODO 0514

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 46
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    44:                     trigger OnValidate()
    45:                     begin
    46:                         //TODO: Ver ICR.SETCURRENTKEY("Cross-Reference No.");
    47:                         //TODO: Ver ICR.SETRANGE("Cross-Reference No.", Barcode);
    48:                         //TODO: Ver 
~~~

## TODO 0515

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 47
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    45:                     begin
    46:                         //TODO: Ver ICR.SETCURRENTKEY("Cross-Reference No.");
    47:                         //TODO: Ver ICR.SETRANGE("Cross-Reference No.", Barcode);
    48:                         //TODO: Ver 
    49:                         /*
~~~

## TODO 0516

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 48
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    46:                         //TODO: Ver ICR.SETCURRENTKEY("Cross-Reference No.");
    47:                         //TODO: Ver ICR.SETRANGE("Cross-Reference No.", Barcode);
    48:                         //TODO: Ver 
    49:                         /*
    50:                         IF ICR.FINDFIRST THEN
~~~

## TODO 0517

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 119
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   117:                         ERROR(Err001);
   118: 
   119:                     //TODO: Ver CD2.RESET;
   120:                     //TODO: Ver CD2.SETRANGE("No. Documento", "No.");
   121:                     //TODO: Ver IF CD2.FINDLAST THEN;
~~~

## TODO 0518

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 120
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   118: 
   119:                     //TODO: Ver CD2.RESET;
   120:                     //TODO: Ver CD2.SETRANGE("No. Documento", "No.");
   121:                     //TODO: Ver IF CD2.FINDLAST THEN;
   122: 
~~~

## TODO 0519

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 121
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   119:                     //TODO: Ver CD2.RESET;
   120:                     //TODO: Ver CD2.SETRANGE("No. Documento", "No.");
   121:                     //TODO: Ver IF CD2.FINDLAST THEN;
   122: 
   123:                     CD.INIT;
~~~

## TODO 0520

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 128
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   126:                     CD.VALIDATE("Item No.", ItemNo);
   127:                     CD.VALIDATE(Quantity, Cant);
   128:                     //TODO: Ver CD."Line No." := CD2."Line No." + 1;
   129:                     //CD."External Doc. Number" := EDoc;
   130:                     CD."External Doc. Number" := "External document no.";
~~~

## TODO 0521

- File path: `src/Pages/Page 55251 - Clasificacion devoluciones.al`
- Object type: Page
- Object ID: 55251
- Object name: `Clasificacion devoluciones`
- Line number: 180
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   178:         CD: Record 55251;
   179:         CD2Record: Record 55251;
   180:         //TODO: Ver ICR: Record 5717;
   181:         Item: Record 27;
   182:         CDR: Record 55250;
~~~

## TODO 0522

- File path: `src/Pages/Page 55253 - Lista clas. devoluciones cer..al`
- Object type: Page
- Object ID: 55253
- Object name: `Lista clas. devoluciones cer.`
- Line number: 72
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    70:                 begin
    71:                     CR.SETRANGE("No.", "No.");
    72:                     //TODO: Ver REPORT.RUNMODAL(REPORT::"Clasifica devoluciones", TRUE, FALSE, CR);
    73:                 end;
    74:             }
~~~

## TODO 0523

- File path: `src/Pages/Page 55253 - Lista clas. devoluciones cer..al`
- Object type: Page
- Object ID: 55253
- Object name: `Lista clas. devoluciones cer.`
- Line number: 88
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    86:                 begin
    87:                     CR.SETRANGE("No.", "No.");
    88:                     //TODO: Ver REPORT.RUNMODAL(REPORT::"Listado clas. devoluciones", TRUE, FALSE, CR);
    89:                 end;
    90:             }
~~~

## TODO 0524

- File path: `src/Pages/Page 55253 - Lista clas. devoluciones cer..al`
- Object type: Page
- Object ID: 55253
- Object name: `Lista clas. devoluciones cer.`
- Line number: 104
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   102:                 begin
   103:                     CR.SETRANGE("No.", "No.");
   104:                     //TODO: Ver REPORT.RUNMODAL(REPORT::"Documentos generados clas. dev", TRUE, FALSE, CR);
   105:                 end;
   106:             }
~~~

## TODO 0525

- File path: `src/Pages/Page 55253 - Lista clas. devoluciones cer..al`
- Object type: Page
- Object ID: 55253
- Object name: `Lista clas. devoluciones cer.`
- Line number: 111
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   109: 
   110:     var
   111:     //TODO: Ver CreaDev: Report 55225;
   112: }
   113: 
~~~


## TODO 0526

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 244
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   242:                     Caption = 'Invoices';
   243:                     Image = Invoice;
   244:                     //TODO: Ver
   245:                     /*
   246:                     RunObject = Page "Posted Sales Invoices";
~~~

## TODO 0527

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 252
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   250:                 action("Prepa&yment Invoices")
   251:                 {
   252:                     //TODO: Ver
   253:                     /*
   254:                     Caption = 'Prepa&yment Invoices';
~~~

## TODO 0528

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 261
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   259:                 action("Prepayment Credi&t Memos")
   260:                 {
   261:                     //TODO: Ver
   262:                     /*
   263:                     Caption = 'Prepayment Credi&t Memos';
~~~

## TODO 0529

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 287
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   285:                         ApprovalEntries: Page "Approval Entries";
   286:                     begin
   287:                         //TODO: Ver ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
   288:                         ApprovalEntries.RUN;
   289:                     end;
~~~

## TODO 0530

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 346
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   344:                     Caption = 'Create &Whse. Shipment';
   345: 
   346:                     //TODO: Ver
   347:                     /*
   348:                     trigger OnAction()
~~~

## TODO 0531

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 430
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   428:                     trigger OnAction()
   429:                     var
   430:                     //TODO: Ver ICInOutboxMgt: Codeunit 427;
   431:                     //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
   432:                     //TODO: Ver PurchaseHeader: Record 38;
~~~

## TODO 0532

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 431
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   429:                     var
   430:                     //TODO: Ver ICInOutboxMgt: Codeunit 427;
   431:                     //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
   432:                     //TODO: Ver PurchaseHeader: Record 38;
   433:                     begin
~~~

## TODO 0533

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 432
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   430:                     //TODO: Ver ICInOutboxMgt: Codeunit 427;
   431:                     //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
   432:                     //TODO: Ver PurchaseHeader: Record 38;
   433:                     begin
   434:                         /*//fes mig
~~~

## TODO 0534

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 489
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   487:                     var
   488:                         PurchaseHeader: Record 38;
   489:                     //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
   490:                     begin
   491:                         /*//fes mig
~~~

## TODO 0535

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 519
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   517:                     var
   518:                         PurchaseHeader: Record 38;
   519:                     //TODO: Ver  ApprovalMgt: Codeunit "Approvals Mgmt.";
   520:                     begin
   521:                         /*//fes
~~~

## TODO 0536

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 564
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   562:                     trigger OnAction()
   563:                     begin
   564:                         //TODO: Ver DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
   565:                     end;
   566:                 }
~~~

## TODO 0537

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 575
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   573:                     trigger OnAction()
   574:                     begin
   575:                         //TODO: Ver DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
   576:                     end;
   577:                 }
~~~

## TODO 0538

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 587
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   585:                 Promoted = true;
   586:                 PromotedCategory = "Report";
   587:                 //TODO: Ver RunObject = Report 209;
   588:             }
   589:         }
~~~

## TODO 0539

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 593
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   591: 
   592:     var
   593:         //TODO: Ver DocPrint: Codeunit 229;
   594:         ReportPrint: Codeunit 228;
   595:         //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
~~~

## TODO 0540

- File path: `src/Pages/Page 55260 - Sales Order Call Center  List.al`
- Object type: Page
- Object ID: 55260
- Object name: `Sales Order Call Center  List`
- Line number: 595
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   593:         //TODO: Ver DocPrint: Codeunit 229;
   594:         ReportPrint: Codeunit 228;
   595:         //TODO: Ver ApprovalMgt: Codeunit "Approvals Mgmt.";
   596:         Usage: Option "Order Confirmation","Work Order";
   597:         Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
~~~


## TODO 0541

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 32
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    30:                     trigger OnValidate()
    31:                     begin
    32:                         //TODO: Ver SelltoCustomerNoOnAfterValidat;
    33:                     end;
    34:                 }
~~~

## TODO 0542

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 102
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   100:                     trigger OnValidate()
   101:                     begin
   102:                         //TODO: Ver SalespersonCodeOnAfterValidate;
   103:                     end;
   104:                 }
~~~

## TODO 0543

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 153
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   151:                     trigger OnValidate()
   152:                     begin
   153:                         //TODO: Ver BilltoCustomerNoOnAfterValidat;
   154:                     end;
   155:                 }
~~~

## TODO 0544

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 194
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   192:                     trigger OnValidate()
   193:                     begin
   194:                         //TODO: Ver ShortcutDimension1CodeOnAfterV;
   195:                     end;
   196:                 }
~~~

## TODO 0545

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 202
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   200:                     trigger OnValidate()
   201:                     begin
   202:                         //TODO: Ver ShortcutDimension2CodeOnAfterV;
   203:                     end;
   204:                 }
~~~

## TODO 0546

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 273
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   271:                     Importance = Additional;
   272:                 }
   273:                 //TODO: Ver field("Ship-to UPS Zone"; "Ship-to UPS Zone")
   274:                 //TODO: Ver {
   275:                 //TODO: Ver }
~~~

## TODO 0547

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 274
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   272:                 }
   273:                 //TODO: Ver field("Ship-to UPS Zone"; "Ship-to UPS Zone")
   274:                 //TODO: Ver {
   275:                 //TODO: Ver }
   276:                 field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
~~~

## TODO 0548

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 275
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   273:                 //TODO: Ver field("Ship-to UPS Zone"; "Ship-to UPS Zone")
   274:                 //TODO: Ver {
   275:                 //TODO: Ver }
   276:                 field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
   277:                 {
~~~

## TODO 0549

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 311
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   309:                 Caption = 'Foreign Trade';
   310:                 Visible = false;
   311:                 //TODO: Ver 
   312:                 /*
   313:                 field("Currency Code"; "Currency Code")
~~~

## TODO 0550

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 362
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   360:                     trigger OnValidate()
   361:                     begin
   362:                         //TODO: Ver Prepayment37OnAfterValidate;
   363:                     end;
   364:                 }
~~~

## TODO 0551

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 381
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   379:                 {
   380:                 }
   381:                 //TODO: Ver field("Prepmt. Include Tax"; "Prepmt. Include Tax")
   382:                 //TODO: Ver {
   383:                 //TODO: Ver }
~~~

## TODO 0552

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 382
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   380:                 }
   381:                 //TODO: Ver field("Prepmt. Include Tax"; "Prepmt. Include Tax")
   382:                 //TODO: Ver {
   383:                 //TODO: Ver }
   384:             }
~~~

## TODO 0553

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 383
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   381:                 //TODO: Ver field("Prepmt. Include Tax"; "Prepmt. Include Tax")
   382:                 //TODO: Ver {
   383:                 //TODO: Ver }
   384:             }
   385:         }
~~~

## TODO 0554

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 470
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   468:                     trigger OnAction()
   469:                     begin
   470:                         //TODO: Ver CapturarProductos;
   471:                     end;
   472:                 }
~~~

## TODO 0555

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 487
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   485:                         IF "Tax Area Code" = '' THEN
   486:                             PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
   487:                         //TODO: Ver ELSE
   488:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   489:                     end;
~~~


## TODO 0556

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 488
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   486:                             PAGE.RUNMODAL(PAGE::"Sales Order Statistics", Rec);
   487:                         //TODO: Ver ELSE
   488:                         //TODO: Ver     PAGE.RUNMODAL(PAGE::"Sales Order Stats.", Rec)
   489:                     end;
   490:                 }
~~~

## TODO 0557

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 534
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   532:                     Caption = 'Prepayment Credi&t Memos';
   533:                     RunObject = Page "Posted Sales Credit Memos";
   534:                     //TODO: Ver RunPageLink = "Order No."=FIELD("No.");
   535:                     RunPageView = SORTING("Prepayment Order No.");
   536:                 }
~~~

## TODO 0558

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 608
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   606:                 {
   607:                     Caption = 'Credit Cards Transaction Lo&g Entries';
   608:                     //TODO: Ver RunObject = Page 829;
   609:                 }
   610:             }
~~~

## TODO 0559

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 686
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   684:                     trigger OnAction()
   685:                     var
   686:                     //TODO: Ver GetSourceDocOutbound: Codeunit 5752;
   687:                     begin
   688:                         //TODO: Ver GetSourceDocOutbound.CreateFromSalesOrder(Rec);
~~~

## TODO 0560

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 688
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   686:                     //TODO: Ver GetSourceDocOutbound: Codeunit 5752;
   687:                     begin
   688:                         //TODO: Ver GetSourceDocOutbound.CreateFromSalesOrder(Rec);
   689: 
   690:                         IF NOT FIND('=><') THEN
~~~

## TODO 0561

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 989
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   987:                     trigger OnAction()
   988:                     begin
   989:                         //TODO: Ver DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
   990:                     end;
   991:                 }
~~~

## TODO 0562

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1000
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   998:                     trigger OnAction()
   999:                     begin
  1000:                         //TODO: Ver DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
  1001:                     end;
  1002:                 }
~~~

## TODO 0563

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1009
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
  1007:                     trigger OnAction()
  1008:                     begin
  1009:                         //TODO: Ver  DocPrint.PrintSalesOrder(Rec, Usage::"Pick Ticket");
  1010:                     end;
  1011:                 }
~~~

## TODO 0564

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1022
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
  1020:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
  1021:                 //PromotedCategory = "Report";
  1022:                 //TODO: Ver //TODO: Ver RunObject = Report 10051;
  1023:             }
  1024:             action("Picking List by Order")
~~~

## TODO 0565

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1022
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
  1020:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
  1021:                 //PromotedCategory = "Report";
  1022:                 //TODO: Ver //TODO: Ver RunObject = Report 10051;
  1023:             }
  1024:             action("Picking List by Order")
~~~

## TODO 0566

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1029
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
  1027:                 Promoted = true;
  1028:                 PromotedCategory = "Report";
  1029:                 //TODO: Ver //TODO: Ver RunObject = Report 10153;
  1030:             }
  1031:         }
~~~

## TODO 0567

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1029
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
  1027:                 Promoted = true;
  1028:                 PromotedCategory = "Report";
  1029:                 //TODO: Ver //TODO: Ver RunObject = Report 10153;
  1030:             }
  1031:         }
~~~

## TODO 0568

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1037
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
  1035:     begin
  1036:         //004
  1037:         //TODO: Ver AppTemp.RESET;
  1038:         //TODO: Ver AppTemp.SETRANGE("Table ID", 36);
  1039:         //TODO: Ver AppTemp.SETRANGE(Enabled, TRUE);
~~~

## TODO 0569

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1038
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
  1036:         //004
  1037:         //TODO: Ver AppTemp.RESET;
  1038:         //TODO: Ver AppTemp.SETRANGE("Table ID", 36);
  1039:         //TODO: Ver AppTemp.SETRANGE(Enabled, TRUE);
  1040:         //TODO: Ver IF NOT AppTemp.FINDFIRST THEN BEGIN
~~~

## TODO 0570

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1039
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
  1037:         //TODO: Ver AppTemp.RESET;
  1038:         //TODO: Ver AppTemp.SETRANGE("Table ID", 36);
  1039:         //TODO: Ver AppTemp.SETRANGE(Enabled, TRUE);
  1040:         //TODO: Ver IF NOT AppTemp.FINDFIRST THEN BEGIN
  1041:         SalesLine.SETRANGE("Document Type", "Document Type");
~~~


## TODO 0571

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1040
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
  1038:         //TODO: Ver AppTemp.SETRANGE("Table ID", 36);
  1039:         //TODO: Ver AppTemp.SETRANGE(Enabled, TRUE);
  1040:         //TODO: Ver IF NOT AppTemp.FINDFIRST THEN BEGIN
  1041:         SalesLine.SETRANGE("Document Type", "Document Type");
  1042:         SalesLine.SETRANGE("Document No.", "No.");
~~~

## TODO 0572

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1047
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
  1045:         IF SalesLine.FIND('-') THEN
  1046:             ReleaseSalesDoc.PerformManualRelease(Rec);
  1047:         //TODO: Ver END
  1048:         //TODO: Ver ELSE
  1049:         //  IF ApprovalMgt.SendSalesApprovalRequest_BO(Rec) THEN; //-$001
~~~

## TODO 0573

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1048
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
  1046:             ReleaseSalesDoc.PerformManualRelease(Rec);
  1047:         //TODO: Ver END
  1048:         //TODO: Ver ELSE
  1049:         //  IF ApprovalMgt.SendSalesApprovalRequest_BO(Rec) THEN; //-$001
  1050:         //004
~~~

## TODO 0574

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1097
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
  1095:         ApprovalMgt: Codeunit "Approvals Mgmt.";
  1096:         ReportPrint: Codeunit 228;
  1097:         //TODO: Ver DocPrint: Codeunit 229;
  1098:         ArchiveManagement: Codeunit 5063;
  1099:         SalesInfoPaneMgt: Codeunit 7171;
~~~

## TODO 0575

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1116
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
  1114:         SH: Record 36;
  1115:         GestBO: Boolean;
  1116:         //TODO: Ver AjusBO: Report 55261;
  1117:         //TODO: Ver AppTemp: Record 464;
  1118:         SalesLine: Record 37;
~~~

## TODO 0576

- File path: `src/Pages/Page 55261 - Sales Order Call Center.al`
- Object type: Page
- Object ID: 55261
- Object name: `Sales Order Call Center`
- Line number: 1117
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
  1115:         GestBO: Boolean;
  1116:         //TODO: Ver AjusBO: Report 55261;
  1117:         //TODO: Ver AppTemp: Record 464;
  1118:         SalesLine: Record 37;
  1119:         ReleaseSalesDoc: Codeunit "Release Sales Document";
~~~

## TODO 0577

- File path: `src/Pages/Page 55262 - Captura Productos.al`
- Object type: Page
- Object ID: 55262
- Object name: `Captura Productos`
- Line number: 26
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    24:                 {
    25:                 }
    26:                 //TODO: Ver
    27:                 /*
    28:                 field(SalesInfoPaneMgt.CalcAvailability_Item("No.",_Location);
~~~

## TODO 0578

- File path: `src/Pages/Page 55264 - Matriz Prod x Almacen (Grupos).al`
- Object type: Page
- Object ID: 55264
- Object name: `Matriz Prod x Almacen (Grupos)`
- Line number: 20
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    18:             group(GeneralG)
    19:             {
    20:                 //TODO: Ver 
    21:                 /*
    22:                 field("Grupo Almacen"; wGrupoAlmacen)
~~~

## TODO 0579

- File path: `src/Pages/Page 55264 - Matriz Prod x Almacen (Grupos).al`
- Object type: Page
- Object ID: 55264
- Object name: `Matriz Prod x Almacen (Grupos)`
- Line number: 40
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    38:             }
    39: 
    40:             //TODO: Ver
    41:             /*
    42:             repeater(General)
~~~

## TODO 0580

- File path: `src/Pages/Page 55264 - Matriz Prod x Almacen (Grupos).al`
- Object type: Page
- Object ID: 55264
- Object name: `Matriz Prod x Almacen (Grupos)`
- Line number: 474
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   472:     }
   473: 
   474:     //TODO: Ver
   475:     /*
   476:     actions
~~~

## TODO 0581

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 140
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   138:                 trigger OnAction()
   139:                 var
   140:                     //TODO: Ver lReporteVentas: Report 55349;
   141:                     TextL001: Label 'Se genero el archivo de texto en la carpeta indicada %1, con el nombre %2';
   142:                     TextL002: Label 'Fatla indicar la carpeta o bien el nombre del archivo a generar.';
~~~

## TODO 0582

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 194
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   192:                     //lReporteVentas.Parametros(TRUE,wDetallado,wFechaIni,wFechaFin,wCodNumDev,wTipoCliente,wCliente,wProducto,wProducto2,wTipoDocumento,wGCN,wLineaNegocio); //005+-
   193:                     //lReporteVentas.Parametros(TRUE,wDetallado,wFechaIni,wFechaFin,wCodNumDev,wTipoCliente,wCliente,wProducto,wProducto2,wTipoDocumento,wGCN,wLineaNegocio,wCategoriaPedido); //007+-
   194:                     //TODO: Ver lReporteVentas.Parametros(TRUE, wDetallado, wFechaIni, wFechaFin, wCodNumDev, wTipoCliente, wCliente, wProducto, wProducto2, wTipoDocumento, wGCN, wLineaNegocio, wCategoriaPedido, wCanalVenta); //008+-
   195:                     //-003
   196: 
~~~

## TODO 0583

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 199
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   197:                     lWindow.OPEN(TextL004);
   198:                     //lReporteVentas.GetFileName(lFile0,lRuta+'\');
   199:                     //TODO: Ver lReporteVentas.SAVEASEXCEL(lRuta + '\' + lFile0);  //+002
   200:                     lWindow.CLOSE;
   201: 
~~~

## TODO 0584

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 204
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   202:                     //DOWNLOAD(FromFile, DialogTitle, ToFolder, ToFilter, ToFile)
   203:                     //DOWNLOAD('FromFile.txt','Download file','C:\','Text file(*.txt)|*.txt',ToFile);
   204:                     //TODO: Ver IF NOT DOWNLOAD(lRuta + '\' + lFile0, 'Descargar archivo', 'C:\', 'Excel File|*.xlsx', lFile) THEN
   205:                     //TODO: Ver    MESSAGE(TextL005);
   206: 
~~~

## TODO 0585

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 205
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   203:                     //DOWNLOAD('FromFile.txt','Download file','C:\','Text file(*.txt)|*.txt',ToFile);
   204:                     //TODO: Ver IF NOT DOWNLOAD(lRuta + '\' + lFile0, 'Descargar archivo', 'C:\', 'Excel File|*.xlsx', lFile) THEN
   205:                     //TODO: Ver    MESSAGE(TextL005);
   206: 
   207:                     //+002
~~~


## TODO 0586

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 211
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   209: 
   210:                     //006+
   211:                     //TODO: Ver IF FILE.EXISTS(lRuta + '\' + lFile0) THEN
   212:                     //TODO: Ver     ERASE(lRuta + '\' + lFile0);
   213:                     //006-
~~~

## TODO 0587

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 212
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   210:                     //006+
   211:                     //TODO: Ver IF FILE.EXISTS(lRuta + '\' + lFile0) THEN
   212:                     //TODO: Ver     ERASE(lRuta + '\' + lFile0);
   213:                     //006-
   214: 
~~~

## TODO 0588

- File path: `src/Pages/Page 55268 - Estadisticas de Vtas. (EXCEL).al`
- Object type: Page
- Object ID: 55268
- Object name: `Estadisticas de Vtas. (EXCEL)`
- Line number: 248
- Classification: SaaS incompatibility
- Proposed correction: Do not restore this OnPrem/file-system/automation interaction as-is. Confirm the business requirement and replace it with a supported SaaS stream, service, or integration pattern using verified AL APIs.
- Compile risk: High
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   246:         wTipoCliente: Code[20];
   247:         wCodNumDev: Code[20];
   248:         //TODO: Ver Folder: Automation;
   249:         wLineaNegocio: Code[20];
   250:         wGCN: Code[20];
~~~

## TODO 0589

- File path: `src/Pages/Page 55273 - Lin. Consignacion a Facturar.al`
- Object type: Page
- Object ID: 55273
- Object name: `Lin. Consignacion a Facturar`
- Line number: 65
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    63:                 trigger OnAction()
    64:                 begin
    65:                     //TODO: Ver FuncSant.RecibeNoDoc(NoPedido);
    66:                     REPORT.RUNMODAL(55252);
    67:                     CurrPage.UPDATE;
~~~

## TODO 0590

- File path: `src/Pages/Page 55273 - Lin. Consignacion a Facturar.al`
- Object type: Page
- Object ID: 55273
- Object name: `Lin. Consignacion a Facturar`
- Line number: 159
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   157:         rItem: Record 27;
   158:         rLCF: Record 55236;
   159:         //TODO: Ver FuncSant: Codeunit 55225;
   160:         PageActDesc: Page 55274;
   161:         Window: Dialog;
~~~

## TODO 0591

- File path: `src/Pages/Page 55280 - BackOrders Sin Disp. Transfer..al`
- Object type: Page
- Object ID: 55280
- Object name: `BackOrders Sin Disp. Transfer.`
- Line number: 76
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    74:                     Editable = false;
    75:                 }
    76:                 //TODO: Ver 
    77:                 /*
    78:                 field(SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(Rec);
~~~

## TODO 0592

- File path: `src/Pages/Page 55280 - BackOrders Sin Disp. Transfer..al`
- Object type: Page
- Object ID: 55280
- Object name: `BackOrders Sin Disp. Transfer.`
- Line number: 232
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   230:             //-$002
   231:             //IF (SalesInfoPaneMgt.CalcAvailabilityTransLine(TL) = 0) AND (TL."Cantidad pendiente BO" <> 0) THEN //-#55310
   232:             //TODO: Ver 
   233:             /*
   234:             IF (SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL) <= 0) AND (TL."Cantidad pendiente BO" <> 0) THEN //+#55310
~~~

## TODO 0593

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 91
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    89:                     Editable = false;
    90:                 }
    91:                 //TODO: Ver
    92:                 /*
    93:                 field(SalesInfoPaneMgt.CalcAvailability_BackOrder(Rec);
~~~

## TODO 0594

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 135
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   133:                     SH.GET("Document Type", "Document No.");
   134:                     PedVta.SETRECORD(SH);
   135:                     //TODO: Ver PedVta.GestBackOrd(TRUE);
   136:                     PedVta.RUNMODAL;
   137:                     CLEAR(PedVta);
~~~

## TODO 0595

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 231
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   229:                                 Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
   230: 
   231:                                 //TODO: Ver CantDisp := SalesInfoPaneMgt.CalcAvailability_BackOrder(SL);
   232:                                 IF CantDisp > SL."Cantidad pendiente BO" THEN
   233:                                     SL."Cantidad a Anular" := 0;
~~~

## TODO 0596

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 234
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   232:                                 IF CantDisp > SL."Cantidad pendiente BO" THEN
   233:                                     SL."Cantidad a Anular" := 0;
   234:                                 //TODO: Ver ELSE
   235:                                 //TODO: Ver SL."Cantidad a Anular" := SL."Cantidad pendiente BO" - SalesInfoPaneMgt.CalcAvailability_BackOrder(SL);
   236:                                 SL."Cantidad a Ajustar" := SL."Cantidad pendiente BO" - SL."Cantidad a Anular";
~~~

## TODO 0597

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 235
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   233:                                     SL."Cantidad a Anular" := 0;
   234:                                 //TODO: Ver ELSE
   235:                                 //TODO: Ver SL."Cantidad a Anular" := SL."Cantidad pendiente BO" - SalesInfoPaneMgt.CalcAvailability_BackOrder(SL);
   236:                                 SL."Cantidad a Ajustar" := SL."Cantidad pendiente BO" - SL."Cantidad a Anular";
   237:                                 SL.MODIFY;
~~~

## TODO 0598

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 323
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   321:                 //-$002
   322: 
   323:                 //TODO: Ver 
   324:                 //TODO: Ver IF (SalesLine."Cantidad pendiente BO" > 0) THEN // +$003
   325:                 //TODO: Ver IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SalesLine) > 0) AND
~~~

## TODO 0599

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 324
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   322: 
   323:                 //TODO: Ver 
   324:                 //TODO: Ver IF (SalesLine."Cantidad pendiente BO" > 0) THEN // +$003
   325:                 //TODO: Ver IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SalesLine) > 0) AND
   326:                 //TODO: Ver (SH.GET(SalesLine."Document Type", SalesLine."Document No.")) THEN
~~~

## TODO 0600

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 325
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   323:                 //TODO: Ver 
   324:                 //TODO: Ver IF (SalesLine."Cantidad pendiente BO" > 0) THEN // +$003
   325:                 //TODO: Ver IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SalesLine) > 0) AND
   326:                 //TODO: Ver (SH.GET(SalesLine."Document Type", SalesLine."Document No.")) THEN
   327:                 //+$002
~~~


## TODO 0601

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 326
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   324:                 //TODO: Ver IF (SalesLine."Cantidad pendiente BO" > 0) THEN // +$003
   325:                 //TODO: Ver IF (SalesInfoPaneMgt.CalcAvailability_BackOrder(SalesLine) > 0) AND
   326:                 //TODO: Ver (SH.GET(SalesLine."Document Type", SalesLine."Document No.")) THEN
   327:                 //+$002
   328:                 // El ELSE no tenia ningún sentido, los registros ya están marcados como FALSE
~~~

## TODO 0602

- File path: `src/Pages/Page 55285 - Gestion BackOrder - SL.al`
- Object type: Page
- Object ID: 55285
- Object name: `Gestion BackOrder - SL`
- Line number: 361
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   359:         ReleaseSalesDoc: Codeunit "Release Sales Document";
   360:         salesheader: Record 36;
   361:         //TODO: Ver AppTemp: Record 464;
   362:         ApprovalMgt: Codeunit "Approvals Mgmt.";
   363:         EstatusPed: Option Abierto,Lanzado,"Aprobacion pendiente","Anticipo pendiente";
~~~

## TODO 0603

- File path: `src/Pages/Page 55286 - Gestion BackOrder - TL.al`
- Object type: Page
- Object ID: 55286
- Object name: `Gestion BackOrder - TL`
- Line number: 73
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    71:                     Editable = false;
    72:                 }
    73:                 //TODO: Ver 
    74:                 /*
    75:                 field(SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(Rec);
~~~

## TODO 0604

- File path: `src/Pages/Page 55286 - Gestion BackOrder - TL.al`
- Object type: Page
- Object ID: 55286
- Object name: `Gestion BackOrder - TL`
- Line number: 210
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   208:                                 Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
   209: 
   210:                                 //TODO: Ver cantdisp := SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL);
   211:                                 IF cantdisp > TL."Cantidad pendiente BO" THEN
   212:                                     TL."Cantidad a Anular" := 0;
~~~

## TODO 0605

- File path: `src/Pages/Page 55286 - Gestion BackOrder - TL.al`
- Object type: Page
- Object ID: 55286
- Object name: `Gestion BackOrder - TL`
- Line number: 213
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   211:                                 IF cantdisp > TL."Cantidad pendiente BO" THEN
   212:                                     TL."Cantidad a Anular" := 0;
   213:                                 //TODO: Ver ELSE
   214:                                 //TODO: Ver     TL."Cantidad a Anular" := TL."Cantidad pendiente BO" - SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL);
   215:                                 TL."Cantidad a Ajustar" := TL."Cantidad pendiente BO" - TL."Cantidad a Anular";
~~~

## TODO 0606

- File path: `src/Pages/Page 55286 - Gestion BackOrder - TL.al`
- Object type: Page
- Object ID: 55286
- Object name: `Gestion BackOrder - TL`
- Line number: 214
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   212:                                     TL."Cantidad a Anular" := 0;
   213:                                 //TODO: Ver ELSE
   214:                                 //TODO: Ver     TL."Cantidad a Anular" := TL."Cantidad pendiente BO" - SalesInfoPaneMgt.CalcAvailabilityTL_BackOrder(TL);
   215:                                 TL."Cantidad a Ajustar" := TL."Cantidad pendiente BO" - TL."Cantidad a Anular";
   216:                                 TL.MODIFY;
~~~

## TODO 0607

- File path: `src/Pages/Page 55286 - Gestion BackOrder - TL.al`
- Object type: Page
- Object ID: 55286
- Object name: `Gestion BackOrder - TL`
- Line number: 279
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   277: 
   278:                     //Se verifica que la linea no esté en Envios de Almacen
   279:                     //TODO: Ver 
   280:                     /*
   281:                     WHSL.RESET;
~~~

## TODO 0608

- File path: `src/Pages/Page 55289 - Crea Cupones en Lote.al`
- Object type: Page
- Object ID: 55289
- Object name: `Crea Cupones en Lote`
- Line number: 102
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   100:                 PromotedIsBig = true;
   101:                 RunObject = Page 55172;
   102:                 //TODO: Ver RunPageLink = "Lote cupon" = FIELD("Lote");
   103:                 //TODO: Ver RunPageView = SORTING("No." "Lote cupon")
   104:                 //TODO: Ver               ORDER(Ascending);
~~~

## TODO 0609

- File path: `src/Pages/Page 55289 - Crea Cupones en Lote.al`
- Object type: Page
- Object ID: 55289
- Object name: `Crea Cupones en Lote`
- Line number: 103
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   101:                 RunObject = Page 55172;
   102:                 //TODO: Ver RunPageLink = "Lote cupon" = FIELD("Lote");
   103:                 //TODO: Ver RunPageView = SORTING("No." "Lote cupon")
   104:                 //TODO: Ver               ORDER(Ascending);
   105:             }
~~~

## TODO 0610

- File path: `src/Pages/Page 55289 - Crea Cupones en Lote.al`
- Object type: Page
- Object ID: 55289
- Object name: `Crea Cupones en Lote`
- Line number: 104
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   102:                 //TODO: Ver RunPageLink = "Lote cupon" = FIELD("Lote");
   103:                 //TODO: Ver RunPageView = SORTING("No." "Lote cupon")
   104:                 //TODO: Ver               ORDER(Ascending);
   105:             }
   106:             action("&Generar")
~~~

## TODO 0611

- File path: `src/Pages/Page 55289 - Crea Cupones en Lote.al`
- Object type: Page
- Object ID: 55289
- Object name: `Crea Cupones en Lote`
- Line number: 119
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   117: 
   118:                     ComprobarLote(Lote);
   119:                     //TODO: Ver cuFunSantillana.cuCreaCupones("Cod. Colegio", "Cod. Vendedor", NombreVendedor("Cod. Vendedor"), "Valido Desde", "Valido Hasta", "Grado Alumno", "Dto Colegio",
   120:                     //TODO: Ver                               "Dto Padre", "Año Escolar", NombreColegio("Cod. Colegio"), Descripcion, "Cantidad Cupones", Lote, "Cantidad Limite", "Importe Dto. Limite", "Cod. Cliente", "Nombre Cliente");
   121:                 end;
~~~

## TODO 0612

- File path: `src/Pages/Page 55289 - Crea Cupones en Lote.al`
- Object type: Page
- Object ID: 55289
- Object name: `Crea Cupones en Lote`
- Line number: 120
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   118:                     ComprobarLote(Lote);
   119:                     //TODO: Ver cuFunSantillana.cuCreaCupones("Cod. Colegio", "Cod. Vendedor", NombreVendedor("Cod. Vendedor"), "Valido Desde", "Valido Hasta", "Grado Alumno", "Dto Colegio",
   120:                     //TODO: Ver                               "Dto Padre", "Año Escolar", NombreColegio("Cod. Colegio"), Descripcion, "Cantidad Cupones", Lote, "Cantidad Limite", "Importe Dto. Limite", "Cod. Cliente", "Nombre Cliente");
   121:                 end;
   122:             }
~~~

## TODO 0613

- File path: `src/Pages/Page 55289 - Crea Cupones en Lote.al`
- Object type: Page
- Object ID: 55289
- Object name: `Crea Cupones en Lote`
- Line number: 143
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   141: 
   142:     var
   143:     //TODO: Ver cuFunSantillana: Codeunit 55225;
   144: 
   145:     procedure NombreColegio(pColegio: Code[20]): Text
~~~

## TODO 0614

- File path: `src/Pages/Page 55310 - Lista Pedidos Ecommerce.al`
- Object type: Page
- Object ID: 55310
- Object name: `Lista Pedidos Ecommerce`
- Line number: 102
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   100:                 trigger OnAction()
   101:                 var
   102:                     //TODO: Ver ModificarPedidosEcommerce: Report 55000;
   103:                     CabVentaNopCommerce: Record 55100;
   104:                 begin
~~~

## TODO 0615

- File path: `src/Pages/Page 55353 - Equiv. conceptos NAV-MdE.al`
- Object type: Page
- Object ID: 55353
- Object name: `Equiv. conceptos NAV-MdE`
- Line number: 20
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    18:                 //The GridLayout property is only supported on controls of type Grid
    19:                 //GridLayout = Rows;
    20:                 //TODO: Ver 
    21:                 /*
    22:                 field(GetMdEEquiv; GetMdEEquiv)
~~~


## TODO 0616

- File path: `src/Pages/Page 55353 - Equiv. conceptos NAV-MdE.al`
- Object type: Page
- Object ID: 55353
- Object name: `Equiv. conceptos NAV-MdE`
- Line number: 40
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    38:                     Editable = false;
    39:                 }
    40:                 //TODO: Ver 
    41:                 /*
    42:                 field(BooleanArray[1]; BooleanArray[1])
~~~

## TODO 0617

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 143
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   141:                 {
   142:                 }
   143:                 //TODO: Ver field("Usuario creacion"; "Usuario creacion")
   144:                 //TODO: Ver {
   145:                 //TODO: Ver }
~~~

## TODO 0618

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 144
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   142:                 }
   143:                 //TODO: Ver field("Usuario creacion"; "Usuario creacion")
   144:                 //TODO: Ver {
   145:                 //TODO: Ver }
   146:             }
~~~

## TODO 0619

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 145
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   143:                 //TODO: Ver field("Usuario creacion"; "Usuario creacion")
   144:                 //TODO: Ver {
   145:                 //TODO: Ver }
   146:             }
   147:             group(Communication)
~~~

## TODO 0620

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 182
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   180:                     Importance = Promoted;
   181:                 }
   182:                 //TODO: Ver field("E-Mail 2"; "E - Mail 2")
   183:                 //TODO: Ver {
   184:                 //TODO: Ver }
~~~

## TODO 0621

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 183
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   181:                 }
   182:                 //TODO: Ver field("E-Mail 2"; "E - Mail 2")
   183:                 //TODO: Ver {
   184:                 //TODO: Ver }
   185:                 field("Home Page"; "Home Page")
~~~

## TODO 0622

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 184
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   182:                 //TODO: Ver field("E-Mail 2"; "E - Mail 2")
   183:                 //TODO: Ver {
   184:                 //TODO: Ver }
   185:                 field("Home Page"; "Home Page")
   186:                 {
~~~

## TODO 0623

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 248
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   246:                     PromotedCategory = Process;
   247:                     PromotedIsBig = true;
   248:                     //TODO: Ver RunObject = Page 67045;
   249:                     //TODO: Ver                 RunPageLink = "Cod. Docente"=FIELD("No.");
   250:                 }
~~~

## TODO 0624

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 249
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   247:                     PromotedIsBig = true;
   248:                     //TODO: Ver RunObject = Page 67045;
   249:                     //TODO: Ver                 RunPageLink = "Cod. Docente"=FIELD("No.");
   250:                 }
   251:                 action(Hobbies)
~~~

## TODO 0625

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 258
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   256:                     PromotedCategory = Process;
   257:                     PromotedIsBig = true;
   258:                     //TODO: Ver RunObject = Page 67058;
   259:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   260:                 }
~~~

## TODO 0626

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 259
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   257:                     PromotedIsBig = true;
   258:                     //TODO: Ver RunObject = Page 67058;
   259:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   260:                 }
   261: 
~~~

## TODO 0627

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 269
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   267:                     PromotedCategory = Process;
   268:                     PromotedIsBig = true;
   269:                     //TODO: Ver RunObject = Page 67063;
   270:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   271:                 }
~~~

## TODO 0628

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 270
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   268:                     PromotedIsBig = true;
   269:                     //TODO: Ver RunObject = Page 67063;
   270:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   271:                 }
   272:                 action("Workshop - Event")
~~~

## TODO 0629

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 279
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   277:                     PromotedCategory = Process;
   278:                     PromotedIsBig = true;
   279:                     //TODO: Ver RunObject = Page 67108;
   280:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   281:                 }
~~~

## TODO 0630

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 280
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   278:                     PromotedIsBig = true;
   279:                     //TODO: Ver RunObject = Page 67108;
   280:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   281:                 }
   282:             }
~~~


## TODO 0631

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 287
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   285:                 Caption = '&Exponent';
   286:                 Image = ContactReference;
   287:                 //TODO: Ver RunObject = Page 67100;
   288:                 //TODO: Ver RunPageLink = "Cod. Expositor" = FIELD("Cod. Proveedor");
   289:             }
~~~

## TODO 0632

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 288
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   286:                 Image = ContactReference;
   287:                 //TODO: Ver RunObject = Page 67100;
   288:                 //TODO: Ver RunPageLink = "Cod. Expositor" = FIELD("Cod. Proveedor");
   289:             }
   290:             group("&Historics")
~~~

## TODO 0633

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 299
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   297:                     Promoted = true;
   298:                     PromotedCategory = Process;
   299:                     //TODO: Ver RunObject = Page 67113;
   300:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   301:                 }
~~~

## TODO 0634

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 300
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   298:                     PromotedCategory = Process;
   299:                     //TODO: Ver RunObject = Page 67113;
   300:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   301:                 }
   302:                 action("Teacher - Hobbies History")
~~~

## TODO 0635

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 308
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   306:                     Promoted = true;
   307:                     PromotedCategory = Process;
   308:                     //TODO: Ver RunObject = Page 67114;
   309:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   310:                 }
~~~

## TODO 0636

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 309
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   307:                     PromotedCategory = Process;
   308:                     //TODO: Ver RunObject = Page 67114;
   309:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   310:                 }
   311:                 action("Teacher - Specialties History")
~~~

## TODO 0637

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 317
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   315:                     Promoted = true;
   316:                     PromotedCategory = Process;
   317:                     //TODO: Ver RunObject = Page 67115;
   318:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   319:                 }
~~~

## TODO 0638

- File path: `src/Pages/Page 55468 - Docentes.al`
- Object type: Page
- Object ID: 55468
- Object name: `Docentes`
- Line number: 318
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   316:                     PromotedCategory = Process;
   317:                     //TODO: Ver RunObject = Page 67115;
   318:                     //TODO: Ver RunPageLink = "Cod. Docente" = FIELD("No.");
   319:                 }
   320:                 action("School - Teacher History")
~~~

## TODO 0639

- File path: `src/Pages/Page 55472 - Productos equivalentes.al`
- Object type: Page
- Object ID: 55472
- Object name: `Productos equivalentes`
- Line number: 63
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    61:                     trigger OnAction()
    62:                     var
    63:                     //TODO: Ver ImportaProdEquiv: Report 55468;
    64:                     begin
    65:                         //TODO: Ver ImportaProdEquiv.RUNMODAL;
~~~

## TODO 0640

- File path: `src/Pages/Page 55472 - Productos equivalentes.al`
- Object type: Page
- Object ID: 55472
- Object name: `Productos equivalentes`
- Line number: 65
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    63:                     //TODO: Ver ImportaProdEquiv: Report 55468;
    64:                     begin
    65:                         //TODO: Ver ImportaProdEquiv.RUNMODAL;
    66:                         CurrPage.UPDATE;
    67:                     end;
~~~

## TODO 0641

- File path: `src/Pages/Page 55479 - Ficha Talleres - Eventos.al`
- Object type: Page
- Object ID: 55479
- Object name: `Ficha Talleres - Eventos`
- Line number: 71
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    69:                     PromotedIsBig = true;
    70:                     RunObject = Page 67100;
    71:                     //TODO: Ver RunPageLink = "Cod. Evento" = FIELD("No.");
    72:                 }
    73:                 action("<Action1000000039>")
~~~

## TODO 0642

- File path: `src/Pages/Page 55482 - Programac. Talleres y Eventos.al`
- Object type: Page
- Object ID: 55482
- Object name: `Programac. Talleres y Eventos`
- Line number: 49
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    47:                     Editable = false;
    48:                 }
    49:                 //TODO: Ver field("Horas Pedagogicas"; "Horas Pedagogicas")
    50:                 //TODO: Ver {
    51:                 //TODO: Ver }
~~~

## TODO 0643

- File path: `src/Pages/Page 55482 - Programac. Talleres y Eventos.al`
- Object type: Page
- Object ID: 55482
- Object name: `Programac. Talleres y Eventos`
- Line number: 50
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    48:                 }
    49:                 //TODO: Ver field("Horas Pedagogicas"; "Horas Pedagogicas")
    50:                 //TODO: Ver {
    51:                 //TODO: Ver }
    52:                 field(Expositor; Expositor)
~~~

## TODO 0644

- File path: `src/Pages/Page 55482 - Programac. Talleres y Eventos.al`
- Object type: Page
- Object ID: 55482
- Object name: `Programac. Talleres y Eventos`
- Line number: 51
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    49:                 //TODO: Ver field("Horas Pedagogicas"; "Horas Pedagogicas")
    50:                 //TODO: Ver {
    51:                 //TODO: Ver }
    52:                 field(Expositor; Expositor)
    53:                 {
~~~

## TODO 0645

- File path: `src/Pages/Page 55485 - Areas de interes.al`
- Object type: Page
- Object ID: 55485
- Object name: `Areas de interes`
- Line number: 7
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
     5:     PageType = List;
     6:     SourceTable = 55469;
     7:     //TODO: Ver SourceTableView = SORTING("Tipo registro", Codigo)
     8:     //TODO: Ver WHERE("Tipo registro" = CONST("Areas de interes"));
     9:     UsageCategory = Administration;
~~~


## TODO 0646

- File path: `src/Pages/Page 55485 - Areas de interes.al`
- Object type: Page
- Object ID: 55485
- Object name: `Areas de interes`
- Line number: 8
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     6:     SourceTable = 55469;
     7:     //TODO: Ver SourceTableView = SORTING("Tipo registro", Codigo)
     8:     //TODO: Ver WHERE("Tipo registro" = CONST("Areas de interes"));
     9:     UsageCategory = Administration;
    10: 
~~~

## TODO 0647

- File path: `src/Pages/Page 55485 - Areas de interes.al`
- Object type: Page
- Object ID: 55485
- Object name: `Areas de interes`
- Line number: 33
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    31:     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    32:     begin
    33:         //TODO: Ver "Tipo registro" := "Tipo registro"::"Areas de interés";
    34:     end;
    35: }
~~~

## TODO 0648

- File path: `src/Pages/Page 55488 - Distribuidor.al`
- Object type: Page
- Object ID: 55488
- Object name: `Distribuidor`
- Line number: 93
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    91:                     PromotedCategory = Process;
    92:                     RunObject = Page 67100;
    93:                     //TODO: Ver RunPageLink = "Cod. Expositor" = FIELD("No.");
    94:                 }
    95:             }
~~~

## TODO 0649

- File path: `src/Pages/Page 55494 - Promotores - Ppto Vtas.al`
- Object type: Page
- Object ID: 55494
- Object name: `Promotores - Ppto Vtas`
- Line number: 69
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    67:                     trigger OnAction()
    68:                     begin
    69:                         //TODO: Ver CopiaProducto.RecibeDatos("Cod. Promotor",0);
    70:                         //TODO: Ver CopiaProducto.RUNMODAL();
    71:                     end;
~~~

## TODO 0650

- File path: `src/Pages/Page 55494 - Promotores - Ppto Vtas.al`
- Object type: Page
- Object ID: 55494
- Object name: `Promotores - Ppto Vtas`
- Line number: 70
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    68:                     begin
    69:                         //TODO: Ver CopiaProducto.RecibeDatos("Cod. Promotor",0);
    70:                         //TODO: Ver CopiaProducto.RUNMODAL();
    71:                     end;
    72:                 }
~~~

## TODO 0651

- File path: `src/Pages/Page 55494 - Promotores - Ppto Vtas.al`
- Object type: Page
- Object ID: 55494
- Object name: `Promotores - Ppto Vtas`
- Line number: 83
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    81:                     trigger OnAction()
    82:                     var
    83:                     //TODO: Ver ProcImportaPpto: Report 55469;
    84:                     begin
    85:                         //TODO: Ver ProcImportaPpto.RecibeParametros(0);
~~~

## TODO 0652

- File path: `src/Pages/Page 55494 - Promotores - Ppto Vtas.al`
- Object type: Page
- Object ID: 55494
- Object name: `Promotores - Ppto Vtas`
- Line number: 85
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    83:                     //TODO: Ver ProcImportaPpto: Report 55469;
    84:                     begin
    85:                         //TODO: Ver ProcImportaPpto.RecibeParametros(0);
    86:                         //TODO: Ver ProcImportaPpto.RUNMODAL;
    87:                     end;
~~~

## TODO 0653

- File path: `src/Pages/Page 55494 - Promotores - Ppto Vtas.al`
- Object type: Page
- Object ID: 55494
- Object name: `Promotores - Ppto Vtas`
- Line number: 86
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    84:                     begin
    85:                         //TODO: Ver ProcImportaPpto.RecibeParametros(0);
    86:                         //TODO: Ver ProcImportaPpto.RUNMODAL;
    87:                     end;
    88:                 }
~~~

## TODO 0654

- File path: `src/Pages/Page 55494 - Promotores - Ppto Vtas.al`
- Object type: Page
- Object ID: 55494
- Object name: `Promotores - Ppto Vtas`
- Line number: 94
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    92: 
    93:     var
    94:     //TODO: Ver CopiaProducto: Report 55467;
    95: }
    96: 
~~~

## TODO 0655

- File path: `src/Pages/Page 55495 - Promotores - Ppto Muestras.al`
- Object type: Page
- Object ID: 55495
- Object name: `Promotores - Ppto Muestras`
- Line number: 66
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    64:                     trigger OnAction()
    65:                     begin
    66:                         //TODO: Ver CopiaProducto.RecibeDatos("Cod. Promotor",1);
    67:                         //TODO: Ver CopiaProducto.RUNMODAL();
    68:                     end;
~~~

## TODO 0656

- File path: `src/Pages/Page 55495 - Promotores - Ppto Muestras.al`
- Object type: Page
- Object ID: 55495
- Object name: `Promotores - Ppto Muestras`
- Line number: 67
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    65:                     begin
    66:                         //TODO: Ver CopiaProducto.RecibeDatos("Cod. Promotor",1);
    67:                         //TODO: Ver CopiaProducto.RUNMODAL();
    68:                     end;
    69:                 }
~~~

## TODO 0657

- File path: `src/Pages/Page 55495 - Promotores - Ppto Muestras.al`
- Object type: Page
- Object ID: 55495
- Object name: `Promotores - Ppto Muestras`
- Line number: 80
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    78:                     trigger OnAction()
    79:                     var
    80:                     //TODO: Ver ProcImportaPpto: Report 55469;
    81:                     begin
    82:                         //TODO: Ver ProcImportaPpto.RecibeParametros(1);
~~~

## TODO 0658

- File path: `src/Pages/Page 55495 - Promotores - Ppto Muestras.al`
- Object type: Page
- Object ID: 55495
- Object name: `Promotores - Ppto Muestras`
- Line number: 82
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    80:                     //TODO: Ver ProcImportaPpto: Report 55469;
    81:                     begin
    82:                         //TODO: Ver ProcImportaPpto.RecibeParametros(1);
    83:                         //TODO: Ver ProcImportaPpto.RUNMODAL;
    84:                     end;
~~~

## TODO 0659

- File path: `src/Pages/Page 55495 - Promotores - Ppto Muestras.al`
- Object type: Page
- Object ID: 55495
- Object name: `Promotores - Ppto Muestras`
- Line number: 83
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    81:                     begin
    82:                         //TODO: Ver ProcImportaPpto.RecibeParametros(1);
    83:                         //TODO: Ver ProcImportaPpto.RUNMODAL;
    84:                     end;
    85:                 }
~~~

## TODO 0660

- File path: `src/Pages/Page 55495 - Promotores - Ppto Muestras.al`
- Object type: Page
- Object ID: 55495
- Object name: `Promotores - Ppto Muestras`
- Line number: 91
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    89: 
    90:     var
    91:     //TODO: Ver CopiaProducto: Report 55467;
    92: }
    93: 
~~~


## TODO 0661

- File path: `src/Pages/Page 67038 - Promotor - Planif. Visitas.al`
- Object type: Page
- Object ID: 67038
- Object name: `Promotor - Planif. Visitas`
- Line number: 44
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    42:                 {
    43:                 }
    44:                 //TODO: Ver 
    45:                 /*
    46:                 field(FuncAPS.ColCalcInvMuestras("Cod. Colegio");
~~~

## TODO 0662

- File path: `src/Pages/Page 67038 - Promotor - Planif. Visitas.al`
- Object type: Page
- Object ID: 67038
- Object name: `Promotor - Planif. Visitas`
- Line number: 90
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    88: 
    89:     var
    90:     //TODO: Ver FuncAPS: Codeunit 55467;
    91: 
    92:     procedure CargaEntregaMuestras()
~~~

## TODO 0663

- File path: `src/Pages/Page 67045 - Lista Colegio - Docentes.al`
- Object type: Page
- Object ID: 67045
- Object name: `Lista Colegio - Docentes`
- Line number: 75
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    73:                 {
    74:                 }
    75:                 //TODO: Ver field("Docente - E-Mail 2"; "Docente-E-Mail 2")
    76:                 //TODO: Ver {
    77:                 //TODO: Ver }
~~~

## TODO 0664

- File path: `src/Pages/Page 67045 - Lista Colegio - Docentes.al`
- Object type: Page
- Object ID: 67045
- Object name: `Lista Colegio - Docentes`
- Line number: 76
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    74:                 }
    75:                 //TODO: Ver field("Docente - E-Mail 2"; "Docente-E-Mail 2")
    76:                 //TODO: Ver {
    77:                 //TODO: Ver }
    78:                 field("Cod. Promotor"; "Cod. Promotor")
~~~

## TODO 0665

- File path: `src/Pages/Page 67045 - Lista Colegio - Docentes.al`
- Object type: Page
- Object ID: 67045
- Object name: `Lista Colegio - Docentes`
- Line number: 77
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    75:                 //TODO: Ver field("Docente - E-Mail 2"; "Docente-E-Mail 2")
    76:                 //TODO: Ver {
    77:                 //TODO: Ver }
    78:                 field("Cod. Promotor"; "Cod. Promotor")
    79:                 {
~~~

## TODO 0666

- File path: `src/Pages/Page 67051 - Colegio - Adopciones Cab.al`
- Object type: Page
- Object ID: 67051
- Object name: `Colegio - Adopciones Cab`
- Line number: 35
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    33:                     Importance = Promoted;
    34:                 }
    35:                 //TODO: Ver 
    36:                 /*
    37:                 field(FuncAPS.ColCalcInvMuestras("Cod. Colegio");
~~~

## TODO 0667

- File path: `src/Pages/Page 67051 - Colegio - Adopciones Cab.al`
- Object type: Page
- Object ID: 67051
- Object name: `Colegio - Adopciones Cab`
- Line number: 83
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    81:                     trigger OnLookup(var Text: Text): Boolean
    82:                     begin
    83:                         //TODO: Ver 
    84:                         /*
    85:                         ConfAPS.GET();
~~~

## TODO 0668

- File path: `src/Pages/Page 67051 - Colegio - Adopciones Cab.al`
- Object type: Page
- Object ID: 67051
- Object name: `Colegio - Adopciones Cab`
- Line number: 111
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   109:                     end;
   110:                 }
   111:                 //TODO: Ver 
   112:                 /*
   113:                 field("Filtro Nivel"; Filtro)
~~~

## TODO 0669

- File path: `src/Pages/Page 67051 - Colegio - Adopciones Cab.al`
- Object type: Page
- Object ID: 67051
- Object name: `Colegio - Adopciones Cab`
- Line number: 130
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   128:                     trigger OnLookup(var Text: Text): Boolean
   129:                     begin
   130:                         //TODO: Ver 
   131:                         /*
   132:                         ConfAPS.GET();
~~~

## TODO 0670

- File path: `src/Pages/Page 67051 - Colegio - Adopciones Cab.al`
- Object type: Page
- Object ID: 67051
- Object name: `Colegio - Adopciones Cab`
- Line number: 161
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   159:                     trigger OnLookup(var Text: Text): Boolean
   160:                     begin
   161:                         //TODO: Ver 
   162:                         /*
   163:                         ConfAPS.GET();
~~~

## TODO 0671

- File path: `src/Pages/Page 67051 - Colegio - Adopciones Cab.al`
- Object type: Page
- Object ID: 67051
- Object name: `Colegio - Adopciones Cab`
- Line number: 308
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   306:                         FiltroNivel: Text[100];
   307:                     begin
   308:                         //TODO: Ver FuncAPS.InsertaAdopciones("Cod. Colegio",Filtro,"Cod. Promotor",Turno);
   309:                     end;
   310:                 }
~~~

## TODO 0672

- File path: `src/Pages/Page 67051 - Colegio - Adopciones Cab.al`
- Object type: Page
- Object ID: 67051
- Object name: `Colegio - Adopciones Cab`
- Line number: 353
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   351:         DefDim: Record 352;
   352:         DimVal: Record 349;
   353:         //TODO: Ver FuncAPS: Codeunit 55467;
   354:         Table_ID: Integer;
   355:         MigratedTables: Integer;
~~~

## TODO 0673

- File path: `src/Pages/Page 67057 - Niveles de desicion.al`
- Object type: Page
- Object ID: 67057
- Object name: `Niveles de desicion`
- Line number: 7
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
     5:     PageType = List;
     6:     SourceTable = 55469;
     7:     //TODO: Ver SourceTableView = SORTING("Tipo registro", Codigo)
     8:     //TODO: Ver                   WHERE("Tipo registro" = CONST("Nivel de decision"));
     9:     UsageCategory = Administration;
~~~

## TODO 0674

- File path: `src/Pages/Page 67057 - Niveles de desicion.al`
- Object type: Page
- Object ID: 67057
- Object name: `Niveles de desicion`
- Line number: 8
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     6:     SourceTable = 55469;
     7:     //TODO: Ver SourceTableView = SORTING("Tipo registro", Codigo)
     8:     //TODO: Ver                   WHERE("Tipo registro" = CONST("Nivel de decision"));
     9:     UsageCategory = Administration;
    10: 
~~~

## TODO 0675

- File path: `src/Pages/Page 67062 - Fechas.al`
- Object type: Page
- Object ID: 67062
- Object name: `Fechas`
- Line number: 20
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    18:                 {
    19:                 }
    20:                 //TODO: Ver 
    21:                 /*
    22:                 field(NORMALDATE("Period End"); NORMALDATE("Period End"))
~~~


## TODO 0676

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 572
- Classification: Custom dependency
- Proposed correction: Verify that the referenced custom object exists with the same semantics, then restore the RunObject property exactly as intended; do not substitute a standard object without semantic confirmation.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   570:                     Promoted = true;
   571:                     PromotedCategory = Process;
   572:                     //TODO: Ver RunObject = Page 67130;
   573:                     //TODO: Ver RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
   574:                 }
~~~

## TODO 0677

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 573
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   571:                     PromotedCategory = Process;
   572:                     //TODO: Ver RunObject = Page 67130;
   573:                     //TODO: Ver RunPageLink = "No. Solicitud" = FIELD("No. Solicitud");
   574:                 }
   575:                 action("&Competencia")
~~~

## TODO 0678

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 626
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   624:                     begin
   625:                         TESTFIELD("Cod. Colegio");
   626:                         //TODO: Ver pgRanking.CalcularRanking("Cod. Colegio");
   627:                         pgRanking.RUN;
   628:                         CLEAR(pgRanking);
~~~

## TODO 0679

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 774
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   772:                 trigger OnAction()
   773:                 var
   774:                 //TODO: Ver cduWord: Codeunit 55468;
   775:                 begin
   776:                     //TODO: Ver cduWord.GeneraWordSolicitudAsistencia("No. Solicitud");
~~~

## TODO 0680

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 776
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   774:                 //TODO: Ver cduWord: Codeunit 55468;
   775:                 begin
   776:                     //TODO: Ver cduWord.GeneraWordSolicitudAsistencia("No. Solicitud");
   777:                 end;
   778:             }
~~~

## TODO 0681

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 785
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   783:                 trigger OnAction()
   784:                 var
   785:                 //TODO: Ver cduWord: Codeunit 55468;
   786:                 begin
   787:                     //TODO: Ver cduWord.GeneraWordPPFF("No. Solicitud");
~~~

## TODO 0682

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 787
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   785:                 //TODO: Ver cduWord: Codeunit 55468;
   786:                 begin
   787:                     //TODO: Ver cduWord.GeneraWordPPFF("No. Solicitud");
   788:                 end;
   789:             }
~~~

## TODO 0683

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 969
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   967:                 END;
   968: 
   969:         //TODO: Ver Status::Cancelada, Status::Cancelada:
   970:         //TODO: Ver    BEGIN
   971:         //TODO: Ver    END;
~~~

## TODO 0684

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 970
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   968: 
   969:         //TODO: Ver Status::Cancelada, Status::Cancelada:
   970:         //TODO: Ver    BEGIN
   971:         //TODO: Ver    END;
   972: 
~~~

## TODO 0685

- File path: `src/Pages/Page 67064 - Solicitud asistencia Tec - Ped.al`
- Object type: Page
- Object ID: 67064
- Object name: `Solicitud asistencia Tec - Ped`
- Line number: 971
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   969:         //TODO: Ver Status::Cancelada, Status::Cancelada:
   970:         //TODO: Ver    BEGIN
   971:         //TODO: Ver    END;
   972: 
   973:         END;
~~~

## TODO 0686

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 343
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   341:                     Caption = 'S&hipments';
   342:                     RunObject = Page 5752;
   343:                     //TODO: Ver RunPageLink = "Order No." = FIELD("No.");
   344:                 }
   345:                 action("Re&ceipts")
~~~

## TODO 0687

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 350
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   348:                     Image = PostedReceipts;
   349:                     RunObject = Page 5753;
   350:                     //TODO: Ver RunPageLink = "Order No." = FIELD("No.");
   351:                 }
   352:                 action(Dimensions)
~~~

## TODO 0688

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 403
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   401:                         trigger OnAction()
   402:                         begin
   403:                             //TODO: Ver CurrPage.TransferLines.PAGE.ItemAvailability(0);
   404:                         end;
   405:                     }
~~~

## TODO 0689

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 412
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   410:                         trigger OnAction()
   411:                         begin
   412:                             //TODO: Ver CurrPage.TransferLines.PAGE.ItemAvailability(1);
   413:                         end;
   414:                     }
~~~

## TODO 0690

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 421
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   419:                         trigger OnAction()
   420:                         begin
   421:                             //TODO: Ver CurrPage.TransferLines.PAGE.ItemAvailability(2);
   422:                         end;
   423:                     }
~~~


## TODO 0691

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 433
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   431:                     trigger OnAction()
   432:                     begin
   433:                         //TODO: Ver CurrPage.TransferLines.PAGE.ShowDimensions;
   434:                     end;
   435:                 }
~~~

## TODO 0692

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 445
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   443:                         trigger OnAction()
   444:                         begin
   445:                             //TODO: Ver CurrPage.TransferLines.PAGE.OpenItemTrackingLines(0);
   446:                         end;
   447:                     }
~~~

## TODO 0693

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 454
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   452:                         trigger OnAction()
   453:                         begin
   454:                             //TODO: Ver CurrPage.TransferLines.PAGE.OpenItemTrackingLines(1);
   455:                         end;
   456:                     }
~~~

## TODO 0694

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 486
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   484:                     trigger OnAction()
   485:                     begin
   486:                         //TODO: Ver CurrPage.TransferLines.PAGE.ShowReservation;
   487:                     end;
   488:                 }
~~~

## TODO 0695

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 591
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   589:                         //002
   590: 
   591:                         //TODO: Ver CFuncSantillana.CreaEmailPedidoConsg(Rec);
   592:                         CurrPage.UPDATE;
   593:                         //002
~~~

## TODO 0696

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 687
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   685:     var
   686:         ConfAPS: Record 55467;
   687:         //TODO: Ver CFuncSantillana: Codeunit 55225;
   688:         rTransHeader: Record 5740;
   689:         NombreCliente: Text[200];
~~~

## TODO 0697

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 693
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   691:         "**003**": Integer;
   692:         Cliente: Record 18;
   693:         //TODO: Ver cuManejaParametros: Codeunit 34002500;
   694:         I: Integer;
   695:         TransferHeader: Record 5740;
~~~

## TODO 0698

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 721
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   719:     local procedure PostingDateOnAfterValidate()
   720:     begin
   721:         //TODO: Ver CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   722:     end;
   723: 
~~~

## TODO 0699

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 726
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   724:     local procedure ShipmentDateOnAfterValidate()
   725:     begin
   726:         //TODO: Ver CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   727:     end;
   728: 
~~~

## TODO 0700

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 731
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   729:     local procedure ShippingAgentServiceCodeOnAfte()
   730:     begin
   731:         //TODO: Ver CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   732:     end;
   733: 
~~~

## TODO 0701

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 736
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   734:     local procedure ShippingAgentCodeOnAfterValida()
   735:     begin
   736:         //TODO: Ver CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   737:     end;
   738: 
~~~

## TODO 0702

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 741
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   739:     local procedure ShippingTimeOnAfterValidate()
   740:     begin
   741:         //TODO: Ver  CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   742:     end;
   743: 
~~~

## TODO 0703

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 746
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   744:     local procedure OutboundWhseHandlingTimeOnAfte()
   745:     begin
   746:         //TODO: Ver CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   747:     end;
   748: 
~~~

## TODO 0704

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 751
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   749:     local procedure ReceiptDateOnAfterValidate()
   750:     begin
   751:         //TODO: Ver CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   752:     end;
   753: 
~~~

## TODO 0705

- File path: `src/Pages/Page 67074 - Cab. Muestras.al`
- Object type: Page
- Object ID: 67074
- Object name: `Cab. Muestras`
- Line number: 756
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   754:     local procedure InboundWhseHandlingTimeOnAfter()
   755:     begin
   756:         //TODO: Ver CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
   757:     end;
   758: 
~~~


## TODO 0706

- File path: `src/Pages/Page 67076 - Transfer Order Subform Muestra.al`
- Object type: Page
- Object ID: 67076
- Object name: `Transfer Order Subform Muestra`
- Line number: 136
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   134:                     Visible = false;
   135:                 }
   136:                 //TODO: Ver
   137:                 /*
   138:                 field(ShortcutDimCode[3];ShortcutDimCode[3])
~~~

## TODO 0707

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 18
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    16:             repeater(General)
    17:             {
    18:                 //TODO: Ver IndentationColumn = NameIndent;
    19:                 IndentationControls = Name;
    20:                 field("No."; "No.")
~~~

## TODO 0708

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 194
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   192:                     Caption = 'Interaction Log E&ntries';
   193:                     RunObject = Page 5076;
   194:                     RunPageLink = //TODO: Ver "Company No." = FIELD("Company No."),
   195:                                   "Contact No." = FILTER(<> ''),
   196:                                   "Contact No." = FIELD(FILTER("Lookup Contact No."));
~~~

## TODO 0709

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 204
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   202:                     Caption = 'Postponed &Interactions';
   203:                     RunObject = Page 5082;
   204:                     RunPageLink = //TODO: Ver "Company No." = FIELD("Company No."),
   205:                                   "Contact No." = FILTER(<> ''),
   206:                                   "Contact No." = FIELD(FILTER("Lookup Contact No."));
~~~

## TODO 0710

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 213
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   211:                     Caption = 'T&o-dos';
   212:                     RunObject = Page 5096;
   213:                     RunPageLink = //TODO: Ver "Company No." = FIELD("Company No."),
   214:                                   "Contact No." = FIELD(FILTER("Lookup Contact No.")),
   215:                                   "System To-do Type" = FILTER("Contact Attendee");
~~~

## TODO 0711

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 225
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   223:                         Caption = 'List';
   224:                         RunObject = Page 5123;
   225:                         RunPageLink = //TODO: Ver "Company No." = FIELD("Company No."),
   226:                                       "Contact No." = FILTER(<> ''),
   227:                                       "Contact No." = FIELD(FILTER("Lookup Contact No."));
~~~

## TODO 0712

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 236
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   234:                     Image = Segment;
   235:                     RunObject = Page 5150;
   236:                     RunPageLink = //TODO: Ver "Company No." = FIELD("Company No."),
   237:                                   "Contact No." = FILTER(<> ''),
   238:                                   "Contact No." = FIELD(FILTER("Lookup Contact No."));
~~~

## TODO 0713

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 257
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   255:                     trigger OnAction()
   256:                     begin
   257:                         //TODO: Ver ShowCustVendBank;
   258:                     end;
   259:                 }
~~~

## TODO 0714

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 297
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   295:                         TESTFIELD(County);
   296:                         TESTFIELD("Post Code");
   297:                         //TODO: Ver PageColNivel.RecibeParametros("No.", City, County, "Post Code");
   298:                         //TODO: Ver PageColNivel.RUNMODAL;
   299:                         //TODO: Ver CLEAR(PageColNivel);
~~~

## TODO 0715

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 298
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   296:                         TESTFIELD("Post Code");
   297:                         //TODO: Ver PageColNivel.RecibeParametros("No.", City, County, "Post Code");
   298:                         //TODO: Ver PageColNivel.RUNMODAL;
   299:                         //TODO: Ver CLEAR(PageColNivel);
   300:                     end;
~~~

## TODO 0716

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 299
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   297:                         //TODO: Ver PageColNivel.RecibeParametros("No.", City, County, "Post Code");
   298:                         //TODO: Ver PageColNivel.RUNMODAL;
   299:                         //TODO: Ver CLEAR(PageColNivel);
   300:                     end;
   301:                 }
~~~

## TODO 0717

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 424
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   422:                         trigger OnAction()
   423:                         begin
   424:                             //TODO: Ver CreateCustomer(ChooseCustomerTemplate);
   425:                         end;
   426:                     }
~~~

## TODO 0718

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 527
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   525:                 Promoted = true;
   526:                 PromotedCategory = "Report";
   527:                 //TODO: Ver RunObject = Report 5051;
   528:             }
   529:             action("Contact Labels")
~~~

## TODO 0719

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 536
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   534:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
   535:                 //PromotedCategory = "Report";
   536:                 //TODO: Ver RunObject = Report 5056;
   537:             }
   538:             action("Questionnaire Handout")
~~~

## TODO 0720

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 545
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   543:                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
   544:                 //PromotedCategory = "Report";
   545:                 //TODO: Ver RunObject = Report 5066;
   546:             }
   547:             action("Sales Cycle Analysis")
~~~


## TODO 0721

- File path: `src/Pages/Page 67077 - Contact List APS.al`
- Object type: Page
- Object ID: 67077
- Object name: `Contact List APS`
- Line number: 553
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Resolve the legacy numeric object reference with AL symbol search, use the verified current standard object symbol, and validate any associated page links before restoring the property.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   551:                 Promoted = true;
   552:                 PromotedCategory = "Report";
   553:                 //TODO: Ver RunObject = Report 5062;
   554:             }
   555:         }
~~~

## TODO 0722

- File path: `src/Pages/Page 67079 - Promotores - Lista de Colegios.al`
- Object type: Page
- Object ID: 67079
- Object name: `Promotores - Lista de Colegios`
- Line number: 64
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    62:                     trigger OnAction()
    63:                     var
    64:                     //TODO: Ver FuncAPS: Codeunit 55467;
    65:                     begin
    66:                         //TODO: Ver IF Promotor <> '' THEN
~~~

## TODO 0723

- File path: `src/Pages/Page 67079 - Promotores - Lista de Colegios.al`
- Object type: Page
- Object ID: 67079
- Object name: `Promotores - Lista de Colegios`
- Line number: 66
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    64:                     //TODO: Ver FuncAPS: Codeunit 55467;
    65:                     begin
    66:                         //TODO: Ver IF Promotor <> '' THEN
    67:                         //TODO: Ver     FuncAPS.LlenaPromotorColegios(Promotor)
    68:                         //TODO: Ver ELSE
~~~

## TODO 0724

- File path: `src/Pages/Page 67079 - Promotores - Lista de Colegios.al`
- Object type: Page
- Object ID: 67079
- Object name: `Promotores - Lista de Colegios`
- Line number: 67
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    65:                     begin
    66:                         //TODO: Ver IF Promotor <> '' THEN
    67:                         //TODO: Ver     FuncAPS.LlenaPromotorColegios(Promotor)
    68:                         //TODO: Ver ELSE
    69:                         //TODO: Ver     FuncAPS.LlenaPromotorColegios(GETRANGEMIN("Cod. Promotor"))
~~~

## TODO 0725

- File path: `src/Pages/Page 67079 - Promotores - Lista de Colegios.al`
- Object type: Page
- Object ID: 67079
- Object name: `Promotores - Lista de Colegios`
- Line number: 68
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    66:                         //TODO: Ver IF Promotor <> '' THEN
    67:                         //TODO: Ver     FuncAPS.LlenaPromotorColegios(Promotor)
    68:                         //TODO: Ver ELSE
    69:                         //TODO: Ver     FuncAPS.LlenaPromotorColegios(GETRANGEMIN("Cod. Promotor"))
    70:                     end;
~~~

## TODO 0726

- File path: `src/Pages/Page 67079 - Promotores - Lista de Colegios.al`
- Object type: Page
- Object ID: 67079
- Object name: `Promotores - Lista de Colegios`
- Line number: 69
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    67:                         //TODO: Ver     FuncAPS.LlenaPromotorColegios(Promotor)
    68:                         //TODO: Ver ELSE
    69:                         //TODO: Ver     FuncAPS.LlenaPromotorColegios(GETRANGEMIN("Cod. Promotor"))
    70:                     end;
    71:                 }
~~~

## TODO 0727

- File path: `src/Pages/Page 67100 - Expositores - Eventos.al`
- Object type: Page
- Object ID: 67100
- Object name: `Expositores - Eventos`
- Line number: 59
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    57:                         PlanEvent: Page 67102;
    58:                     begin
    59:                         //TODO: Ver PlanEvent.RecibeParametros("Cod. Expositor", "Tipo de Expositor", "Cod. Evento", CabPlanEvent."Tipo Evento");
    60:                         CabPlanEvent.RESET;
    61:                         CabPlanEvent.SETRANGE("Cod. Taller - Evento", "Cod. Evento");
~~~

## TODO 0728

- File path: `src/Pages/Page 67111 - Adopciones - Colegio - MRK.al`
- Object type: Page
- Object ID: 67111
- Object name: `Adopciones - Colegio - MRK`
- Line number: 65
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    63:                     Caption = '4INI';
    64:                     Editable = false;
    65:                     //TODO: Ver OptionCaption = ' ,Conquest,Keep,Lost,Retired';
    66: 
    67:                     trigger OnAssistEdit()
~~~

## TODO 0729

- File path: `src/Pages/Page 67116 - Hist Colegio - Docentes.al`
- Object type: Page
- Object ID: 67116
- Object name: `Hist Colegio - Docentes`
- Line number: 112
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   110:                         Estad: Page 67119;
   111:                     begin
   112:                         //TODO: Ver Estad.RecibeParametros("Cod. Docente","Cod. Colegio");
   113:                         Estad.RUN;
   114:                         CLEAR(Estad);
~~~

## TODO 0730

- File path: `src/Pages/Page 67118 - Inventarios Colegios ListPart.al`
- Object type: Page
- Object ID: 67118
- Object name: `Inventarios Colegios ListPart`
- Line number: 11
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
     9:         area(content)
    10:         {
    11:             //TODO: Ver  
    12:             /*
    13:             field(FuncAPSColCalcInvMuestrasNo; FuncAPS.ColCalcInvMuestras(Rec."No."))
~~~

## TODO 0731

- File path: `src/Pages/Page 67118 - Inventarios Colegios ListPart.al`
- Object type: Page
- Object ID: 67118
- Object name: `Inventarios Colegios ListPart`
- Line number: 41
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    39: 
    40:     var
    41:     //TODO: Ver FuncAPS: Codeunit 55467;
    42: }
    43: 
~~~

## TODO 0732

- File path: `src/Pages/Page 67166 - Ficha de Atenciones.al`
- Object type: Page
- Object ID: 67166
- Object name: `Ficha de Atenciones`
- Line number: 102
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
   100:             {
   101:                 Editable = wMod;
   102:                 //TODO: Ver SubPageLink = "Cab. Atencion" = FIELD("Codigo");
   103:             }
   104:         }
~~~

## TODO 0733

- File path: `src/Pages/Page 67170 - Documentos operac. comerciales.al`
- Object type: Page
- Object ID: 67170
- Object name: `Documentos operac. comerciales`
- Line number: 5
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
     3:     PageType = List;
     4:     SourceTable = 55469;
     5:     //TODO: Ver SourceTableView = WHERE("Tipo registro" = CONST(28));
     6: 
     7:     layout
~~~

## TODO 0734

- File path: `src/Pages/Page 67183 - Area Curricular - APS.al`
- Object type: Page
- Object ID: 67183
- Object name: `Area Curricular - APS`
- Line number: 5
- Classification: Missing page property
- Proposed correction: Restore this property only as part of its complete property block after verifying the referenced source and destination fields and preserving the original filter or display semantics.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
     3:     PageType = List;
     4:     SourceTable = 55469;
     5:     //TODO: Ver SourceTableView = WHERE("Tipo registro" = CONST(29));
     6: 
     7:     layout
~~~

## TODO 0735

- File path: `src/Pages/Page 75001 - Datos MDM.al`
- Object type: Page
- Object ID: 75001
- Object name: `Datos MDM`
- Line number: 60
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    58:     trigger OnDeleteRecord(): Boolean
    59:     begin
    60:         //TODO: Ver wEditable := cFunMdm.GetEditableErr(FORMAT(wTipo));
    61:     end;
    62: 
~~~


## TODO 0736

- File path: `src/Pages/Page 75001 - Datos MDM.al`
- Object type: Page
- Object ID: 75001
- Object name: `Datos MDM`
- Line number: 65
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    63:     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    64:     begin
    65:         //TODO: Ver wEditable := cFunMdm.GetEditableErr(FORMAT(wTipo));
    66:     end;
    67: 
~~~

## TODO 0737

- File path: `src/Pages/Page 75001 - Datos MDM.al`
- Object type: Page
- Object ID: 75001
- Object name: `Datos MDM`
- Line number: 70
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    68:     trigger OnModifyRecord(): Boolean
    69:     begin
    70:         //TODO: Ver wEditable := cFunMdm.GetEditableErr(FORMAT(wTipo));
    71:     end;
    72: 
~~~

## TODO 0738

- File path: `src/Pages/Page 75001 - Datos MDM.al`
- Object type: Page
- Object ID: 75001
- Object name: `Datos MDM`
- Line number: 79
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    77:             wTipo := GETRANGEMIN(Tipo);
    78:         ActualizaTipo;
    79:         //TODO: Ver wEditable := cFunMdm.GetEditable;
    80:         CurrPage.EDITABLE := wEditable;
    81:     end;
~~~

## TODO 0739

- File path: `src/Pages/Page 75001 - Datos MDM.al`
- Object type: Page
- Object ID: 75001
- Object name: `Datos MDM`
- Line number: 85
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    83:     var
    84:         wTipo: Option "Tipo Producto",Soporte,Editora,Nivel,"Plan Editorial",Autor,Ciclo,Linea,Asignatura,Grado,Sello,"Edicion",Estado,"Campaña";
    85:         //TODO: Ver cFunMdm: Codeunit 75000;
    86:         wEditable: Boolean;
    87: 
~~~

## TODO 0740

- File path: `src/Pages/Page 75002 - Estructura Analitica.al`
- Object type: Page
- Object ID: 75002
- Object name: `Estructura Analitica`
- Line number: 38
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    36:     trigger OnDeleteRecord(): Boolean
    37:     begin
    38:         //TODO: Ver wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    39:     end;
    40: 
~~~

## TODO 0741

- File path: `src/Pages/Page 75002 - Estructura Analitica.al`
- Object type: Page
- Object ID: 75002
- Object name: `Estructura Analitica`
- Line number: 43
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    41:     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    42:     begin
    43:         //TODO: Ver wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    44:     end;
    45: 
~~~

## TODO 0742

- File path: `src/Pages/Page 75002 - Estructura Analitica.al`
- Object type: Page
- Object ID: 75002
- Object name: `Estructura Analitica`
- Line number: 48
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    46:     trigger OnModifyRecord(): Boolean
    47:     begin
    48:         //TODO: Ver wEditable := cFunMdm.GetEditableErr(TABLECAPTION);
    49:     end;
    50: 
~~~

## TODO 0743

- File path: `src/Pages/Page 75002 - Estructura Analitica.al`
- Object type: Page
- Object ID: 75002
- Object name: `Estructura Analitica`
- Line number: 53
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    51:     trigger OnOpenPage()
    52:     begin
    53:         //TODO: Ver wEditable := cFunMdm.GetEditable;
    54:         CurrPage.EDITABLE := wEditable;
    55:     end;
~~~

## TODO 0744

- File path: `src/Pages/Page 75002 - Estructura Analitica.al`
- Object type: Page
- Object ID: 75002
- Object name: `Estructura Analitica`
- Line number: 58
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    56: 
    57:     var
    58:         //TODO: Ver cFunMdm: Codeunit 75000;
    59:         wEditable: Boolean;
    60: }
~~~

## TODO 0745

- File path: `src/Pages/Page 75005 - Imp.MdM Campos.al`
- Object type: Page
- Object ID: 75005
- Object name: `Imp.MdM Campos`
- Line number: 35
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    33:                 {
    34:                 }
    35:                 //TODO: Ver 
    36:                 /*
    37:                 field(cFumImp.GetFieldCaption("Table Id","Id Field");
~~~

## TODO 0746

- File path: `src/Pages/Page 75005 - Imp.MdM Campos.al`
- Object type: Page
- Object ID: 75005
- Object name: `Imp.MdM Campos`
- Line number: 63
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    61: 
    62:     var
    63:     //TODO: Ver cFumImp: Codeunit 75001;
    64: }
    65: 
~~~

## TODO 0747

- File path: `src/Pages/Page 75006 - Conf. Tipologias MdM.al`
- Object type: Page
- Object ID: 75006
- Object name: `Conf. Tipologias MdM`
- Line number: 125
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   123:         lwNo: Integer;
   124:     begin
   125:         //TODO: Ver wEditable := cFunMdm.GetEditable;
   126:         CurrPage.EDITABLE := wEditable;
   127: 
~~~

## TODO 0748

- File path: `src/Pages/Page 75006 - Conf. Tipologias MdM.al`
- Object type: Page
- Object ID: 75006
- Object name: `Conf. Tipologias MdM`
- Line number: 140
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   138:     var
   139:         wEditable: Boolean;
   140:         //TODO: Ver cFunMdm: Codeunit 75000;
   141:         wRefEnbl1: Boolean;
   142:         wRefEnbl2: Boolean;
~~~

## TODO 0749

- File path: `src/Pages/Page 75008 - Conf.Filtros Tipologias MdM.al`
- Object type: Page
- Object ID: 75008
- Object name: `Conf.Filtros Tipologias MdM`
- Line number: 45
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    43:     trigger OnOpenPage()
    44:     begin
    45:         //TODO: Ver wEditable := cFunMdm.GetEditable;
    46:         CurrPage.EDITABLE := wEditable;
    47:     end;
~~~

## TODO 0750

- File path: `src/Pages/Page 75008 - Conf.Filtros Tipologias MdM.al`
- Object type: Page
- Object ID: 75008
- Object name: `Conf.Filtros Tipologias MdM`
- Line number: 50
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    48: 
    49:     var
    50:         //TODO: Ver cFunMdm: Codeunit 75000;
    51:         rCampos: Record 75008;
    52:         wEditable: Boolean;
~~~


## TODO 0751

- File path: `src/Pages/Page 75011 - Tipo Filtros Tipologia MdM.al`
- Object type: Page
- Object ID: 75011
- Object name: `Tipo Filtros Tipologia MdM`
- Line number: 36
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    34: 
    35:     var
    36:     //TODO: Ver cFunMdM: Codeunit 75000;
    37: 
    38:     procedure RellenaTabla(pwTipo: Option Dimension,"Dato MdM",Otros)
~~~

## TODO 0752

- File path: `src/Pages/Page 75011 - Tipo Filtros Tipologia MdM.al`
- Object type: Page
- Object ID: 75011
- Object name: `Tipo Filtros Tipologia MdM`
- Line number: 47
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    45:         DELETEALL;
    46: 
    47:         //TODO: Ver 
    48:         /*
    49:         CASE pwTipo OF
~~~

## TODO 0753

- File path: `src/Pages/Page 75012 - Valores Filtros Tipologia MdM.al`
- Object type: Page
- Object ID: 75012
- Object name: `Valores Filtros Tipologia MdM`
- Line number: 35
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    33:     var
    34:         wId: Integer;
    35:     //TODO: Ver cFunMdM: Codeunit 75000;
    36: 
    37:     procedure RellenaTabla(pwIdFiltro: Integer)
~~~

## TODO 0754

- File path: `src/Pages/Page 75012 - Valores Filtros Tipologia MdM.al`
- Object type: Page
- Object ID: 75012
- Object name: `Valores Filtros Tipologia MdM`
- Line number: 43
- Classification: Renamed standard object, field, method, enum, or property
- Proposed correction: Use AL symbol search to confirm the current standard object and member signature, then update only the flagged reference while preserving its original call or page behavior.
- Compile risk: Medium
- Functional risk: Medium
- Confidence: Medium
- Surrounding code:

~~~al
    41:         lwCodDim: Code[20];
    42:         lrValDim: Record 349;
    43:     //TODO: Ver lrCodGrProd: Record 5723;
    44:     begin
    45:         // RellenaTabla
~~~

## TODO 0755

- File path: `src/Pages/Page 75012 - Valores Filtros Tipologia MdM.al`
- Object type: Page
- Object ID: 75012
- Object name: `Valores Filtros Tipologia MdM`
- Line number: 54
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    52:                 lrFiltroTipo.Tipo::Dimension:
    53:                     BEGIN
    54:                         //TODO: Ver lwCodDim := cFunMdM.GetDimCode(lrFiltroTipo."Valor Id", TRUE);
    55:                         CLEAR(lrValDim);
    56:                         lrValDim.SETRANGE("Dimension Code", lwCodDim);
~~~

## TODO 0756

- File path: `src/Pages/Page 75012 - Valores Filtros Tipologia MdM.al`
- Object type: Page
- Object ID: 75012
- Object name: `Valores Filtros Tipologia MdM`
- Line number: 73
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    71:                         END;
    72:                     END;
    73:             //TODO: Ver 
    74:             /*
    75:         lrFiltroTipo.Tipo::Otros:
~~~

## TODO 0757

- File path: `src/Pages/Page 75013 - Filtro Campo.al`
- Object type: Page
- Object ID: 75013
- Object name: `Filtro Campo`
- Line number: 44
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    42: 
    43:     var
    44:     //TODO: Ver cFunMdm: Codeunit 75000;
    45: 
    46:     procedure RellenaTemp(pwTableId: Integer)
~~~

## TODO 0758

- File path: `src/Pages/Page 75013 - Filtro Campo.al`
- Object type: Page
- Object ID: 75013
- Object name: `Filtro Campo`
- Line number: 69
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    67:             UNTIL lrFields.NEXT = 0;
    68:         END;
    69:         //TODO: Ver 
    70:         /*
    71:         CASE pwTableId OF
~~~

## TODO 0759

- File path: `src/Pages/Page 75013 - Filtro Campo.al`
- Object type: Page
- Object ID: 75013
- Object name: `Filtro Campo`
- Line number: 100
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    98:                     BEGIN // Dimensiones
    99:                         lwIdDim := -(pwIdField + 200);
   100:                         //TODO: Ver cFunMdm.GetDimCode(lwIdDim, TRUE);
   101:                     END;
   102:             END;
~~~

## TODO 0760

- File path: `src/Pages/Page 75014 - Filtro Valor Campo.al`
- Object type: Page
- Object ID: 75014
- Object name: `Filtro Valor Campo`
- Line number: 40
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    38:         Text001: Label 'El tipo de dato %1 no está permitido. Campo %2';
    39:         Text002: Label '%1 No es un valor permitido para %2.\ Los valores permitidos son %3';
    40:     //TODO: Ver cFunMdM: Codeunit 75000;
    41: 
    42:     procedure RellenaTemp()
~~~

## TODO 0761

- File path: `src/Pages/Page 75014 - Filtro Valor Campo.al`
- Object type: Page
- Object ID: 75014
- Object name: `Filtro Valor Campo`
- Line number: 83
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    81:                     BEGIN // Dimensiones
    82:                         lwIdDim := -(lwFieldNo + 200);
    83:                         //TODO: Ver lwCodDim := cFunMdM.GetDimCode(lwIdDim, TRUE);
    84:                         CLEAR(lrValDim);
    85:                         lrValDim.SETRANGE("Dimension Code", lwCodDim);
~~~

## TODO 0762

- File path: `src/Pages/Page 75014 - Filtro Valor Campo.al`
- Object type: Page
- Object ID: 75014
- Object name: `Filtro Valor Campo`
- Line number: 163
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   161:                     pwIdfVal := 2;  // Codigo
   162:                     pwIdfDesc := 3;  // Descripcion
   163:                     //TODO: Ver lwFieldRf := pwRelRf.FIELD("1");
   164:                     //lwOptionValue := lwFieldRf.OPTIONCAPTION;
   165:                     lwOptionValue := lwFieldRf.OPTIONSTRING;
~~~

## TODO 0763

- File path: `src/Pages/Page 75014 - Filtro Valor Campo.al`
- Object type: Page
- Object ID: 75014
- Object name: `Filtro Valor Campo`
- Line number: 185
- Classification: Functional ambiguity
- Proposed correction: Inspect the complete disabled or flagged logic and confirm the intended page behavior before restoring or changing it; leave the TODO in place until that review is complete.
- Compile risk: Medium
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   183:                     pwIdfVal := 2;  // Codigo
   184:                     pwIdfDesc := 3;  // Descripcion
   185:                     //TODO: Ver lwFieldRf := pwRelRf.FIELD("1");
   186:                     //lwOptionValue := lwFieldRf.OPTIONCAPTION;
   187:                     lwOptionValue := lwFieldRf.OPTIONSTRING;
~~~

## TODO 0764

- File path: `src/Pages/Page 75014 - Filtro Valor Campo.al`
- Object type: Page
- Object ID: 75014
- Object name: `Filtro Valor Campo`
- Line number: 244
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   242:                     BEGIN // Dimensiones
   243:                         lwIdDim := -(pwIdField + 200);
   244:                         //TODO: Ver cFunMdM.GetDimCode(lwIdDim, TRUE);
   245:                     END;
   246:             END;
~~~

## TODO 0765

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 85
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    83:                         trigger OnAction()
    84:                         begin
    85:                             //TODO: Ver cImpExcel.ImportaFile(FALSE, 0);
    86:                         end;
    87:                     }
~~~


## TODO 0766

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 94
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    92:                         trigger OnAction()
    93:                         begin
    94:                             //TODO: Ver cImpExcel.ImportaFile(TRUE, 0);
    95:                         end;
    96:                     }
~~~

## TODO 0767

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 119
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   117:                         Image = Save;
   118: 
   119:                         //TODO: Ver 
   120:                         /*
   121:                         trigger OnAction()
~~~

## TODO 0768

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 137
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   135:                         Enabled = wBlobEnabled2;
   136:                         Image = Save;
   137:                         //TODO: Ver 
   138:                         /*
   139:                         trigger OnAction()
~~~

## TODO 0769

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 155
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
   153:                         Enabled = wBlobEnabled3;
   154:                         Image = Save;
   155:                         //TODO: Ver 
   156:                         /*
   157:                         trigger OnAction()
~~~

## TODO 0770

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 176
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   174:                     trigger OnAction()
   175:                     begin
   176:                         //TODO: Ver cMaestrosMdm.TrasPasaCab(Rec);
   177:                     end;
   178:                 }
~~~

## TODO 0771

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 192
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   190: 
   191:     var
   192:         //TODO: Ver cImpExcel: Codeunit 75002;
   193:         //TODO: Ver cMaestrosMdm: Codeunit 75001;
   194:         cFileMng: Codeunit 419;
~~~

## TODO 0772

- File path: `src/Pages/Page 75016 - Importaciones MdM.al`
- Object type: Page
- Object ID: 75016
- Object name: `Importaciones MdM`
- Line number: 193
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
   191:     var
   192:         //TODO: Ver cImpExcel: Codeunit 75002;
   193:         //TODO: Ver cMaestrosMdm: Codeunit 75001;
   194:         cFileMng: Codeunit 419;
   195:         wBlobEnabled1: Boolean;
~~~

## TODO 0773

- File path: `src/Pages/Page 75017 - Lista Imp.Mdm Tabla.al`
- Object type: Page
- Object ID: 75017
- Object name: `Lista Imp.Mdm Tabla`
- Line number: 28
- Classification: Functional ambiguity
- Proposed correction: Review the entire surrounding disabled block and its matching control-flow boundaries before deciding whether any line should be restored; this marker is not independently actionable.
- Compile risk: High
- Functional risk: High
- Confidence: Low
- Surrounding code:

~~~al
    26:                 {
    27:                 }
    28:                 //TODO: Ver 
    29:                 /*
    30:                 field(Campo;
~~~

## TODO 0774

- File path: `src/Pages/Page 75017 - Lista Imp.Mdm Tabla.al`
- Object type: Page
- Object ID: 75017
- Object name: `Lista Imp.Mdm Tabla`
- Line number: 98
- Classification: Custom dependency
- Proposed correction: Verify the referenced custom object or public method in this extension and confirm its SaaS compatibility before restoring the declaration, call, action, or link unchanged.
- Compile risk: Medium
- Functional risk: High
- Confidence: High
- Surrounding code:

~~~al
    96: 
    97:     var
    98:     //TODO: Ver cFumImp: Codeunit 75001;
    99: }
   100: 
~~~

