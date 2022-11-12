import React, { createContext, useEffect, useState, useMemo } from 'react'

export const AppContext = createContext()

export const AppProvider = ({ children }) => {
  const [carts, setCarts] = useState([])
  const providerValue = useMemo(() => ({ carts, setCarts }), [carts, setCarts])

  useEffect(() => {
    getCarts()
  }, [])

  var getCarts = async () => {
    await fetch(`http://localhost:8000/api/user/1/cart`)
      .then((res) => res.json())
      .then((data) => {
        console.log(data)
        setCarts(data)
      })
  }

  return (
    <AppContext.Provider value={providerValue}>{children}</AppContext.Provider>
  )
}
