import React, { useContext } from 'react'

import '../../../styles/product-card.css'

import { Link, useNavigate } from 'react-router-dom'

import { useDispatch } from 'react-redux'
import { cartActions } from '../../../store/shopping-cart/cartSlice'
import { CartContext, UserContext } from '../../../context'  
import Cookies from 'js-cookie'

const ProductCard = (props) => {
  const { id, name, image, price } = props.item
  const { carts, setCarts } = useContext(CartContext)
  const { user, setUser } = useContext(UserContext)
  const navigate = useNavigate()

  var getCarts = async () => {
    await fetch(`http://localhost:8000/api/cart`, {
      headers: {
        'Authorization': `jwt=${Cookies.get('jwt')}`
      },
      method: 'GET',
      credentials: 'include'
    })
      .then((res) => res.json())
      .then((data) => {
        setCarts(data)
      })
      .catch((error) => {
        console.log(error);
        navigate('/error')
      })
  }

  // TODO: Not use this func anymore
  // Use the code in block else
  const addToCart = async () => {
    if (user.id !== undefined) {
      let response = await fetch(`http://localhost:8000/api/cart/product/${id}`, {
        headers: {
          'Authorization': `jwt=${Cookies.get('jwt')}`
        },
        method: 'GET',
        credentials: 'include'
      })
      let data = await response.json()
      if (Object.keys(data).length === 0) {
        await fetch(`http://localhost:8000/api/cart`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `jwt=${Cookies.get('jwt')}`
          },
          body: JSON.stringify({
            product: id,
            quantity: 1,
          }),
          credentials: 'include'
        })
      } else {
        await fetch(`http://localhost:8000/api/cart/product/${id}`, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `jwt=${Cookies.get('jwt')}`
          },
          body: JSON.stringify({
            quantity: data.quantity + 1,
          }),
          credentials: 'include'
        })
      }
      getCarts()
    }
    else {
      const index = carts.findIndex((item) => {
        return item.id === id;
      });
  
      if (index !== -1) {
        let newCart = [...carts];
  
        newCart[index] = {
          ...newCart[index],
          quantity: newCart[index].quantity + 1,
        };
  
        setCarts(newCart)
      } else {
        let newCart = [...carts, {"id": id, "name": name, "image": image, "price": price, "quantity": 1}]
        setCarts(newCart)
      }
  }
}
    return (
      <div className='product__item'>
      <div className='product__img'>
        <Link to={`/foods/${id}`}>
          <img
          src={'http://localhost:8000' + image}
          alt='product-img'
          className='w-50'/>
        </Link>
        
      </div>

      <div className='product__content'>
        <h5>
          <Link to={`/foods/${id}`}>{name}</Link>
        </h5>
        <div className=' d-flex align-items-center justify-content-between '>
          <span className='product__price'>${price}</span>
          <button className='addTOCart__btn' onClick={() => addToCart()}>
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  )
}

export default ProductCard
