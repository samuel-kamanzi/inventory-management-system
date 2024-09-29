package model;

/**
 * Represents a product with its details.
 * 
 * @author Samuel
 */
public class ProductModel {
    
    private Long id;
    private String productName;
    private String description;
    private int price;
    private int quantity;

    // Default constructor
    public ProductModel() {
    }

    // Parameterized constructor
    public ProductModel(Long id, String productName, String description, double price, int quantity) {
        this.id = id;
        this.productName = productName;
        this.description = description;
        this.price = (int) price;
        this.quantity = quantity;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = (int) price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "ProductModel{" +
                "id=" + id +
                ", productName='" + productName + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                '}';
    }
}
