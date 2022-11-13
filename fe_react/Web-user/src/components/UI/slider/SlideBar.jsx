import React, { useRef, useState, useEffect } from "react";
import "../../../styles/slidebar.scss";
const AdminPage = () => {
  return (
    <div className="slidebar-container">
      <div className="logo">
        <img
          src="http://localhost:3000/static/media/bannerImg.9d66662d.png"
          alt=""
        />
        <h3 className="logo-name">Foody</h3>
      </div>
      <ul className="menu-choice">
        <li class='menu-item'>
          <a href="">
            <i class="ri-shopping-basket-line"></i>
            <span>Customer</span>
          </a>
        </li>
        <li class='menu-item'>
          <a href="">
            <i class="ri-shopping-basket-line"></i>
            <span>Orders</span>
          </a>
        </li>
        <li class='menu-item'>
          <a href="">
            <i class="ri-shopping-basket-line"></i>
            <span>Product</span>
          </a>
        </li>
        <li class='menu-item'>
          <a href="">
            <i class="ri-shopping-basket-line"></i>
            <span>Vouchers</span>
          </a>
        </li>
        <li class='menu-item'>
          <a href="">
            <i class="ri-shopping-basket-line"></i>
            <span>Revenue</span>
          </a>
        </li>
        <li class='menu-item'>
          <a href="">
            <i class="ri-shopping-basket-line"></i>
            <span>Logout</span>
          </a>
        </li>
      </ul>
    </div>
  );
};

export default AdminPage;
