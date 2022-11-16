import React, { useContext } from 'react'

import '../../../styles/product-card.css'

import { Link } from 'react-router-dom'

import { useDispatch } from 'react-redux'
import { cartActions } from '../../../store/shopping-cart/cartSlice'
import { CartContext, UserContext } from '../../../context'  

const ProductCard = (props) => {
  const { id, name, image, price } = props.item
  const { carts, setCarts } = useContext(CartContext)
  const { user, setUser } = useContext(UserContext)
  const dispatch = useDispatch()

  var getCarts = async () => {
    await fetch(`http://localhost:8000/api/user/${user.id}/cart`)
      .then((res) => res.json())
      .then((data) => {
        setCarts(data)
      })
  }

  const addToCart = async () => {
    if (user.id !== undefined) {
      let response = await fetch(`http://localhost:8000/api/user/${user.id}/product/${id}`)
      let data = await response.json()
      if (Object.keys(data).length === 0) {
        await fetch(`http://localhost:8000/api/user/${user.id}/cart`, {
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
        await fetch(`http://localhost:8000/api/user/${user.id}/product/${id}`, {
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
