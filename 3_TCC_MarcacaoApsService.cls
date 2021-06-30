public without sharing class TCC_MarcacaoApsService {
    
    private IRepositoryFactory repositoryFactory = new RepositoryFactory();
    private List<TCC_MarcacaoApsResponse> retorno;

    public TCC_MarcacaoApsService() {

    }

    public List<TCC_MarcacaoApsResponse> marcarAccountsAps(){
        
        String requestBody = RestContext.request.requestBody.toString();
        TCC_MarcacaoApsRequest.CONTA results = (TCC_MarcacaoApsRequest.CONTA) JSON.deserialize(requestBody, TCC_MarcacaoApsRequest.CONTA.class);
        
        Map<String,TCC_MarcacaoApsRequest.DETALHESCONTA> mapIdAccount = new Map<String,TCC_MarcacaoApsRequest.DETALHESCONTA>();
        for ( TCC_MarcacaoApsRequest.DETALHESCONTA marcacao : results.req ) {
            mapIdAccount.put(marcacao.accountId,marcacao);
        }

        IRepository repositoryConta = repositoryFactory.create(Account.SObjectType);
        retorno = new List<TCC_MarcacaoApsResponse>();
        
        Repository.QueryBuilder queryBuilder = new Repository.QueryBuilder()
        .selectFields(new List<String>{'Data_ultima_consulta_APS__c','Prestador_APS__c', 'Id'})
        .whereSpecification( new ContaInternaSpec(mapIdAccount.keySet(), 'Id'));
        
        Map<Id,Account> mapContasEncontradas = new Map<Id,Account>();
        
        try{
            for(Account c : (List<Account>) repositoryConta.queryObjects(queryBuilder)){
                mapContasEncontradas.put(c.Id, c);
            }
        }catch(Exception ex){
            TCC_MarcacaoApsResponse response = new TCC_MarcacaoApsResponse();
            response.mensagem = ex.getMessage();
            response.status = 'Falha';
            retorno.add(response);
            return retorno;
        }
        
        if(!mapContasEncontradas.isEmpty()){

            List<Account> contasAtualizar = new List<Account>(); 
            
            for(TCC_MarcacaoApsRequest.DETALHESCONTA conta : mapIdAccount.values()){
                if(mapContasEncontradas.containsKey(conta.accountId)){
                    if(!String.isBlank(conta.codigoPrestador) && !String.isBlank(conta.dataUltimaConsulta)){
                        try{
                            mapContasEncontradas.get(conta.accountId).Data_ultima_consulta_APS__c   = Date.valueof(conta.dataUltimaConsulta);
                            mapContasEncontradas.get(conta.accountId).Prestador_APS__c              = conta.codigoPrestador;
                            contasAtualizar.add(mapContasEncontradas.get(conta.accountId));
                        }catch(Exception ex){
                            TCC_MarcacaoApsResponse response = new TCC_MarcacaoApsResponse();
                            response.accountId = conta.accountId;
                            response.mensagem = ex.getMessage();
                            response.status = 'Falha';
                            retorno.add(response);
                            return retorno;
                        }
                    }else{
                        TCC_MarcacaoApsResponse campoNaoPreenchido = new TCC_MarcacaoApsResponse();
                        campoNaoPreenchido.accountId    = conta.accountId;
                        campoNaoPreenchido.status       = 'Falha';
                        campoNaoPreenchido.mensagem     =  String.isBlank(conta.codigoPrestador) ? 'O campo data código prestador deve está preenchido.' : 'O campo data última consulta deve está preenchido.';
                        retorno.add(campoNaoPreenchido);
                    }
                }else{
                    TCC_MarcacaoApsResponse contaNaoEncontrada = new TCC_MarcacaoApsResponse();
                    contaNaoEncontrada.accountId    = conta.accountId;
                    contaNaoEncontrada.status       = 'Falha';
                    contaNaoEncontrada.mensagem     = 'Conta não encontrada.';
                    retorno.add(contaNaoEncontrada); 
                }
            }

            if(!contasAtualizar.isEmpty()){
                List<Database.SaveResult> srList = Database.update(contasAtualizar, false);

                for (Database.SaveResult sr : srList) {
                    if(sr.isSuccess()){
                        TCC_MarcacaoApsResponse sucesso = new TCC_MarcacaoApsResponse();
                        sucesso.accountId   = sr.getId();
                        sucesso.status      = 'Sucesso';
                        sucesso.mensagem    = 'Conta atualizada com sucesso.'; 
                        retorno.add(sucesso);
                    }else{
                        for(Database.Error err : sr.getErrors()) {
                            TCC_MarcacaoApsResponse erro = new TCC_MarcacaoApsResponse();
                            erro.status      = 'Falha';
                            erro.mensagem    = err.getMessage();
                            retorno.add(erro);
                        }
                    }
                } 
            }
        }else{
            for(TCC_MarcacaoApsRequest.DETALHESCONTA conta : mapIdAccount.values()){
                TCC_MarcacaoApsResponse contaNaoEncontrada = new TCC_MarcacaoApsResponse();
                contaNaoEncontrada.accountId    = conta.accountId;
                contaNaoEncontrada.status       = 'Falha';
                contaNaoEncontrada.mensagem     = 'Conta não encontrada.';
                retorno.add(contaNaoEncontrada);
            }
        }

        return retorno;
    }
}