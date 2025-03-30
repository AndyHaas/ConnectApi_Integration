@IsTest
private class WebhookServiceTest {
    
    @TestSetup
    static void setup() {
        // Add any test setup if needed
    }
    
    @IsTest
    static void testVerifySignature() {
        Test.startTest();
        
        // Test with valid signature
        Boolean validResult = WebhookService.verifySignature('test payload', 'valid signature');
        System.assertEquals(true, validResult, 'Valid signature should return true');
        
        // Test with blank signature
        Boolean blankResult = WebhookService.verifySignature('test payload', '');
        System.assertEquals(false, blankResult, 'Blank signature should return false');
        
        // Test with null signature
        Boolean nullResult = WebhookService.verifySignature('test payload', null);
        System.assertEquals(false, nullResult, 'Null signature should return false');
        
        Test.stopTest();
    }
    
    @IsTest
    static void testProcessWebhook() {
        Test.startTest();
        
        // Test order.created event
        String orderCreatedPayload = JSON.serialize(new Map<String, Object>{
            'event' => 'order.created',
            'data' => new Map<String, Object>{
                'orderId' => '123',
                'status' => 'new'
            }
        });
        
        WebhookService.processWebhook(orderCreatedPayload);
        
        // Test order.updated event
        String orderUpdatedPayload = JSON.serialize(new Map<String, Object>{
            'event' => 'order.updated',
            'data' => new Map<String, Object>{
                'orderId' => '123',
                'status' => 'processing'
            }
        });
        
        WebhookService.processWebhook(orderUpdatedPayload);
        
        // Test invalid payload
        try {
            WebhookService.processWebhook('invalid json');
            System.assert(false, 'Should have thrown an exception');
        } catch (WebhookService.WebhookProcessingException e) {
            System.assert(e.getMessage().contains('Error processing webhook'), 'Should have thrown WebhookProcessingException');
        }
        
        Test.stopTest();
    }
} 