import React from 'react'
import { ListGroupItem } from 'reactstrap'

import '../../../styles/cart-item.css'

import { useDispatch } from 'react-redux'
import { cartActions } from '../../../store/shopping-cart/cartSlice'
import { useState, useContext } from 'react'
import { CartContext, UserContext } from '../../../context'

const CartItem = ({ item }) => {
  let { id, name, price, image, quantity } = item
  const [currentQuantity, setQuantity] = useState(quantity)
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


  const incrementItem = async () => {
    if (user.id !== undefined) {
      await fetch(`http://localhost:8000/api/user/${user.id}/cart/${id}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        quantity: currentQuantity + 1,
      }),
    })
    getCarts()
  }
  else {
    const index = carts.findIndex((item) => {
      return item.id === id
    })
    let newCart = [...carts]
    newCart[index] = {...newCart[index], quantity: newCart[index].quantity + 1}
    setCarts(newCart)
  }
  setQuantity(currentQuantity + 1)
}

  const decreaseItem = async () => {
    if (user.id !== undefined) {
      await fetch(`http://localhost:8000/api/user/${user.id}/cart/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          quantity: currentQuantity - 1,
        }),
      })
      getCarts()
    }
    else {
      const index = carts.findIndex((item) => {
        return item.id === id;
      });
  
      let newCart = [...carts];
  
      if (newCart[index].quantity === 1) {
        newCart = newCart.filter((cart) => cart.id !== newCart[index].id);
      } else {
        newCart[index] = { ...newCart[index], quantity: newCart[index].quantity - 1 };
      }
      setCarts(newCart)
    }
    setQuantity(currentQuantity - 1)
  }

  const deleteItem = async () => {
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
    setQuantity(0)
  }
  if (currentQuantity == 0) {
    return <></>
  } else
    return (
      <ListGroupItem className='border-0 cart__item'>
        <div className='cart__item-info d-flex gap-2'>
          <img src={'http://localhost:8000' + image} alt='product-img' />

          <div className='cart__product-info w-100 d-flex align-items-center gap-4 justify-content-between'>
            <div>
              <h6 className='cart__product-title'>{name}</h6>
              <p className=' d-flex align-items-center gap-5 cart__product-price'>
                {currentQuantity}x <span>${price * currentQuantity}</span>
              </p>
              <div className=' d-flex align-items-center justify-content-between increase__decrease-btn'>
                <span className='increase__btn' onClick={() => incrementItem()}>
                  <i class='ri-add-line'></i>
                </span>
                <span className='quantity'>{currentQuantity}</span>
                <span className='decrease__btn' onClick={() => decreaseItem()}>
                  <i class='ri-subtract-line'></i>
                </span>
              </div>
            </div>

            <span className='delete__btn' onClick={() => deleteItem()}>
              <i class='ri-close-line'></i>
            </span>
          </div>
        </div>
      </ListGroupItem>
    )
}

export default CartItem
