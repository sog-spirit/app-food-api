import Cookies from 'js-cookie'
import React, { createContext, useEffect, useState, useMemo, useContext } from 'react'
import { useNavigate } from 'react-router-dom'

export const CartContext = createContext()
export const UserContext = createContext()

export const UserProvider = ({children}) => {
  const navigate = useNavigate()
  const [user, setUser] = useState({})
  const providerValue = useMemo(() => ({ user, setUser }), [user, setUser])

  useEffect(() => {
    getUser()
  }, [])

  var getUser = async () => {
    var cookie = Cookies.get('jwt')
    if (cookie) {
      await fetch(`http://localhost:8000/api/user/view`, {
        headers: {
          'Authorization': `jwt=${cookie}`
        },
        method: 'GET',
        credentials: 'include'
      })
      .then((res) => res.json())
      .then((data) => {
        setUser(data)
      })
      .catch((error) => {
        console.log(error);
        navigate('/error')
      })
  }}
  return (
    <UserContext.Provider value={providerValue}>{children}</UserContext.Provider>
  )
}

export const CartProvider = ({ children }) => {
  const navigate = useNavigate()
  const [carts, setCarts] = useState([])
  const {user, setUser} = useContext(UserContext)
  const providerValue = useMemo(() => ({ carts, setCarts }), [carts, setCarts])

  useEffect(() => {
    getCarts(user)
  }, [user])

  var getCarts = async () => {
    if (user.id !== undefined) {
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
    else {
      setCarts([])
    }
  }

  return (
    <CartContext.Provider value={providerValue}>{children}</CartContext.Provider>
  )
}
