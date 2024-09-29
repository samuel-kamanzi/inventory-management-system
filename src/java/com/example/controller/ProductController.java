package com.example.controller;

import com.example.dao.ProductDao;
import com.example.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.List;

@Controller
public class ProductController {

    @Autowired
    private ProductDao productDao;

    @RequestMapping("/products")
    public String listProducts(Model model) {
        List<Product> products = productDao.getAllProducts();
        model.addAttribute("products", products);
        return "productList";
    }
}
