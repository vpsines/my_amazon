const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const Product = require('../models/product');

// api to add product
adminRouter.post('/admin/add-product',admin, async function(req,res){
    try{
        const {name,description,images,price,quantity,category} = req.body;
        let product = new Product({
            name,
            description,
            images,
            price,
            quantity,
            category
        });

        product = await product.save();

        res.json(product);
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

// get all products 
adminRouter.get('/admin/products',admin,async function(req,res){
    try{
        const products = await Product.find({});
        res.json(products);
    }catch(e){
        res.status(500).json({error: e.message});       
    }
});

// delete a product
adminRouter.post('/admin/delete-product',admin,async function(req,res){
    try{
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports = adminRouter