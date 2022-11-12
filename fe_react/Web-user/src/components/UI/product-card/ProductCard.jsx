import React, { useContext } from 'react'

import '../../../styles/product-card.css'

import { Link } from 'react-router-dom'

import { useDispatch } from 'react-redux'
import { cartActions } from '../../../store/shopping-cart/cartSlice'
import { AppContext } from '../../../context'

const ProductCard = (props) => {
  const { id, name, image, price } = props.item
  const { carts, setCarts } = useContext(AppContext)
  const dispatch = useDispatch()

  var getCarts = async () => {
    await fetch(`http://localhost:8000/api/user/1/cart`)
      .then((res) => res.json())
      .then((data) => {
        console.log(data)
        setCarts(data)
      })
  }

  const addToCart = async () => {
    let response = await fetch(`http://localhost:8000/api/user/1/product/${id}`)
    let data = await response.json()
    if (Object.keys(data).length === 0) {
      fetch(`http://localhost:8000/api/user/1/cart`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          product: id,
          quantity: 1,
        }),
      })
    } else {
      fetch(`http://localhost:8000/api/user/1/product/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          quantity: data.quantity + 1,
        }),
      })
    }
    getCarts()
  }

  return (
    <div className='product__item'>
      <div className='product__img'>
        <img
          src={'http://localhost:8000' + image}
          alt='product-img'
          className='w-50'
        />
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
