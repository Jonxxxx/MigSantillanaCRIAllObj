codeunit 34002529 "Limpiar Conf POS - PELIGRO"
{

    trigger OnRun()
    var
        rTiendas: Record 34002503;
        rCajeros: Record 34002505;
        rGruposCaj: Record 34002507;
        rUsuarios: Record 34002502;
        rBancos: Record 34002504;
        rConf: Record 34002500;
        rConf2: Record 34002501;
        rMenus: Record 34002506;
        rClientes: Record 34002510;
        rBotones: Record 34002511;
        rFpago: Record 34002513;
        rFpago2: Record 34002514;
        rTarj: Record 34002515;
    begin

        rTiendas.DELETEALL(FALSE);
        rCajeros.DELETEALL(FALSE);
        rGruposCaj.DELETEALL(FALSE);
        rUsuarios.DELETEALL(FALSE);
        rBancos.DELETEALL(FALSE);
        rConf.DELETEALL(FALSE);
        rConf2.DELETEALL(FALSE);
        rMenus.DELETEALL(FALSE);
        rClientes.DELETEALL(FALSE);
        rBotones.DELETEALL(FALSE);
        rFpago.DELETEALL(FALSE);
        rFpago2.DELETEALL(FALSE);
        rTarj.DELETEALL(FALSE);
        MESSAGE('ok');
    end;
}

