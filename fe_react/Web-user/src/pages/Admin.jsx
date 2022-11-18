import React, { useRef, useState, useEffect } from "react";
import Helmet from "../components/Helmet/Helmet";
import SlideBar from "../components/UI/slider/SlideBar";
import "../styles/dashboard.scss";
import Button from "react-bootstrap/Button";
import Form from "react-bootstrap/Form";
const AdninPage = () => {
  return (
    <Helmet title="AdminPage">
      <div className="admin-page d-flex">
        <SlideBar />
        <div className="dashboard-content">
          <div className="d-label">
            <h2>Product</h2>
          </div>
          {/* form add product */}
          <div className="d-add">
            <Form>
              <Form.Group className="mb-3" controlId="formBasicEmail">
                <Form.Label>Product Name</Form.Label>
                <Form.Control type="text" placeholder="Enter product name" />
              </Form.Group>
              <Form.Group className="mb-3" controlId="formBasicEmail">
                <Form.Label>Product Category: </Form.Label>

                <Form.Select
                  aria-label="Default select example"
                  className="mb-3"
                >
                  <option>Open this select category</option>
                  <option value="1">Rice</option>
                  <option value="2">chiken</option>
                  <option value="3">Bugur</option>
                  <option value="4">Drink</option>
                </Form.Select>
              </Form.Group>
              <Form.Group className="mb-3" controlId="formBasicEmail">
                <Form.Label>Email address</Form.Label>
                <Form.Control type="email" placeholder="Enter email" />
                <Form.Text className="text-muted">
                  We'll never share your email with anyone else.
                </Form.Text>
              </Form.Group>
              <Form.Group className="mb-3" controlId="formBasicPassword">
                <Form.Label>Password</Form.Label>
                <Form.Control type="password" placeholder="Password" />
              </Form.Group>
              <Button variant="primary" type="submit">
                Submit
              </Button>
            </Form>
          </div>
          {/* table list product */}
          <div className="d-list">
            <table class="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Name</th>
                  <th scope="col">Category</th>
                  <th scope="col">Stock</th>
                  <th scope="col">Edit</th>
                  <th scope="col">Delete</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <th scope="row">1</th>
                  <td>Chiken 1 pice</td>
                  <td>Chiken</td>
                  <td>27</td>
                  <td>Edit</td>
                  <td>Delete</td>
                </tr>
                <tr>
                  <th scope="row">2</th>
                  <td>Milo</td>
                  <td>Drink</td>
                  <td>20</td>
                  <td>Edit</td>
                  <td>Delete</td>
                </tr>
                <tr>
                  <th scope="row">3</th>
                  <td>Larry</td>
                  <td>the Bird</td>
                  <td>@twitter</td>
                  <td>Edit</td>
                  <td>Delete</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </Helmet>
  );
};

export default AdninPage;
