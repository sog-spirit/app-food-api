import React from "react";

import CommonSection from "../components/UI/common-section/CommonSection";
import Helmet from "../components/Helmet/Helmet";
import "../styles/cart-page.css";
import { Container, Row, Col } from "reactstrap";
import { Link } from "react-router-dom";
import { useContext } from "react";
import { CartContext, UserContext } from "../context";
import { useState } from "react";
import { useEffect } from "react";
import Cookies from "js-cookie";

function Order() {
    const [order, setOrder] = useState([])
    useEffect(async () => {
        await fetch(`http://localhost:8000/api/order`, {
          headers: {
          'Authorization': `jwt=${Cookies.get('jwt')}`
          },
          method: 'GET',
          credentials: 'include'
        })
        .then((res) => res.json())
        .then((data) => {
            setOrder(data)
        })
    }, [])

  return (
    <Helmet title="Order">
      <CommonSection title="Your Order" />
      <section>
        <Container>
          <Row>
            <Col lg="12">
                <table className="table table-bordered text-center">
                  <thead>
                    <tr>
                      <th>Số thứ tự</th>
                      <th>Ngày đặt</th>
                      <th>Tổng giá</th>
                      <th>Trạng thái</th>
                      <th>Địa chỉ</th>
                      <th>Ghi chú</th>
                      <th>Chi tiết</th>
                      <th>Đánh giá</th>
                    </tr>
                  </thead>
                  <tbody>
                    {order.map((item, index) => (
                        <Tr item={item} key={item.id} index={index}></Tr>
                    ))}
                  </tbody>
                </table>
            </Col>
          </Row>
        </Container>
      </section>
    </Helmet>
  )
}

const Tr = (props) => {
    const { id, _created, price, order_status, address, note} = props.item
    return (
      <tr>
        <td className="text-center">{props.index + 1}</td>
        <td className="text-center">{_created}</td>
        <td className="text-center">${price}</td>
        <td className="text-center">{order_status}</td>
        <td className="text-center">{address}</td>
        <td className="text-center">{note}</td>
        <td className="text-center cart__item-del">
          <Link to={`/detail/${id}`}>Detail</Link>
        </td>
        <td className="text-center cart__item-del">
          <Link to={`/review/${id}`}>Review</Link>
        </td>
      </tr>
    );
  };

export default Order