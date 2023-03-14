const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const {Product} = require("../models/product");

// get all products
productRouter.get("/api/products", auth, async function (req, res) {
  try {
    const category = req.query.category;
    const products = await Product.find({ category: category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// search for products
productRouter.get(
  "/api/products/search/:name",
  auth,
  async function (req, res) {
    try {
      const searchQuery = req.query.name;
      const products = await Product.find({
        name: {
          $regex: searchQuery,
          $options: "i",
        },
      });
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// rate a product
productRouter.post("/api/rate-product", auth, async function (req, res) {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);
    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings[i].splice(i, 1);
        break;
      }
    }

    const ratingSchema = {
      userId: id,
      rating,
    };

    products.ratings.push(ratingSchema);
    product = await product.save();
    req.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get deals of the day
adminRouter.get("/api/deals-of-day", auth, async function (req, res) {
  try {
    let products = await Product.find({});
    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating;
      }

      return aSum < bSum ? 1 : -1;
    });

    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
