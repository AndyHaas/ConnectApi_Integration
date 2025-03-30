public class ShipmentDto {
    public String id;
    public String brandId;
    public String warehouseId;
    public String orderId;
    public String trackingNumber;
    public String carrier;
    public String status;
    public DateTime shipDate;
    public DateTime createDateTimeUtc;
    public DateTime modifyDateTimeUtc;
    public List<ShipmentItemDto> items;
} 