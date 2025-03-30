public class WebhookService {
    private static final String WEBHOOK_SECRET = 'YOUR_WEBHOOK_SECRET'; // Store this in Custom Setting or Named Credential
    
    public static Boolean verifySignature(String payload, String signature) {
        if (String.isBlank(signature)) {
            return false;
        }
        
        // Implement signature verification logic here
        // This is a placeholder - you should implement proper HMAC verification
        return true;
    }
    
    public static void processWebhook(String payload) {
        try {
            // Parse the webhook payload
            Map<String, Object> webhookData = (Map<String, Object>)JSON.deserializeUntyped(payload);
            
            // Get the event type
            String eventType = (String)webhookData.get('event');
            
            // Process based on event type
            switch on eventType {
                when 'order.created' {
                    handleOrderCreated(webhookData);
                }
                when 'order.updated' {
                    handleOrderUpdated(webhookData);
                }
                when 'order.cancelled' {
                    handleOrderCancelled(webhookData);
                }
                when 'order.fulfilled' {
                    handleOrderFulfilled(webhookData);
                }
                when else {
                    System.debug('Unhandled event type: ' + eventType);
                }
            }
        } catch (Exception e) {
            System.debug('Error processing webhook: ' + e.getMessage());
            throw new WebhookProcessingException('Error processing webhook: ' + e.getMessage());
        }
    }
    
    private static void handleOrderCreated(Map<String, Object> webhookData) {
        // Implement order creation handling
        // This could involve creating records, triggering flows, etc.
    }
    
    private static void handleOrderUpdated(Map<String, Object> webhookData) {
        // Implement order update handling
    }
    
    private static void handleOrderCancelled(Map<String, Object> webhookData) {
        // Implement order cancellation handling
    }
    
    private static void handleOrderFulfilled(Map<String, Object> webhookData) {
        // Implement order fulfillment handling
    }
    
    public class WebhookProcessingException extends Exception {}
} 