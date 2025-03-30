@RestResource(urlMapping='/lacoreconnect/webhook/*')
global with sharing class WebhookRestResource {
    
    @HttpPost
    global static void handleWebhook() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        try {
            // Get the webhook payload
            String payload = req.requestBody.toString();
            
            // Get the webhook signature for verification
            String signature = req.headers.get('X-Webhook-Signature');
            
            // Verify webhook signature
            if (!WebhookService.verifySignature(payload, signature)) {
                res.statusCode = 401;
                res.responseBody = Blob.valueOf('Invalid signature');
                return;
            }
            
            // Process the webhook
            WebhookService.processWebhook(payload);
            
            // Return success response
            res.statusCode = 200;
            res.responseBody = Blob.valueOf('Webhook processed successfully');
            
        } catch (Exception e) {
            // Log the error
            System.debug('Webhook processing error: ' + e.getMessage());
            
            // Return error response
            res.statusCode = 500;
            res.responseBody = Blob.valueOf('Error processing webhook: ' + e.getMessage());
        }
    }
} 