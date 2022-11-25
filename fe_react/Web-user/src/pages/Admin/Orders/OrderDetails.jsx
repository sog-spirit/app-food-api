import Cookies from 'js-cookie'
import React from 'react'
import { useEffect } from 'react'
import { useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import Helmet from '../../../components/Helmet/Helmet'
import Slidebar from '../../../components/UI/slider/SlideBar'

function AdminOrderDetails() {
  const {id} = useParams()  
  const [products, setProducts] = useState([])

  useEffect(() => {
    getProductFromOrder()
  }, [])

  const getProductFromOrder = async() => {
    await fetch(`http://localhost:8000/api/admin/orders/detail/${id}`, {
      headers: {
        'Authorization': `jwt=${Cookies.get('jwt')}`
      },
      method: 'GET',
      credentials: 'include'
    })
      .then((res) => res.json())
      .then((data) => {
        setProducts(data)
      })
  }

  return (
    <Helmet title="AdminPage">
      <div className="admin__section d-flex">
        <Slidebar />
        <div className="main__content">
          <h1>Đơn hàng chi tiết</h1>
          <div className="d-list">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Tên</th>
                  <th scope="col">Hình ảnh</th>
                  <th scope="col">Số lượng</th>
                  <th scope="col">Giá tiền</th>
                  <th scope="col">Ghi chú</th>
                </tr>
              </thead>
              <tbody>
              {products.map((item, index) => (
                <Tr item={item} key={item.id} index={index}/>
              ))}
              </tbody>
            </table>
          </div>
          <Link to="/admin/orders" type="button" class="btn select__action--add">
            Trở về
          </Link>
        </div>;
      </div>
    </Helmet>
  )
}

const Tr = (props) => {
    const {id, name, image, quantity, price, description} = props.item
    
    const slash = (value) => {
      return value ? value : '-'
    }

    return (
      <tr class="d-item">
        <th scope="row">{props.index + 1}</th>
        <td>{name}</td>
        <td>
          <img
            src={"http://localhost:8000" + image}
            alt={name}
          />
        </td>
        <td class="d-item--category">{quantity}</td>
        <td class="d-item--price">{price}đ</td>
        <td class="d-item--des">{slash(description)}</td>
      </tr>
    )
  }

export default AdminOrderDetails