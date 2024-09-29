package com.example.model;

public class Product {
    private int product_id;
    private String product_name;
    private double category;

    // Getters and setters
    public int getId() {
        return product_id;
    }

    public void setId(int id) {
        this.product_id = product_id;
    }

    public String getName() {
        return product_name;
    }

    public void setName(String name) {
        this.product_name = product_name;
    }

    public double getPrice() {
        return category;
    }

    public void setPrice(double price) {
        this.category = category;
    }
}
