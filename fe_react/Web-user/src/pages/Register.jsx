import React, { useRef } from "react";
import Helmet from "../components/Helmet/Helmet";
import CommonSection from "../components/UI/common-section/CommonSection";
import { Container, Row, Col } from "reactstrap";
import { Link } from "react-router-dom";

const Register = () => {
  const signupNameRef = useRef();
  const signupPasswordRef = useRef();
  const signupEmailRef = useRef();

  const submitHandler = (e) => {
    e.preventDefault();
  };

  return (
    <Helmet title="Signup">
      <CommonSection title="Signup" />
      <section>
        <Container>
          <Row>
            <Col lg="6" md="6" sm="12" className="m-auto text-center">
              <form
                className="form"
                onSubmit={submitHandler}
                style={{width: "70%"}}
               
              >
                <div className="form-group text-left">
                  <label>FullName</label>
                  <input type="text" class="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Email</label>
                  <input type="email" class="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Username</label>
                  <input type="email" class="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Phone Number</label>
                  <input type="email" class="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Address</label>
                  <input type="email" class="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Date of Birth</label>
                  <input type="email" class="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Image</label>
                  <input
                    type="file"
                    accept="image/jpeg, image/png, image/jpg"
                    multiple
                  />
                  <div id="display-image"></div>
                </div>
                <div className="form-group text-left">
                  <label>Password</label>
                  <input type="text" class="form-control" required />
                </div>
                <div className="form-group text-left">
                  <label>Confirm Password</label>
                  <input type="text" class="form-control" required />
                </div>

                <button type="submit" className="addTOCart__btn">
                  Sign Up
                </button>
              </form>

              <Link to="/login">Already have an account? Login</Link>
            </Col>
          </Row>
        </Container>
      </section>
    </Helmet>
  );
};

export default Register;
