@istest
public class TCC_MarcacaoApsTest {

    public static final String CONST_URL = 'https://sulamericatest/services/apexrest/marcacaoAps';
    
    @TestSetup
    static void inclusaoDados(){
        Account objConta = new Account(Name = 'Paciente Test', COD_BENEF_UNICO__c = 123456);
        insert objConta;
    }

    /**
     * @author Everton da Silva Nascimento
     * @date 18/05/2021
     * @description teste sucesso atualização dos campos codigo prestador e data última consulta.
     */
    @istest
    public static void AtualizarMarcacaoAccountsApsSucesso() {
        
        String jsonBody = '{"req":[{"accountId": "' + [SELECT id FROM Account LIMIT 1].Id + '","dataUltimaConsulta": "2021-05-12","codigoPrestador": "teste"}]}';

        Test.startTest();
		RestRequest request = new RestRequest();
        request.requestURI = CONST_URL;
		request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;

        List<TCC_MarcacaoApsResponse> response = TCC_MarcacaoApsRS.aplicarMarcacao();
        Test.stopTest();
        
        system.assertEquals('Sucesso', response.get(0).status);
    }

    /**
     * @author Everton da Silva Nascimento
     * @date 18/05/2021
     * @description teste falha atualização da conta pelo id está incorreto.
     */
    @istest
    public static void AtualizarMarcacaoAccountsApsfalhaIdContaIncorreto() {
        
        String jsonBody = '{"req":[{"accountId": "teste","dataUltimaConsulta": "2021-05-12","codigoPrestador": "teste"}]}';

        Test.startTest();
		RestRequest request = new RestRequest();
        request.requestURI = CONST_URL;
		request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;

        List<TCC_MarcacaoApsResponse> response = TCC_MarcacaoApsRS.aplicarMarcacao();
        Test.stopTest();
        
        system.assertEquals('Falha', response.get(0).status);
    }

    /**
     * @author Everton da Silva Nascimento
     * @date 18/05/2021
     * @description teste falha atualização de conta não encontrada.
     */
    @istest
    public static void AtualizarMarcacaoAccountsApsfalhaIdContaNaoEncontrada() {
        
        String jsonBody = '{"req":[{"accountId": "0015500001IM8p8AAD","dataUltimaConsulta": "2021-05-12","codigoPrestador": "teste"}]}';

        Test.startTest();
		RestRequest request = new RestRequest();
        request.requestURI = CONST_URL;
		request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;

        List<TCC_MarcacaoApsResponse> response = TCC_MarcacaoApsRS.aplicarMarcacao();
        Test.stopTest();
        
        system.assertEquals('Falha', response.get(0).status);
    }

    /**
     * @author Everton da Silva Nascimento
     * @date 18/05/2021
     * @description teste falha atualização de conta campo não preenchido.
     */
    @istest
    public static void AtualizarMarcacaoAccountsApsfalhaIdContaNaoPreenchido() {
        
        String jsonBody = '{"req":[{"accountId": "' + [SELECT id FROM Account LIMIT 1].Id + '","dataUltimaConsulta": "2021-05-12","codigoPrestador": ""}]}';

        Test.startTest();
		RestRequest request = new RestRequest();
        request.requestURI = CONST_URL;
		request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;

        List<TCC_MarcacaoApsResponse> response = TCC_MarcacaoApsRS.aplicarMarcacao();
        Test.stopTest();
        
        system.assertEquals('Falha', response.get(0).status);
    }

    /**
     * @author Everton da Silva Nascimento
     * @date 18/05/2021
     * @description teste falha atualização de conta data incorreta.
     */
    @istest
    public static void AtualizarMarcacaoAccountsApsfalhaIdContaDataIncorreta() {
        
        String jsonBody = '{"req":[{"accountId": "' + [SELECT id FROM Account LIMIT 1].Id + '","dataUltimaConsulta": "2021-32-12","codigoPrestador": "teste"}]}';

        Test.startTest();
		RestRequest request = new RestRequest();
        request.requestURI = CONST_URL;
		request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;

        List<TCC_MarcacaoApsResponse> response = TCC_MarcacaoApsRS.aplicarMarcacao();
        Test.stopTest();
        
        system.assertEquals('Falha', response.get(0).status);
    }

    /**
     * @author Everton da Silva Nascimento
     * @date 18/05/2021
     * @description teste falha atualização duas conta uma correta e outra incorreta.
     */
    @istest
    public static void AtualizarMarcacaoAccountsApsfalhaContas() {
        
        String jsonBody = '{"req":[{"accountId": "' + [SELECT id FROM Account LIMIT 1].Id + '","dataUltimaConsulta": "2021-32-12","codigoPrestador": "teste"},{"accountId": "0015500001IM8p8AA1","dataUltimaConsulta": "2021-05-12","codigoPrestador": "teste"}]}';

        Test.startTest();
		RestRequest request = new RestRequest();
        request.requestURI = CONST_URL;
		request.httpMethod = 'POST';
        request.requestBody = Blob.valueOf(jsonBody);
        RestContext.request = request;

        List<TCC_MarcacaoApsResponse> response = TCC_MarcacaoApsRS.aplicarMarcacao();
        Test.stopTest();
    }
}