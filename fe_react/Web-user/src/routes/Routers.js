import React from "react";
import { Routes, Route, Navigate } from "react-router-dom";

import Home from "../pages/Home";
import AllFoods from "../pages/AllFoods";
import FoodDetails from "../pages/FoodDetails";
import Cart from "../pages/Cart";
import Checkout from "../pages/Checkout";
import Contact from "../pages/Contact";
import Login from "../pages/Login";
import Register from "../pages/Register";
import AddProduct from "../pages/Admin/Products/AddProduct";
import Products from "../pages/Admin/Products/Products";
import AdminCategory from "../pages/Admin/Category/Categories";
import AddCategory from "../pages/Admin/Category/AddCategory";
import AdminOrder from "../pages/Admin/Orders/Orders";
import AdminRating from "../pages/Admin/Rating/Rating";
import AdminCustomer from "../pages/Admin/Customer/Customer";
const Routers = () => {
  return (
    <Routes>
      <Route path="/" element={<Navigate to="/home" />} />
      <Route path="/home" element={<Home />} />
      <Route path="/foods" element={<AllFoods />} />
      <Route path="/foods/:id" element={<FoodDetails />} />
      <Route path="/cart" element={<Cart />} />
      <Route path="/checkout" element={<Checkout />} />
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route path="/contact" element={<Contact />} />

      {/* Admin */}
      <Route path="/admin" element={<Products />} />
      <Route path="/admin/products" element={<Products />} />
      <Route path="/admin/addProduct" element={<AddProduct />} />
      <Route path="/admin/categories" element={<AdminCategory />} />
      <Route path="/admin/addCategory" element={<AddCategory />} />
      <Route path="/admin/orders" element={<AdminOrder />} />
      <Route path="/admin/rating" element={<AdminRating />} />
      <Route path="/admin/customers" element={<AdminCustomer />} />
      {/* <Route path="/admin/information" element={<AddProduct />} /> */}
    </Routes>
  );
};

export default Routers;
