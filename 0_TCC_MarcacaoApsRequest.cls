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