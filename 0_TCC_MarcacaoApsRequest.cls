/*******************************************************************************
 * @company: Globant Brasil 
 * @author: Filippe de Araujo Nunes
 * @project: Sulamerica
 * @Description: Body request para atualização de marcações.
 * @version
 * -------------------------------------
No. 	  Data 				 Autor 			  Descrição
------ ---------- -------------------------- ----------------------------
1.0    18/05/2021  Filippe de Araujo Nunes	  Versão inicial.

*******************************************************************************/
global with sharing class TCC_MarcacaoApsRequest {

    global class CONTA {
        global List<DETALHESCONTA> req;
    }
    
    global class DETALHESCONTA{
        global String accountId;
        global String dataUltimaConsulta;
        global String codigoPrestador;
    }
}