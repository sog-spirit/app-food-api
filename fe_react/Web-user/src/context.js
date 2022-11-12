import React, { createContext, useEffect, useState } from 'react';

export const AppContext = createContext();

export const AppProvider = ({ children }) => {
  const [carts, setCarts] = useState([]);
  useEffect(() => {
    fetch(`http://localhost:8000/api/user/1/cart`)
    .then((res) => res.json())
    .then((data) => {
      console.log(data);
      setCarts(data);
    });
  }, [carts]);
  return (
    <AppContext.Provider  value={carts}>
      {children}
    </AppContext.Provider>
  );
};