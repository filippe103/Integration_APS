@RestResource(urlMapping='/marcacaoAps/*')
global with sharing class TCC_MarcacaoApsRS {
    
    @HttpPost
    global static List<TCC_MarcacaoApsResponse> aplicarMarcacao() {
        TCC_MarcacaoApsService service = new TCC_MarcacaoApsService();
        return service.marcarAccountsAps();
    }
}