import React, { useState, useEffect } from "react";

import CommonSection from "../components/UI/common-section/CommonSection";
import Helmet from "../components/Helmet/Helmet";
import "../styles/cart-page.css";
import { useSelector, useDispatch } from "react-redux";
import { Container, Row, Col } from "reactstrap";
import { cartActions } from "../store/shopping-cart/cartSlice";
import { Link } from "react-router-dom";
import { useContext } from "react";
import { CartContext, UserContext } from "../context";

const Cart = () => {
  const {carts, setCarts} = useContext(CartContext);
  const {user, setUser} = useContext(UserContext);

  const totalAmount = (cart) => {
    return cart.reduce((sum, item) => {
      return sum + item.quantity * item.price
    }, 0)
  }

  return (
    <Helmet title="Cart">
      <CommonSection title="Your Cart" />
      <section>
        <Container>
          <Row>
            <Col lg="12">
              {carts.length === 0 ? (
                <h5 className="text-center">Your cart is empty</h5>
              ) : (
                <table className="table table-bordered">
                  <thead>
                    <tr>
                      <th>Image</th>
                      <th>Product Title</th>
                      <th>Price</th>
                      <th>Quantity</th>
                      <th>Delete</th>
                    </tr>
                  </thead>
                  <tbody>
                    {carts.map((item) => (
                      <Tr item={item} key={item.id}/>
                    ))}
                  </tbody>
                </table>
              )}

              <div className="mt-4">
                <h6>
                  Subtotal: $
                  <span className="cart__subtotal">{totalAmount(carts)}</span>
                </h6>
                <p>Taxes and shipping will calculate at checkout</p>
                <div className="cart__page-btn">
                  <button className="addTOCart__btn me-4">
                    <Link to="/foods">Continue Shopping</Link>
                  </button>
                  <button className="addTOCart__btn">
                    <Link to={user.id !== undefined ? "/checkout" : "/login"}>Proceed to checkout</Link>
                  </button>
                </div>
              </div>
            </Col>
          </Row>
        </Container>
      </section>
    </Helmet>
  );
};

const Tr = (props) => {
  const { id, name, image, price, quantity } = props.item;
  const {carts, setCarts} = useContext(CartContext);
  const {user, setUser} = useContext(UserContext);

  var getCarts = async () => {
    await fetch(`http://localhost:8000/api/user/${user.id}/cart`)
      .then((res) => res.json())
      .then((data) => {
        setCarts(data)
      })
  }

  const deleteItem = async () => {
    console.log(user.id);
    if (user.id !== undefined) {
      await fetch(`http://localhost:8000/api/user/${user.id}/cart/${id}`, {
        method: 'DELETE',
      })
      getCarts()
    }
    else {
      const index = carts.findIndex((item) => {
        return item.id === id;
      });
      
      let newCart = [...carts];
      newCart = newCart.filter((cart) => cart.id !== newCart[index].id);
      setCarts(newCart)
    }
  };
  return (
    <tr>
      <td className="text-center cart__img-box">
        <img src={"http://localhost:8000" + image} alt="" />
      </td>
      <td className="text-center">{name}</td>
      <td className="text-center">${price}</td>
      <td className="text-center">{quantity}</td>
      <td className="text-center cart__item-del">
        <i className="ri-delete-bin-line" onClick={deleteItem}></i>
      </td>
    </tr>
  );
};

export default Cart;
