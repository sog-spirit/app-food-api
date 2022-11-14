import React, { useState } from "react";
import Helmet from "../components/Helmet/Helmet";
import CommonSection from "../components/UI/common-section/CommonSection";
import { Container, Row, Col } from "reactstrap";

function ChangePassword() {
    const [isError, setIsError] = useState(false)
    const [passwordInfo, setPasswordInfo] = useState({
        oldPassword: "",
        newPassword: "",
        confirmPassword: "",
    })
    const handleChange = (event) => {
        setPasswordInfo({ ...passwordInfo, [event.target.name]: event.target.value });
      };
    const submitHandler = (e) => {
      e.preventDefault();
      if (passwordInfo.newPassword !== passwordInfo.confirmPassword) {
        setIsError(true)
        setTimeout(() => {
            setIsError(false)
        }, 2000);
      }
    };
  
    return (
      <Helmet title="Update Password">
        <CommonSection title="Update Password" />
        <section>
          <Container>
            <Row>
              <Col lg="6" md="6" sm="12" className="m-auto text-center">
                <form className="form mb-5" onSubmit={(e) => submitHandler(e)}>
                  <div className="form__group">
                    <input
                      type="password"
                      placeholder="Password"
                      name="oldPassword"
                      required
                      onChange={(e) => {
                        handleChange(e)
                      }}
                    />
                  </div>
                  <div className="form__group">
                    <input
                      type="password"
                      placeholder="Password"
                      name="newPassword"
                      required
                      onChange={(e) => {
                          handleChange(e)
                      }}
                      />
                  </div>
                  <div className="form__group">
                    <input
                      type="password"
                      placeholder="Confirm Password"
                      name="confirmPassword"
                      required
                      onChange={(e) => {
                        handleChange(e)
                      }}
                    />
                  {isError && <span style={{color: "red"}}>Error</span>}
                  </div>
                  <button
                    onClick={(e) => submitHandler(e)}
                    type="submit"
                    className="addTOCart__btn"
                    >
                    Save
                  </button>
                </form>
              </Col>
            </Row>
          </Container>
        </section>
      </Helmet>
    )
}

export default ChangePassword