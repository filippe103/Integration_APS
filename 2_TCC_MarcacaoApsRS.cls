/*******************************************************************************
 * @company: Globant Brasil 
 * @author: Filippe de Araujo Nunes
 * @project: Sulamerica
 * @Description: Classe para expor o serviço de endpoint.
 * @version
 * -------------------------------------
No. 	  Data 				 Autor 			  Descrição
------ ---------- -------------------------- ----------------------------
1.0    18/05/2021  Filippe de Araujo Nunes	  Versão inicial.

*******************************************************************************/
@RestResource(urlMapping='/marcacaoAps/*')
global with sharing class TCC_MarcacaoApsRS {
    
    @HttpPost
    global static List<TCC_MarcacaoApsResponse> aplicarMarcacao() {
        TCC_MarcacaoApsService service = new TCC_MarcacaoApsService();
        return service.marcarAccountsAps();
    }
}