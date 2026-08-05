codeunit 55923 "Limpiar Conf POS - PELIGRO"
{

    trigger OnRun()
    var
        rTiendas: Record 55897;
        rCajeros: Record 55899;
        rGruposCaj: Record 55901;
        rUsuarios: Record 55896;
        rBancos: Record 55898;
        rConf: Record 55894;
        rConf2: Record 55895;
        rMenus: Record 55900;
        rClientes: Record 55904;
        rBotones: Record 55905;
        rFpago: Record 55907;
        rFpago2: Record 55908;
        rTarj: Record 55909;
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

