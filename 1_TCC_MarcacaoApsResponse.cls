/*******************************************************************************
 * @company: Globant Brasil 
 * @author: Filippe de Araujo Nunes
 * @project: Sulamerica
 * @Description: Body response para atualização de marcações.
 * @version
 * -------------------------------------
No. 	  Data 				 Autor 			  Descrição
------ ---------- -------------------------- ----------------------------
1.0    18/05/2021  Filippe de Araujo Nunes	  Versão inicial.

*******************************************************************************/
global with sharing class TCC_MarcacaoApsResponse {
    
    global String accountId;
    global String mensagem;
    global String status;
    
    public TCC_MarcacaoApsResponse( ) {
        this.accountId 			= '';
        this.mensagem           = '';
        this.status 	        = '';
    }
}