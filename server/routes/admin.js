const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");

// api to add product
adminRouter.post("/admin/add-product", admin, async function (req, res) {
  try {
    const { name, description, images, price, quantity, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      price,
      quantity,
      category,
    });

    product = await product.save();

    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get all products
adminRouter.get("/admin/products", admin, async function (req, res) {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// delete a product
adminRouter.post("/admin/delete-product", admin, async function (req, res) {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get all orders
adminRouter.get("/admin/orders", admin, async function (req, res) {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// update order status
adminRouter.post(
  "/admin/update-order-status",
  admin,
  async function (req, res) {
    try {
      const { id, status } = req.body;
      let order = await Order.findByIdAndDelete(id);
      order.status = status;
      order = await order.save();

      res.json(order);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

// get analytics
adminRouter.get("/admin/analytics", admin, async function (req, res) {
  try {
    const orders = await Order.find({});

    let totalEarnings = 0;
    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].price * orders[i].products[j].product.price;
      }
    }

    let mobileEarnings = await fetchCategoryEarnings('Mobiles');
    let essentialsEarnings = await fetchCategoryEarnings('Essentials');
    let appliancesEarnings = await fetchCategoryEarnings('Appliances');
    let booksEarnings = await fetchCategoryEarnings('Books');
    let fashionEarnings = await fetchCategoryEarnings('Fashion');

    let earnings = {
      totalEarnings,
      mobileEarnings,
      essentialsEarnings,
      appliancesEarnings,
      booksEarnings,
      fashionEarnings
    };

    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryEarnings(category) {
  let earnings = 0;

  let categoryOrders = await Order.find({
    "products.product.category": category,
  });
  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].price *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = adminRouter;
