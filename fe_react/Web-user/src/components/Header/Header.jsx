import React, { useRef, useEffect } from 'react'

import { Container } from 'reactstrap'
import bannerImg from '../../assets/images/bannerImg.png'

import { NavLink, Link } from 'react-router-dom'
import { useDispatch } from 'react-redux'

import { cartUiActions } from '../../store/shopping-cart/cartUiSlice'

import '../../styles/header.css'
import { AppContext } from '../../context'
import { useContext } from 'react'

const nav__links = [
  {
    display: 'Home',
    path: '/home',
  },
  {
    display: 'Foods',
    path: '/foods',
  },
  {
    display: 'Cart',
    path: '/cart',
  },
  {
    display: 'Contact',
    path: '/contact',
  },
]

const Header = () => {
  const { carts, setCarts } = useContext(AppContext)
  const getAmountItems = (cart) => {
    return cart.reduce((sum, item) => {
      return sum + item.quantity
    }, 0)
  }

  const menuRef = useRef(null)
  const headerRef = useRef(null)
  const dispatch = useDispatch()

  const toggleMenu = () => menuRef.current.classList.toggle('show__menu')

  const toggleCart = () => {
    dispatch(cartUiActions.toggle())
  }

  useEffect(() => {
    window.addEventListener('scroll', () => {
      if (
        document.body.scrollTop > 80 ||
        document.documentElement.scrollTop > 80
      ) {
        headerRef.current.classList.add('header__shrink')
      } else {
        headerRef.current.classList.remove('header__shrink')
      }
    })

    return () => window.removeEventListener('scroll')
  }, [])

  return (
    <header className='header' ref={headerRef}>
      <Container>
        <div className='nav__wrapper d-flex align-items-center justify-content-between'>
          <div className='logo'>
            <img src={bannerImg} alt='logo' />
          </div>

          {/* ======= menu ======= */}
          <div className='navigation' ref={menuRef} onClick={toggleMenu}>
            <div className='menu d-flex align-items-center gap-5'>
              {nav__links.map((item, index) => (
                <NavLink
                  to={item.path}
                  key={index}
                  className={(navClass) =>
                    navClass.isActive ? 'active__menu' : ''
                  }
                >
                  {item.display}
                </NavLink>
              ))}
            </div>
          </div>

          {/* ======== nav right icons ========= */}
          <div className='nav__right d-flex align-items-center gap-4'>
            <span className='cart__icon' onClick={toggleCart}>
              <i class='ri-shopping-basket-line'></i>
              <span className='cart__badge'>{getAmountItems(carts)}</span>
            </span>

            <span className='user'>
              <Link to='/login'>
                <i class='ri-user-line'></i>
              </Link>
            </span>

            <span className='mobile__menu' onClick={toggleMenu}>
              <i class='ri-menu-line'></i>
            </span>
          </div>
        </div>
      </Container>
    </header>
  )
}

export default Header
