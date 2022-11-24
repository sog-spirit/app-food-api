import React, { useState, useEffect } from "react";
import Helmet from "../../../components/Helmet/Helmet";
import SlideBar from "../../../components/UI/slider/SlideBar";
import "../../../styles/dashboard.scss";
import "../../../styles/admin.scss";
import { Link } from 'react-router-dom';

import {
  Form,
  Button,
  FormGroup,
  FormControl,
  ControlLabel,
} from "react-bootstrap";

import TextField from "@mui/material/TextField";
import { AdapterDayjs } from "@mui/x-date-pickers/AdapterDayjs";
import { LocalizationProvider } from "@mui/x-date-pickers/LocalizationProvider";
import { DatePicker } from "@mui/x-date-pickers/DatePicker";
import Cookies from "js-cookie";

const AdminProduct = () => {
  const [searchTerm, setSearchTerm] = useState("")
  const [products, setProducts] = useState([])
  const [filter, setFilter] = useState("default")
  const [categories, setCategories] = useState([])

  useEffect(() => {
    getProducts()
    getCategories()
  }, [])

  useEffect(async () => {
    if (filter == "default") {
      getProducts()
    }
    else {
      let response = await fetch("http://localhost:8000/api/product");
      let data = await response.json();
      let items = data.filter((item) => item.category == filter);
      setProducts(items)
    }
  }, [filter])

  let getProducts = async () => {
    let response = await fetch("http://localhost:8000/api/product");
    let data = await response.json();
    setProducts(data);
  };

  let getCategories = async () => {
    let response = await fetch("http://localhost:8000/api/category");
    let data = await response.json();
    setCategories(data);
  };

  const handleSearch = (e) => {
    e.preventDefault()
    console.log(searchTerm);
    if (searchTerm) {
      let items = [...products].filter((item) => item.name.toLowerCase().includes(searchTerm.toLowerCase()))
      setProducts(items)
    } else {
      getProducts()
    }
  }

  const handleDelete = async (id) => {
    await fetch(`http://localhost:8000/api/product/${id}`, {
      method: 'DELETE',
      headers: {
        'Authorization': `jwt=${Cookies.get('jwt')}`
      },
      credentials: 'include'
    })
    /api/product/31/api/product/31()
  }

  return (
    <Helmet title="AdminPage">
      <div className="admin__section d-flex">
        <SlideBar />
        <div className="main__content">
          <h1>Sản phẩm</h1>
          {/* <div className="select__actions">
            <div className="select__actions--datetime d-flex flex-column">
              <label class="mb-1">Thời gian</label>
              <LocalizationProvider dateAdapter={AdapterDayjs}>
                <DatePicker
                  label="Basic example"
                  value={value}
                  onChange={(newValue) => {
                    setValue(newValue);
                  }}
                  renderInput={(params) => <TextField {...params} />}
                />
              </LocalizationProvider>
            </div>
          </div> */}

          <div className="select__actions">
            <Link to="/admin/addProduct" class="d-flex">
              <button type="button" class="btn select__action--add">
                Thêm sản phẩm
              </button>
            </Link>
            <div className="select__actions-item d-flex">
              <Form.Group className="mr-1" controlId="formBasicEmail">
                <Form.Label>Product Category: </Form.Label>
                <Form.Select
                  aria-label="Default select example"
                  className="mr-3"
                  onChange={e => setFilter(e.target.value)}
                >
                  <option value="default">Mặc định</option>
                  {categories.map((item) => {return <option key={item.id} value={item.id}>{item.name}</option>} )}  
                </Form.Select>
              </Form.Group>
              <Form.Group className="mr-1" controlId="">
                <Form.Label>Tìm kiếm</Form.Label>
                <Form.Control type="text" placeholder="Tìm kiếm sản phẩm" onChange={e => setSearchTerm(e.target.value)}/>
              </Form.Group>
              <button type="button" class="btn select__action--add" onClick={e => handleSearch(e)}>
                Tìm kiếm
              </button>
            </div>
          </div>

          {/* table list product */}
          <div className="d-list">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Name</th>
                  <th scope="col">Image</th>
                  <th scope="col">Category</th>
                  <th scope="col">Price</th>
                  <th scope="col">Description</th>
                  <th scope="col" style={{ color: "green" }}>
                    Edit
                  </th>
                  <th scope="col" style={{ color: "red" }}>
                    Delete
                  </th>
                </tr>
              </thead>
              <tbody>
              {products.map((item, index) => (
                <Tr item={item} key={item.id} index={index} handleDelete={handleDelete}/>
              ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </Helmet>
  );
};

const Tr = (props) => {
  const {id, name, image, category_name, price, description} = props.item
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
      <td class="d-item--category">{category_name}</td>
      <td class="d-item--price">{price}</td>
      <td class="d-item--des">{description}</td>
      <Link to={`/admin/product/${id}`} class="d-item--icon d-item--edit">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 512 512"
        >
          <path d="M471.6 21.7c-21.9-21.9-57.3-21.9-79.2 0L362.3 51.7l97.9 97.9 30.1-30.1c21.9-21.9 21.9-57.3 0-79.2L471.6 21.7zm-299.2 220c-6.1 6.1-10.8 13.6-13.5 21.9l-29.6 88.8c-2.9 8.6-.6 18.1 5.8 24.6s15.9 8.7 24.6 5.8l88.8-29.6c8.2-2.8 15.7-7.4 21.9-13.5L437.7 172.3 339.7 74.3 172.4 241.7zM96 64C43 64 0 107 0 160V416c0 53 43 96 96 96H352c53 0 96-43 96-96V320c0-17.7-14.3-32-32-32s-32 14.3-32 32v96c0 17.7-14.3 32-32 32H96c-17.7 0-32-14.3-32-32V160c0-17.7 14.3-32 32-32h96c17.7 0 32-14.3 32-32s-14.3-32-32-32H96z" />
        </svg>
      </Link>
      <td class="d-item--icon d-item--delete" onClick={() => props.handleDelete(id)}>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 448 512"
        >
          <path d="M135.2 17.7L128 32H32C14.3 32 0 46.3 0 64S14.3 96 32 96H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320l-7.2-14.3C307.4 6.8 296.3 0 284.2 0H163.8c-12.1 0-23.2 6.8-28.6 17.7zM416 128H32L53.2 467c1.6 25.3 22.6 45 47.9 45H346.9c25.3 0 46.3-19.7 47.9-45L416 128z" />
        </svg>
      </td>
    </tr>
  )
}


export default AdminProduct;
