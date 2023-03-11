const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");

// add product to cart
userRouter.post("/api/add-to-cart", auth, async function (req, res) {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);

    let user = await User.findById(req.user);
    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
        let productInCart = user.cart.find((c) =>
          c.product._id.equals(product._id)
        );
        productInCart.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }

    user = await user.save();

    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// remove product from cart
userRouter.delete("/api/remove-from-cart/:id", auth, async function (req, res) {
  try {
    const id = req.params.id;
    const product = await Product.findById(id);

    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }

    user = await user.save();

    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// save user address
userRouter.post("/api/save-user-address", auth, async function (req, res) {
  try {
    const id = req.user;
    let user = await User.findById(id);
    user.address = req.body.address;

    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// order a product
userRouter.post("/api/order", autht, async function (req, res) {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart.quantity) {
        product.quantity -= cart.quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res.json({ msg: `${product.name} is out of stock!` });
      }
    }

    let user = User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });

    order = await order.save();

    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get user orders
userRouter.get("/api/orders/me", auth, async function (req, res) {
  try {
    const id = req.user;
    const orders = await Order.find({ userId: id });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = userRouter;
