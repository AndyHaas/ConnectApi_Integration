@IsTest
private class GetBrandActionTest {
    @IsTest
    static void testExecute() {        
        List<GetBrandAction.GetBrandResponse> responses = GetBrandAction.execute(new List<GetBrandAction.GetBrandRequest>{});
        
        System.assertNotEquals(null, responses);
        System.assertEquals(1, responses.size());
        System.assertEquals(true, responses[0].success);
    }
} 